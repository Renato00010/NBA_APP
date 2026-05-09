import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:bcrypt/bcrypt.dart';
import '../../main.dart';
import '../../db/app_database.dart';

String _hashPasswordSync(String password) {
  return BCrypt.hashpw(password, BCrypt.gensalt(logRounds: 6));
}

bool _verifyPasswordSync(List<String> args) {
  return BCrypt.checkpw(args[0], args[1]);
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;
  bool _isRegister = false;
  bool _obscurePassword = true;
  String? _error;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<String> _hashPassword(String password) async {
    return await compute(_hashPasswordSync, password);
  }

  Future<bool> _verifyPassword(String password, String hash) async {
    return await compute(_verifyPasswordSync, [password, hash]);
  }

  Future<void> _submit() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() => _error = 'Preenche todos os campos');
      return;
    }

    if (password.length < 6) {
      setState(() => _error = 'A password deve ter pelo menos 6 caracteres');
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      if (_isRegister) {
        final existing = await database.preferencesDao.getUserByEmail(email);
        if (existing != null) {
          setState(() {
            _error = 'Este email já está registado';
            _loading = false;
          });
          return;
        }

        final hashedPassword = await _hashPassword(password);

        await database.preferencesDao.upsertPreferences(
          UserPreferencesCompanion(
            email: Value(email),
            passwordHash: Value(hashedPassword),
            updatedAt: Value(DateTime.now()),
          ),
        );

        if (!mounted) return;
        await NbaApp.of(context)?.login(email);
      } else {
        final user = await database.preferencesDao.getUserByEmail(email);

        if (user == null) {
          setState(() {
            _error = 'Email não encontrado. Cria uma conta primeiro.';
            _loading = false;
          });
          return;
        }

        final passwordHash = user.passwordHash;
        if (passwordHash == null) {
          setState(() {
            _error = 'Erro na conta. Tenta registar novamente.';
            _loading = false;
          });
          return;
        }

        final isValid = await _verifyPassword(password, passwordHash);
        if (!isValid) {
          setState(() {
            _error = 'Password incorreta';
            _loading = false;
          });
          return;
        }

        if (!mounted) return;
        await NbaApp.of(context)?.login(email);
      }
    } catch (e) {
      print('Erro submit: $e');
      setState(() {
        _error = 'Erro inesperado: ${e.toString()}';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: const Color(0xFF17408B),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Center(
                        child: Text(
                          'NBA',
                          style: TextStyle(
                            color: Color(0xFFFFC72C),
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'NBA App',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      _isRegister ? 'Cria a tua conta' : 'Bem-vindo de volta',
                      style: const TextStyle(
                        color: Colors.white54,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 48),

              const Text(
                'Email',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'o.teu@email.com',
                  hintStyle: const TextStyle(color: Colors.white24),
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: Colors.white38,
                  ),
                  filled: true,
                  fillColor: const Color(0xFF1A1A1A),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF17408B),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              const Text(
                'Password',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: _obscurePassword,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: '••••••••',
                  hintStyle: const TextStyle(color: Colors.white24),
                  prefixIcon: const Icon(
                    Icons.lock_outlined,
                    color: Colors.white38,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: Colors.white38,
                    ),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  filled: true,
                  fillColor: const Color(0xFF1A1A1A),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: Color(0xFF17408B),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              if (_error != null)
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFC9082A).withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: const Color(0xFFC9082A).withOpacity(0.4),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.error_outline,
                        color: Color(0xFFC9082A),
                        size: 16,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _error!,
                          style: const TextStyle(
                            color: Color(0xFFC9082A),
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _loading ? null : _submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF17408B),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _loading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        )
                      : Text(
                          _isRegister ? 'Criar conta' : 'Entrar',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 16),

              Center(
                child: TextButton(
                  onPressed: () => setState(() {
                    _isRegister = !_isRegister;
                    _error = null;
                  }),
                  child: Text(
                    _isRegister
                        ? 'Já tens conta? Entrar'
                        : 'Não tens conta? Registar',
                    style: const TextStyle(
                      color: Color(0xFF4DBCE9),
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

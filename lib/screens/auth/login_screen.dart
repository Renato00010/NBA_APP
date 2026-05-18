import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:intl/intl.dart';
import '../../main.dart';

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
  final _usernameController = TextEditingController();
  final _dobController = TextEditingController();

  bool _loading = false;
  bool _isRegister = false;
  bool _obscurePassword = true;
  String? _error;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  Future<String> _hashPassword(String password) async {
    return await compute(_hashPasswordSync, password);
  }

  Future<bool> _verifyPassword(String password, String hash) async {
    return await compute(_verifyPasswordSync, [password, hash]);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF17408B),
              onPrimary: Colors.white,
              surface: Color(0xFF1A1A1A),
              onSurface: Colors.white,
            ),
            dialogBackgroundColor: const Color(0xFF151515),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _submit() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final username = _usernameController.text.trim();
    final dob = _dobController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() => _error = 'Preenche os campos obrigatórios');
      return;
    }

    if (_isRegister && (username.isEmpty || dob.isEmpty)) {
      setState(() => _error = 'Preenche todos os campos para registar');
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
        // Verifica se já existe
        final existing = await database.preferencesDao.getUserByEmail(email);
        if (existing != null) {
          setState(() {
            _error = 'Este email já está registado';
            _loading = false;
          });
          return;
        }

        // Hash da password
        final hashedPassword = await _hashPassword(password);

        // Regista
        await database.preferencesDao.registerUser(email, hashedPassword, username, dob);

        // Inicia sessão
        await database.preferencesDao.setLoggedIn(email);

        if (!mounted) return;
        await NbaApp.of(context)?.login(email);
      } else {
        // Login
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

        await database.preferencesDao.setLoggedIn(email);
        if (!mounted) return;
        await NbaApp.of(context)?.login(email);
      }
    } catch (e) {
      setState(() {
        _error = 'Erro: ${e.toString()}';
        _loading = false;
      });
    }
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    bool isPassword = false,
    bool readOnly = false,
    VoidCallback? onTap,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: isPassword && _obscurePassword,
          readOnly: readOnly,
          onTap: onTap,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            prefixIcon: Icon(icon, color: Colors.white38),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                      color: Colors.white38,
                    ),
                    onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                  )
                : null,
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(
                color: Color(0xFF17408B),
                width: 1.5,
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Stack(
        children: [
          // Background Elements
          Positioned(
            top: -100,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF17408B).withValues(alpha: 0.2),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            right: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFC9082A).withValues(alpha: 0.2),
              ),
            ),
          ),
          // Blur Layer
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
              child: Container(color: Colors.transparent),
            ),
          ),
          // Main Content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
                child: Container(
                  padding: const EdgeInsets.all(32),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(32),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFF17408B),
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF17408B).withValues(alpha: 0.5),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'NBA',
                            style: TextStyle(
                              color: Color(0xFFFFC72C),
                              fontSize: 28,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        _isRegister ? 'Criar Conta' : 'Bem-vindo de volta',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _isRegister ? 'Regista-te para acompanhar a liga' : 'Acede às estatísticas e jogos',
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Form Fields
                      AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        child: Column(
                          children: [
                            if (_isRegister) ...[
                              _buildTextField(
                                label: 'Username',
                                controller: _usernameController,
                                icon: Icons.person_outline,
                              ),
                              _buildTextField(
                                label: 'Data de Nascimento',
                                controller: _dobController,
                                icon: Icons.calendar_today_outlined,
                                readOnly: true,
                                onTap: () => _selectDate(context),
                              ),
                            ],
                            _buildTextField(
                              label: 'Email',
                              controller: _emailController,
                              icon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                            ),
                            _buildTextField(
                              label: 'Password',
                              controller: _passwordController,
                              icon: Icons.lock_outline,
                              isPassword: true,
                            ),
                          ],
                        ),
                      ),

                      // Error message
                      if (_error != null) ...[
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFC9082A).withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFC9082A).withValues(alpha: 0.4),
                            ),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.error_outline, color: Color(0xFFC9082A), size: 18),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  _error!,
                                  style: const TextStyle(
                                    color: Color(0xFFC9082A),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],

                      const SizedBox(height: 8),

                      // Submit Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _loading ? null : _submit,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF17408B),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 8,
                            shadowColor: const Color(0xFF17408B).withValues(alpha: 0.5),
                          ),
                          child: _loading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : Text(
                                  _isRegister ? 'Criar Conta' : 'Entrar',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Toggle Button
                      TextButton(
                        onPressed: () {
                          setState(() {
                            _isRegister = !_isRegister;
                            _error = null;
                            if (!_isRegister) {
                              _usernameController.clear();
                              _dobController.clear();
                            }
                          });
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.white70,
                        ),
                        child: RichText(
                          text: TextSpan(
                            text: _isRegister ? 'Já tens conta? ' : 'Não tens conta? ',
                            style: const TextStyle(color: Colors.white54, fontSize: 14),
                            children: [
                              TextSpan(
                                text: _isRegister ? 'Entrar' : 'Registar',
                                style: const TextStyle(
                                  color: Color(0xFF4DBCE9),
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

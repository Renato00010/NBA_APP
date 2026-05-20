import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import '../main.dart';
import '../widgets/basketball_loader.dart';
import 'smtp_config_service.dart';

class EmailSimulationService {
  /// Prompts the user for their email and runs a beautiful sending simulation.
  static Future<void> showEmailPrompt({
    required BuildContext context,
    required String documentName,
    required String documentTypePt, // e.g., "Fatura" or "Bilhete"
    required String documentTypeEn, // e.g., "Invoice" or "Ticket"
    required Uint8List pdfBytes,
  }) async {
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';
    
    // Fetch logged-in user email if available
    String defaultEmail = '';
    try {
      final prefs = await database.preferencesDao.getPreferences();
      if (prefs != null && prefs.email != null) {
        defaultEmail = prefs.email!;
      }
    } catch (e) {
      debugPrint("Failed to fetch user email: $e");
    }

    if (!context.mounted) return;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return _EmailSimulationDialog(
          documentName: documentName,
          documentTypePt: documentTypePt,
          documentTypeEn: documentTypeEn,
          defaultEmail: defaultEmail,
          isEnglish: isEnglish,
          pdfBytes: pdfBytes,
        );
      },
    );
  }
}

class _EmailSimulationDialog extends StatefulWidget {
  final String documentName;
  final String documentTypePt;
  final String documentTypeEn;
  final String defaultEmail;
  final bool isEnglish;
  final Uint8List pdfBytes;

  const _EmailSimulationDialog({
    required this.documentName,
    required this.documentTypePt,
    required this.documentTypeEn,
    required this.defaultEmail,
    required this.isEnglish,
    required this.pdfBytes,
  });

  @override
  State<_EmailSimulationDialog> createState() => _EmailSimulationDialogState();
}

enum _SimulationState { input, sending, success, error }

class _EmailSimulationDialogState extends State<_EmailSimulationDialog> {
  _SimulationState _state = _SimulationState.input;
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  
  bool _useRealSmtp = false;
  bool _smtpExpanded = false;
  final _smtpEmailController = TextEditingController();
  final _smtpPasswordController = TextEditingController();

  int _stepIndex = 0;
  Timer? _stepTimer;
  String _currentStepText = '';

  late final List<String> _stepsPt;
  late final List<String> _stepsEn;

  bool _realEmailSent = false;
  bool _waitingForNetwork = false;
  String _smtpError = '';

  @override
  void initState() {
    super.initState();
    _emailController.text = widget.defaultEmail;
    _loadSmtpConfig();

    _stepsPt = [
      "A gerar o documento PDF...",
      "A formatar e estruturar o anexo...",
      "A encriptar ficheiro por motivos de segurança...",
      "A estabelecer ligação segura com o servidor de e-mail...",
      "A autenticar credenciais de envio...",
      "A enviar e-mail com anexo: ${widget.documentName}...",
    ];

    _stepsEn = [
      "Generating PDF document...",
      "Formatting and structuring attachment...",
      "Encrypting file for security reasons...",
      "Establishing secure connection to mail server...",
      "Authenticating sending credentials...",
      "Sending email with attachment: ${widget.documentName}...",
    ];
  }

  Future<void> _loadSmtpConfig() async {
    final config = await SmtpConfigService.loadConfig();
    if (mounted) {
      setState(() {
        _useRealSmtp = config.useRealSmtp;
        _smtpEmailController.text = config.senderEmail;
        _smtpPasswordController.text = config.appPassword;
        if (_useRealSmtp) {
          _smtpExpanded = true;
        }
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _smtpEmailController.dispose();
    _smtpPasswordController.dispose();
    _stepTimer?.cancel();
    super.dispose();
  }

  void _startSimulation() {
    setState(() {
      _state = _SimulationState.sending;
      _stepIndex = 0;
      _currentStepText = widget.isEnglish ? _stepsEn[0] : _stepsPt[0];
      _realEmailSent = false;
      _waitingForNetwork = false;
      _smtpError = '';
    });

    if (_useRealSmtp) {
      _sendRealEmail();
    }

    _stepTimer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      if (!mounted) return;
      
      setState(() {
        _stepIndex++;
        if (_stepIndex < _stepsPt.length) {
          _currentStepText = widget.isEnglish ? _stepsEn[_stepIndex] : _stepsPt[_stepIndex];
        } else {
          _stepTimer?.cancel();
          if (!_useRealSmtp) {
            _state = _SimulationState.success;
          } else {
            if (_smtpError.isNotEmpty) {
              _state = _SimulationState.error;
            } else if (_realEmailSent) {
              _state = _SimulationState.success;
            } else {
              _waitingForNetwork = true;
              _currentStepText = widget.isEnglish 
                  ? "Waiting for mail server confirmation..." 
                  : "A aguardar confirmação do servidor de e-mail...";
            }
          }
        }
      });
    });
  }

  Future<void> _sendRealEmail() async {
    final sender = _smtpEmailController.text.trim();
    final password = _smtpPasswordController.text.trim();
    final recipient = _emailController.text.trim();
    final isEnglish = widget.isEnglish;

    // Save configurations locally
    await SmtpConfigService.saveConfig(
      SmtpConfig(
        senderEmail: sender,
        appPassword: password,
        useRealSmtp: true,
      ),
    );

    final smtpServer = gmail(sender, password);

    final subjectPt = "O teu/tua ${widget.documentTypePt}: ${widget.documentName}";
    final subjectEn = "Your ${widget.documentTypeEn}: ${widget.documentName}";

    final bodyPt = "Olá!\n\nEm anexo encontras o teu documento: ${widget.documentName}.\n\nObrigado por utilizares a NBA App!";
    final bodyEn = "Hello!\n\nPlease find attached your document: ${widget.documentName}.\n\nThank you for using the NBA App!";

    final attachment = StreamAttachment(
      Stream<List<int>>.value(widget.pdfBytes),
      'application/pdf',
      fileName: widget.documentName,
    );

    final message = Message()
      ..from = Address(sender, 'NBA App')
      ..recipients.add(recipient)
      ..subject = isEnglish ? subjectEn : subjectPt
      ..text = isEnglish ? bodyEn : bodyPt
      ..attachments = [attachment];

    try {
      await send(message, smtpServer);
      if (mounted) {
        setState(() {
          _realEmailSent = true;
          if (_waitingForNetwork) {
            _state = _SimulationState.success;
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _smtpError = e.toString();
          if (_waitingForNetwork || _stepIndex >= _stepsPt.length) {
            _state = _SimulationState.error;
          }
        });
      }
    }
  }

  String _t(String pt, String en) {
    return widget.isEnglish ? en : pt;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accentColor = theme.colorScheme.primary;

    return PopScope(
      canPop: _state != _SimulationState.sending,
      child: AlertDialog(
        backgroundColor: const Color(0xFF141414),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
        ),
        contentPadding: const EdgeInsets.all(24),
        content: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _buildContent(accentColor),
        ),
      ),
    );
  }

  Widget _buildContent(Color accentColor) {
    switch (_state) {
      case _SimulationState.input:
        return _buildInputView(accentColor);
      case _SimulationState.sending:
        return _buildSendingView(accentColor);
      case _SimulationState.success:
        return _buildSuccessView(accentColor);
      case _SimulationState.error:
        return _buildErrorView(accentColor);
    }
  }

  Widget _buildInputView(Color accentColor) {
    final docType = _t(widget.documentTypePt, widget.documentTypeEn);
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: accentColor.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.email_outlined, color: accentColor, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _t('Enviar por E-mail', 'Send via Email'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              _t(
                'Gostarias que enviássemos o/a $docType para o teu e-mail para teres um registo permanente?',
                'Would you like us to send the $docType to your email for your permanent records?',
              ),
              style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _emailController,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return _t('Obrigatório', 'Required');
                }
                final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                if (!emailRegex.hasMatch(value.trim())) {
                  return _t('E-mail inválido', 'Invalid email');
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: _t('E-mail Destinatário', 'Recipient email address'),
                labelStyle: const TextStyle(color: Colors.white54, fontSize: 13),
                filled: true,
                fillColor: const Color(0xFF1E1E1E),
                prefixIcon: const Icon(Icons.alternate_email, color: Colors.white30, size: 18),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.05)),
                ),
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () => setState(() => _smtpExpanded = !_smtpExpanded),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    Icon(
                      _smtpExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right,
                      color: Colors.amberAccent,
                      size: 18,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      _t('Configurações SMTP Reais (Opcional)', 'Real SMTP Settings (Optional)'),
                      style: const TextStyle(color: Colors.amberAccent, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            if (_smtpExpanded) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Checkbox(
                    value: _useRealSmtp,
                    activeColor: Colors.amberAccent,
                    onChanged: (val) {
                      setState(() {
                        _useRealSmtp = val ?? false;
                      });
                    },
                  ),
                  Expanded(
                    child: Text(
                      _t('Enviar e-mail real com Gmail SMTP', 'Send real email using Gmail SMTP'),
                      style: const TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ),
                ],
              ),
              if (_useRealSmtp) ...[
                const SizedBox(height: 10),
                TextFormField(
                  controller: _smtpEmailController,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                  validator: (val) {
                    if (_useRealSmtp && (val == null || val.trim().isEmpty)) {
                      return _t('Obrigatório', 'Required');
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: _t('Teu e-mail do Gmail', 'Your Gmail address'),
                    labelStyle: const TextStyle(color: Colors.white38, fontSize: 12),
                    filled: true,
                    fillColor: const Color(0xFF1E1E1E),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _smtpPasswordController,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                  obscureText: true,
                  validator: (val) {
                    if (_useRealSmtp && (val == null || val.trim().isEmpty)) {
                      return _t('Obrigatório', 'Required');
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: _t('App Password (16 letras)', 'App Password (16 letters)'),
                    labelStyle: const TextStyle(color: Colors.white38, fontSize: 12),
                    filled: true,
                    fillColor: const Color(0xFF1E1E1E),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _t(
                    'Nota: Requer Ativar "Verificação em 2 Passos" na Conta Google e gerar uma "Palavra-passe de app" em myaccount.google.com/apppasswords.',
                    'Note: Requires activating "2-Step Verification" on your Google Account and generating an "App password" at myaccount.google.com/apppasswords.',
                  ),
                  style: const TextStyle(color: Colors.white38, fontSize: 10, height: 1.3),
                ),
              ],
            ],
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    _t('Não, obrigado', 'No, thanks'),
                    style: const TextStyle(color: Colors.white38),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _startSimulation();
                    }
                  },
                  child: Text(_t('Enviar', 'Send')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSendingView(Color accentColor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const BasketballLoader(size: 56),
        const SizedBox(height: 20),
        Text(
          _t('A enviar e-mail...', 'Sending email...'),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          height: 48,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            _currentStepText,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.amberAccent, fontSize: 13),
          ),
        ),
        const SizedBox(height: 14),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: SizedBox(
            width: 140,
            child: LinearProgressIndicator(
              value: _stepIndex / _stepsPt.length,
              backgroundColor: Colors.white.withValues(alpha: 0.05),
              valueColor: AlwaysStoppedAnimation<Color>(accentColor),
              minHeight: 4,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSuccessView(Color accentColor) {
    final email = _emailController.text.trim();
    final docType = _t(widget.documentTypePt, widget.documentTypeEn);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.check, color: Colors.white, size: 36),
        ),
        const SizedBox(height: 20),
        Text(
          _t('E-mail Enviado!', 'Email Sent!'),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          _t(
            'O/A $docType (${widget.documentName}) foi processado(a) com sucesso e enviado(a) para a tua caixa de correio:\n\n$email',
            'The $docType (${widget.documentName}) has been successfully processed and sent to your inbox at:\n\n$email',
          ),
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E1E1E),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
              ),
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: Text(_t('Fechar', 'Close')),
          ),
        ),
      ],
    );
  }

  Widget _buildErrorView(Color accentColor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.error_outline, color: Colors.white, size: 36),
        ),
        const SizedBox(height: 20),
        Text(
          _t('Erro ao Enviar E-mail', 'Failed to Send Email'),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          constraints: const BoxConstraints(maxHeight: 120),
          child: SingleChildScrollView(
            child: Text(
              _smtpError,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white70, fontSize: 11, fontFamily: 'monospace'),
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white54,
                ),
                onPressed: () {
                  setState(() {
                    _state = _SimulationState.input;
                    _smtpError = '';
                    _realEmailSent = false;
                    _waitingForNetwork = false;
                  });
                },
                child: Text(_t('Tentar Novamente', 'Try Again')),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () => Navigator.of(context).pop(),
                child: Text(_t('Fechar', 'Close')),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

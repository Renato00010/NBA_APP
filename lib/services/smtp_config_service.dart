import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class SmtpConfig {
  final String senderEmail;
  final String appPassword;
  final bool useRealSmtp;

  SmtpConfig({
    this.senderEmail = '',
    this.appPassword = '',
    this.useRealSmtp = false,
  });

  factory SmtpConfig.fromJson(Map<String, dynamic> json) {
    return SmtpConfig(
      senderEmail: json['senderEmail'] ?? '',
      appPassword: json['appPassword'] ?? '',
      useRealSmtp: json['useRealSmtp'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'senderEmail': senderEmail,
        'appPassword': appPassword,
        'useRealSmtp': useRealSmtp,
      };
}

class SmtpConfigService {
  static SmtpConfig? _cachedConfig;

  static Future<File> get _file async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/smtp_config.json');
  }

  static Future<SmtpConfig> loadConfig() async {
    if (_cachedConfig != null) return _cachedConfig!;
    try {
      final file = await _file;
      if (await file.exists()) {
        final content = await file.readAsString();
        final json = jsonDecode(content) as Map<String, dynamic>;
        _cachedConfig = SmtpConfig.fromJson(json);
        return _cachedConfig!;
      }
    } catch (e) {
      // ignore
    }
    return SmtpConfig();
  }

  static Future<void> saveConfig(SmtpConfig config) async {
    _cachedConfig = config;
    try {
      final file = await _file;
      final content = jsonEncode(config.toJson());
      await file.writeAsString(content);
    } catch (e) {
      // ignore
    }
  }
}

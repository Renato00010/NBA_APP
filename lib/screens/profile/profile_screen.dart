import 'package:flutter/material.dart';
import '../../db/app_database.dart';
import '../../main.dart';
import '../../services/theme_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userEmail = NbaApp.of(context)?.userEmail ?? '';

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        title: const Text(
          'Perfil',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 48,
              backgroundColor: theme.colorScheme.primary,
              child: const Icon(Icons.person, size: 48, color: Colors.white),
            ),
            const SizedBox(height: 12),
            const Text(
              'Olá, seja bem vindo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              userEmail,
              style: const TextStyle(color: Colors.white54, fontSize: 13),
            ),
            const SizedBox(height: 24),
            StreamBuilder<UserPreference?>(
              stream: database.preferencesDao.watchPreferences(),
              builder: (context, snapshot) {
                final prefs = snapshot.data;
                return Column(
                  children: [
                    _buildSection(
                      icon: Icons.favorite_outlined,
                      title: 'Equipa favorita',
                      subtitle: _favoriteTeamLabel(prefs?.favoriteTeamId),
                      onTap: () => _showTeamPicker(context),
                    ),
                    _buildSection(
                      icon: Icons.straighten,
                      title: 'Medidas',
                      subtitle: _measurementUnitLabel(
                        prefs?.measurementUnit ?? 'metric',
                      ),
                      onTap: () => _showMeasurementPicker(context),
                    ),
                    _buildSection(
                      icon: Icons.payments_outlined,
                      title: 'Moeda',
                      subtitle: _currencyLabel(prefs?.currencyCode ?? 'EUR'),
                      onTap: () => _showCurrencyPicker(context),
                    ),
                    _buildSwitchSection(
                      icon: Icons.sports_basketball_outlined,
                      title: 'Alertas da equipa',
                      subtitle: 'Jogos e notícias da equipa favorita',
                      value: prefs?.favoriteTeamAlerts ?? true,
                      onChanged:
                          database.preferencesDao.updateFavoriteTeamAlerts,
                    ),
                    _buildSwitchSection(
                      icon: Icons.notifications_outlined,
                      title: 'Notificações',
                      subtitle: 'Avisos gerais da app',
                      value: prefs?.notificationsOn ?? true,
                      onChanged: database.preferencesDao.updateNotifications,
                    ),
                  ],
                );
              },
            ),
            _buildSection(
              icon: Icons.logout,
              title: 'Terminar sessão',
              subtitle: '',
              onTap: () => NbaApp.of(context)?.logout(),
              isDestructive: true,
            ),
          ],
        ),
      ),
    );
  }

  String _favoriteTeamLabel(String? teamId) {
    if (teamId == null || teamId.isEmpty) return 'Padrão NBA';
    return ThemeService.teamThemes[teamId]?.teamName ?? 'Equipa $teamId';
  }

  String _measurementUnitLabel(String value) {
    return value == 'imperial' ? 'Pounds e inches' : 'Kg e cm';
  }

  String _currencyLabel(String value) {
    return switch (value) {
      'USD' => 'Dólar americano (USD)',
      'GBP' => 'Libra esterlina (GBP)',
      'BRL' => 'Real brasileiro (BRL)',
      _ => 'Euro (EUR)',
    };
  }

  void _showTeamPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Escolhe a tua equipa',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Color(0xFF17408B),
                child: Text(
                  'NBA',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: const Text(
                'Padrão NBA',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                NbaApp.of(context)?.updateTeam(null);
                Navigator.pop(context);
              },
            ),
            Expanded(
              child: ListView(
                children: ThemeService.teamThemes.entries.map((entry) {
                  final team = entry.value;
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: team.primaryColor,
                      child: Text(
                        team.teamName.substring(
                          team.teamName.lastIndexOf(' ') + 1,
                          team.teamName.lastIndexOf(' ') + 3,
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      team.teamName,
                      style: const TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      NbaApp.of(context)?.updateTeam(team.teamId);
                      Navigator.pop(context);
                    },
                  );
                }).toList(),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showMeasurementPicker(BuildContext context) {
    _showOptionPicker(
      context,
      title: 'Unidade de medida',
      options: const [
        _SettingsOption('metric', 'Kg e cm', 'Peso em kg e altura em cm'),
        _SettingsOption(
          'imperial',
          'Pounds e inches',
          'Peso em lb e altura em in',
        ),
      ],
      onSelected: database.preferencesDao.updateMeasurementUnit,
    );
  }

  void _showCurrencyPicker(BuildContext context) {
    _showOptionPicker(
      context,
      title: 'Moeda',
      options: const [
        _SettingsOption('EUR', 'Euro (EUR)', 'Preços em euros'),
        _SettingsOption('USD', 'Dólar americano (USD)', 'Preços em dólares'),
        _SettingsOption('GBP', 'Libra esterlina (GBP)', 'Preços em libras'),
        _SettingsOption('BRL', 'Real brasileiro (BRL)', 'Preços em reais'),
      ],
      onSelected: database.preferencesDao.updateCurrencyCode,
    );
  }

  void _showOptionPicker(
    BuildContext context, {
    required String title,
    required List<_SettingsOption> options,
    required Future<void> Function(String value) onSelected,
  }) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              ...options.map(
                (option) => ListTile(
                  title: Text(
                    option.title,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    option.subtitle,
                    style: const TextStyle(color: Colors.white54),
                  ),
                  onTap: () async {
                    await onSelected(option.value);
                    if (context.mounted) Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSection({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isDestructive
              ? const Color(0xFFC9082A)
              : const Color(0xFFFFC72C),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isDestructive ? const Color(0xFFC9082A) : Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: subtitle.isNotEmpty
            ? Text(
                subtitle,
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              )
            : null,
        trailing: const Icon(Icons.chevron_right, color: Colors.white38),
        onTap: onTap,
      ),
    );
  }

  Widget _buildSwitchSection({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: SwitchListTile(
        value: value,
        onChanged: onChanged,
        activeThumbColor: const Color(0xFFFFC72C),
        secondary: Icon(icon, color: const Color(0xFFFFC72C)),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.white54, fontSize: 12),
        ),
      ),
    );
  }
}

class _SettingsOption {
  final String value;
  final String title;
  final String subtitle;

  const _SettingsOption(this.value, this.title, this.subtitle);
}

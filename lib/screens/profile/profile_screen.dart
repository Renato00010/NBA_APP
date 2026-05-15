import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;
    final userEmail = NbaApp.of(context)?.userEmail ?? '';

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        title: Text(
          l10n.profile,
          style: const TextStyle(
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
            Text(
              l10n.hello,
              style: const TextStyle(
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
                      title: l10n.favoriteTeam,
                      subtitle: _favoriteTeamLabel(prefs?.favoriteTeamId),
                      onTap: () => _showTeamPicker(context),
                    ),
                    _buildSection(
                      icon: Icons.straighten,
                      title: l10n.measurements,
                      subtitle: _measurementUnitLabel(
                        prefs?.measurementUnit ?? 'metric',
                      ),
                      onTap: () => _showMeasurementPicker(context),
                    ),
                    _buildSection(
                      icon: Icons.payments_outlined,
                      title: l10n.currency,
                      subtitle: _currencyLabel(prefs?.currencyCode ?? 'EUR'),
                      onTap: () => _showCurrencyPicker(context),
                    ),
                    _buildSection(
                      icon: Icons.language,
                      title: l10n.language,
                      subtitle: _languageLabel(prefs?.language ?? 'pt'),
                      onTap: () => _showLanguagePicker(context),
                    ),
                    _buildSwitchSection(
                      icon: Icons.sports_basketball_outlined,
                      title: l10n.teamAlerts,
                      subtitle: l10n.teamAlertsSubtitle,
                      value: prefs?.favoriteTeamAlerts ?? true,
                      onChanged:
                          database.preferencesDao.updateFavoriteTeamAlerts,
                    ),
                    _buildSwitchSection(
                      icon: Icons.notifications_outlined,
                      title: l10n.notifications,
                      subtitle: l10n.notificationsSubtitle,
                      value: prefs?.notificationsOn ?? true,
                      onChanged: database.preferencesDao.updateNotifications,
                    ),
                  ],
                );
              },
            ),
            _buildSection(
              icon: Icons.logout,
              title: l10n.logout,
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
    final l10n = AppLocalizations.of(context)!;
    if (teamId == null || teamId.isEmpty) return l10n.defaultNBA;
    return ThemeService.teamThemes[teamId]?.teamName ?? 'Equipa $teamId';
  }

  String _measurementUnitLabel(String value) {
    final l10n = AppLocalizations.of(context)!;
    return value == 'imperial' ? l10n.poundsInches : l10n.kgCm;
  }

  String _currencyLabel(String value) {
    final l10n = AppLocalizations.of(context)!;
    return switch (value) {
      'USD' => l10n.usd,
      'GBP' => l10n.gbp,
      'BRL' => l10n.brl,
      _ => l10n.euro,
    };
  }

  String _languageLabel(String value) {
    final l10n = AppLocalizations.of(context)!;
    return value == 'en' ? l10n.english : l10n.portuguese;
  }

  void _showTeamPicker(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                l10n.chooseTeam,
                style: const TextStyle(
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
              title: Text(
                l10n.defaultNBA,
                style: const TextStyle(color: Colors.white),
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
    final l10n = AppLocalizations.of(context)!;
    _showOptionPicker(
      context,
      title: l10n.measurementUnit,
      options: [
        _SettingsOption('metric', l10n.kgCm, l10n.weightInKg + ' e ' + l10n.heightInCm),
        _SettingsOption(
          'imperial',
          l10n.poundsInches,
          l10n.weightInLb + ' e ' + l10n.heightInIn,
        ),
      ],
      onSelected: database.preferencesDao.updateMeasurementUnit,
    );
  }

  void _showCurrencyPicker(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    _showOptionPicker(
      context,
      title: l10n.currencyPicker,
      options: [
        _SettingsOption('EUR', l10n.euro, l10n.pricesInEuros),
        _SettingsOption('USD', l10n.usd, l10n.pricesInDollars),
        _SettingsOption('GBP', l10n.gbp, l10n.pricesInPounds),
        _SettingsOption('BRL', l10n.brl, l10n.pricesInReais),
      ],
      onSelected: database.preferencesDao.updateCurrencyCode,
    );
  }

  void _showLanguagePicker(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    _showOptionPicker(
      context,
      title: l10n.language,
      options: [
        _SettingsOption('pt', l10n.portuguese, ''),
        _SettingsOption('en', l10n.english, ''),
      ],
      onSelected: (langCode) async {
        await database.preferencesDao.updateLanguageCode(langCode);
        NbaApp.of(context)?.setLocale(langCode);
      },
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

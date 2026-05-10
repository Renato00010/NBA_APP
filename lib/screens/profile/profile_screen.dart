import 'package:flutter/material.dart';
import '../../main.dart';
import '../../services/theme_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

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
            _buildSection(
              icon: Icons.favorite_outlined,
              title: 'Equipa Favorita',
              subtitle: 'Selecionar equipa',
              onTap: () => _showTeamPicker(context),
            ),
            _buildSection(
              icon: Icons.palette_outlined,
              title: 'Tema',
              subtitle: 'Escuro',
              onTap: () {},
            ),
            _buildSection(
              icon: Icons.notifications_outlined,
              title: 'Notificações',
              subtitle: 'Ativas',
              onTap: () {},
            ),
            _buildSection(
              icon: Icons.logout,
              title: 'Terminar Sessão',
              subtitle: '',
              onTap: () => NbaApp.of(context)?.logout(),
              isDestructive: true,
            ),
          ],
        ),
      ),
    );
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
            // Opção padrão NBA
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
}

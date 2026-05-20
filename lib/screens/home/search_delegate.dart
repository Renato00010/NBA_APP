import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../db/app_database.dart';
import '../../main.dart';
import '../../widgets/team_logo.dart';
import '../games/player_detail_screen.dart';
import '../teams/team_detail_screen.dart';

class NbaSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Pesquisar jogadores ou equipas...';

  @override
  ThemeData appBarTheme(BuildContext context) {
    final theme = Theme.of(context);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white24, fontSize: 16),
        border: InputBorder.none,
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear, color: Colors.white54),
          onPressed: () => query = '',
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new, size: 20),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildResults(BuildContext context) => _buildSearchResults();

  @override
  Widget buildSuggestions(BuildContext context) => _buildSearchResults();

  Widget _buildSearchResults() {
    if (query.trim().isEmpty) {
      return Container(
        color: const Color(0xFF0A0A0A),
        child: const Center(
          child: Text(
            'Digita para pesquisar',
            style: TextStyle(
              color: Colors.white24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      );
    }

    return Container(
      color: const Color(0xFF0A0A0A),
      child: FutureBuilder<List<dynamic>>(
        future: _searchAll(query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final results = snapshot.data!;
          if (results.isEmpty) {
            return const Center(
              child: Text(
                'Sem resultados encontrados',
                style: TextStyle(color: Colors.white38),
              ),
            );
          }

          return ListView.builder(
            itemCount: results.length,
            padding: const EdgeInsets.symmetric(vertical: 16),
            itemBuilder: (context, index) {
              final item = results[index];
              if (item is Player) {
                return _buildPlayerResult(context, item);
              } else if (item is NbaTeam) {
                return _buildTeamResult(context, item);
              }
              return const SizedBox.shrink();
            },
          );
        },
      ),
    );
  }

  Future<List<dynamic>> _searchAll(String q) async {
    final players = await database.playersDao.searchPlayers(q);
    final teams = await database.teamsDao.searchTeams(q);
    return [...teams, ...players];
  }

  Widget _buildPlayerResult(BuildContext context, Player player) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      leading: CircleAvatar(
        backgroundColor: const Color(0xFF1A1A1A),
        backgroundImage: (player.photoWebpPath != null && !kIsWeb)
            ? AssetImage(player.photoWebpPath!) as ImageProvider
            : null,
        child: (player.photoWebpPath == null || kIsWeb)
            ? const Icon(Icons.person, color: Colors.white24)
            : null,
      ),
      title: Text(
        player.fullName.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: 16,
          letterSpacing: -0.5,
        ),
      ),
      subtitle: Text(
        'JOGADOR | ${player.position ?? 'N/A'}',
        style: const TextStyle(
          color: Colors.white38,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 1,
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlayerDetailScreen(player: player),
          ),
        );
      },
    );
  }

  Widget _buildTeamResult(BuildContext context, NbaTeam team) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      leading: Container(
        width: 40,
        height: 40,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.05),
          shape: BoxShape.circle,
        ),
        child: TeamLogo(teamId: team.teamId, size: 30),
      ),
      title: Text(
        team.name.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: 16,
          letterSpacing: -0.5,
        ),
      ),
      subtitle: Text(
        'EQUIPA | ${team.city}',
        style: const TextStyle(
          color: Colors.white38,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 1,
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                TeamDetailScreen(teamId: team.teamId, initialTeam: team),
          ),
        );
      },
    );
  }
}

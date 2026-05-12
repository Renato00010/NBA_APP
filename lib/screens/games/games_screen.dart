import 'package:flutter/material.dart';
import '../../main.dart';
import '../../db/app_database.dart';
import '../../widgets/team_logo.dart';
import 'players_screen.dart';
import '../teams/team_detail_screen.dart';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  List<CachedGame> _liveGames = [];
  List<CachedGame> _todayGames = [];
  List<CachedGame> _pastResults = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadGames();
  }

  Future<void> _loadGames() async {
    try {
      await repository.getTeams();
      final today = DateTime.now();
      
      // Busca jogos de hoje (inclui janela de ontem/amanhã no repo)
      final games = await repository.getGamesByDate(today);
      
      // Busca resultados recentes (últimos 7 dias)
      final recent = await repository.getRecentResults();

      setState(() {
        _liveGames = games.where((g) => g.status.toLowerCase().contains('qtr') || g.status.toLowerCase().contains('half') || g.status == 'live').toList();
        _todayGames = games;
        _pastResults = recent.where((g) => g.status == 'Final').toList();
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        title: const Text(
          'Jogos',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.people_outlined, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PlayersScreen()),
              );
            },
          ),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            TabBar(
              indicatorColor: theme.colorScheme.tertiary,
              labelColor: theme.colorScheme.tertiary,
              unselectedLabelColor: Colors.white54,
              tabs: const [
                Tab(text: 'Ao Vivo'),
                Tab(text: 'Hoje'),
                Tab(text: 'Resultados'),
              ],
            ),
            Expanded(
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : TabBarView(
                      children: [
                        _liveGames.isEmpty
                            ? const Center(
                                child: Text(
                                  'Sem jogos ao vivo',
                                  style: TextStyle(color: Colors.white54),
                                ),
                              )
                            : _buildGamesList(_liveGames, theme),
                        _todayGames.isEmpty
                            ? const Center(
                                child: Text(
                                  'Sem jogos hoje',
                                  style: TextStyle(color: Colors.white54),
                                ),
                              )
                            : _buildGamesList(_todayGames, theme),
                        _buildGamesList(_pastResults, theme),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGamesList(List<CachedGame> games, ThemeData theme) {
    if (games.isEmpty) {
      return const Center(
        child: Text('Sem resultados', style: TextStyle(color: Colors.white54)),
      );
    }
    return RefreshIndicator(
      onRefresh: _loadGames,
      color: theme.colorScheme.primary,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: games.length,
        itemBuilder: (context, index) {
          final game = games[index];
          final isLive = game.status == 'live';
          final homeName = repository.getTeamName(game.homeTeamId);
          final awayName = repository.getTeamName(game.awayTeamId);
          final homeCity = repository.getTeamCity(game.homeTeamId);
          final awayCity = repository.getTeamCity(game.awayTeamId);
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A1A),
              borderRadius: BorderRadius.circular(12),
              border: isLive
                  ? Border.all(color: theme.colorScheme.secondary, width: 1)
                  : null,
            ),
            child: Column(
              children: [
                if (isLive)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const Text(
                      'AO VIVO',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                if (isLive) const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () => _openTeam(game.homeTeamId),
                        child: Column(
                          children: [
                            const SizedBox(height: 2),
                            TeamLogo(
                              teamId: game.homeTeamId,
                              size: 42,
                              fallbackColor: Colors.white38,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              homeCity,
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              homeName.split(' ').last,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            '${game.scoreHome} - ${game.scoreAway}',
                            style: TextStyle(
                              color: theme.colorScheme.tertiary,
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            game.status,
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 11,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () => _openTeam(game.awayTeamId),
                        child: Column(
                          children: [
                            const SizedBox(height: 2),
                            TeamLogo(
                              teamId: game.awayTeamId,
                              size: 42,
                              fallbackColor: Colors.white38,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              awayCity,
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 10,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              awayName.split(' ').last,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _openTeam(String teamId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TeamDetailScreen(teamId: teamId)),
    );
  }
}

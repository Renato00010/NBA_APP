import 'package:flutter/material.dart';
import '../../main.dart';
import '../../db/app_database.dart';
import '../teams/team_detail_screen.dart';
import '../../widgets/team_logo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<NbaTeam> _teams = [];
  List<CachedGame> _games = [];
  bool _loadingTeams = true;
  bool _loadingGames = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final teams = await repository.getTeams();
      setState(() {
        _teams = teams;
        _loadingTeams = false;
      });
    } catch (e) {
      setState(() => _loadingTeams = false);
    }

    try {
      final games = await repository.getGamesByDate(DateTime.now());
      setState(() {
        _games = games;
        _loadingGames = false;
      });
    } catch (e) {
      setState(() => _loadingGames = false);
    }
  }

  void _openTeam(String teamId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TeamDetailScreen(teamId: teamId)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        title: Text(
          'NBA',
          style: TextStyle(
            color: theme.colorScheme.tertiary,
            fontSize: 24,
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        color: theme.colorScheme.primary,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Equipas
              const Text(
                'Equipas NBA',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              _loadingTeams
                  ? const Center(child: CircularProgressIndicator())
                  : SizedBox(
                      height: 90,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _teams.length,
                        itemBuilder: (context, index) {
                          final team = _teams[index];
                          return InkWell(
                            borderRadius: BorderRadius.circular(12),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TeamDetailScreen(
                                    teamId: team.teamId,
                                    initialTeam: team,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 10),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary.withValues(
                                  alpha: 0.15,
                                ),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: theme.colorScheme.primary.withValues(
                                    alpha: 0.4,
                                  ),
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TeamLogo(
                                    teamId: team.teamId,
                                    size: 40,
                                    fallbackColor: theme.colorScheme.primary,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    team.name.split(' ').last,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
              const SizedBox(height: 24),

              // Jogos de hoje
              const Text(
                'Jogos de Hoje',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 12),
              _loadingGames
                  ? const Center(child: CircularProgressIndicator())
                  : _games.isEmpty
                  ? Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          'Sem jogos hoje',
                          style: TextStyle(color: Colors.white54),
                        ),
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _games.length,
                      itemBuilder: (context, index) {
                        final game = _games[index];
                        final homeName = repository.getTeamName(
                          game.homeTeamId,
                        );
                        final awayName = repository.getTeamName(
                          game.awayTeamId,
                        );
                        final homeCity = repository.getTeamCity(
                          game.homeTeamId,
                        );
                        final awayCity = repository.getTeamCity(
                          game.awayTeamId,
                        );
                        final isLive = game.status == 'live';

                        return Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1A1A),
                            borderRadius: BorderRadius.circular(12),
                            border: isLive
                                ? Border.all(
                                    color: theme.colorScheme.secondary,
                                    width: 1,
                                  )
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
                                  margin: const EdgeInsets.only(bottom: 8),
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(10),
                                      onTap: () => _openTeam(game.homeTeamId),
                                      child: Column(
                                        children: [
                                          TeamLogo(
                                            teamId: game.homeTeamId,
                                            size: 36,
                                            fallbackColor: Colors.white38,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            homeCity,
                                            style: const TextStyle(
                                              color: Colors.white54,
                                              fontSize: 10,
                                            ),
                                          ),
                                          Text(
                                            homeName.split(' ').last,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        '${game.scoreHome}  -  ${game.scoreAway}',
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
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(10),
                                      onTap: () => _openTeam(game.awayTeamId),
                                      child: Column(
                                        children: [
                                          TeamLogo(
                                            teamId: game.awayTeamId,
                                            size: 36,
                                            fallbackColor: Colors.white38,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            awayCity,
                                            style: const TextStyle(
                                              color: Colors.white54,
                                              fontSize: 10,
                                            ),
                                          ),
                                          Text(
                                            awayName.split(' ').last,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700,
                                            ),
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
            ],
          ),
        ),
      ),
    );
  }
}

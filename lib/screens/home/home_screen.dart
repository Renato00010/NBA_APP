import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import '../../main.dart';
import '../../db/app_database.dart';
import '../teams/team_detail_screen.dart';
import '../../widgets/team_logo.dart';
import '../../services/news_api_service.dart';
import 'search_delegate.dart';
import '../news/news_detail_screen.dart';
import '../comparator/player_comparator_screen.dart';
import '../profile/profile_screen.dart';
import '../games/game_detail_screen.dart';
import '../../utils/game_status_utils.dart';
import '../../widgets/basketball_loader.dart';
import '../../widgets/live_game_clock.dart';
import '../chatbot/ai_chatbot_screen.dart';
import '../playground/playground_hub_screen.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final NewsApiService _newsApi = NewsApiService();
  List<NbaTeam> _teams = [];
  List<CachedGame> _games = [];
  List<dynamic> _news = [];
  bool _loadingTeams = true;
  bool _loadingGames = true;
  bool _loadingNews = true;
  bool _refreshingGames = false;
  Timer? _liveRefreshTimer;

  @override
  void initState() {
    super.initState();
    _loadData();
    _liveRefreshTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      _loadGames(isBackground: true);
    });
  }

  @override
  void dispose() {
    _liveRefreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadData() async {
    try {
      final news = await _newsApi.getNbaNews();
      if (mounted) {
        setState(() {
          _news = news;
          _loadingNews = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _loadingNews = false);
    }

    try {
      final teams = await repository.getTeams();
      if (mounted) {
        setState(() {
          _teams = teams;
          _loadingTeams = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _loadingTeams = false);
    }

    try {
      await _loadGames();
    } catch (e) {
      if (mounted) setState(() => _loadingGames = false);
    }
  }

  Future<void> _loadGames({bool isBackground = false}) async {
    if (_refreshingGames) return;

    _refreshingGames = true;
    try {
      final games = await repository.getGamesByDate(DateTime.now());
      if (mounted) {
        setState(() {
          _games = games;
          _loadingGames = false;
        });
      }
    } catch (_) {
      if (mounted && !isBackground) {
        setState(() => _loadingGames = false);
      }
    } finally {
      _refreshingGames = false;
    }
  }

  void _openTeam(String teamId, NbaTeam? initialTeam) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            TeamDetailScreen(teamId: teamId, initialTeam: initialTeam),
      ),
    );
  }

  void _openGame(CachedGame game) {
    final homeName = repository.getTeamName(game.homeTeamId);
    final awayName = repository.getTeamName(game.awayTeamId);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GameDetailScreen(
          gameId: game.gameId,
          homeName: homeName,
          awayName: awayName,
          gameDate: game.gameDate,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor:
            theme.colorScheme.primary, // Cor dinâmica da equipa favorita
        elevation: 4,
        centerTitle: false,
        title: const Text(
          'NBA',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white, size: 20),
            onPressed: () {
              showSearch(context: context, delegate: NbaSearchDelegate());
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.account_circle_outlined,
              color: Colors.white70,
              size: 22,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.compare_arrows,
              color: Colors.white70,
              size: 22,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PlayerComparatorScreen(),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _loadData,
        color: theme.colorScheme.primary,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!_loadingNews && _news.isNotEmpty) _buildNewsTicker(),
              _buildPlaygroundEntryCard(theme),
              const SizedBox(height: 20),
              _buildSectionHeader(_t(context, 'Equipas', 'Teams')),

              const SizedBox(height: 12),
              _buildTeamsList(theme),
              const SizedBox(height: 32),
              _buildSectionHeader(
                _t(context, 'Jogos de Hoje', "Today's Games"),
              ),
              const SizedBox(height: 16),
              _buildGamesSection(theme),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withValues(alpha: 0.4),
              blurRadius: 12,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            )
          ],
        ),

        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AiChatbotScreen(),
              ),
            );
          },
          backgroundColor: theme.colorScheme.primary,
          elevation: 0,
          child: const Icon(
            Icons.smart_toy_outlined,
            color: Colors.white,
            size: 26,
          ),
        ),
      ),
    );
  }


  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w800,
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.white38),
        ],
      ),
    );
  }

  Widget _buildNewsTicker() {
    return Container(
      height: 44,
      margin: const EdgeInsets.only(top: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _news.length,
        itemBuilder: (context, index) {
          final article = _news[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailScreen(article: article),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(left: 18),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFF1A1A1A),
                borderRadius: BorderRadius.circular(22),
                border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.flash_on, size: 14, color: Colors.amber),
                  const SizedBox(width: 8),
                  Text(
                    article['title'] ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTeamsList(ThemeData theme) {
    if (_loadingTeams) {
      return const SizedBox(
        height: 110,
        child: Center(child: BasketballLoader()),
      );
    }
    return SizedBox(
      height: 115,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _teams.length,
        itemBuilder: (context, index) {
          final team = _teams[index];
          return _HoverTeamItem(
            team: team,
            theme: theme,
            onTap: () => _openTeam(team.teamId, team),
          );
        },
      ),
    );
  }

  Widget _buildGamesSection(ThemeData theme) {
    if (_loadingGames) {
      return const Center(child: BasketballLoader());
    }
    if (_games.isEmpty) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 18),
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: const Color(0xFF151515),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: Column(
            children: [
              const Icon(
                Icons.calendar_today_outlined,
                color: Colors.white12,
                size: 48,
              ),
              const SizedBox(height: 16),
              Text(
                _t(
                  context,
                  'Sem jogos agendados para hoje',
                  'No games scheduled for today',
                ),
                style: const TextStyle(color: Colors.white38, fontSize: 14),
              ),
            ],
          ),
        ),
      );
    }
    return Column(
      children: _games.map((game) => _buildGameCard(game, theme)).toList(),
    );
  }

  String _t(BuildContext context, String pt, String en) {
    return Localizations.localeOf(context).languageCode == 'en' ? en : pt;
  }

  Widget _buildGameCard(CachedGame game, ThemeData theme) {
    final isLive = GameStatusUtils.isLive(game.status);
    final homeName = repository.getTeamName(game.homeTeamId).split(' ').last;
    final awayName = repository.getTeamName(game.awayTeamId).split(' ').last;

    return GestureDetector(
      onTap: () => _openGame(game),
      child: Container(
        margin: const EdgeInsets.only(left: 18, right: 18, bottom: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: isLive
                ? theme.colorScheme.primary.withValues(alpha: 0.4)
                : Colors.white.withValues(alpha: 0.08),
            width: isLive ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.03),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTeamInGame(
                    game.homeTeamId,
                    homeName,
                    'game_${game.gameId}_${game.homeTeamId}',
                  ),
                  Column(
                    children: [
                      if (isLive)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          margin: const EdgeInsets.only(bottom: 8),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE11D48),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'LIVE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      Text(
                        '${game.scoreHome} - ${game.scoreAway}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -1,
                        ),
                      ),
                      LiveGameClock(
                        status: game.status,
                        style: TextStyle(
                          color: isLive
                              ? const Color(0xFFE11D48)
                              : Colors.white38,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  _buildTeamInGame(
                    game.awayTeamId,
                    awayName,
                    'game_${game.gameId}_${game.awayTeamId}',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTeamInGame(String teamId, String name, String heroTag) {
    return Column(
      children: [
        TeamLogo(teamId: teamId, size: 54, heroTag: heroTag),
        const SizedBox(height: 10),
        Text(
          name.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildPlaygroundEntryCard(ThemeData theme) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 18, right: 18, top: 22, bottom: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: const LinearGradient(
          colors: [Color(0xFFFF8C00), Color(0xFF8A2BE2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8A2BE2).withValues(alpha: 0.35),
            blurRadius: 15,
            spreadRadius: 1,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PlaygroundHubScreen(),
                ),
              );
            },
            splashColor: Colors.white.withValues(alpha: 0.15),
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.25),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.sports_basketball_outlined,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _t(context, 'NOVO • DIVERSÃO', 'NEW • FUN ZONE'),
                            style: const TextStyle(
                              color: Colors.amberAccent,
                              fontSize: 8.5,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _t(context, 'ZONA PLAYGROUND', 'PLAYGROUND ZONE'),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _t(
                            context,
                            'Joga Basket Grid, Fantasy Draft e Trivia Quiz!',
                            'Play Basket Grid, Fantasy Draft & Trivia Quiz!',
                          ),
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 11.5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    color: Colors.white,
                    size: 28,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _HoverTeamItem extends StatefulWidget {
  final NbaTeam team;
  final ThemeData theme;
  final VoidCallback onTap;

  const _HoverTeamItem({
    required this.team,
    required this.theme,
    required this.onTap,
  });

  @override
  State<_HoverTeamItem> createState() => _HoverTeamItemState();
}

class _HoverTeamItemState extends State<_HoverTeamItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          width: 85,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          transform: _isHovered
              ? (Matrix4.identity()..scaleByDouble(1.15, 1.15, 1, 1))
              : Matrix4.identity(),
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: _isHovered
                        ? [Colors.white, widget.theme.colorScheme.primary]
                        : [
                            widget.theme.colorScheme.primary,
                            widget.theme.colorScheme.tertiary,
                          ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: _isHovered
                      ? [
                          BoxShadow(
                            color: widget.theme.colorScheme.primary.withValues(
                              alpha: 0.6,
                            ),
                            blurRadius: 15,
                            spreadRadius: 2,
                          ),
                        ]
                      : [],
                ),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xFF1A1A1A),
                    shape: BoxShape.circle,
                  ),
                  child: TeamLogo(teamId: widget.team.teamId, size: 42),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.team.name.split(' ').last.toUpperCase(),
                style: TextStyle(
                  color: _isHovered ? Colors.white : Colors.white60,
                  fontSize: 10,
                  fontWeight: _isHovered ? FontWeight.w900 : FontWeight.w700,
                  letterSpacing: 0.8,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

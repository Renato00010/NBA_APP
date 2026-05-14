import 'package:flutter/material.dart';
import '../../main.dart';
import '../../db/app_database.dart';
import '../teams/team_detail_screen.dart';
import '../../widgets/team_logo.dart';
import '../../services/news_api_service.dart';
import 'search_delegate.dart';
import '../news/news_detail_screen.dart';
import '../profile/profile_screen.dart';
import '../comparator/player_comparator_screen.dart';

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

  @override
  void initState() {
    super.initState();
    _loadData();
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
      final games = await repository.getGamesByDate(DateTime.now());
      if (mounted) {
        setState(() {
          _games = games;
          _loadingGames = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _loadingGames = false);
    }
  }

  void _openTeam(String teamId, NbaTeam? initialTeam) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TeamDetailScreen(
          teamId: teamId,
          initialTeam: initialTeam,
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
        backgroundColor: theme.colorScheme.primary, // Cor dinâmica da equipa favorita
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
              showSearch(
                context: context,
                delegate: NbaSearchDelegate(),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle_outlined, color: Colors.white70, size: 22),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.compare_arrows, color: Colors.white70, size: 22),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PlayerComparatorScreen()),
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
              const SizedBox(height: 20),
              _buildSectionHeader('Equipas'),
              const SizedBox(height: 12),
              _buildTeamsList(theme),
              const SizedBox(height: 32),
              _buildSectionHeader('Jogos de Hoje'),
              const SizedBox(height: 16),
              _buildGamesSection(theme),
              const SizedBox(height: 100),
            ],
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
      return const SizedBox(height: 110, child: Center(child: CircularProgressIndicator()));
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
      return const Center(child: CircularProgressIndicator());
    }
    if (_games.isEmpty) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 18),
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: const Color(0xFF151515),
          borderRadius: BorderRadius.circular(24),
        ),
        child: const Center(
          child: Column(
            children: [
              Icon(Icons.calendar_today_outlined, color: Colors.white12, size: 48),
              SizedBox(height: 16),
              Text(
                'Sem jogos agendados para hoje',
                style: TextStyle(color: Colors.white38, fontSize: 14),
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

  Widget _buildGameCard(CachedGame game, ThemeData theme) {
    final isLive = game.status.toLowerCase() == 'live';
    final homeName = repository.getTeamName(game.homeTeamId).split(' ').last;
    final awayName = repository.getTeamName(game.awayTeamId).split(' ').last;

    return Container(
      margin: const EdgeInsets.only(left: 18, right: 18, bottom: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF151515),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: isLive ? theme.colorScheme.primary.withValues(alpha: 0.4) : Colors.white.withValues(alpha: 0.03),
          width: isLive ? 2 : 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildTeamInGame(game.homeTeamId, homeName),
          Column(
            children: [
              if (isLive)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE11D48),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'LIVE',
                    style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w900),
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
              Text(
                game.status.toUpperCase(),
                style: TextStyle(
                  color: isLive ? const Color(0xFFE11D48) : Colors.white38,
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          _buildTeamInGame(game.awayTeamId, awayName),
        ],
      ),
    );
  }

  Widget _buildTeamInGame(String teamId, String name) {
    return Column(
      children: [
        TeamLogo(teamId: teamId, size: 54),
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
          transform: _isHovered ? (Matrix4.identity()..scale(1.15)) : Matrix4.identity(),
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
                      : [widget.theme.colorScheme.primary, widget.theme.colorScheme.tertiary],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: _isHovered ? [
                    BoxShadow(
                      color: widget.theme.colorScheme.primary.withValues(alpha: 0.6),
                      blurRadius: 15,
                      spreadRadius: 2,
                    )
                  ] : [],
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

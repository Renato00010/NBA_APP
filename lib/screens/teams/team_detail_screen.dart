import 'package:flutter/foundation.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../db/app_database.dart';
import '../../main.dart';
import '../../services/theme_service.dart';
import '../../services/season_report_service.dart';
import '../../widgets/team_logo.dart';
import '../games/player_detail_screen.dart';

bool _isEnglish(BuildContext context) =>
    Localizations.localeOf(context).languageCode == 'en';

String _t(BuildContext context, String pt, String en) =>
    _isEnglish(context) ? en : pt;

class TeamDetailScreen extends StatefulWidget {
  final String teamId;
  final NbaTeam? initialTeam;

  const TeamDetailScreen({super.key, required this.teamId, this.initialTeam});

  @override
  State<TeamDetailScreen> createState() => _TeamDetailScreenState();
}

class _TeamDetailScreenState extends State<TeamDetailScreen> {
  NbaTeam? _team;
  List<Player> _players = [];
  List<CachedGame> _games = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _team = widget.initialTeam;
    _loadTeam();
  }

  Future<void> _loadTeam() async {
    try {
      await repository.getTeams();
      await repository.getPlayers();
      final team = await database.teamsDao.getTeamById(widget.teamId);
      final players = await database.playersDao.getAllPlayers();
      final games = await repository.getTeamSeasonGames(widget.teamId);
      if (!mounted) return;
      setState(() {
        _team = team ?? widget.initialTeam;
        _players = players.where((p) => p.teamId == widget.teamId).toList()
          ..sort((a, b) => a.fullName.compareTo(b.fullName));
        _games =
            games
                .where(
                  (g) =>
                      g.homeTeamId == widget.teamId ||
                      g.awayTeamId == widget.teamId,
                )
                .toList()
              ..sort((a, b) => b.gameDate.compareTo(a.gameDate));
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final teamTheme = ThemeService.getTheme(widget.teamId);
    final teamName = _team?.name ?? teamTheme.teamName;
    final city = _team?.city ?? '';

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: RefreshIndicator(
        onRefresh: _loadTeam,
        color: teamTheme.secondaryColor,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 245,
              backgroundColor: teamTheme.primaryColor,
              title: Text(
                teamName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontWeight: FontWeight.w800),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: _TeamHeader(
                  teamId: widget.teamId,
                  teamName: teamName,
                  city: city,
                  primaryColor: teamTheme.primaryColor,
                  secondaryColor: teamTheme.secondaryColor,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: _loading
                    ? const Padding(
                        padding: EdgeInsets.only(top: 80),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _FavoriteTeamPanel(
                            teamId: widget.teamId,
                            teamName: teamName,
                            accentColor: teamTheme.secondaryColor,
                          ),
                          const SizedBox(height: 16),
                          _SeasonReportButton(
                            teamId: widget.teamId,
                            teamName: teamName,
                            city: city,
                            players: _players,
                            games: _games,
                            accentColor: teamTheme.secondaryColor,
                          ),
                          const SizedBox(height: 16),
                          _InfoGrid(team: _team, players: _players),
                          const SizedBox(height: 22),
                          _SectionHeader(
                            title: _t(context, 'Jogos da equipa', 'Team Games'),
                            trailing: '${_games.length}',
                          ),
                          const SizedBox(height: 10),
                          _games.isEmpty
                              ? _EmptyState(
                                  text: _t(
                                    context,
                                    'Sem jogos guardados para esta equipa',
                                    'No saved games for this team',
                                  ),
                                )
                              : Column(
                                  children: _games
                                      .take(5)
                                      .map(
                                        (game) => _TeamGameTile(
                                          game: game,
                                          teamId: widget.teamId,
                                          accentColor: teamTheme.secondaryColor,
                                        ),
                                      )
                                      .toList(),
                                ),
                          const SizedBox(height: 22),
                          _SectionHeader(
                            title: _t(context, 'Plantel', 'Roster'),
                            trailing: '${_players.length}',
                          ),
                          const SizedBox(height: 10),
                          _players.isEmpty
                              ? _EmptyState(
                                  text: _t(
                                    context,
                                    'Ainda nao ha jogadores guardados para esta equipa',
                                    'No saved players for this team yet',
                                  ),
                                )
                              : Column(
                                  children: _players
                                      .map(
                                        (player) => _PlayerTile(
                                          player: player,
                                          accentColor: teamTheme.primaryColor,
                                        ),
                                      )
                                      .toList(),
                                ),
                        ],
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TeamHeader extends StatelessWidget {
  final String teamId;
  final String teamName;
  final String city;
  final Color primaryColor;
  final Color secondaryColor;

  const _TeamHeader({
    required this.teamId,
    required this.teamName,
    required this.city,
    required this.primaryColor,
    required this.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      child: Stack(
        children: [
          Positioned(
            right: -24,
            bottom: -20,
            child: Opacity(
              opacity: 0.18,
              child: TeamLogo(
                teamId: teamId,
                size: 210,
                fallbackColor: Colors.white,
              ),
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 24,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  width: 92,
                  height: 92,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: secondaryColor, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.24),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: TeamLogo(
                    teamId: teamId,
                    size: 68,
                    fallbackColor: primaryColor,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (city.isNotEmpty)
                        Text(
                          city.toUpperCase(),
                          style: TextStyle(
                            color: secondaryColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      const SizedBox(height: 4),
                      Text(
                        teamName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          height: 1.05,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SeasonReportButton extends StatelessWidget {
  final String teamId;
  final String teamName;
  final String city;
  final List<Player> players;
  final List<CachedGame> games;
  final Color accentColor;

  const _SeasonReportButton({
    required this.teamId,
    required this.teamName,
    required this.city,
    required this.players,
    required this.games,
    required this.accentColor,
  });

  Future<void> _handleGenerateReport(BuildContext context) async {
    try {
      await SeasonReportService.generateAndPrintSeasonReport(
        teamId: teamId,
        teamName: teamName,
        city: city,
        players: players,
        games: games,
        languageCode: Localizations.localeOf(context).languageCode,
      );
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${_t(context, 'Erro ao gerar relatorio', 'Error generating report')}: $e',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [accentColor, accentColor.withValues(alpha: 0.7)],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: accentColor.withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _handleGenerateReport(context),
          borderRadius: BorderRadius.circular(16),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.assessment_outlined,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  _t(context, 'RELATORIO DE EPOCA', 'SEASON REPORT'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FavoriteTeamPanel extends StatelessWidget {
  final String teamId;
  final String teamName;
  final Color accentColor;

  const _FavoriteTeamPanel({
    required this.teamId,
    required this.teamName,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserPreference?>(
      stream: database.preferencesDao.watchPreferences(),
      builder: (context, snapshot) {
        final isFavorite = snapshot.data?.favoriteTeamId == teamId;
        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isFavorite
                  ? accentColor.withValues(alpha: 0.8)
                  : Colors.white.withValues(alpha: 0.06),
            ),
          ),
          child: Row(
            children: [
              Icon(
                isFavorite ? Icons.star : Icons.star_border,
                color: isFavorite ? accentColor : Colors.white38,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  isFavorite
                      ? _t(
                          context,
                          '$teamName e a tua equipa favorita',
                          '$teamName is your favorite team',
                        )
                      : _t(
                          context,
                          'Definir como equipa favorita',
                          'Set as favorite team',
                        ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              TextButton(
                onPressed: () =>
                    NbaApp.of(context)?.updateTeam(isFavorite ? null : teamId),
                child: Text(
                  isFavorite
                      ? _t(context, 'Remover', 'Remove')
                      : _t(context, 'Escolher', 'Choose'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _InfoGrid extends StatelessWidget {
  final NbaTeam? team;
  final List<Player> players;

  const _InfoGrid({required this.team, required this.players});

  @override
  Widget build(BuildContext context) {
    final guards = players
        .where((p) => (p.position ?? '').contains('G'))
        .length;
    final forwards = players
        .where((p) => (p.position ?? '').contains('F'))
        .length;
    final centers = players
        .where((p) => (p.position ?? '').contains('C'))
        .length;

    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 2.2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        _InfoTile(
          label: _t(context, 'Conferencia', 'Conference'),
          value: team?.conference ?? '-',
        ),
        _InfoTile(
          label: _t(context, 'Divisao', 'Division'),
          value: team?.division ?? '-',
        ),
        _InfoTile(
          label: _t(context, 'Plantel', 'Roster'),
          value: _t(
            context,
            '${players.length} jogadores',
            '${players.length} players',
          ),
        ),
        _InfoTile(
          label: _t(context, 'Posicoes', 'Positions'),
          value: '$guards G  $forwards F  $centers C',
        ),
      ],
    );
  }
}

class _InfoTile extends StatelessWidget {
  final String label;
  final String value;

  const _InfoTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white54, fontSize: 11),
          ),
          const SizedBox(height: 5),
          Text(
            value.isEmpty ? '-' : value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String trailing;

  const _SectionHeader({required this.title, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Text(
          trailing,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _TeamGameTile extends StatelessWidget {
  final CachedGame game;
  final String teamId;
  final Color accentColor;

  const _TeamGameTile({
    required this.game,
    required this.teamId,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    final opponentId = game.homeTeamId == teamId
        ? game.awayTeamId
        : game.homeTeamId;
    final opponentName = repository.getTeamName(opponentId);
    final isHome = game.homeTeamId == teamId;
    final teamScore = isHome ? game.scoreHome : game.scoreAway;
    final opponentScore = isHome ? game.scoreAway : game.scoreHome;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          TeamLogo(teamId: opponentId, size: 38, fallbackColor: Colors.white38),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${isHome ? 'vs' : '@'} $opponentName',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _formatDate(game.gameDate),
                  style: const TextStyle(color: Colors.white54, fontSize: 11),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '$teamScore - $opponentScore',
                style: TextStyle(
                  color: accentColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                game.status,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.white54, fontSize: 11),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }
}

class _PlayerTile extends StatelessWidget {
  final Player player;
  final Color accentColor;

  const _PlayerTile({required this.player, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PlayerDetailScreen(player: player),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            _PlayerAvatar(player: player, accentColor: accentColor),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    player.displayName ?? player.fullName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    [
                      if ((player.jerseyNumber ?? '').isNotEmpty)
                        '#${player.jerseyNumber}',
                      player.position ?? '-',
                      player.country ?? '-',
                    ].join('  •  '),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white54, fontSize: 11),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.white38),
          ],
        ),
      ),
    );
  }
}

class _PlayerAvatar extends StatelessWidget {
  final Player player;
  final Color accentColor;

  const _PlayerAvatar({required this.player, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    final photoPath = player.photoWebpPath;
    ImageProvider? provider;

    if (photoPath != null && photoPath.isNotEmpty) {
      if (photoPath.startsWith('assets/')) {
        provider = AssetImage(photoPath);
      } else if (photoPath.startsWith('http')) {
        provider = CachedNetworkImageProvider(photoPath);
      } else if (!kIsWeb) {
        provider = AssetImage(photoPath);
      }
    }

    return CircleAvatar(
      radius: 24,
      backgroundColor: accentColor.withValues(alpha: 0.28),
      backgroundImage: provider,
      child: provider == null
          ? Text(
              player.fullName.isNotEmpty ? player.fullName[0] : '?',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            )
          : null,
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String text;

  const _EmptyState({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white54, fontSize: 13),
      ),
    );
  }
}

import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../db/app_database.dart';
import '../../main.dart';
import '../../widgets/team_logo.dart';

class PlayerDetailScreen extends StatefulWidget {
  final Player player;
  const PlayerDetailScreen({super.key, required this.player});

  @override
  State<PlayerDetailScreen> createState() => _PlayerDetailScreenState();
}

class _PlayerDetailScreenState extends State<PlayerDetailScreen> {
  Map<String, dynamic>? _stats;
  bool _loading = true;
  String _teamName = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final teamName = repository.getTeamName(widget.player.teamId);
    final stats = await repository.getPlayerStats(
      int.parse(widget.player.playerId),
    );
    setState(() {
      _stats = stats;
      _teamName = teamName;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final player = widget.player;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: theme.colorScheme.primary,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                player.displayName ?? player.fullName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(color: theme.colorScheme.primary),
                  _playerPhoto(player),
                  Positioned(top: 54, right: 16, child: _teamLogo(player)),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            theme.colorScheme.primary,
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder<UserPreference?>(
                    stream: database.preferencesDao.watchPreferences(),
                    builder: (context, snapshot) {
                      final unit = snapshot.data?.measurementUnit ?? 'metric';
                      return _playerSummaryCard(player, unit, theme);
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Estatísticas 2024-25',
                    style: TextStyle(
                      color: theme.colorScheme.tertiary,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _statsContent(theme),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _playerSummaryCard(
    Player player,
    String measurementUnit,
    ThemeData theme,
  ) {
    final teamLabel = _teamName.isNotEmpty ? _teamName : player.teamId;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      player.displayName ?? player.fullName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _summaryChip(player.position ?? '-'),
                        _summaryChip(player.country ?? '-'),
                        _summaryChip(teamLabel),
                      ],
                    ),
                  ],
                ),
              ),
              _careerInfoButton(player, measurementUnit, theme),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: _metricTile('Número', player.jerseyNumber ?? '-'),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _metricTile(
                  'Altura',
                  _formatHeight(player.heightCm, measurementUnit),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _metricTile(
                  'Peso',
                  _formatWeight(player.weightKg, measurementUnit),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _careerInfoButton(
    Player player,
    String measurementUnit,
    ThemeData theme,
  ) {
    return Tooltip(
      message: 'Mais informações',
      child: IconButton(
        onPressed: () => _showPlayerInfoSheet(player, measurementUnit, theme),
        icon: Stack(
          alignment: Alignment.center,
          children: const [
            Icon(Icons.sports_basketball, color: Color(0xFFFFC72C), size: 30),
            Icon(Icons.info_outline, color: Colors.black, size: 17),
          ],
        ),
      ),
    );
  }

  void _showPlayerInfoSheet(
    Player player,
    String measurementUnit,
    ThemeData theme,
  ) {
    final teamLabel = _teamName.isNotEmpty ? _teamName : player.teamId;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      width: 42,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Row(
                    children: [
                      _miniLogo(player),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              player.displayName ?? player.fullName,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$teamLabel • ${player.position ?? '-'}',
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
                  _sheetSectionTitle('Biografia'),
                  _sheetRow('Nome completo', player.fullName),
                  _sheetRow('Número', player.jerseyNumber ?? '-'),
                  _sheetRow('País', player.country ?? '-'),
                  _sheetRow('Nascimento', _formatDateOrDash(player.birthDate)),
                  _sheetRow('Idade', _formatAge(player.birthDate)),
                  _sheetRow(
                    'Altura',
                    _formatHeight(player.heightCm, measurementUnit),
                  ),
                  _sheetRow(
                    'Peso',
                    _formatWeight(player.weightKg, measurementUnit),
                  ),
                  const SizedBox(height: 18),
                  _sheetSectionTitle('Carreira'),
                  _sheetRow(
                    _previousTeamLabel(player.previousTeam),
                    player.previousTeam ?? '-',
                  ),
                  _sheetRow(
                    'Experiência NBA',
                    player.experienceYears != null
                        ? '${player.experienceYears} anos'
                        : '-',
                  ),
                  _sheetCareerPath(player, teamLabel, theme),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _statsContent(ThemeData theme) {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_stats == null) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            'Sem estatísticas disponíveis',
            style: TextStyle(color: Colors.white54),
          ),
        ),
      );
    }

    return Column(
      children: [
        Row(
          children: [
            _statCard('PTS', _fmt(_stats!['pts']), theme, isMain: true),
            const SizedBox(width: 10),
            _statCard('REB', _fmt(_stats!['reb']), theme, isMain: true),
            const SizedBox(width: 10),
            _statCard('AST', _fmt(_stats!['ast']), theme, isMain: true),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _statCard('STL', _fmt(_stats!['stl']), theme),
            const SizedBox(width: 10),
            _statCard('BLK', _fmt(_stats!['blk']), theme),
            const SizedBox(width: 10),
            _statCard('MIN', _stats!['min']?.toString() ?? '0', theme),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _statCard('FG%', _fmtPct(_stats!['fg_pct']), theme),
            const SizedBox(width: 10),
            _statCard('3P%', _fmtPct(_stats!['fg3_pct']), theme),
            const SizedBox(width: 10),
            _statCard('FT%', _fmtPct(_stats!['ft_pct']), theme),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _statCard('TO', _fmt(_stats!['turnover']), theme),
            const SizedBox(width: 10),
            _statCard('PF', _fmt(_stats!['pf']), theme),
            const SizedBox(width: 10),
            _statCard('GP', _stats!['games_played']?.toString() ?? '0', theme),
          ],
        ),
      ],
    );
  }

  Widget _playerPhoto(Player player) {
    final photoPath = player.photoWebpPath;
    if (photoPath == null || photoPath.isEmpty) return _photoFallback();

    if (photoPath.startsWith('assets/')) {
      return Image.asset(
        photoPath,
        fit: BoxFit.contain,
        alignment: Alignment.center,
        errorBuilder: (context, error, stackTrace) => _photoFallback(),
      );
    }

    if (photoPath.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: photoPath,
        fit: BoxFit.contain,
        alignment: Alignment.center,
        errorWidget: (context, url, error) => _photoFallback(),
      );
    }

    final photoFile = File(photoPath);
    if (!photoFile.existsSync()) return _photoFallback();
    return Image.file(
      photoFile,
      fit: BoxFit.contain,
      alignment: Alignment.center,
    );
  }

  Widget _photoFallback() {
    return const Center(
      child: Icon(Icons.person, size: 140, color: Colors.white12),
    );
  }

  Widget _teamLogo(Player player) {
    return Container(
      width: 58,
      height: 58,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.24),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TeamLogo(
        teamId: player.teamId,
        size: 42,
        fallbackColor: Colors.black54,
      ),
    );
  }

  Widget _miniLogo(Player player) {
    return TeamLogo(
      teamId: player.teamId,
      size: 42,
      fallbackColor: Colors.white38,
    );
  }

  Widget _summaryChip(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Text(
        value,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _metricTile(String label, String value) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF101010),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white54, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _sheetCareerPath(Player player, String teamLabel, ThemeData theme) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF101010),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Row(
        children: [
          _miniLogo(player),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Caminho na NBA',
                  style: TextStyle(
                    color: Colors.white54,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  teamLabel,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Histórico completo por equipas ainda precisa de fonte por época.',
                  style: TextStyle(color: Colors.white38, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sheetSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFFFFC72C),
          fontSize: 13,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _sheetRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 118,
            child: Text(
              label,
              style: const TextStyle(color: Colors.white54, fontSize: 12),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _previousTeamLabel(String? previousTeam) {
    if (previousTeam == null || previousTeam.isEmpty) return 'Anterior';
    return _isLikelyNcaa(previousTeam) ? 'College' : 'Time anterior';
  }

  bool _isLikelyNcaa(String value) {
    const nonNcaaMarkers = [
      'Real Madrid',
      'Mega Basket',
      'Sevilla',
      'Partizan',
      'Besiktas',
      'Metropolitans',
      'Overtime Elite',
      'Cholet',
      'Washington Wizards',
      'Edgewater HS',
    ];
    return !nonNcaaMarkers.any(
      (marker) => value.toLowerCase().contains(marker.toLowerCase()),
    );
  }

  String _formatHeight(double? heightCm, String measurementUnit) {
    if (heightCm == null) return '-';
    if (measurementUnit == 'imperial') {
      final totalInches = (heightCm / 2.54).round();
      final feet = totalInches ~/ 12;
      final inches = totalInches % 12;
      return '$feet ft $inches in';
    }
    return '${heightCm.toStringAsFixed(0)} cm';
  }

  String _formatWeight(double? weightKg, String measurementUnit) {
    if (weightKg == null) return '-';
    if (measurementUnit == 'imperial') {
      return '${(weightKg * 2.20462262).round()} lb';
    }
    return '${weightKg.toStringAsFixed(0)} kg';
  }

  String _formatAge(DateTime? birthDate) {
    if (birthDate == null) return '-';
    final today = DateTime.now();
    var age = today.year - birthDate.year;
    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }
    return '$age';
  }

  String _formatDateOrDash(DateTime? date) {
    if (date == null) return '-';
    return _formatDate(date);
  }

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  String _fmt(dynamic value) =>
      value != null ? value.toStringAsFixed(1) : '0.0';

  String _fmtPct(dynamic value) {
    if (value == null) return '0%';
    return '${(value * 100).toStringAsFixed(1)}%';
  }

  Widget _statCard(
    String label,
    String value,
    ThemeData theme, {
    bool isMain = false,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isMain
              ? theme.colorScheme.primary.withValues(alpha: 0.2)
              : const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(10),
          border: isMain
              ? Border.all(
                  color: theme.colorScheme.primary.withValues(alpha: 0.4),
                )
              : null,
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                color: isMain ? theme.colorScheme.tertiary : Colors.white,
                fontSize: isMain ? 22 : 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

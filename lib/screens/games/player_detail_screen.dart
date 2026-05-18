import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../db/app_database.dart';
import '../../main.dart';
import '../../services/basketball_reference_service.dart';
import '../../services/player_stats_seed.dart';
import '../../services/player_stats_web_sync.dart';
import '../../widgets/team_logo.dart';
import '../../widgets/player_evolution_chart.dart';
import '../../widgets/player_shot_chart.dart';
import '../comparator/player_comparator_screen.dart';
import '../../models/player_season_stats.dart';

bool _isEnglish(BuildContext context) =>
    Localizations.localeOf(context).languageCode == 'en';

class PlayerDetailScreen extends StatefulWidget {
  final Player player;
  const PlayerDetailScreen({super.key, required this.player});

  @override
  State<PlayerDetailScreen> createState() => _PlayerDetailScreenState();
}

class _PlayerDetailScreenState extends State<PlayerDetailScreen> {
  final BasketballReferenceService _basketballReferenceService =
      BasketballReferenceService();
  late Player _player;
  PlayerStatsProfile? _manualStats;
  List<String> _careerTeamIds = [];
  String? _selectedSeason;
  bool _loading = true;
  bool _syncing = false;
  String _teamName = '';

  @override
  void initState() {
    super.initState();
    _player = widget.player;
    _loadData();
  }

  Future<void> _loadData() async {
    setState(() {
      _loading = true;
    });

    // Atualiza jogador da BD caso tenha mudado em background
    final latest = await database.playersDao.getPlayerById(_player.playerId);
    if (latest != null) {
      _player = latest;
    }

    final teamName = repository.getTeamName(_player.teamId);
    PlayerStatsProfile? externalStats;
    bool isRealData = false;

    // 1. Tenta busca online
    try {
      externalStats = await _basketballReferenceService.getPlayerProfile(
        _player.fullName,
      );
      if (externalStats == null) {
        if (_player.displayName != null &&
            _player.displayName != _player.fullName) {
          externalStats = await _basketballReferenceService.getPlayerProfile(
            _player.displayName!,
          );
        }
      }
      if (externalStats != null) isRealData = true;
    } catch (e) {
      externalStats = null;
    }

    // 2. Se falhou online, tenta dados locais reais da BD
    if (externalStats == null) {
      final localSeasons = await database.playersDao.getPlayerSeasons(
        _player.playerId,
      );
      if (localSeasons.isNotEmpty || _player.careerGames > 0) {
        final seasons = localSeasons
            .map(
              (s) => SeasonStats(
                season: s.season,
                team: s.team,
                gp: s.gp,
                gs: s.gs,
                mpg: s.mpg,
                ppg: s.ppg,
                rpg: s.rpg,
                apg: s.apg,
                spg: s.spg,
                bpg: s.bpg,
                topg: s.topg,
                fgPct: s.fgPct,
                fg3Pct: s.fg3Pct,
                ftPct: s.ftPct,
                per: s.per,
                tsPct: s.tsPct,
                usgPct: s.usgPct,
                impactMetric: 0,
                impactMetricLabel: '-',
                offensiveRating: 0,
                defensiveRating: 0,
              ),
            )
            .toList();

        seasons.sort((a, b) => b.season.compareTo(a.season));

        if (seasons.isNotEmpty || _player.careerGames > 0) {
          externalStats = PlayerStatsProfile(
            currentSeason: seasons.isNotEmpty
                ? seasons.first
                : SeasonStats(
                    season: 'Atual',
                    team: teamName,
                    gp: 0,
                    gs: 0,
                    mpg: _player.mpg,
                    ppg: _player.ppg,
                    rpg: _player.rpg,
                    apg: _player.apg,
                    spg: _player.spg,
                    bpg: _player.bpg,
                    topg: _player.topg,
                    fgPct: _player.fgPct,
                    fg3Pct: _player.fg3Pct,
                    ftPct: _player.ftPct,
                    per: 0,
                    tsPct: 0,
                    usgPct: 0,
                    impactMetric: 0,
                    impactMetricLabel: '-',
                    offensiveRating: 0,
                    defensiveRating: 0,
                  ),
            seasons: seasons,
            career: CareerTotals(
              games: _player.careerGames,
              starts: _player.careerStarts,
              points: _player.careerPoints,
              rebounds: _player.careerRebounds,
              assists: _player.careerAssists,
              steals: _player.careerSteals,
              blocks: _player.careerBlocks,
              turnovers: _player.careerTurnovers,
            ),
            careerHighs: const CareerHighs(
              points: 0,
              rebounds: 0,
              assists: 0,
              steals: 0,
              blocks: 0,
            ),
            recentGames: const [],
            awards: const [],
            health: const HealthStatus(
              status: 'Offline',
              injuryDescription: '-',
              expectedReturn: '-',
            ),
          );
          if (localSeasons.isNotEmpty) isRealData = true;
        }
      }
    }

    // 3. Named seed (dados reais para jogadores específicos: LeBron, Curry, etc.)
    // Usamos para trajetória porque têm times reais, ao contrário do seed estimado
    bool isNamedSeed = false;
    if (externalStats == null) {
      final namedSeed =
          PlayerStatsSeed.forName(_player.fullName) ??
          PlayerStatsSeed.forName(_player.displayName ?? '');
      if (namedSeed != null) {
        externalStats = namedSeed;
        isNamedSeed = true;
      }
    }

    // 4. Computa trajetória — real data (web/BD) OU named seed (times históricos reais)
    final careerTeamIds = _computeCareerTeamIds(
      externalStats,
      isRealData || isNamedSeed,
    );

    // 5. Seed estimado como último fallback apenas para estatísticas (nunca para trajetória)
    externalStats ??= PlayerStatsSeed.estimatedProfileForRosterGap(
      fullName: _player.fullName,
      position: _player.position,
      teamName: teamName,
    );

    if (mounted) {
      setState(() {
        _manualStats = externalStats;
        _careerTeamIds = careerTeamIds;
        _selectedSeason = externalStats?.currentSeason.season;
        _teamName = teamName;
        _loading = false;
      });

      // Sincronização automática em background sempre que não tivermos dados reais da web/BD
      if (!isRealData) {
        _manualSync(silent: true);
      }
    }
  }

  /// Computa a trajetória a partir de dados REAIS apenas.
  /// NUNCA usa seed data (que tem times fictícios gerados aleatoriamente).
  List<String> _computeCareerTeamIds(
    PlayerStatsProfile? profile,
    bool isRealData,
  ) {
    final out = <String>[];

    // 1. Seasons do perfil real (web ou BD local) — ordena do mais antigo ao mais recente
    if (profile != null && isRealData && profile.seasons.isNotEmpty) {
      final sorted = profile.seasons.toList()
        ..sort((a, b) => a.season.compareTo(b.season));
      for (final s in sorted) {
        final teamId = _teamIdFromAbbreviation(s.team);
        if (teamId == null) continue;
        if (out.isEmpty || out.last != teamId) out.add(teamId);
      }
      if (out.isNotEmpty) {
        // Garante que o time atual aparece no fim
        if (out.last != _player.teamId) out.add(_player.teamId);
        return out;
      }
    }

    // 2. Fallback: careerTeams guardado na BD após sync (ordem cronológica)
    if (_player.careerTeams != null && _player.careerTeams!.isNotEmpty) {
      for (final t in _player.careerTeams!.split(',')) {
        final tid = _teamIdFromAbbreviation(t);
        if (tid != null && (out.isEmpty || out.last != tid)) out.add(tid);
      }
      if (out.isNotEmpty) {
        if (out.last != _player.teamId) out.add(_player.teamId);
        return out;
      }
    }

    // 3. Último recurso: só o time atual
    return [_player.teamId];
  }

  Future<void> _manualSync({bool silent = false}) async {
    if (_syncing) return;
    if (mounted) setState(() => _syncing = true);

    final success = await PlayerStatsWebSync(
      database.playersDao,
    ).syncSinglePlayer(_player);

    if (success) {
      final updatedPlayer = await database.playersDao.getPlayerById(
        _player.playerId,
      );
      if (updatedPlayer != null && mounted) {
        setState(() {
          _player = updatedPlayer;
        });
        await _loadData();
      }
      if (mounted && !silent) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Sincronização concluída com sucesso!')),
        );
      }
    } else {
      if (mounted && !silent) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Falha na sincronização. Tente mais tarde.'),
          ),
        );
      }
    }

    if (mounted) setState(() => _syncing = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final player = _player;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildMinimalHeader(player, theme),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  _buildQuickStats(player, theme),
                  const SizedBox(height: 40),
                  _buildSectionTitle('Performance', theme),
                  const SizedBox(height: 16),
                  _statsHub(theme),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool get _hasEnoughSeasonsForChart {
    if (_manualStats != null) {
      return _allSeasonsForProfile(_manualStats!).length > 1;
    }
    return false;
  }

  Widget _buildMinimalHeader(Player player, ThemeData theme) {
    return SliverAppBar(
      expandedHeight: 400,
      pinned: true,
      backgroundColor: const Color(0xFF0A0A0A),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
          size: 20,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.compare_arrows, color: Colors.white70),
          tooltip: _isEnglish(context) ? 'Compare player' : 'Comparar jogador',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    PlayerComparatorScreen(initialPlayer: player),
              ),
            );
          },
        ),
        if (_hasEnoughSeasonsForChart)
          IconButton(
            icon: const Icon(Icons.show_chart, color: Colors.white70),
            onPressed: () => _showEvolutionChart(context),
          ),
        StreamBuilder<UserPreference?>(
          stream: database.preferencesDao.watchPreferences(),
          builder: (context, snapshot) {
            final measurementUnit = snapshot.data?.measurementUnit ?? 'metric';
            return IconButton(
              icon: const Icon(Icons.info_outline, color: Colors.white70),
              onPressed: () =>
                  _showPlayerInfoSheet(player, measurementUnit, theme),
            );
          },
        ),
        const SizedBox(width: 8),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Imagem do Jogador com Gradiente
            _playerPhoto(player),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: const [0.0, 0.4, 0.7],
                  colors: [
                    const Color(0xFF0A0A0A),
                    const Color(0xFF0A0A0A).withValues(alpha: 0.7),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            // Nome e Número (Fundo)
            Positioned(
              bottom: 40,
              left: 24,
              right: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '#${player.jerseyNumber ?? '00'}',
                    style: TextStyle(
                      color: theme.colorScheme.primary.withValues(alpha: 0.8),
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -2,
                    ),
                  ),
                  Text(
                    player.fullName.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      height: 0.9,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        _teamName.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 4,
                        height: 4,
                        decoration: const BoxDecoration(
                          color: Colors.white24,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        (player.position ?? '-').toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white54,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStats(Player player, ThemeData theme) {
    // Dá prioridade aos dados do perfil completo (web/seed) sobre a BD local
    final stats = _manualStats?.currentSeason;
    final ppg = stats != null && stats.ppg > 0 ? stats.ppg : player.ppg;
    final rpg = stats != null && stats.rpg > 0 ? stats.rpg : player.rpg;
    final apg = stats != null && stats.apg > 0 ? stats.apg : player.apg;
    final mpg = stats != null && stats.mpg > 0 ? stats.mpg : player.mpg;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildMinimalStatItem('PTS', ppg.toStringAsFixed(1), theme),
        _buildMinimalStatItem('REB', rpg.toStringAsFixed(1), theme),
        _buildMinimalStatItem('AST', apg.toStringAsFixed(1), theme),
        _buildMinimalStatItem('MPG', mpg.toStringAsFixed(1), theme),
      ],
    );
  }

  Widget _buildMinimalStatItem(String label, String value, ThemeData theme) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: theme.colorScheme.primary.withValues(alpha: 0.7),
            fontSize: 11,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: theme.colorScheme.primary,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          title.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
          ),
        ),
      ],
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
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final currentPlayer = _player;
            final teamLabel = _teamName.isNotEmpty
                ? _teamName
                : currentPlayer.teamId;

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
                          _miniLogo(currentPlayer),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  currentPlayer.displayName ??
                                      currentPlayer.fullName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '$teamLabel • ${currentPlayer.position ?? '-'}',
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
                      _sheetRow('Nome completo', currentPlayer.fullName),
                      _sheetRow('Número', currentPlayer.jerseyNumber ?? '-'),
                      _sheetRow('País', currentPlayer.country ?? '-'),
                      _sheetRow(
                        'Nascimento',
                        _formatDateOrDash(currentPlayer.birthDate),
                      ),
                      _sheetRow('Idade', _formatAge(currentPlayer.birthDate)),
                      _sheetRow(
                        'Altura',
                        _formatHeight(currentPlayer.heightCm, measurementUnit),
                      ),
                      _sheetRow(
                        'Peso',
                        _formatWeight(currentPlayer.weightKg, measurementUnit),
                      ),
                      const SizedBox(height: 18),
                      _sheetSectionTitle('Carreira'),
                      _sheetRow(
                        _previousTeamLabel(currentPlayer.previousTeam),
                        currentPlayer.previousTeam ?? '-',
                      ),
                      _sheetRow(
                        'Experiência NBA',
                        currentPlayer.experienceYears != null
                            ? '${currentPlayer.experienceYears} anos'
                            : '-',
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Spacer(),
                          TextButton.icon(
                            onPressed: _syncing
                                ? null
                                : () async {
                                    setModalState(
                                      () {},
                                    ); // Atualiza o spinner no modal
                                    await _manualSync();
                                    setModalState(
                                      () {},
                                    ); // Atualiza os dados no modal
                                  },
                            icon: _syncing
                                ? const SizedBox(
                                    width: 14,
                                    height: 14,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white70,
                                    ),
                                  )
                                : const Icon(Icons.sync, size: 16),
                            label: Text(
                              _syncing
                                  ? 'Sincronizando...'
                                  : 'Sincronizar Dados Reais',
                              style: const TextStyle(fontSize: 12),
                            ),
                            style: TextButton.styleFrom(
                              foregroundColor: const Color(0xFFFFC72C),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      _sheetCareerPath(),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  bool _hasLocalCareerStats(Player p) => p.careerGames > 0;

  void _showEvolutionChart(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Visualização de Dados',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 24),
              ListTile(
                leading: const Icon(Icons.show_chart, color: Color(0xFFFFC72C)),
                title: const Text('Gráfico de Evolução', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: const Text('Compara o rendimento ao longo das épocas', style: TextStyle(color: Colors.white54)),
                onTap: () {
                  Navigator.pop(context);
                  _showEvolutionChartActual(context);
                },
              ),
              const Divider(color: Colors.white12),
              ListTile(
                leading: const Icon(Icons.local_fire_department, color: Color(0xFFC9082A)),
                title: const Text('Mapa de Lançamento (Heatmap)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                subtitle: const Text('Zonas quentes e frias no campo', style: TextStyle(color: Colors.white54)),
                onTap: () {
                  Navigator.pop(context);
                  _showShotChart(context);
                },
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  void _showShotChart(BuildContext context) {
    // Pegar estatísticas da época atual para basear o mapa
    final stats = _manualStats?.currentSeason;
    final fgPct = stats != null && stats.fgPct > 0 ? stats.fgPct : _player.fgPct;
    final fg3Pct = stats != null && stats.fg3Pct > 0 ? stats.fg3Pct : _player.fg3Pct;
    final position = _player.position ?? 'G';

    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              const SizedBox(height: 24),
              PlayerShotChart(
                fgPct: fgPct,
                fg3Pct: fg3Pct,
                position: position,
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  void _showEvolutionChartActual(BuildContext context) async {
    List<PlayerSeasonStats> seasons = [];
    if (_manualStats != null) {
      final all = _allSeasonsForProfile(_manualStats!);
      if (all.isNotEmpty) {
        seasons = all
            .map(
              (s) => PlayerSeasonStats(
                season: s.season,
                ppg: s.ppg,
                rpg: s.rpg,
                apg: s.apg,
                per: s.per,
                tsPct: s.tsPct,
              ),
            )
            .toList();
      }
    }

    if (seasons.isEmpty) {
      seasons = await repository.getPlayerSeasonStats(_player.playerId);
    }

    if (seasons.isEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nenhum dado de temporada encontrado.')),
      );
      return;
    }
    if (!mounted) return;
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1A1A1A),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              const SizedBox(height: 24),
              PlayerEvolutionChart(seasons: seasons),
              const SizedBox(height: 24),
            ],
          ),
        );
      },
    );
  }

  Widget _statsHub(ThemeData theme) {
    final profile = _manualStats;
    final player = _player;
    if (_loading) return const Center(child: CircularProgressIndicator());

    // Se temos profile completo, mostramos tudo.
    if (profile != null) {
      final selectedStats = _selectedSeasonStats(profile);
      return DefaultTabController(
        length: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _seasonSelector(profile),
            const SizedBox(height: 12),
            Container(
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF101010),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: theme.colorScheme.primary,
                dividerColor: Colors.transparent,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 13,
                  letterSpacing: 1,
                ),
                unselectedLabelColor: Colors.white24,
                tabs: const [
                  Tab(text: 'SEASON'),
                  Tab(text: 'CAREER'),
                  Tab(text: 'ADVANCED'),
                  Tab(text: 'LOGS'),
                  Tab(text: 'HEALTH'),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 520,
              child: TabBarView(
                children: [
                  _seasonStatsTab(
                    selectedStats,
                    _allSeasonsForProfile(profile),
                    theme,
                  ),
                  _careerStatsTab(profile: profile),
                  _advancedStatsTab(selectedStats, theme),
                  _gameLogsTab(profile.recentGames),
                  _healthTab(profile.health, profile.awards),
                ],
              ),
            ),
          ],
        ),
      );
    }

    // Fallback: se nao temos profile mas temos dados locais de temporada ou carreira.
    if (_hasLocalSeasonStats(player) || _hasLocalCareerStats(player)) {
      return DefaultTabController(
        length: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 44,
              decoration: BoxDecoration(
                color: const Color(0xFF101010),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const TabBar(
                isScrollable: false,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: [
                  Tab(text: 'Temporada'),
                  Tab(text: 'Carreira'),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 400,
              child: TabBarView(
                children: [
                  SingleChildScrollView(
                    child: _localDbStatsContent(player, theme),
                  ),
                  _careerStatsTab(player: player),
                ],
              ),
            ),
            const SizedBox(height: 12),
            const _InfoNote(
              text:
                  'Dados locais. Conecte-se para ver historico completo e avancadas.',
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _localDbStatsContent(player, theme),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.red.withValues(alpha: 0.2)),
          ),
          child: Column(
            children: [
              const Icon(Icons.cloud_off, color: Colors.white24, size: 32),
              const SizedBox(height: 12),
              const Text(
                'Não foi possível carregar estatísticas detalhadas online.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _loadData,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.refresh, size: 18),
                  label: const Text('Tentar novamente'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Temporada atual + historico, sem duplicar (ex.: LeBron 2024-25 na lista).
  List<SeasonStats> _allSeasonsForProfile(PlayerStatsProfile profile) {
    final byKey = <String, SeasonStats>{};
    for (final s in profile.seasons) {
      byKey[s.season] = s;
    }
    byKey[profile.currentSeason.season] = profile.currentSeason;
    final out = byKey.values.toList();
    out.sort((a, b) => b.season.compareTo(a.season));
    return out;
  }

  SeasonStats _selectedSeasonStats(PlayerStatsProfile profile) {
    final all = _allSeasonsForProfile(profile);
    for (final s in all) {
      if (s.season == _selectedSeason) return s;
    }
    return profile.currentSeason;
  }

  Widget _seasonSelector(PlayerStatsProfile profile) {
    final seasons = _allSeasonsForProfile(profile);
    final selected = seasons.any((season) => season.season == _selectedSeason)
        ? _selectedSeason
        : seasons.first.season;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selected,
          dropdownColor: const Color(0xFF1A1A1A),
          iconEnabledColor: Colors.white70,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w800,
          ),
          items: seasons
              .map(
                (season) => DropdownMenuItem<String>(
                  value: season.season,
                  child: Text('${season.season} - ${season.team}'),
                ),
              )
              .toList(),
          onChanged: (value) {
            if (value == null) return;
            setState(() => _selectedSeason = value);
          },
        ),
      ),
    );
  }

  Widget _seasonStatsTab(
    SeasonStats current,
    List<SeasonStats> seasons,
    ThemeData theme,
  ) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _seasonHeader(current),
          const SizedBox(height: 10),
          Row(
            children: [
              _statCard(
                'PPG',
                current.ppg.toStringAsFixed(1),
                theme,
                isMain: true,
              ),
              const SizedBox(width: 10),
              _statCard(
                'RPG',
                current.rpg.toStringAsFixed(1),
                theme,
                isMain: true,
              ),
              const SizedBox(width: 10),
              _statCard(
                'APG',
                current.apg.toStringAsFixed(1),
                theme,
                isMain: true,
              ),
            ],
          ),
          const SizedBox(height: 10),
          _statGrid([
            _StatItem('GP', '${current.gp}'),
            _StatItem('GS', '${current.gs}'),
            _StatItem('MPG', current.mpg.toStringAsFixed(1)),
            _StatItem('ORB', current.orb.toStringAsFixed(1)),
            _StatItem('DRB', current.drb.toStringAsFixed(1)),
            _StatItem('PF', current.pf.toStringAsFixed(1)),
            _StatItem('SPG', current.spg.toStringAsFixed(1)),
            _StatItem('BPG', current.bpg.toStringAsFixed(1)),
            _StatItem('TOPG', current.topg.toStringAsFixed(1)),
            _StatItem('FG%', _pct(current.fgPct)),
            _StatItem('3P%', _pct(current.fg3Pct)),
            _StatItem('FT%', _pct(current.ftPct)),
          ]),
          if (seasons.isNotEmpty) ...[
            const SizedBox(height: 16),
            _subHeader('Historico por temporada'),
            const SizedBox(height: 8),
            ...seasons.map(_seasonRow),
          ],
        ],
      ),
    );
  }

  Widget _careerStatsTab({PlayerStatsProfile? profile, Player? player}) {
    if (profile != null) {
      final career = profile.career;
      final highs = profile.careerHighs;
      return SingleChildScrollView(
        child: Column(
          children: [
            _statGrid([
              _StatItem('Jogos', '${career.games}'),
              _StatItem('Titular', '${career.starts}'),
              _StatItem('Pontos', _compactInt(career.points)),
              _StatItem('Rebotes', _compactInt(career.rebounds)),
              _StatItem('Assist.', _compactInt(career.assists)),
              _StatItem('Roubos', _compactInt(career.steals)),
              _StatItem('Tocos', _compactInt(career.blocks)),
              _StatItem('Turnovers', _compactInt(career.turnovers)),
            ]),
            const SizedBox(height: 16),
            _subHeader('Recordes pessoais'),
            const SizedBox(height: 8),
            _statGrid([
              _StatItem('PTS', '${highs.points}'),
              _StatItem('REB', '${highs.rebounds}'),
              _StatItem('AST', '${highs.assists}'),
              _StatItem('STL', '${highs.steals}'),
              _StatItem('BLK', '${highs.blocks}'),
            ]),
            const SizedBox(height: 16),
            _subHeader('Premiacoes'),
            const SizedBox(height: 8),
            ...profile.awards.map((award) => _awardRow(award.label)),
          ],
        ),
      );
    } else if (player != null) {
      return SingleChildScrollView(
        child: Column(
          children: [
            _statGrid([
              _StatItem('Jogos', '${player.careerGames}'),
              _StatItem('Titular', '${player.careerStarts}'),
              _StatItem('Pontos', _compactInt(player.careerPoints)),
              _StatItem('Rebotes', _compactInt(player.careerRebounds)),
              _StatItem('Assist.', _compactInt(player.careerAssists)),
              _StatItem('Roubos', _compactInt(player.careerSteals)),
              _StatItem('Tocos', _compactInt(player.careerBlocks)),
              _StatItem('Turnovers', _compactInt(player.careerTurnovers)),
            ]),
            const SizedBox(height: 16),
            const _InfoNote(text: 'Recordes e premios requerem conexao.'),
          ],
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _advancedStatsTab(SeasonStats stats, ThemeData theme) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              _statCard(
                'PER',
                stats.per.toStringAsFixed(1),
                theme,
                isMain: true,
              ),
              const SizedBox(width: 10),
              _statCard('TS%', _pct(stats.tsPct), theme, isMain: true),
              const SizedBox(width: 10),
              _statCard('USG%', _pct(stats.usgPct), theme, isMain: true),
            ],
          ),
          const SizedBox(height: 10),
          _statGrid([
            _StatItem(
              stats.impactMetricLabel,
              stats.impactMetric.toStringAsFixed(1),
            ),
            _StatItem('OffRtg', stats.offensiveRating.toStringAsFixed(1)),
            _StatItem('DefRtg', stats.defensiveRating.toStringAsFixed(1)),
          ]),
          const SizedBox(height: 12),
          const _InfoNote(
            text:
                'PER, TS%, USG% e ratings ajudam a medir eficiencia, volume e impacto por posse.',
          ),
        ],
      ),
    );
  }

  Widget _gameLogsTab(List<GameLog> logs) {
    if (logs.isEmpty) {
      return const _InfoNote(text: 'Sem logs manuais para este jogador.');
    }
    return ListView.builder(
      itemCount: logs.length,
      itemBuilder: (context, index) {
        final log = logs[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF1A1A1A),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 58,
                child: Text(
                  '${log.result} ${log.opponent}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  '${log.pts} PTS  ${log.reb} REB  ${log.ast} AST',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white70, fontSize: 12),
                ),
              ),
              Text(
                '${log.minutes}m',
                style: const TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _healthTab(HealthStatus health, List<AwardItem> awards) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _sheetRow('Status', health.status),
          _sheetRow('Lesao', health.injuryDescription),
          _sheetRow('Retorno', health.expectedReturn),
          const SizedBox(height: 14),
          _subHeader('Premiacoes'),
          const SizedBox(height: 8),
          ...awards.map((award) => _awardRow(award.label)),
        ],
      ),
    );
  }

  Widget _seasonHeader(SeasonStats stats) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        '${stats.season}  -  ${stats.team}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _seasonRow(SeasonStats stats) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              stats.season,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Text(
            '${stats.ppg.toStringAsFixed(1)} PPG  ${stats.rpg.toStringAsFixed(1)} RPG  ${stats.apg.toStringAsFixed(1)} APG',
            style: const TextStyle(color: Colors.white70, fontSize: 11),
          ),
        ],
      ),
    );
  }

  Widget _statGrid(List<_StatItem> items) {
    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 1.5,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: items
          .map((item) => _smallStatTile(item.label, item.value))
          .toList(),
    );
  }

  Widget _smallStatTile(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: Colors.white54, fontSize: 10),
          ),
        ],
      ),
    );
  }

  Widget _subHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  Widget _awardRow(String label) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white70,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  String _pct(double value) => '${value.toStringAsFixed(1)}%';

  String _compactInt(int value) {
    if (value >= 1000) {
      final compact = value / 1000;
      return '${compact.toStringAsFixed(compact >= 10 ? 1 : 2)}k';
    }
    return '$value';
  }

  bool _hasLocalSeasonStats(Player p) =>
      p.ppg > 0.001 || p.mpg > 0.001 || p.rpg > 0.001;

  /// Medias guardadas na BD (vindas da sincronizacao com basketball-reference.com).
  Widget _localDbStatsContent(Player player, ThemeData theme) {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (!_hasLocalSeasonStats(player)) {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(
          child: Text(
            'Sem medias na base de dados ainda',
            style: TextStyle(color: Colors.white54),
          ),
        ),
      );
    }

    return Column(
      children: [
        Row(
          children: [
            _statCard(
              'PTS',
              player.ppg.toStringAsFixed(1),
              theme,
              isMain: true,
            ),
            const SizedBox(width: 10),
            _statCard(
              'REB',
              player.rpg.toStringAsFixed(1),
              theme,
              isMain: true,
            ),
            const SizedBox(width: 10),
            _statCard(
              'AST',
              player.apg.toStringAsFixed(1),
              theme,
              isMain: true,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _statCard('STL', player.spg.toStringAsFixed(1), theme),
            const SizedBox(width: 10),
            _statCard('BLK', player.bpg.toStringAsFixed(1), theme),
            const SizedBox(width: 10),
            _statCard('MIN', player.mpg.toStringAsFixed(1), theme),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _statCard(
              'FG%',
              player.fgPct > 0 ? '${player.fgPct.toStringAsFixed(1)}%' : '-',
              theme,
            ),
            const SizedBox(width: 10),
            _statCard(
              '3P%',
              player.fg3Pct > 0 ? '${player.fg3Pct.toStringAsFixed(1)}%' : '-',
              theme,
            ),
            const SizedBox(width: 10),
            _statCard(
              'FT%',
              player.ftPct > 0 ? '${player.ftPct.toStringAsFixed(1)}%' : '-',
              theme,
            ),
          ],
        ),
        if (player.topg > 0.001) ...[
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: _statCard('TOPG', player.topg.toStringAsFixed(1), theme),
              ),
            ],
          ),
        ],
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

    return _photoFallback();
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

  Widget _sheetCareerPath() {
    final timelineTeamIds = _careerTeamIds;
    if (timelineTeamIds.isEmpty) {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF101010),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
        ),
        child: const Text(
          'Histórico de clubes indisponível.',
          style: TextStyle(color: Colors.white54, fontSize: 12),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        _sheetSectionTitle('Trajetória'),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF101010),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(timelineTeamIds.length, (index) {
                final teamId = timelineTeamIds[index];
                final isLast = index == timelineTeamIds.length - 1;
                final teamAbbr = _abbrFromTeamId(teamId);

                return Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.05),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white24, width: 1),
                          ),
                          child: TeamLogo(
                            teamId: teamId,
                            size: 32,
                            fallbackColor: Colors.white38,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          teamAbbr,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                    if (!isLast)
                      Container(
                        width: 30,
                        height: 2,
                        margin: const EdgeInsets.only(
                          bottom: 16,
                        ), // Alinhado com o centro do logo
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.white24,
                              Colors.white.withValues(alpha: 0.05),
                            ],
                          ),
                        ),
                      ),
                  ],
                );
              }),
            ),
          ),
        ),
      ],
    );
  }

  String _abbrFromTeamId(String teamId) {
    const reverseMap = <String, String>{
      '1': 'ATL',
      '2': 'BOS',
      '3': 'BKN',
      '4': 'CHA',
      '5': 'CHI',
      '6': 'CLE',
      '7': 'DAL',
      '8': 'DEN',
      '9': 'DET',
      '10': 'GSW',
      '11': 'HOU',
      '12': 'IND',
      '13': 'LAC',
      '14': 'LAL',
      '15': 'MEM',
      '16': 'MIA',
      '17': 'MIL',
      '18': 'MIN',
      '19': 'NOP',
      '20': 'NYK',
      '21': 'OKC',
      '22': 'ORL',
      '23': 'PHI',
      '24': 'PHX',
      '25': 'POR',
      '26': 'SAC',
      '27': 'SAS',
      '28': 'TOR',
      '29': 'UTA',
      '30': 'WAS',
    };
    return reverseMap[teamId] ?? 'NBA';
  }

  String? _teamIdFromAbbreviation(String value) {
    final team = value.trim().toUpperCase();
    if (team.isEmpty || team == 'TOT') return null;
    const map = <String, String>{
      'ATL': '1',
      'BOS': '2',
      'BRK': '3',
      'BKN': '3',
      'NJN': '3',
      'CHA': '4',
      'CHO': '4',
      'CHH': '4',
      'CHI': '5',
      'CLE': '6',
      'DAL': '7',
      'DEN': '8',
      'DET': '9',
      'GSW': '10',
      'GS': '10',
      'HOU': '11',
      'IND': '12',
      'LAC': '13',
      'LAL': '14',
      'MEM': '15',
      'VAN': '15',
      'MIA': '16',
      'MIL': '17',
      'MIN': '18',
      'NOH': '19',
      'NOK': '19',
      'NOP': '19',
      'NYK': '20',
      'NY': '20',
      'OKC': '21',
      'SEA': '21',
      'ORL': '22',
      'PHI': '23',
      'PHO': '24',
      'PHX': '24',
      'POR': '25',
      'SAC': '26',
      'KCK': '26',
      'SAS': '27',
      'SA': '27',
      'TOR': '28',
      'UTA': '29',
      'WAS': '30',
      'WSH': '30',
      'WSB': '30',
    };
    return map[team];
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

  Widget _metricTile(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: Colors.white24,
            fontSize: 9,
            fontWeight: FontWeight.w800,
            letterSpacing: 1,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  Widget _statCard(
    String label,
    String value,
    ThemeData theme, {
    bool isMain = false,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isMain
              ? theme.colorScheme.primary.withValues(alpha: 0.1)
              : const Color(0xFF151515),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isMain
                ? theme.colorScheme.primary.withValues(alpha: 0.2)
                : Colors.white.withValues(alpha: 0.05),
          ),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                color: isMain ? theme.colorScheme.primary : Colors.white,
                fontSize: isMain ? 24 : 18,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label.toUpperCase(),
              style: const TextStyle(
                color: Colors.white38,
                fontSize: 10,
                fontWeight: FontWeight.w800,
                letterSpacing: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatItem {
  final String label;
  final String value;

  const _StatItem(this.label, this.value);
}

class _InfoNote extends StatelessWidget {
  final String text;

  const _InfoNote({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(color: Colors.white54, fontSize: 12),
      ),
    );
  }
}

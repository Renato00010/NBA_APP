import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../main.dart';
import '../../db/app_database.dart';
import '../../services/repository.dart';
import '../../services/player_stats_seed.dart';

class PlayerComparatorScreen extends StatefulWidget {
  const PlayerComparatorScreen({super.key});

  @override
  State<PlayerComparatorScreen> createState() => _PlayerComparatorScreenState();
}

class _PlayerComparatorScreenState extends State<PlayerComparatorScreen> {
  Player? player1;
  Player? player2;
  List<Player> allPlayers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPlayers();
  }

  Future<void> _loadPlayers() async {
    final players = await repository.getPlayers();
    setState(() {
      allPlayers = players;
      isLoading = false;
    });
  }

  void _selectPlayer(int index) async {
    final selected = await showSearch<Player?>(
      context: context,
      delegate: PlayerSearchDelegate(allPlayers),
    );
    if (selected != null) {
      setState(() {
        if (index == 1) {
          player1 = selected;
        } else {
          player2 = selected;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF0A0A0A),
        body: Center(child: CircularProgressIndicator(color: Colors.white)),
      );
    }
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        title: const Text('Comparador de Jogadores', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF101010),
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPlayerSelector(1, player1),
                const Text('VS', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24, color: Colors.white54)),
                _buildPlayerSelector(2, player2),
              ],
            ),
            const SizedBox(height: 48),
            Expanded(
              child: player1 != null && player2 != null
                  ? _buildComparisonChart()
                  : const Center(
                      child: Text(
                        'Selecione dois jogadores para comparar',
                        style: TextStyle(color: Colors.white54, fontSize: 16),
                      ),
                    ),
            ),
            if (player1 != null && player2 != null)
              _buildLegend(),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerSelector(int index, Player? player) {
    return InkWell(
      onTap: () => _selectPlayer(index),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        width: 120,
        child: Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: index == 1 ? Colors.blueAccent : Colors.redAccent,
                  width: 3,
                ),
              ),
              child: ClipOval(
                child: _playerPhotoWidget(player),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              player?.displayName ?? 'Selecionar',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _playerPhotoWidget(Player? player) {
    if (player == null) return const Icon(Icons.person_add, size: 40, color: Colors.white54);
    final photoPath = player.photoWebpPath;
    if (photoPath == null || photoPath.isEmpty) {
      return const Icon(Icons.person, size: 40, color: Colors.white);
    }
    if (photoPath.startsWith('assets/')) {
      return Image.asset(photoPath, fit: BoxFit.cover, errorBuilder: (c, e, s) => const Icon(Icons.person, size: 40, color: Colors.white));
    }
    if (photoPath.startsWith('http')) {
      return CachedNetworkImage(imageUrl: photoPath, fit: BoxFit.cover, errorWidget: (c, u, e) => const Icon(Icons.person, size: 40, color: Colors.white));
    }
    return const Icon(Icons.person, size: 40, color: Colors.white);
  }

  SeasonStats _getPlayerStats(Player? player) {
    if (player == null) return const SeasonStats(season: '', team: '', gp: 0, gs: 0, mpg: 0, ppg: 0, rpg: 0, apg: 0, spg: 0, bpg: 0, topg: 0, fgPct: 0, fg3Pct: 0, ftPct: 0, per: 0, tsPct: 0, usgPct: 0, impactMetric: 0, impactMetricLabel: '', offensiveRating: 0, defensiveRating: 0);
    
    if (player.ppg > 0) {
      return SeasonStats(
        season: 'Atual', team: player.teamId, gp: 0, gs: 0,
        mpg: player.mpg, ppg: player.ppg, rpg: player.rpg, apg: player.apg, spg: player.spg, bpg: player.bpg,
        topg: player.topg, fgPct: player.fgPct, fg3Pct: player.fg3Pct, ftPct: player.ftPct,
        per: 0, tsPct: 0, usgPct: 0, impactMetric: 0, impactMetricLabel: '', offensiveRating: 0, defensiveRating: 0
      );
    }

    final profile = PlayerStatsSeed.forName(player.fullName) ??
        PlayerStatsSeed.forName(player.displayName ?? '') ??
        PlayerStatsSeed.estimatedProfileForRosterGap(
          fullName: player.fullName,
          position: player.position,
        );

    return profile.currentSeason;
  }

  Widget _buildComparisonChart() {
    final stats1 = _getPlayerStats(player1);
    final stats2 = _getPlayerStats(player2);

    double maxVal = 0;
    final allStats = [
      stats1.ppg, stats2.ppg,
      stats1.rpg, stats2.rpg,
      stats1.apg, stats2.apg,
      stats1.spg, stats2.spg,
      stats1.bpg, stats2.bpg,
    ];
    for (var val in allStats) {
      if (val > maxVal) maxVal = val;
    }
    maxVal = (maxVal * 1.2).ceilToDouble();
    if (maxVal < 10) maxVal = 10;

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY: maxVal,
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipColor: (group) => Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              return BarTooltipItem(
                rod.toY.toStringAsFixed(1),
                const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                switch (value.toInt()) {
                  case 0: return const Padding(padding: EdgeInsets.only(top: 8), child: Text('PPG', style: TextStyle(color: Colors.white70)));
                  case 1: return const Padding(padding: EdgeInsets.only(top: 8), child: Text('RPG', style: TextStyle(color: Colors.white70)));
                  case 2: return const Padding(padding: EdgeInsets.only(top: 8), child: Text('APG', style: TextStyle(color: Colors.white70)));
                  case 3: return const Padding(padding: EdgeInsets.only(top: 8), child: Text('SPG', style: TextStyle(color: Colors.white70)));
                  case 4: return const Padding(padding: EdgeInsets.only(top: 8), child: Text('BPG', style: TextStyle(color: Colors.white70)));
                  default: return const Text('');
                }
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (val, meta) => Text(val.toInt().toString(), style: const TextStyle(color: Colors.white38)),
            ),
          ),
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (val) => FlLine(color: Colors.white12, strokeWidth: 1),
        ),
        borderData: FlBorderData(show: false),
        barGroups: [
          _buildBarGroup(0, stats1.ppg, stats2.ppg),
          _buildBarGroup(1, stats1.rpg, stats2.rpg),
          _buildBarGroup(2, stats1.apg, stats2.apg),
          _buildBarGroup(3, stats1.spg, stats2.spg),
          _buildBarGroup(4, stats1.bpg, stats2.bpg),
        ],
      ),
    );
  }

  BarChartGroupData _buildBarGroup(int x, double val1, double val2) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(toY: val1, color: Colors.blueAccent, width: 14, borderRadius: BorderRadius.circular(4)),
        BarChartRodData(toY: val2, color: Colors.redAccent, width: 14, borderRadius: BorderRadius.circular(4)),
      ],
    );
  }

  Widget _buildLegend() {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _legendItem(Colors.blueAccent, player1?.displayName ?? ''),
          const SizedBox(width: 24),
          _legendItem(Colors.redAccent, player2?.displayName ?? ''),
        ],
      ),
    );
  }

  Widget _legendItem(Color color, String name) {
    return Row(
      children: [
        Container(width: 12, height: 12, color: color),
        const SizedBox(width: 8),
        Text(name, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}

class PlayerSearchDelegate extends SearchDelegate<Player?> {
  final List<Player> players;

  PlayerSearchDelegate(this.players);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData.dark().copyWith(
      appBarTheme: const AppBarTheme(backgroundColor: Color(0xFF101010)),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.white54),
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) => [
    IconButton(icon: const Icon(Icons.clear), onPressed: () => query = ''),
  ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
    icon: const Icon(Icons.arrow_back),
    onPressed: () => close(context, null),
  );

  @override
  Widget buildResults(BuildContext context) => _buildList();

  @override
  Widget buildSuggestions(BuildContext context) => _buildList();

  ImageProvider? _getAvatarProvider(Player p) {
    final path = p.photoWebpPath;
    if (path == null || path.isEmpty) return null;
    if (path.startsWith('assets/')) return AssetImage(path);
    if (path.startsWith('http')) return CachedNetworkImageProvider(path);
    return null;
  }

  Widget _buildList() {
    final filtered = players.where((p) => p.fullName.toLowerCase().contains(query.toLowerCase())).toList();
    return Container(
      color: const Color(0xFF0A0A0A),
      child: ListView.builder(
        itemCount: filtered.length,
        itemBuilder: (context, index) {
          final p = filtered[index];
          final avatarProvider = _getAvatarProvider(p);
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              backgroundImage: avatarProvider,
              child: avatarProvider == null ? const Icon(Icons.person, color: Colors.white) : null,
            ),
            title: Text(p.fullName, style: const TextStyle(color: Colors.white)),
            subtitle: Text(p.teamId, style: const TextStyle(color: Colors.white54)),
            onTap: () => close(context, p),
          );
        },
      ),
    );
  }
}

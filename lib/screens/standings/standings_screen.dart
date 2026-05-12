import 'package:flutter/material.dart';
import '../../main.dart';
import '../../models/standing.dart';
import '../../services/repository.dart';

class StandingsScreen extends StatefulWidget {
  const StandingsScreen({super.key});

  @override
  State<StandingsScreen> createState() => _StandingsScreenState();
}

class _StandingsScreenState extends State<StandingsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Standing> _standings = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _loadStandings();
  }

  Future<void> _loadStandings() async {
    final standings = await repository.getStandings();
    if (mounted) {
      setState(() {
        _standings = standings;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        title: const Text(
          'Classificação',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: theme.colorScheme.primary,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white54,
          tabs: const [
            Tab(text: 'CONFERÊNCIA ESTE'),
            Tab(text: 'CONFERÊNCIA OESTE'),
          ],
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
              controller: _tabController,
              children: [
                _buildConferenceTable('East'),
                _buildConferenceTable('West'),
              ],
            ),
    );
  }

  Widget _buildConferenceTable(String conference) {
    final filtered = _standings
        .where((s) => s.conference == conference)
        .toList();
    
    // Sort by wins/percentage
    filtered.sort((a, b) => b.winPercentage.compareTo(a.winPercentage));

    return Column(
      children: [
        _buildHeader(),
        Expanded(
          child: ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              return _buildTeamRow(filtered[index], index + 1);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: const Color(0xFF1A1A1A),
      child: const Row(
        children: [
          SizedBox(width: 30, child: Text('POS', style: _headerStyle)),
          Expanded(child: Text('EQUIPA', style: _headerStyle)),
          SizedBox(width: 50, child: Text('V-D', textAlign: TextAlign.center, style: _headerStyle)),
          SizedBox(width: 50, child: Text('%', textAlign: TextAlign.center, style: _headerStyle)),
          SizedBox(width: 40, child: Text('STRK', textAlign: TextAlign.center, style: _headerStyle)),
        ],
      ),
    );
  }

  Widget _buildTeamRow(Standing standing, int rank) {
    final isPlayoffZone = rank <= 6;
    final isPlayInZone = rank > 6 && rank <= 10;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Color(0xFF1A1A1A))),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 30,
            child: Text(
              '$rank',
              style: TextStyle(
                color: isPlayoffZone ? Colors.white : (isPlayInZone ? Colors.blueAccent : Colors.white38),
                fontWeight: rank <= 10 ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Image.network(
                  NbaRepository.getTeamLogoUrl(standing.teamId.toString()),
                  width: 24,
                  height: 24,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.sports_basketball, size: 24, color: Colors.white24),
                ),
                const SizedBox(width: 12),
                Text(
                  standing.abbreviation,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                ),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    standing.teamName.split(' ').last,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 50,
            child: Text(
              '${standing.wins}-${standing.losses}',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
          SizedBox(
            width: 50,
            child: Text(
              standing.winPercentage.toStringAsFixed(3).replaceFirst('0', ''),
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
          SizedBox(
            width: 40,
            child: Text(
              standing.streak,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: standing.streak.startsWith('W') ? Colors.greenAccent : Colors.redAccent,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static const _headerStyle = TextStyle(
    color: Colors.white54,
    fontSize: 11,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5,
  );
}

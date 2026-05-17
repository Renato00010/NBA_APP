import 'package:flutter/material.dart';
import '../../main.dart';
import '../../l10n/app_localizations.dart';
import '../../models/standing.dart';
import '../../services/repository.dart';
import '../../widgets/playoff_bracket_widget.dart';

class StandingsScreen extends StatefulWidget {
  const StandingsScreen({super.key});

  @override
  State<StandingsScreen> createState() => _StandingsScreenState();
}

class _StandingsScreenState extends State<StandingsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Standing> _standings = [];
  bool _loading = true;
  bool _usingLiveEspn = false;
  int _selectedSeason = 2026;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadStandings();
  }

  Future<void> _loadStandings() async {
    setState(() => _loading = true);
    try {
      final standings = await repository.getStandings(season: _selectedSeason);
      if (mounted) {
        setState(() {
          _standings = standings;
          _usingLiveEspn =
              _selectedSeason >= DateTime.now().year - 1 && standings.isNotEmpty;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _loading = false;
          _usingLiveEspn = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary, // Cor dinâmica
        elevation: 4,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.standings.toUpperCase(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.5,
              ),
            ),
            if (_usingLiveEspn)
              Text(
                _t(context, 'Dados ao vivo · ESPN', 'Live data · ESPN'),
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                ),
              ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                _loading = true;
                _standings = [];
              });
              _loadStandings();
            },
            icon: const Icon(Icons.refresh, color: Colors.white70),
          ),
          DropdownButton<int>(
            value: _selectedSeason,
            items: [2023, 2024, 2025, 2026]
                .map(
                  (year) => DropdownMenuItem(
                    value: year,
                    child: Text('${year - 1}/${year.toString().substring(2)}'),
                  ),
                )
                .toList(),
            onChanged: (val) {
              if (val != null && val != _selectedSeason) {
                setState(() {
                  _selectedSeason = val;
                  _loading = true;
                  _standings = [];
                });
                _loadStandings();
              }
            },
            underline: Container(),
            dropdownColor: const Color(0xFF0A0A0A),
            iconEnabledColor: Colors.white,
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: theme.colorScheme.primary,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white54,
          tabs: [
            Tab(text: _t(context, 'CONFERENCIA ESTE', 'EASTERN CONFERENCE')),
            Tab(text: _t(context, 'CONFERENCIA OESTE', 'WESTERN CONFERENCE')),
            const Tab(text: 'PLAYOFFS'),
          ],
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadStandings,
              color: theme.colorScheme.primary,
              child: TabBarView(
                key: ValueKey('standings_$_selectedSeason'),
                controller: _tabController,
                children: [
                  _buildConferenceTable('East'),
                  _buildConferenceTable('West'),
                  PlayoffBracketWidget(standings: _standings),
                ],
              ),
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
        _buildHeader(context),
        Expanded(
          child: ListView.builder(
            itemCount: filtered.length,
            itemBuilder: (context, index) {
              final standing = filtered[index];
              return Column(
                children: [
                  if (index == 6)
                    _buildDivisionLine(
                      context,
                      _t(context, 'PLAY-IN', 'PLAY-IN TOURNAMENT'),
                      Colors.blueAccent,
                    ),
                  if (index == 10)
                    _buildDivisionLine(
                      context,
                      _t(context, 'LINHA DE ELIMINACAO', 'ELIMINATION LINE'),
                      Colors.redAccent.withValues(alpha: 0.5),
                    ),
                  _buildTeamRow(standing, index + 1),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: const Color(0xFF1A1A1A),
      child: Column(
        children: [
          Row(
            children: [
              const SizedBox(
                width: 30,
                child: Text('POS', style: _headerStyle),
              ),
              Expanded(
                child: Text(_t(context, 'EQUIPA', 'TEAM'), style: _headerStyle),
              ),
              const SizedBox(
                width: 50,
                child: Text(
                  'W-L',
                  textAlign: TextAlign.center,
                  style: _headerStyle,
                ),
              ),
              const SizedBox(
                width: 50,
                child: Text(
                  '%',
                  textAlign: TextAlign.center,
                  style: _headerStyle,
                ),
              ),
              const SizedBox(
                width: 40,
                child: Text(
                  'STRK',
                  textAlign: TextAlign.center,
                  style: _headerStyle,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDivisionLine(BuildContext context, String label, Color color) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        border: Border(
          top: BorderSide(color: color.withValues(alpha: 0.2), width: 0.5),
          bottom: BorderSide(color: color.withValues(alpha: 0.2), width: 0.5),
        ),
      ),
      child: Row(
        children: [
          Icon(Icons.double_arrow, size: 12, color: color),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w900,
              letterSpacing: 1,
            ),
          ),
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
                color: isPlayoffZone
                    ? Colors.white
                    : (isPlayInZone ? Colors.blueAccent : Colors.white38),
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
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.sports_basketball,
                    size: 24,
                    color: Colors.white24,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  standing.abbreviation,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
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
                color: standing.streak.startsWith('W')
                    ? Colors.greenAccent
                    : Colors.redAccent,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _t(BuildContext context, String pt, String en) {
    return Localizations.localeOf(context).languageCode == 'en' ? en : pt;
  }

  static const _headerStyle = TextStyle(
    color: Colors.white54,
    fontSize: 11,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.5,
  );
}

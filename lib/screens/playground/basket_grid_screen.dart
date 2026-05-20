import 'dart:math';
import 'package:flutter/material.dart';
import '../../main.dart';
import '../../db/app_database.dart';
import '../../widgets/team_logo.dart';
import '../../widgets/basketball_loader.dart';

class BasketGridScreen extends StatefulWidget {
  final Function(int score) onGameCompleted;

  const BasketGridScreen({super.key, required this.onGameCompleted});

  @override
  State<BasketGridScreen> createState() => _BasketGridScreenState();
}

class _BasketGridScreenState extends State<BasketGridScreen> {
  int _attemptsLeft = 9;
  int _score = 0;
  bool _gameOver = false;
  bool _loading = true;

  List<NbaTeam> _allTeams = [];
  List<Player> _allPlayers = [];

  // Grid answers [RowIndex][ColIndex] -> Player?
  final List<List<Player?>> _gridAnswers = List.generate(3, (_) => List.filled(3, null));

  // Team configurations
  final List<Map<String, dynamic>> _rows = [];
  final List<Map<String, dynamic>> _cols = [];

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    try {
      final teams = await database.teamsDao.getAllTeams();
      final activePlayers = await database.playersDao.getAllPlayers();
      final retiredPlayers = await database.playersDao.getAllRetiredPlayers();
      
      final mappedRetired = retiredPlayers.map((rp) => Player(
        playerId: rp.playerId,
        teamId: 'retired',
        fullName: rp.fullName,
        displayName: rp.displayName,
        position: rp.position,
        jerseyNumber: rp.jerseyNumber,
        heightCm: rp.heightCm,
        weightKg: rp.weightKg,
        birthDate: rp.birthDate,
        country: rp.country,
        previousTeam: rp.previousTeam,
        experienceYears: rp.experienceYears,
        photoWebpPath: rp.photoWebpPath,
        careerTeams: rp.careerTeams,
        ppg: 0, rpg: 0, apg: 0, spg: 0, bpg: 0, mpg: 0, topg: 0, fgPct: 0, fg3Pct: 0, ftPct: 0,
        careerPoints: 0, careerRebounds: 0, careerAssists: 0, careerSteals: 0, careerBlocks: 0, careerGames: 0, careerStarts: 0, careerTurnovers: 0,
        cachedAt: DateTime.now(),
      )).toList();

      if (mounted) {
        setState(() {
          _allTeams = teams;
          _allPlayers = [...activePlayers, ...mappedRetired];
          _setupRandomTeams();
          _loading = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  void _setupRandomTeams() {
    if (_allTeams.isEmpty) return;

    final random = Random();
    
    for (int attempt = 0; attempt < 500; attempt++) {
      final shuffledTeams = List<NbaTeam>.from(_allTeams)..shuffle(random);
      final candidates = shuffledTeams.take(6).toList();
      
      final candidateRows = candidates.sublist(0, 3);
      final candidateCols = candidates.sublist(3, 6);
      
      bool solvable = true;
      for (final r in candidateRows) {
        for (final c in candidateCols) {
          final hasPlayer = _allPlayers.any((p) =>
              _playerPlayedForTeam(p, r) && _playerPlayedForTeam(p, c));
          if (!hasPlayer) {
            solvable = false;
            break;
          }
        }
        if (!solvable) break;
      }
      
      if (solvable) {
        setState(() {
          _rows.clear();
          _rows.addAll(candidateRows.map((t) => {
            'id': t.teamId,
            'name': t.name.split(' ').last,
            'code': _getTeamCode(t),
            'color': _getTeamColor(t),
          }));
          
          _cols.clear();
          _cols.addAll(candidateCols.map((t) => {
            'id': t.teamId,
            'name': t.name.split(' ').last,
            'code': _getTeamCode(t),
            'color': _getTeamColor(t),
          }));
        });
        return;
      }
    }

    // Fallback if no solvable configuration was found randomly
    final fallbackRows = [
      _allTeams.firstWhere((t) => t.teamId == '14', orElse: () => _allTeams[0]),
      _allTeams.firstWhere((t) => t.teamId == '2', orElse: () => _allTeams[1]),
      _allTeams.firstWhere((t) => t.teamId == '10', orElse: () => _allTeams[2]),
    ];
    final fallbackCols = [
      _allTeams.firstWhere((t) => t.teamId == '16', orElse: () => _allTeams[3]),
      _allTeams.firstWhere((t) => t.teamId == '3', orElse: () => _allTeams[4]),
      _allTeams.firstWhere((t) => t.teamId == '13', orElse: () => _allTeams[5]),
    ];
    
    setState(() {
      _rows.clear();
      _rows.addAll(fallbackRows.map((t) => {
        'id': t.teamId,
        'name': t.name.split(' ').last,
        'code': _getTeamCode(t),
        'color': _getTeamColor(t),
      }));
      _cols.clear();
      _cols.addAll(fallbackCols.map((t) => {
        'id': t.teamId,
        'name': t.name.split(' ').last,
        'code': _getTeamCode(t),
        'color': _getTeamColor(t),
      }));
    });
  }

  bool _playerPlayedForTeam(Player player, NbaTeam team) {
    if (player.teamId == team.teamId) return true;

    final teamNameLower = team.name.toLowerCase();
    final teamCityLower = team.city.toLowerCase();
    
    final teamCodes = const {
      '1': 'ATL', '2': 'BOS', '3': 'BKN', '4': 'CHA', '5': 'CHI',
      '6': 'CLE', '7': 'DAL', '8': 'DEN', '9': 'DET', '10': 'GSW',
      '11': 'HOU', '12': 'IND', '13': 'LAC', '14': 'LAL', '15': 'MEM',
      '16': 'MIA', '17': 'MIL', '18': 'MIN', '19': 'NOP', '20': 'NYK',
      '21': 'OKC', '22': 'ORL', '23': 'PHI', '24': 'PHX', '25': 'POR',
      '26': 'SAC', '27': 'SAS', '28': 'TOR', '29': 'UTA', '30': 'WAS',
    };
    final code = teamCodes[team.teamId];

    if (player.careerTeams != null && player.careerTeams!.isNotEmpty) {
      final careerTeamsList = player.careerTeams!
          .split(',')
          .map((t) => t.trim().toUpperCase())
          .toList();
      
      for (final ct in careerTeamsList) {
        if (code != null && ct == code) return true;
        final ctLower = ct.toLowerCase();
        if (teamNameLower.contains(ctLower) || teamCityLower.contains(ctLower)) return true;
        if (ctLower.contains(teamNameLower) || ctLower.contains(teamCityLower)) return true;
      }
    }

    if (player.previousTeam != null && player.previousTeam!.isNotEmpty) {
      final prevLower = player.previousTeam!.toLowerCase();
      if (prevLower.contains(teamNameLower) || prevLower.contains(teamCityLower)) return true;
    }

    return false;
  }

  String _getTeamCode(NbaTeam team) {
    final teamCodes = const {
      '1': 'ATL', '2': 'BOS', '3': 'BKN', '4': 'CHA', '5': 'CHI',
      '6': 'CLE', '7': 'DAL', '8': 'DEN', '9': 'DET', '10': 'GSW',
      '11': 'HOU', '12': 'IND', '13': 'LAC', '14': 'LAL', '15': 'MEM',
      '16': 'MIA', '17': 'MIL', '18': 'MIN', '19': 'NOP', '20': 'NYK',
      '21': 'OKC', '22': 'ORL', '23': 'PHI', '24': 'PHX', '25': 'POR',
      '26': 'SAC', '27': 'SAS', '28': 'TOR', '29': 'UTA', '30': 'WAS',
    };
    return teamCodes[team.teamId] ?? team.name.substring(0, 3).toUpperCase();
  }

  Color _getTeamColor(NbaTeam team) {
    final teamColors = const {
      '1': Color(0xFFC1D32F),
      '2': Color(0xFF007A33),
      '3': Color(0xFF000000),
      '4': Color(0xFF1D1160),
      '5': Color(0xFFCE1141),
      '6': Color(0xFF860038),
      '7': Color(0xFF00538C),
      '8': Color(0xFF0E2240),
      '9': Color(0xFFC8102E),
      '10': Color(0xFF1D428A),
      '11': Color(0xFFCE1141),
      '12': Color(0xFFFDBB30),
      '13': Color(0xFFC8102E),
      '14': Color(0xFF552583),
      '15': Color(0xFF5D76A9),
      '16': Color(0xFF98002E),
      '17': Color(0xFF00471B),
      '18': Color(0xFF0C2340),
      '19': Color(0xFF0C2340),
      '20': Color(0xFF006BB6),
      '21': Color(0xFF007AC1),
      '22': Color(0xFF0077C0),
      '23': Color(0xFF006BB6),
      '24': Color(0xFF1D1160),
      '25': Color(0xFFE03A3E),
      '26': Color(0xFF5A2D81),
      '27': Color(0xFFC4CED4),
      '28': Color(0xFFCE1141),
      '29': Color(0xFF002B5C),
      '30': Color(0xFF002B5C),
    };
    return teamColors[team.teamId] ?? Colors.grey;
  }

  bool _isEnglish(BuildContext context) =>
      Localizations.localeOf(context).languageCode == 'en';

  String _t(String pt, String en) => _isEnglish(context) ? en : pt;

  bool _validateCrossover(Player player, String rowTeamId, String colTeamId) {
    final rowTeam = _allTeams.firstWhere((t) => t.teamId == rowTeamId);
    final colTeam = _allTeams.firstWhere((t) => t.teamId == colTeamId);
    return _playerPlayedForTeam(player, rowTeam) && _playerPlayedForTeam(player, colTeam);
  }

  void _tapCell(int rowIndex, int colIndex) {
    if (_gameOver || _gridAnswers[rowIndex][colIndex] != null) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _PlayerSearchSheet(
        rowTeamName: _rows[rowIndex]['name'],
        colTeamName: _cols[colIndex]['name'],
        isEnglish: _isEnglish(context),
        onPlayerSelected: (player) {
          final isCorrect = _validateCrossover(player, _rows[rowIndex]['id'], _cols[colIndex]['id']);
          
          setState(() {
            _attemptsLeft--;
            if (isCorrect) {
              _gridAnswers[rowIndex][colIndex] = player;
              _score++;
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    _t(
                      '${player.fullName} não jogou em ambas as equipas!',
                      '${player.fullName} did not play for both teams!',
                    ),
                  ),
                  backgroundColor: Colors.redAccent,
                  duration: const Duration(seconds: 2),
                ),
              );
            }

            if (_attemptsLeft <= 0 || _score == 9) {
              _gameOver = true;
              widget.onGameCompleted(_score);
            }
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          _t('BASKET CROSSOVER GRID', 'BASKET CROSSOVER GRID'),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.0,
          ),
        ),
      ),
      body: SafeArea(
        child: _loading
            ? const Center(child: BasketballLoader(size: 60))
            : Column(
                children: [
                  // Dashboard Header
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _t('TENTATIVAS RESTANTES', 'ATTEMPTS LEFT'),
                              style: const TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$_attemptsLeft / 9',
                              style: TextStyle(
                                color: _attemptsLeft <= 2 ? Colors.redAccent : Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              _t('PONTUAÇÃO', 'SCORE'),
                              style: const TextStyle(color: Colors.white54, fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$_score / 9',
                              style: const TextStyle(
                                color: Colors.amber,
                                fontSize: 22,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const Divider(color: Colors.white10),

                  // 4x4 Grid Container
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: _buildGridMatrix(),
                        ),
                      ),
                    ),
                  ),

                  // GameOver Recap Screen
                  if (_gameOver) _buildGameOverView(),
                ],
              ),
      ),
    );
  }

  Widget _buildGridMatrix() {
    return Table(
      defaultColumnWidth: const IntrinsicColumnWidth(),
      children: [
        // Column Headers
        TableRow(
          children: [
            const SizedBox(width: 70, height: 70), // Empty top-left
            _buildTeamHeaderCell(_cols[0]),
            _buildTeamHeaderCell(_cols[1]),
            _buildTeamHeaderCell(_cols[2]),
          ],
        ),
        // Row 1
        TableRow(
          children: [
            _buildTeamHeaderCell(_rows[0]),
            _buildPlayCell(0, 0),
            _buildPlayCell(0, 1),
            _buildPlayCell(0, 2),
          ],
        ),
        // Row 2
        TableRow(
          children: [
            _buildTeamHeaderCell(_rows[1]),
            _buildPlayCell(1, 0),
            _buildPlayCell(1, 1),
            _buildPlayCell(1, 2),
          ],
        ),
        // Row 3
        TableRow(
          children: [
            _buildTeamHeaderCell(_rows[2]),
            _buildPlayCell(2, 0),
            _buildPlayCell(2, 1),
            _buildPlayCell(2, 2),
          ],
        ),
      ],
    );
  }

  Widget _buildTeamHeaderCell(Map<String, dynamic> team) {
    return Container(
      width: 76,
      height: 76,
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TeamLogo(teamId: team['id'], size: 36),
            const SizedBox(height: 4),
            Text(
              team['code'],
              style: const TextStyle(color: Colors.white70, fontSize: 9, fontWeight: FontWeight.w900),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayCell(int rowIndex, int colIndex) {
    final player = _gridAnswers[rowIndex][colIndex];
    final isCorrect = player != null;

    return GestureDetector(
      onTap: () => _tapCell(rowIndex, colIndex),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 76,
        height: 76,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isCorrect ? const Color(0xFF0F2C11) : const Color(0xFF1E1E1E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isCorrect ? Colors.green : Colors.white.withValues(alpha: 0.06),
            width: isCorrect ? 2 : 1,
          ),
          boxShadow: isCorrect
              ? [
                  BoxShadow(
                    color: Colors.green.withValues(alpha: 0.2),
                    blurRadius: 8,
                    spreadRadius: 1,
                  )
                ]
              : null,
        ),
        child: isCorrect
            ? ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Positioned.fill(
                      child: Opacity(
                        opacity: 0.85,
                        child: player.photoWebpPath != null
                            ? Image.asset(
                                player.photoWebpPath!,
                                fit: BoxFit.cover,
                                errorBuilder: (c, e, s) => const Icon(Icons.person, color: Colors.white30, size: 28),
                              )
                            : const Icon(Icons.person, color: Colors.white30, size: 28),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      color: Colors.black54,
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: Text(
                        player.fullName.split(' ').last,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 8,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              )
            : const Center(
                child: Icon(Icons.add, color: Colors.white24, size: 20),
              ),
      ),
    );
  }

  Widget _buildGameOverView() {
    final win = _score >= 5;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Color(0xFF121212),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            win ? Icons.emoji_events : Icons.sentiment_dissatisfied,
            color: win ? Colors.amber : Colors.redAccent,
            size: 48,
          ),
          const SizedBox(height: 12),
          Text(
            win ? _t('Grelha Concluída com Sucesso!', 'Grid Completed Successfully!') : _t('Fim do Jogo!', 'Game Over!'),
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            _t(
              'Acertaste em $_score de 9 cruzamentos possíveis e acumulaste +${_score * 20} XP!',
              'You correctly matched $_score of 9 grid intersections and earned +${_score * 20} XP!',
            ),
            style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1E1E1E),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Colors.white10),
                ),
              ),
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                _t('Voltar ao Hub', 'Back to Hub'),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayerSearchSheet extends StatefulWidget {
  final String rowTeamName;
  final String colTeamName;
  final bool isEnglish;
  final Function(Player player) onPlayerSelected;

  const _PlayerSearchSheet({
    required this.rowTeamName,
    required this.colTeamName,
    required this.isEnglish,
    required this.onPlayerSelected,
  });

  @override
  State<_PlayerSearchSheet> createState() => _PlayerSearchSheetState();
}

class _PlayerSearchSheetState extends State<_PlayerSearchSheet> {
  final _searchController = TextEditingController();
  List<Player> _searchResults = [];
  bool _searching = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _performSearch(''); // Show some players initially
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _performSearch(_searchController.text);
  }

  Future<void> _performSearch(String query) async {
    setState(() {
      _searching = true;
    });

    try {
      final activeResults = await database.playersDao.searchPlayers(query);
      final retiredResults = await database.playersDao.searchRetiredPlayers(query);
      
      final mappedRetired = retiredResults.map((rp) => Player(
        playerId: rp.playerId,
        teamId: 'retired',
        fullName: rp.fullName,
        displayName: rp.displayName,
        position: rp.position,
        jerseyNumber: rp.jerseyNumber,
        heightCm: rp.heightCm,
        weightKg: rp.weightKg,
        birthDate: rp.birthDate,
        country: rp.country,
        previousTeam: rp.previousTeam,
        experienceYears: rp.experienceYears,
        photoWebpPath: rp.photoWebpPath,
        careerTeams: rp.careerTeams,
        ppg: 0, rpg: 0, apg: 0, spg: 0, bpg: 0, mpg: 0, topg: 0, fgPct: 0, fg3Pct: 0, ftPct: 0,
        careerPoints: 0, careerRebounds: 0, careerAssists: 0, careerSteals: 0, careerBlocks: 0, careerGames: 0, careerStarts: 0, careerTurnovers: 0,
        cachedAt: DateTime.now(),
      )).toList();

      final combined = [...activeResults, ...mappedRetired];

      if (mounted) {
        setState(() {
          _searchResults = combined.take(15).toList();
          _searching = false;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => _searching = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Color(0xFF141414),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header description
          Text(
            widget.isEnglish
                ? 'Player who played for both:'
                : 'Jogador que jogou em ambos:',
            style: const TextStyle(color: Colors.white54, fontSize: 11, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            '${widget.rowTeamName} ✕ ${widget.colTeamName}',
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 16),

          // Search Field
          TextField(
            controller: _searchController,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            decoration: InputDecoration(
              hintText: widget.isEnglish ? 'Search player name...' : 'Pesquisar nome do jogador...',
              hintStyle: const TextStyle(color: Colors.white30, fontSize: 13),
              prefixIcon: const Icon(Icons.search, color: Colors.white30, size: 20),
              filled: true,
              fillColor: const Color(0xFF1E1E1E),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Player List
          Expanded(
            child: _searching
                ? const Center(child: BasketballLoader(size: 40))
                : _searchResults.isEmpty
                    ? Center(
                        child: Text(
                          widget.isEnglish ? 'No players found' : 'Nenhum jogador encontrado',
                          style: const TextStyle(color: Colors.white38, fontSize: 13),
                        ),
                      )
                    : ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          final player = _searchResults[index];
                          return Card(
                            color: const Color(0xFF1E1E1E),
                            margin: const EdgeInsets.only(bottom: 8),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.white12,
                                backgroundImage: player.photoWebpPath != null
                                    ? AssetImage(player.photoWebpPath!)
                                    : null,
                                child: player.photoWebpPath == null
                                    ? const Icon(Icons.person, color: Colors.white54)
                                    : null,
                              ),
                              title: Text(
                                player.fullName,
                                style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                player.position ?? 'F/G',
                                style: const TextStyle(color: Colors.white38, fontSize: 11),
                              ),
                              trailing: const Icon(Icons.chevron_right, color: Colors.white38, size: 20),
                              onTap: () {
                                widget.onPlayerSelected(player);
                                Navigator.of(context).pop(); // Close sheet
                              },
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}

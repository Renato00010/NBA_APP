import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../main.dart';
import '../../db/app_database.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/team_logo.dart';
import 'players_screen.dart';
import 'game_detail_screen.dart';
import '../../utils/game_status_utils.dart';
import '../../widgets/basketball_loader.dart';
import 'dart:ui';

class GamesScreen extends StatefulWidget {
  const GamesScreen({super.key});

  @override
  State<GamesScreen> createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  List<CachedGame> _liveGames = [];
  List<CachedGame> _selectedDayGames = [];
  List<CachedGame> _pastResults = [];
  bool _loading = true;
  DateTime _selectedDate = DateTime.now();
  Timer? _refreshTimer;

  bool get _isToday {
    final now = DateTime.now();
    return _selectedDate.year == now.year &&
        _selectedDate.month == now.month &&
        _selectedDate.day == now.day;
  }

  @override
  void initState() {
    super.initState();
    _loadGames();
    _refreshTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      _loadGames(isBackground: true);
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadGames({bool isBackground = false}) async {
    if (!isBackground && mounted) {
      setState(() => _loading = true);
    }
    try {
      await repository.getTeams();
      final dayGames = await repository.getGamesByDate(_selectedDate);
      final recent = await repository.getRecentResults();

      if (mounted) {
        setState(() {
          _liveGames = dayGames.where((g) => GameStatusUtils.isLive(g.status)).toList();
          _selectedDayGames = dayGames;
          _pastResults = recent;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2024, 10, 1),
      lastDate: DateTime.now().add(const Duration(days: 14)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: Color(0xFF17408B),
              surface: Color(0xFF1A1A1A),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
      await _loadGames();
    }
  }

  void _shiftDate(int days) {
    setState(() => _selectedDate = _selectedDate.add(Duration(days: days)));
    _loadGames();
  }

  void _goToToday() {
    setState(() => _selectedDate = DateTime.now());
    _loadGames();
  }

  String _dateLabel(BuildContext context) {
    if (_isToday) return _t(context, 'Hoje', 'Today');
    final locale = Localizations.localeOf(context).languageCode;
    return DateFormat.yMMMd(locale).format(_selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        elevation: 4,
        title: Text(
          l10n.games.toUpperCase(),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.people_outlined, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PlayersScreen()),
              );
            },
          ),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Column(
          children: [
            _buildDateBar(theme),
            TabBar(
              indicatorColor: theme.colorScheme.tertiary,
              labelColor: theme.colorScheme.tertiary,
              unselectedLabelColor: Colors.white54,
              tabs: [
                Tab(text: _t(context, 'Ao Vivo', 'Live')),
                Tab(text: _dateLabel(context)),
                Tab(text: _t(context, 'Resultados', 'Results')),
              ],
            ),
            Expanded(
              child: _loading
                  ? const Center(child: BasketballLoader())
                  : TabBarView(
                      children: [
                        _liveGames.isEmpty
                            ? Center(
                                child: Text(
                                  _t(
                                    context,
                                    'Sem jogos ao vivo',
                                    'No live games',
                                  ),
                                  style: const TextStyle(color: Colors.white54),
                                ),
                              )
                            : _buildGamesList(_liveGames, theme),
                        _selectedDayGames.isEmpty
                            ? Center(
                                child: Text(
                                  _t(
                                    context,
                                    'Sem jogos nesta data',
                                    'No games on this date',
                                  ),
                                  style: const TextStyle(color: Colors.white54),
                                ),
                              )
                            : _buildGamesList(_selectedDayGames, theme),
                        _buildGamesList(_pastResults, theme),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateBar(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      color: const Color(0xFF121212),
      child: Row(
        children: [
          IconButton(
            onPressed: () => _shiftDate(-1),
            icon: const Icon(Icons.chevron_left, color: Colors.white70),
          ),
          Expanded(
            child: InkWell(
              onTap: _pickDate,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A1A),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: theme.colorScheme.primary.withValues(alpha: 0.4),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.calendar_month, color: Color(0xFFFFC72C), size: 20),
                    const SizedBox(width: 8),
                    Text(
                      _dateLabel(context),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: () => _shiftDate(1),
            icon: const Icon(Icons.chevron_right, color: Colors.white70),
          ),
          if (!_isToday)
            TextButton(
              onPressed: _goToToday,
              child: Text(
                _t(context, 'Hoje', 'Today'),
                style: TextStyle(color: theme.colorScheme.tertiary),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildGamesList(List<CachedGame> games, ThemeData theme) {
    if (games.isEmpty) {
      return Center(
        child: Text(
          _t(context, 'Sem resultados', 'No results'),
          style: const TextStyle(color: Colors.white54),
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: _loadGames,
      color: theme.colorScheme.primary,
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: games.length,
        itemBuilder: (context, index) {
          final game = games[index];
          final isLive = GameStatusUtils.isLive(game.status);
          final homeName = repository.getTeamName(game.homeTeamId);
          final awayName = repository.getTeamName(game.awayTeamId);
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GameDetailScreen(
                    gameId: game.gameId,
                    homeName: homeName,
                    awayName: awayName,
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: isLive
                    ? Border.all(color: theme.colorScheme.secondary, width: 1)
                    : Border.all(color: Colors.white.withValues(alpha: 0.08)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.03),
                    ),
                    child: Column(
                children: [
                  if (isLive)
                    Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            TeamLogo(
                              teamId: game.awayTeamId,
                              size: 48,
                              fallbackColor: Colors.white38,
                              heroTag: 'game_${game.gameId}_${game.awayTeamId}',
                            ),
                            const SizedBox(height: 8),
                            Text(
                              awayName.split(' ').last.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              '${game.scoreAway} - ${game.scoreHome}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              game.status.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            TeamLogo(
                              teamId: game.homeTeamId,
                              size: 48,
                              fallbackColor: Colors.white38,
                              heroTag: 'game_${game.gameId}_${game.homeTeamId}',
                            ),
                            const SizedBox(height: 8),
                            Text(
                              homeName.split(' ').last.toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ),
            ),
          ),
          );
        },
      ),
    );
  }

  String _t(BuildContext context, String pt, String en) {
    return Localizations.localeOf(context).languageCode == 'en' ? en : pt;
  }
}

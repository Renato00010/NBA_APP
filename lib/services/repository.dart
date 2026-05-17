import 'dart:convert';
import 'package:flutter/foundation.dart'; // debugPrint
import 'package:flutter/services.dart' show rootBundle;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:drift/drift.dart'; // Value<T>
import '../db/app_database.dart';
import '../models/standing.dart';
import '../models/player_season_stats.dart';
import 'nba_api_service.dart';
import '../utils/game_status_utils.dart';

class NbaRepository {
  final AppDatabase _db;
  final NbaApiService _api;

  final Map<String, String> _teamNames = {};
  final Map<String, String> _teamCities = {};

  NbaRepository(this._db, this._api);

  Future<bool> _hasInternet() async {
    final results = await Connectivity().checkConnectivity();
    return !results.contains(ConnectivityResult.none);
  }

  String getTeamName(String teamId) => _teamNames[teamId] ?? 'Equipa $teamId';
  String getTeamCity(String teamId) => _teamCities[teamId] ?? '';

  static const Map<String, String> _nbaCdnTeamIds = {
    '1': '1610612737',
    '2': '1610612738',
    '3': '1610612751',
    '4': '1610612766',
    '5': '1610612741',
    '6': '1610612739',
    '7': '1610612742',
    '8': '1610612743',
    '9': '1610612765',
    '10': '1610612744',
    '11': '1610612745',
    '12': '1610612754',
    '13': '1610612746',
    '14': '1610612747',
    '15': '1610612763',
    '16': '1610612748',
    '17': '1610612749',
    '18': '1610612750',
    '19': '1610612740',
    '20': '1610612752',
    '21': '1610612760',
    '22': '1610612753',
    '23': '1610612755',
    '24': '1610612756',
    '25': '1610612757',
    '26': '1610612758',
    '27': '1610612759',
    '28': '1610612761',
    '29': '1610612762',
    '30': '1610612764',
  };

  static const Map<String, String> _espnTeamSlugs = {
    '1': 'atl',
    '2': 'bos',
    '3': 'bkn',
    '4': 'cha',
    '5': 'chi',
    '6': 'cle',
    '7': 'dal',
    '8': 'den',
    '9': 'det',
    '10': 'gs',
    '11': 'hou',
    '12': 'ind',
    '13': 'lac',
    '14': 'lal',
    '15': 'mem',
    '16': 'mia',
    '17': 'mil',
    '18': 'min',
    '19': 'no',
    '20': 'ny',
    '21': 'okc',
    '22': 'orl',
    '23': 'phi',
    '24': 'phx',
    '25': 'por',
    '26': 'sac',
    '27': 'sa',
    '28': 'tor',
    '29': 'utah',
    '30': 'wsh',
  };

  static String getTeamLogoUrl(String teamId) {
    final slug = _espnTeamSlugs[teamId];
    if (slug != null) {
      return 'https://a.espncdn.com/i/teamlogos/nba/500/$slug.png';
    }

    final cdnTeamId = _nbaCdnTeamIds[teamId] ?? teamId;
    return 'https://cdn.nba.com/logos/nba/$cdnTeamId/global/L/logo.svg';
  }

  static String getPlayerPhotoUrl(String playerId) =>
      'https://cdn.nba.com/headshots/nba/latest/1040x760/$playerId.png';

  Future<List<NbaTeam>> getTeams() async {
    final teams = await _db.teamsDao.getAllTeams();
    for (final t in teams) {
      _teamNames[t.teamId] = t.name;
      _teamCities[t.teamId] = t.city;
    }
    return teams;
  }

  String _findTeamIdByName(String name) {
    if (name.isEmpty) return '1'; // Default fallback
    final lowerName = name.toLowerCase().replaceAll('la ', 'los angeles ');
    for (final entry in _teamNames.entries) {
      if (entry.value.toLowerCase() == lowerName ||
          lowerName.contains(entry.value.toLowerCase())) {
        return entry.key;
      }
    }
    return '1';
  }

  static int currentNbaSeasonYear() {
    final now = DateTime.now();
    return now.month >= 10 ? now.year + 1 : now.year;
  }

  static DateTime seasonStartDate(int seasonYear) =>
      DateTime(seasonYear - 1, 10, 1);

  static DateTime seasonEndDate(int seasonYear) =>
      DateTime(seasonYear, 7, 1);

  int _parseEspnScore(dynamic score) {
    if (score == null) return 0;
    if (score is Map) {
      final raw =
          score['displayValue']?.toString() ?? score['value']?.toString() ?? '0';
      return int.tryParse(raw.split('.').first) ?? 0;
    }
    return int.tryParse(score.toString()) ?? 0;
  }

  CachedGamesCompanion? _companionFromEspnEvent(Map<String, dynamic> event) {
    final competitions = event['competitions'] as List<dynamic>?;
    if (competitions == null || competitions.isEmpty) return null;

    final comp = competitions.first as Map<String, dynamic>;
    final competitors = comp['competitors'] as List<dynamic>?;
    if (competitors == null || competitors.length < 2) return null;

    final home = competitors.firstWhere(
      (c) => c['homeAway'] == 'home',
      orElse: () => competitors.first,
    );
    final away = competitors.firstWhere(
      (c) => c['homeAway'] == 'away',
      orElse: () => competitors.last,
    );

    final homeTeam = home['team'] as Map<String, dynamic>?;
    final awayTeam = away['team'] as Map<String, dynamic>?;
    final homeName =
        homeTeam?['displayName'] ?? homeTeam?['name'] ?? '';
    final awayName =
        awayTeam?['displayName'] ?? awayTeam?['name'] ?? '';

    final statusSource =
        comp['status'] as Map<String, dynamic>? ??
        event['status'] as Map<String, dynamic>?;
    final statusType = statusSource?['type'] as Map<String, dynamic>?;
    final statusDetail =
        statusType?['detail']?.toString() ??
        statusType?['shortDetail']?.toString() ??
        statusType?['state']?.toString() ??
        '';
    final statusState = statusType?['state']?.toString().toLowerCase() ?? '';

    final dateStr = comp['date']?.toString() ?? event['date']?.toString();
    if (dateStr == null) return null;

    return CachedGamesCompanion(
      gameId: Value(event['id'].toString()),
      homeTeamId: Value(_findTeamIdByName(homeName)),
      awayTeamId: Value(_findTeamIdByName(awayName)),
      scoreHome: Value(_parseEspnScore(home['score'])),
      scoreAway: Value(_parseEspnScore(away['score'])),
      status: Value(_normalizeEspnGameStatus(statusState, statusDetail)),
      gameDate: Value(DateTime.parse(dateStr)),
    );
  }

  Future<void> _syncEspnEvents(List<dynamic> events) async {
    final companions = <CachedGamesCompanion>[];
    for (final event in events) {
      if (event is! Map<String, dynamic>) continue;
      final companion = _companionFromEspnEvent(event);
      if (companion != null) companions.add(companion);
    }
    if (companions.isNotEmpty) {
      await _db.gamesDao.upsertAllGames(companions);
    }
  }

  Future<void> _syncTeamSeasonSchedule(String teamId) async {
    final slug = _espnTeamSlugs[teamId];
    if (slug == null) return;

    final season = currentNbaSeasonYear();
    for (final seasonType in [2, 3]) {
      final events = await _api.getEspnTeamSchedule(
        slug,
        season: season,
        seasonType: seasonType,
      );
      await _syncEspnEvents(events);
    }
  }

  /// Jogos da época atual da equipa (calendário ESPN + cache local).
  Future<List<CachedGame>> getTeamSeasonGames(String teamId) async {
    await getTeams();
    if (await _hasInternet()) {
      try {
        await _syncTeamSeasonSchedule(teamId);
      } catch (e) {
        debugPrint('Erro getTeamSeasonGames (ESPN): $e');
      }
    }

    final season = currentNbaSeasonYear();
    final games = await _db.gamesDao.getGamesForTeamInRange(
      teamId,
      seasonStartDate(season),
      seasonEndDate(season),
    );
    return _withoutDemoGames(games);
  }

  Future<List<CachedGame>> getGamesByDate(DateTime date) async {
    if (await _hasInternet()) {
      try {
        // Busca ontem, hoje e amanhã para os fusos horários
        final daysToSync = [-1, 0, 1];
        for (final offset in daysToSync) {
          final targetDate = date.add(Duration(days: offset));
          final dateStr =
              '${targetDate.year}${targetDate.month.toString().padLeft(2, '0')}${targetDate.day.toString().padLeft(2, '0')}';

          final data = await _api.getEspnScoreboard(dateStr);
          await _syncEspnEvents(data);
        }
      } catch (e) {
        debugPrint('Erro getGamesByDate (ESPN): $e');
      }
    }

    final localGames = await _db.gamesDao.getGamesByDate(date);

    return _withoutDemoGames(
      localGames,
    ).where((game) => _isSameLocalDate(game.gameDate, date)).toList();
  }

  /// Retorna jogos recentes para a aba de resultados
  /// Jogos futuros reais da equipa (sincroniza calendário ESPN antes de filtrar).
  Future<List<CachedGame>> getUpcomingGamesForTeam(
    String teamId, {
    int daysAhead = 14,
  }) async {
    final today = DateTime.now();
    for (var offset = 0; offset <= daysAhead; offset++) {
      await getGamesByDate(today.add(Duration(days: offset)));
    }

    final end = today.add(Duration(days: daysAhead + 1));
    final games = await _db.gamesDao.getGamesInDateRange(today, end);
    final upcoming = games
        .where((game) {
          if (game.homeTeamId != teamId && game.awayTeamId != teamId) {
            return false;
          }
          final status = game.status.toLowerCase();
          if (status.contains('final')) return false;
          return game.gameDate.isAfter(
            DateTime.now().subtract(const Duration(minutes: 15)),
          );
        })
        .toList()
      ..sort((a, b) => a.gameDate.compareTo(b.gameDate));
    return _withoutDemoGames(upcoming);
  }

  static String _normalizeEspnGameStatus(String state, String detail) {
    final d = detail.trim();
    if (state == 'post' || GameStatusUtils.isFinal(d)) {
      return d.isNotEmpty ? d : 'Final';
    }
    if (state == 'in' || GameStatusUtils.isLive(d)) {
      return d.isNotEmpty ? d : 'Live';
    }
    if (state == 'pre' || GameStatusUtils.isScheduled(d)) {
      return d.isNotEmpty ? d : 'Scheduled';
    }
    return d.isNotEmpty ? d : 'Scheduled';
  }

  Future<List<CachedGame>> getRecentResults() async {
    final today = DateTime.now();
    final start = today.subtract(const Duration(days: 7));
    final results = await _db.gamesDao.getGamesInDateRange(start, today);
    return _withoutDemoGames(
      results.where((g) => GameStatusUtils.isFinal(g.status)).toList(),
    );
  }

  List<CachedGame> _withoutDemoGames(List<CachedGame> games) {
    return games
        .where((game) => !game.gameId.startsWith('real_2024_'))
        .toList();
  }

  bool _isSameLocalDate(DateTime value, DateTime date) {
    final localValue = value.toLocal();
    final localDate = date.toLocal();
    return localValue.year == localDate.year &&
        localValue.month == localDate.month &&
        localValue.day == localDate.day;
  }

  Future<List<Player>> getPlayers({String? search}) async {
    if (search != null && search.isNotEmpty) {
      return _db.playersDao.searchPlayers(search);
    }
    return _db.playersDao.getAllPlayers();
  }

  Future<Player?> getPlayerCareer(String playerId) async {
    return _db.playersDao.getPlayerById(playerId);
  }

  // -------- PLAYER SEASON STATS --------
  Future<List<PlayerSeasonStats>> getPlayerSeasonStats(String playerId) async {
    final seasons = await _db.playersDao.getPlayerSeasons(playerId);
    return seasons
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

  Future<List<Standing>> getStandings({int season = 2024}) async {
    final isRecentSeason = season >= DateTime.now().year - 1;
    if (isRecentSeason && await _hasInternet()) {
      try {
        await getTeams();
        final espn = await _api.getEspnStandings();
        if (espn.isNotEmpty) {
          return espn.map((row) {
            final mappedId = int.tryParse(_findTeamIdByName(row.teamName)) ?? row.teamId;
            return Standing(
              teamId: mappedId,
              teamName: row.teamName,
              abbreviation: row.abbreviation,
              conference: row.conference,
              wins: row.wins,
              losses: row.losses,
              winPercentage: row.winPercentage,
              gamesBack: row.gamesBack,
              streak: row.streak,
              last10: row.last10,
              conferenceRecord: row.conferenceRecord,
              homeRecord: row.homeRecord,
              roadRecord: row.roadRecord,
            );
          }).toList();
        }
      } catch (e) {
        debugPrint('Erro getStandings (ESPN): $e');
      }
    }

    try {
      final path = 'assets/data/standings/$season.json';
      String jsonString;
      try {
        jsonString = await rootBundle.loadString(path);
      } catch (e) {
        // Fallback para Web (algumas configurações removem o prefixo assets/)
        jsonString = await rootBundle.loadString('data/standings/$season.json');
      }

      final List<dynamic> parsed = json.decode(jsonString) as List<dynamic>;
      return parsed
          .map((json) => Standing.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      debugPrint('Erro crítico ao carregar standings: $e');
    }
    // Caso tudo falhe, devolve lista vazia.
    return [];
  }

  Future<Map<String, dynamic>> getGameSummary(String eventId) async {
    if (await _hasInternet()) {
      return _api.getEspnGameSummary(eventId);
    }
    return {};
  }

  Future<List<dynamic>> getNews() async {
    if (await _hasInternet()) {
      return _api.getEspnNews();
    }
    return [];
  }
}

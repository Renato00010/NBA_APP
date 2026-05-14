import 'dart:convert';
import 'package:flutter/foundation.dart'; // debugPrint
import 'package:flutter/services.dart' show rootBundle;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:drift/drift.dart'; // Value<T>
import '../db/app_database.dart';
import '../models/standing.dart';
import '../models/player_season_stats.dart';
import 'nba_api_service.dart';

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
      if (entry.value.toLowerCase() == lowerName || lowerName.contains(entry.value.toLowerCase())) {
        return entry.key;
      }
    }
    return '1';
  }

  Future<List<CachedGame>> getGamesByDate(DateTime date) async {
    if (await _hasInternet()) {
      try {
        // Busca ontem, hoje e amanhã para os fusos horários
        final daysToSync = [-1, 0, 1];
        for (final offset in daysToSync) {
          final targetDate = date.add(Duration(days: offset));
          final dateStr = '${targetDate.year}${targetDate.month.toString().padLeft(2, '0')}${targetDate.day.toString().padLeft(2, '0')}';
          
          final data = await _api.getEspnScoreboard(dateStr);
          final List<CachedGamesCompanion> companions = [];
          
          for (final event in data) {
            final comp = event['competitions'][0];
            final competitors = comp['competitors'] as List<dynamic>;
            final home = competitors.firstWhere((c) => c['homeAway'] == 'home');
            final away = competitors.firstWhere((c) => c['homeAway'] == 'away');
            
            final homeName = home['team']['displayName'] ?? home['team']['name'] ?? '';
            final awayName = away['team']['displayName'] ?? away['team']['name'] ?? '';
            
            final homeId = _findTeamIdByName(homeName);
            final awayId = _findTeamIdByName(awayName);
            
            final statusDetail = event['status']['type']['detail'] ?? event['status']['type']['state'];
            
            companions.add(CachedGamesCompanion(
              gameId: Value(event['id'].toString()),
              homeTeamId: Value(homeId),
              awayTeamId: Value(awayId),
              scoreHome: Value(int.tryParse(home['score']?.toString() ?? '0') ?? 0),
              scoreAway: Value(int.tryParse(away['score']?.toString() ?? '0') ?? 0),
              status: Value(statusDetail),
              gameDate: Value(DateTime.parse(event['date'])),
            ));
          }
          
          if (companions.isNotEmpty) {
            await _db.gamesDao.upsertAllGames(companions);
          }
        }
      } catch (e) {
        debugPrint('Erro getGamesByDate (ESPN): $e');
      }
    }

    var localGames = await _db.gamesDao.getGamesByDate(date);

    // OFFLINE FALLBACK: Se a DB local estiver vazia, inserir jogos de demonstração
    if (localGames.isEmpty) {
      await _seedFallbackGames();
      localGames = await _db.gamesDao.getGamesByDate(date);
    }

    return localGames;
  }

  Future<void> _seedFallbackGames() async {
    final today = DateTime.now();
    final yesterday = today.subtract(const Duration(days: 1));

    // Utilizando dados 100% REAIS de jogos marcantes dos Playoffs de 2024,
    // mas com as datas ajustadas para "hoje" e "ontem" para aparecerem na UI.
    final fallbacks = [
      CachedGamesCompanion(
        gameId: const Value('real_2024_finals_g3'),
        homeTeamId: const Value('7'),  // Dallas Mavericks
        awayTeamId: const Value('2'),  // Boston Celtics
        scoreHome: const Value(99),
        scoreAway: const Value(106),
        status: const Value('Final'),
        gameDate: Value(yesterday),
      ),
      CachedGamesCompanion(
        gameId: const Value('real_2024_wcf_g1'),
        homeTeamId: const Value('18'), // Minnesota Timberwolves
        awayTeamId: const Value('7'),  // Dallas Mavericks
        scoreHome: const Value(105),
        scoreAway: const Value(108),
        status: const Value('Final'),
        gameDate: Value(yesterday),
      ),
      CachedGamesCompanion(
        gameId: const Value('real_2024_ecf_g3'),
        homeTeamId: const Value('12'), // Indiana Pacers
        awayTeamId: const Value('2'),  // Boston Celtics
        scoreHome: const Value(111),
        scoreAway: const Value(114),
        status: const Value('Final'),
        gameDate: Value(today),
      ),
      CachedGamesCompanion(
        gameId: const Value('real_2024_wcsf_g7'),
        homeTeamId: const Value('8'),  // Denver Nuggets
        awayTeamId: const Value('18'), // Minnesota Timberwolves
        scoreHome: const Value(90),
        scoreAway: const Value(98),
        status: const Value('Final'),
        gameDate: Value(today),
      ),
    ];
    await _db.gamesDao.upsertAllGames(fallbacks);
  }

  /// Retorna jogos recentes para a aba de resultados
  Future<List<CachedGame>> getRecentResults() async {
    final today = DateTime.now();
    final start = today.subtract(const Duration(days: 7));
    var results = await _db.gamesDao.getGamesInDateRange(start, today);
    
    if (results.isEmpty) {
      await _seedFallbackGames();
      results = await _db.gamesDao.getGamesInDateRange(start, today);
    }
    
    return results;
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
    return seasons.map((s) => PlayerSeasonStats(
      season: s.season,
      ppg: s.ppg,
      rpg: s.rpg,
      apg: s.apg,
      per: s.per,
      tsPct: s.tsPct,
    )).toList();
  }

  // Existing getStandings method
  Future<List<Standing>> getStandings({int season = 2024}) async {
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
      return parsed.map((json) => Standing.fromJson(json as Map<String, dynamic>)).toList();
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

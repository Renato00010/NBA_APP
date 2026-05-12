import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../db/app_database.dart';
import 'nba_api_service.dart';
import 'package:drift/drift.dart';
import '../models/standing.dart';

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
    if (await _hasInternet()) {
      try {
        final data = await _api.getTeams();
        final companions = data.map((t) {
          final id = t['id'].toString();
          _teamNames[id] = t['full_name'] ?? '';
          _teamCities[id] = t['city'] ?? '';
          return NbaTeamsCompanion(
            teamId: Value(id),
            name: Value(t['full_name'] ?? ''),
            city: Value(t['city'] ?? ''),
            conference: Value(t['conference'] ?? ''),
            division: Value(t['division'] ?? ''),
            colorPrimary: Value('#17408B'),
            colorSecondary: Value('#C9082A'),
          );
        }).toList();
        await _db.teamsDao.upsertAllTeams(companions);
      } catch (e) {
        debugPrint('Erro getTeams: $e');
      }
    }
    final teams = await _db.teamsDao.getAllTeams();
    for (final t in teams) {
      _teamNames[t.teamId] = t.name;
      _teamCities[t.teamId] = t.city;
    }
    return teams;
  }

  Future<List<CachedGame>> getGamesByDate(DateTime date) async {
    if (await _hasInternet()) {
      try {
        // Vamos buscar um intervalo para garantir que temos ontem, hoje e amanhã
        // (importante para fusos horários e para ter "resultados" reais)
        final daysToSync = [-1, 0, 1];
        for (final offset in daysToSync) {
          final targetDate = date.add(Duration(days: offset));
          final dateStr = '${targetDate.year}-${targetDate.month.toString().padLeft(2, '0')}-${targetDate.day.toString().padLeft(2, '0')}';
          
          final data = await _api.getGamesByDate(dateStr);
          final companions = data.map((g) => CachedGamesCompanion(
            gameId: Value(g['id'].toString()),
            homeTeamId: Value(g['home_team']['id'].toString()),
            awayTeamId: Value(g['visitor_team']['id'].toString()),
            scoreHome: Value(g['home_team_score'] ?? 0),
            scoreAway: Value(g['visitor_team_score'] ?? 0),
            status: Value(g['status'] ?? ''),
            gameDate: Value(DateTime.parse(g['date'])),
          )).toList();
          
          await _db.gamesDao.upsertAllGames(companions);
        }
      } catch (e) {
        debugPrint('Erro getGamesByDate range: $e');
      }
    }
    // Retorna apenas os jogos do dia solicitado
    return _db.gamesDao.getGamesByDate(date);
  }

  /// Retorna jogos recentes para a aba de resultados
  Future<List<CachedGame>> getRecentResults() async {
    final today = DateTime.now();
    final start = today.subtract(const Duration(days: 7));
    return _db.gamesDao.getGamesInDateRange(start, today);
  }

  Future<List<Player>> getPlayers({String? search}) async {
    debugPrint('getPlayers search=$search');
    final hasNet = await _hasInternet();
    debugPrint('hasInternet=$hasNet');

    // Se houver pesquisa, vai SEMPRE à base de dados local
    if (search != null && search.isNotEmpty) {
      return _db.playersDao.searchPlayers(search);
    }

    // Só vai à API se a DB local estiver vazia
    final localPlayers = await _db.playersDao.getAllPlayers();

    if (hasNet && localPlayers.isEmpty) {
      try {
        final data = await _api.getPlayers();
        debugPrint('Cache: API retornou ${data.length} jogadores');
        final companions = data.map((p) {
          final teamId = p['team']?['id']?.toString() ?? '0';
          return PlayersCompanion(
            playerId: Value(p['id'].toString()),
            teamId: Value(teamId),
            fullName: Value(
              '${p['first_name'] ?? ''} ${p['last_name'] ?? ''}'.trim(),
            ),
            position: Value(p['position'] ?? ''),
          );
        }).toList();
        await _db.playersDao.upsertAllPlayers(companions);
      } catch (e) {
        debugPrint('Erro cache jogadores: $e');
      }
    }
    return _db.playersDao.getAllPlayers();
  }

  Future<List<Standing>> getStandings() async {
    if (await _hasInternet()) {
      try {
        final data = await _api.getStandings();
        return data.map((json) => Standing.fromJson(json)).toList();
      } catch (e) {
        debugPrint('Erro getStandings: $e');
      }
    }
    return []; // Fallback for offline (optional: could add DB caching)
  }
}

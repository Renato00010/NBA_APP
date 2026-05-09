import 'package:connectivity_plus/connectivity_plus.dart';
import '../db/app_database.dart';
import 'nba_api_service.dart';
import 'package:drift/drift.dart';

class NbaRepository {
  final AppDatabase _db;
  final NbaApiService _api;

  Map<String, String> _teamNames = {};
  Map<String, String> _teamCities = {};

  NbaRepository(this._db, this._api);

  Future<bool> _hasInternet() async {
    final results = await Connectivity().checkConnectivity();
    return !results.contains(ConnectivityResult.none);
  }

  String getTeamName(String teamId) => _teamNames[teamId] ?? 'Equipa $teamId';
  String getTeamCity(String teamId) => _teamCities[teamId] ?? '';

  static String getTeamLogoUrl(String teamId) =>
      'https://cdn.nba.com/logos/nba/$teamId/global/L/logo.svg';

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
        print('Erro getTeams: $e');
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
    final dateStr =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    if (await _hasInternet()) {
      try {
        final data = await _api.getGamesByDate(dateStr);
        final companions = data
            .map(
              (g) => CachedGamesCompanion(
                gameId: Value(g['id'].toString()),
                homeTeamId: Value(g['home_team']['id'].toString()),
                awayTeamId: Value(g['visitor_team']['id'].toString()),
                scoreHome: Value(g['home_team_score'] ?? 0),
                scoreAway: Value(g['visitor_team_score'] ?? 0),
                status: Value(g['status'] ?? ''),
                gameDate: Value(DateTime.parse(g['date'])),
              ),
            )
            .toList();
        await _db.gamesDao.upsertAllGames(companions);
      } catch (e) {
        print('Erro getGamesByDate: $e');
      }
    }
    return _db.gamesDao.getAllGames();
  }

  Future<List<Player>> getPlayers({String? search}) async {
    print('getPlayers search=$search');
    final hasNet = await _hasInternet();
    print('hasInternet=$hasNet');

    if (search != null && search.isNotEmpty) {
      if (hasNet) {
        try {
          final data = await _api.getPlayers(search: search);
          print('API retornou ${data.length} jogadores');
          return data
              .map(
                (p) => Player(
                  playerId: p['id'].toString(),
                  teamId: p['team']['id'].toString(),
                  fullName: '${p['first_name'] ?? ''} ${p['last_name'] ?? ''}'
                      .trim(),
                  position: p['position'] ?? '',
                  ppg: 0.0,
                  rpg: 0.0,
                  apg: 0.0,
                  spg: 0.0,
                  bpg: 0.0,
                  photoWebpPath: null,
                  cachedAt: DateTime.now(),
                ),
              )
              .toList();
        } catch (e) {
          print('Erro pesquisa jogadores: $e');
        }
      }
      return [];
    }

    if (hasNet) {
      try {
        final data = await _api.getPlayers();
        print('Cache: API retornou ${data.length} jogadores');
        final companions = data
            .map(
              (p) => PlayersCompanion(
                playerId: Value(p['id'].toString()),
                teamId: Value(p['team']['id'].toString()),
                fullName: Value(
                  '${p['first_name'] ?? ''} ${p['last_name'] ?? ''}'.trim(),
                ),
                position: Value(p['position'] ?? ''),
              ),
            )
            .toList();
        await _db.playersDao.upsertAllPlayers(companions);
      } catch (e) {
        print('Erro cache jogadores: $e');
      }
    }
    return _db.playersDao.getAllPlayers();
  }

  Future<Map<String, dynamic>?> getPlayerStats(int playerId) async {
    if (await _hasInternet()) {
      try {
        final data = await _api.getPlayerStats(playerId);
        if (data.isNotEmpty) return data.first as Map<String, dynamic>;
      } catch (e) {
        print('Erro getPlayerStats: $e');
      }
    }
    return null;
  }
}

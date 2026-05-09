import 'package:connectivity_plus/connectivity_plus.dart';
import '../db/app_database.dart';
import 'nba_api_service.dart';
import 'package:drift/drift.dart';

class NbaRepository {
  final AppDatabase _db;
  final NbaApiService _api;

  // Cache em memória dos nomes das equipas
  Map<String, String> _teamNames = {};
  Map<String, String> _teamCities = {};

  NbaRepository(this._db, this._api);

  Future<bool> _hasInternet() async {
    final results = await Connectivity().checkConnectivity();
    return !results.contains(ConnectivityResult.none);
  }

  // Obter nome da equipa por ID
  String getTeamName(String teamId) {
    return _teamNames[teamId] ?? 'Equipa $teamId';
  }

  // Obter cidade da equipa por ID
  String getTeamCity(String teamId) {
    return _teamCities[teamId] ?? '';
  }

  // Logo da equipa via NBA CDN
  static String getTeamLogoUrl(String teamId) {
    return 'https://cdn.nba.com/logos/nba/$teamId/global/L/logo.svg';
  }

  // Foto do jogador via NBA CDN
  static String getPlayerPhotoUrl(String playerId) {
    return 'https://cdn.nba.com/headshots/nba/latest/1040x760/$playerId.png';
  }

  // EQUIPAS
  Future<List<NbaTeam>> getTeams() async {
    if (await _hasInternet()) {
      try {
        final data = await _api.getTeams();
        final companions = data.map((t) {
          final id = t['id'].toString();
          final name = t['full_name'] ?? '';
          final city = t['city'] ?? '';
          _teamNames[id] = name;
          _teamCities[id] = city;
          return NbaTeamsCompanion(
            teamId: Value(id),
            name: Value(name),
            city: Value(city),
            conference: Value(t['conference'] ?? ''),
            division: Value(t['division'] ?? ''),
            colorPrimary: Value('#17408B'),
            colorSecondary: Value('#C9082A'),
          );
        }).toList();
        await _db.teamsDao.upsertAllTeams(companions);
      } catch (_) {}
    }

    // Carrega cache em memória do SQLite
    final teams = await _db.teamsDao.getAllTeams();
    for (final t in teams) {
      _teamNames[t.teamId] = t.name;
      _teamCities[t.teamId] = t.city;
    }
    return teams;
  }

  // JOGOS
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
      } catch (_) {}
    }
    return _db.gamesDao.getAllGames();
  }

  // JOGADORES
  Future<List<Player>> getPlayers({String? search}) async {
    if (await _hasInternet()) {
      try {
        final data = await _api.getPlayers(search: search);
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
      } catch (_) {}
    }
    return _db.playersDao.getAllPlayers();
  }

  // ESTATÍSTICAS DO JOGADOR
  Future<Map<String, dynamic>?> getPlayerStats(int playerId) async {
    if (await _hasInternet()) {
      try {
        final data = await _api.getPlayerStats(playerId);
        if (data.isNotEmpty) return data.first as Map<String, dynamic>;
      } catch (_) {}
    }
    return null;
  }
}

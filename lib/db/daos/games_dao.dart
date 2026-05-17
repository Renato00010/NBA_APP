import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/cached_games_table.dart';

part 'games_dao.g.dart';

@DriftAccessor(tables: [CachedGames])
class GamesDao extends DatabaseAccessor<AppDatabase> with _$GamesDaoMixin {
  GamesDao(super.db);

  // Buscar todos os jogos
  Future<List<CachedGame>> getAllGames() => select(cachedGames).get();

  // Buscar jogos por data específica
  Future<List<CachedGame>> getGamesByDate(DateTime date) {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    return (select(cachedGames)
          ..where((g) => g.gameDate.isBetweenValues(startOfDay, endOfDay)))
        .get();
  }

  // Buscar jogos num intervalo (ex: últimos 3 dias)
  Future<List<CachedGame>> getGamesInDateRange(DateTime start, DateTime end) {
    return (select(cachedGames)
          ..where((g) => g.gameDate.isBetweenValues(start, end))
          ..orderBy([(g) => OrderingTerm(expression: g.gameDate, mode: OrderingMode.desc)]))
        .get();
  }

  // Stream reativo
  Stream<List<CachedGame>> watchAllGames() => select(cachedGames).watch();

  Future<List<CachedGame>> getGamesForTeamInRange(
    String teamId,
    DateTime start,
    DateTime end,
  ) {
    return (select(cachedGames)
          ..where(
            (g) =>
                (g.homeTeamId.equals(teamId) | g.awayTeamId.equals(teamId)) &
                g.gameDate.isBetweenValues(start, end),
          )
          ..orderBy([
            (g) => OrderingTerm(expression: g.gameDate, mode: OrderingMode.desc),
          ]))
        .get();
  }

  // Buscar jogos por equipa (casa ou fora)
  Stream<List<CachedGame>> watchGamesByTeam(String teamId) =>
      (select(cachedGames)..where(
            (g) => g.homeTeamId.equals(teamId) | g.awayTeamId.equals(teamId),
          ))
          .watch();

  // Buscar jogos ao vivo
  Stream<List<CachedGame>> watchLiveGames() =>
      (select(cachedGames)..where((g) => g.status.equals('live'))).watch();

  // Inserir ou atualizar jogo
  Future<void> upsertGame(CachedGamesCompanion game) =>
      into(cachedGames).insertOnConflictUpdate(game);

  // Inserir vários jogos de uma vez
  Future<void> upsertAllGames(List<CachedGamesCompanion> games) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(cachedGames, games);
    });
  }

  // Apagar jogos antigos (cache expirada)
  Future<void> deleteOldGames(DateTime before) => (delete(
    cachedGames,
  )..where((g) => g.cachedAt.isSmallerThanValue(before))).go();
}

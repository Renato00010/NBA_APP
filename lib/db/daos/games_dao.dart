import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/cached_games_table.dart';

part 'games_dao.g.dart';

@DriftAccessor(tables: [CachedGames])
class GamesDao extends DatabaseAccessor<AppDatabase> with _$GamesDaoMixin {
  GamesDao(super.db);

  // Buscar todos os jogos
  Future<List<CachedGame>> getAllGames() => select(cachedGames).get();

  // Stream reativo
  Stream<List<CachedGame>> watchAllGames() => select(cachedGames).watch();

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

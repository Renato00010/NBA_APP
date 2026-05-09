import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/players_table.dart';

part 'players_dao.g.dart';

@DriftAccessor(tables: [Players])
class PlayersDao extends DatabaseAccessor<AppDatabase> with _$PlayersDaoMixin {
  PlayersDao(super.db);

  // Buscar todos os jogadores
  Future<List<Player>> getAllPlayers() => select(players).get();

  // Stream reativo
  Stream<List<Player>> watchAllPlayers() => select(players).watch();

  // Buscar jogadores por equipa
  Stream<List<Player>> watchPlayersByTeam(String teamId) =>
      (select(players)..where((p) => p.teamId.equals(teamId))).watch();

  // Buscar jogador por ID
  Future<Player?> getPlayerById(String playerId) => (select(
    players,
  )..where((p) => p.playerId.equals(playerId))).getSingleOrNull();

  // Inserir ou atualizar jogador
  Future<void> upsertPlayer(PlayersCompanion player) =>
      into(players).insertOnConflictUpdate(player);

  // Inserir vários jogadores de uma vez
  Future<void> upsertAllPlayers(List<PlayersCompanion> allPlayers) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(players, allPlayers);
    });
  }

  // Apagar jogadores de uma equipa
  Future<void> deletePlayersByTeam(String teamId) =>
      (delete(players)..where((p) => p.teamId.equals(teamId))).go();
}

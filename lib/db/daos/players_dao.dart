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

  // Pesquisar jogadores por nome na BD local (case-insensitive)
  Future<List<Player>> searchPlayers(String query) => (select(
    players,
  )..where((p) => p.fullName.lower().contains(query.toLowerCase()))).get();

  // Stream reativo para pesquisa
  Stream<List<Player>> watchSearchPlayers(String query) => (select(
    players,
  )..where((p) => p.fullName.lower().contains(query.toLowerCase()))).watch();

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

  Future<void> updatePlayerPhotoPath(String playerId, String photoWebpPath) =>
      (update(players)..where((p) => p.playerId.equals(playerId))).write(
        PlayersCompanion(photoWebpPath: Value(photoWebpPath)),
      );

  Future<void> updatePlayerSeedData(
    String playerId, {
    required String teamId,
    required String? position,
    required String? photoWebpPath,
    required String? displayName,
    required String? jerseyNumber,
    required double? heightCm,
    required double? weightKg,
    required DateTime? birthDate,
    required String? country,
    required String? previousTeam,
    required int? experienceYears,
  }) => (update(players)..where((p) => p.playerId.equals(playerId))).write(
    PlayersCompanion(
      teamId: Value(teamId),
      displayName: Value(displayName),
      position: Value(position),
      jerseyNumber: Value(jerseyNumber),
      heightCm: Value(heightCm),
      weightKg: Value(weightKg),
      birthDate: Value(birthDate),
      country: Value(country),
      previousTeam: Value(previousTeam),
      experienceYears: Value(experienceYears),
      photoWebpPath: Value(photoWebpPath),
    ),
  );

  // Apagar jogadores de uma equipa
  Future<void> deletePlayersByTeam(String teamId) =>
      (delete(players)..where((p) => p.teamId.equals(teamId))).go();

  Future<void> deletePlayer(String playerId) =>
      (delete(players)..where((p) => p.playerId.equals(playerId))).go();
}

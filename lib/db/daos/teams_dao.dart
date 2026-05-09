import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/nba_teams_table.dart';

part 'teams_dao.g.dart';

@DriftAccessor(tables: [NbaTeams])
class TeamsDao extends DatabaseAccessor<AppDatabase> with _$TeamsDaoMixin {
  TeamsDao(super.db);

  // Buscar todas as equipas
  Future<List<NbaTeam>> getAllTeams() => select(nbaTeams).get();

  // Stream reativo — atualiza UI automaticamente
  Stream<List<NbaTeam>> watchAllTeams() => select(nbaTeams).watch();

  // Buscar equipa por ID
  Future<NbaTeam?> getTeamById(String teamId) => (select(
    nbaTeams,
  )..where((t) => t.teamId.equals(teamId))).getSingleOrNull();

  // Inserir ou atualizar equipa
  Future<void> upsertTeam(NbaTeamsCompanion team) =>
      into(nbaTeams).insertOnConflictUpdate(team);

  // Inserir várias equipas de uma vez
  Future<void> upsertAllTeams(List<NbaTeamsCompanion> teams) async {
    await batch((batch) {
      batch.insertAllOnConflictUpdate(nbaTeams, teams);
    });
  }

  // Apagar todas as equipas
  Future<void> deleteAllTeams() => delete(nbaTeams).go();
}

import 'package:drift/drift.dart';
import 'nba_teams_table.dart';

class Players extends Table {
  TextColumn get playerId => text()();
  TextColumn get teamId => text().references(NbaTeams, #teamId)();
  TextColumn get fullName => text()();
  TextColumn get displayName => text().nullable()();
  TextColumn get position => text().nullable()();
  TextColumn get jerseyNumber => text().nullable()();
  RealColumn get heightCm => real().nullable()();
  RealColumn get weightKg => real().nullable()();
  DateTimeColumn get birthDate => dateTime().nullable()();
  TextColumn get country => text().nullable()();
  TextColumn get previousTeam => text().nullable()();
  IntColumn get experienceYears => integer().nullable()();
  RealColumn get ppg => real().withDefault(const Constant(0.0))();
  RealColumn get rpg => real().withDefault(const Constant(0.0))();
  RealColumn get apg => real().withDefault(const Constant(0.0))();
  RealColumn get spg => real().withDefault(const Constant(0.0))();
  RealColumn get bpg => real().withDefault(const Constant(0.0))();
  TextColumn get photoWebpPath => text().nullable()();
  DateTimeColumn get cachedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {playerId};
}

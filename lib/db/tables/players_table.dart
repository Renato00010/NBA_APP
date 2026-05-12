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
  RealColumn get mpg => real().withDefault(const Constant(0.0))();
  RealColumn get topg => real().withDefault(const Constant(0.0))();
  RealColumn get fgPct => real().withDefault(const Constant(0.0))();
  RealColumn get fg3Pct => real().withDefault(const Constant(0.0))();
  RealColumn get ftPct => real().withDefault(const Constant(0.0))();
  TextColumn get photoWebpPath => text().nullable()();
  IntColumn get careerPoints => integer().withDefault(const Constant(0))();
  IntColumn get careerRebounds => integer().withDefault(const Constant(0))();
  IntColumn get careerAssists => integer().withDefault(const Constant(0))();
  IntColumn get careerSteals => integer().withDefault(const Constant(0))();
  IntColumn get careerBlocks => integer().withDefault(const Constant(0))();
  IntColumn get careerGames => integer().withDefault(const Constant(0))();
  IntColumn get careerStarts => integer().withDefault(const Constant(0))();
  IntColumn get careerTurnovers => integer().withDefault(const Constant(0))();
  TextColumn get careerTeams => text().nullable()();
  DateTimeColumn get cachedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {playerId};
}

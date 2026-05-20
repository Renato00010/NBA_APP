import 'package:drift/drift.dart';

class RetiredPlayers extends Table {
  TextColumn get playerId => text()();
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
  TextColumn get careerTeams => text().nullable()(); // Comma-separated list of team IDs
  TextColumn get photoWebpPath => text().nullable()();

  @override
  Set<Column> get primaryKey => {playerId};
}

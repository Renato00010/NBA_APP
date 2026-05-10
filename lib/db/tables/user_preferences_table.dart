import 'package:drift/drift.dart';
import 'nba_teams_table.dart';

class UserPreferences extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get email => text().nullable().unique()();
  TextColumn get passwordHash => text().nullable()();
  TextColumn get displayName => text().nullable()();
  TextColumn get favoriteTeamId =>
      text().nullable().references(NbaTeams, #teamId)();
  BoolColumn get isLoggedIn => boolean().withDefault(const Constant(false))();
  TextColumn get themeMode => text().withDefault(const Constant('system'))();
  BoolColumn get notificationsOn =>
      boolean().withDefault(const Constant(true))();
  TextColumn get language => text().withDefault(const Constant('pt'))();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}

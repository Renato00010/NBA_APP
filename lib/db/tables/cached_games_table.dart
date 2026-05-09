import 'package:drift/drift.dart';
import 'nba_teams_table.dart';

class CachedGames extends Table {
  TextColumn get gameId => text()();
  TextColumn get homeTeamId => text().references(NbaTeams, #teamId)();
  TextColumn get awayTeamId => text().references(NbaTeams, #teamId)();
  IntColumn get scoreHome => integer().withDefault(const Constant(0))();
  IntColumn get scoreAway => integer().withDefault(const Constant(0))();
  TextColumn get status => text()();
  DateTimeColumn get gameDate => dateTime()();
  DateTimeColumn get cachedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {gameId};
}

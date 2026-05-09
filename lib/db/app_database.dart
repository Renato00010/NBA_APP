import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables/nba_teams_table.dart';
import 'tables/players_table.dart';
import 'tables/cached_games_table.dart';
import 'tables/user_preferences_table.dart';
import 'tables/viewed_history_table.dart';
import 'daos/teams_dao.dart';
import 'daos/players_dao.dart';
import 'daos/games_dao.dart';
import 'daos/preferences_dao.dart';
import 'daos/history_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [NbaTeams, Players, CachedGames, UserPreferences, ViewedHistory],
  daos: [TeamsDao, PlayersDao, GamesDao, PreferencesDao, HistoryDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'nba_app.db'));
    return NativeDatabase.createInBackground(file);
  });
}

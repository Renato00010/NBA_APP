import 'package:drift/drift.dart';

import 'tables/nba_teams_table.dart';
import 'tables/players_table.dart';
import 'tables/cached_games_table.dart';
import 'tables/user_preferences_table.dart';
import 'tables/viewed_history_table.dart';
import 'tables/player_seasons_table.dart';

import 'daos/teams_dao.dart';
import 'daos/players_dao.dart';
import 'daos/games_dao.dart';
import 'daos/preferences_dao.dart';
import 'daos/history_dao.dart';
import 'database_connection/connection.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [NbaTeams, Players, CachedGames, UserPreferences, ViewedHistory, PlayerSeasons],
  daos: [TeamsDao, PlayersDao, GamesDao, PreferencesDao, HistoryDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 8;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) => m.createAll(),
    onUpgrade: (m, from, to) async {
      if (from < 2) {
        await m.addColumn(userPreferences, userPreferences.email);
        await m.addColumn(userPreferences, userPreferences.passwordHash);
        await m.addColumn(userPreferences, userPreferences.displayName);
      }
      if (from < 3) {
        await m.addColumn(userPreferences, userPreferences.isLoggedIn);
      }
      if (from < 4) {
        await m.addColumn(userPreferences, userPreferences.measurementUnit);
        await m.addColumn(userPreferences, userPreferences.currencyCode);
        await m.addColumn(userPreferences, userPreferences.favoriteTeamAlerts);
      }
      if (from < 5) {
        await m.addColumn(players, players.displayName);
        await m.addColumn(players, players.jerseyNumber);
        await m.addColumn(players, players.heightCm);
        await m.addColumn(players, players.weightKg);
        await m.addColumn(players, players.birthDate);
        await m.addColumn(players, players.country);
        await m.addColumn(players, players.previousTeam);
        await m.addColumn(players, players.experienceYears);
      }
      if (from < 6) {
        await m.addColumn(players, players.mpg);
        await m.addColumn(players, players.topg);
        await m.addColumn(players, players.fgPct);
        await m.addColumn(players, players.fg3Pct);
        await m.addColumn(players, players.ftPct);
      }
      if (from < 7) {
        await m.addColumn(players, players.careerPoints);
        await m.addColumn(players, players.careerRebounds);
        await m.addColumn(players, players.careerAssists);
        await m.addColumn(players, players.careerSteals);
        await m.addColumn(players, players.careerBlocks);
        await m.addColumn(players, players.careerGames);
        await m.addColumn(players, players.careerStarts);
        await m.addColumn(players, players.careerTurnovers);
        await m.addColumn(players, players.careerTeams);
      }
      if (from < 8) {
        await m.createTable(playerSeasons);
      }

    },
  );
}

QueryExecutor _openConnection() => connect();

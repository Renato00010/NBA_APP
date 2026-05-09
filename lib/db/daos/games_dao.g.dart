// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'games_dao.dart';

// ignore_for_file: type=lint
mixin _$GamesDaoMixin on DatabaseAccessor<AppDatabase> {
  $NbaTeamsTable get nbaTeams => attachedDatabase.nbaTeams;
  $CachedGamesTable get cachedGames => attachedDatabase.cachedGames;
  GamesDaoManager get managers => GamesDaoManager(this);
}

class GamesDaoManager {
  final _$GamesDaoMixin _db;
  GamesDaoManager(this._db);
  $$NbaTeamsTableTableManager get nbaTeams =>
      $$NbaTeamsTableTableManager(_db.attachedDatabase, _db.nbaTeams);
  $$CachedGamesTableTableManager get cachedGames =>
      $$CachedGamesTableTableManager(_db.attachedDatabase, _db.cachedGames);
}

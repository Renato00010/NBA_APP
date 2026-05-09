// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'players_dao.dart';

// ignore_for_file: type=lint
mixin _$PlayersDaoMixin on DatabaseAccessor<AppDatabase> {
  $NbaTeamsTable get nbaTeams => attachedDatabase.nbaTeams;
  $PlayersTable get players => attachedDatabase.players;
  PlayersDaoManager get managers => PlayersDaoManager(this);
}

class PlayersDaoManager {
  final _$PlayersDaoMixin _db;
  PlayersDaoManager(this._db);
  $$NbaTeamsTableTableManager get nbaTeams =>
      $$NbaTeamsTableTableManager(_db.attachedDatabase, _db.nbaTeams);
  $$PlayersTableTableManager get players =>
      $$PlayersTableTableManager(_db.attachedDatabase, _db.players);
}

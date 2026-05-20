// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'players_dao.dart';

// ignore_for_file: type=lint
mixin _$PlayersDaoMixin on DatabaseAccessor<AppDatabase> {
  $NbaTeamsTable get nbaTeams => attachedDatabase.nbaTeams;
  $PlayersTable get players => attachedDatabase.players;
  $PlayerSeasonsTable get playerSeasons => attachedDatabase.playerSeasons;
  $RetiredPlayersTable get retiredPlayers => attachedDatabase.retiredPlayers;
  PlayersDaoManager get managers => PlayersDaoManager(this);
}

class PlayersDaoManager {
  final _$PlayersDaoMixin _db;
  PlayersDaoManager(this._db);
  $$NbaTeamsTableTableManager get nbaTeams =>
      $$NbaTeamsTableTableManager(_db.attachedDatabase, _db.nbaTeams);
  $$PlayersTableTableManager get players =>
      $$PlayersTableTableManager(_db.attachedDatabase, _db.players);
  $$PlayerSeasonsTableTableManager get playerSeasons =>
      $$PlayerSeasonsTableTableManager(_db.attachedDatabase, _db.playerSeasons);
  $$RetiredPlayersTableTableManager get retiredPlayers =>
      $$RetiredPlayersTableTableManager(
        _db.attachedDatabase,
        _db.retiredPlayers,
      );
}

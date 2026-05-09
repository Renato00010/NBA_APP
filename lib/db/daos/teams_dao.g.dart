// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teams_dao.dart';

// ignore_for_file: type=lint
mixin _$TeamsDaoMixin on DatabaseAccessor<AppDatabase> {
  $NbaTeamsTable get nbaTeams => attachedDatabase.nbaTeams;
  TeamsDaoManager get managers => TeamsDaoManager(this);
}

class TeamsDaoManager {
  final _$TeamsDaoMixin _db;
  TeamsDaoManager(this._db);
  $$NbaTeamsTableTableManager get nbaTeams =>
      $$NbaTeamsTableTableManager(_db.attachedDatabase, _db.nbaTeams);
}

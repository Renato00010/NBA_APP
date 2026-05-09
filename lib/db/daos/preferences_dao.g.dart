// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences_dao.dart';

// ignore_for_file: type=lint
mixin _$PreferencesDaoMixin on DatabaseAccessor<AppDatabase> {
  $NbaTeamsTable get nbaTeams => attachedDatabase.nbaTeams;
  $UserPreferencesTable get userPreferences => attachedDatabase.userPreferences;
  PreferencesDaoManager get managers => PreferencesDaoManager(this);
}

class PreferencesDaoManager {
  final _$PreferencesDaoMixin _db;
  PreferencesDaoManager(this._db);
  $$NbaTeamsTableTableManager get nbaTeams =>
      $$NbaTeamsTableTableManager(_db.attachedDatabase, _db.nbaTeams);
  $$UserPreferencesTableTableManager get userPreferences =>
      $$UserPreferencesTableTableManager(
        _db.attachedDatabase,
        _db.userPreferences,
      );
}

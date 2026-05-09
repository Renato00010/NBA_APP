import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/user_preferences_table.dart';

part 'preferences_dao.g.dart';

@DriftAccessor(tables: [UserPreferences])
class PreferencesDao extends DatabaseAccessor<AppDatabase>
    with _$PreferencesDaoMixin {
  PreferencesDao(super.db);

  Future<UserPreference?> getPreferences() =>
      select(userPreferences).getSingleOrNull();

  Stream<UserPreference?> watchPreferences() =>
      select(userPreferences).watchSingleOrNull();

  Future<void> upsertPreferences(UserPreferencesCompanion prefs) =>
      into(userPreferences).insertOnConflictUpdate(prefs);

  UserPreferencesCompanion buildCompanion({String? email}) {
    return UserPreferencesCompanion(
      email: Value(email),
      updatedAt: Value(DateTime.now()),
    );
  }

  Future<void> updateFavoriteTeam(String teamId) async {
    final prefs = await getPreferences();
    if (prefs == null) {
      await upsertPreferences(
        UserPreferencesCompanion(
          favoriteTeamId: Value(teamId),
          updatedAt: Value(DateTime.now()),
        ),
      );
    } else {
      await (update(
        userPreferences,
      )..where((p) => p.id.equals(prefs.id))).write(
        UserPreferencesCompanion(
          favoriteTeamId: Value(teamId),
          updatedAt: Value(DateTime.now()),
        ),
      );
    }
  }

  Future<void> updateEmail(String email) async {
    final prefs = await getPreferences();
    if (prefs == null) {
      await upsertPreferences(
        UserPreferencesCompanion(
          email: Value(email),
          updatedAt: Value(DateTime.now()),
        ),
      );
    } else {
      await (update(
        userPreferences,
      )..where((p) => p.id.equals(prefs.id))).write(
        UserPreferencesCompanion(
          email: Value(email),
          updatedAt: Value(DateTime.now()),
        ),
      );
    }
  }

  Future<UserPreference?> getUserByEmail(String email) => (select(
    userPreferences,
  )..where((p) => p.email.equals(email))).getSingleOrNull();
}

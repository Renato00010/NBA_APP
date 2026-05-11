import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/user_preferences_table.dart';

part 'preferences_dao.g.dart';

@DriftAccessor(tables: [UserPreferences])
class PreferencesDao extends DatabaseAccessor<AppDatabase>
    with _$PreferencesDaoMixin {
  PreferencesDao(super.db);

  Future<UserPreference?> getPreferences() =>
      (select(userPreferences)
            ..where((p) => p.isLoggedIn.equals(true))
            ..limit(1))
          .getSingleOrNull();

  Stream<UserPreference?> watchPreferences() =>
      (select(userPreferences)
            ..where((p) => p.isLoggedIn.equals(true))
            ..limit(1))
          .watchSingleOrNull();

  Future<UserPreference?> getUserByEmail(String email) async {
    final results = await (select(
      userPreferences,
    )..where((p) => p.email.equals(email))).get();
    return results.isEmpty ? null : results.first;
  }

  Future<void> registerUser(String email, String passwordHash) async {
    final existing = await getUserByEmail(email);
    if (existing != null) {
      throw Exception('Email ja registado');
    }

    await into(userPreferences).insert(
      UserPreferencesCompanion(
        email: Value(email),
        passwordHash: Value(passwordHash),
        isLoggedIn: const Value(false),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> setLoggedIn(String email) async {
    final user = await getUserByEmail(email);
    if (user == null) {
      throw Exception('Email nao registado');
    }

    await update(userPreferences).write(
      UserPreferencesCompanion(
        isLoggedIn: const Value(false),
        updatedAt: Value(DateTime.now()),
      ),
    );

    await (update(userPreferences)..where((p) => p.id.equals(user.id))).write(
      UserPreferencesCompanion(
        isLoggedIn: const Value(true),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> setLoggedOut() async {
    final prefs = await getPreferences();
    if (prefs != null) {
      await (update(
        userPreferences,
      )..where((p) => p.id.equals(prefs.id))).write(
        UserPreferencesCompanion(
          isLoggedIn: const Value(false),
          updatedAt: Value(DateTime.now()),
        ),
      );
    }
  }

  Future<void> updateFavoriteTeam(String teamId) async {
    final prefs = await getPreferences();
    if (prefs == null) return;

    await (update(userPreferences)..where((p) => p.id.equals(prefs.id))).write(
      UserPreferencesCompanion(
        favoriteTeamId: Value(teamId),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> updateMeasurementUnit(String measurementUnit) async {
    final prefs = await getPreferences();
    if (prefs == null) return;

    await (update(userPreferences)..where((p) => p.id.equals(prefs.id))).write(
      UserPreferencesCompanion(
        measurementUnit: Value(measurementUnit),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> updateCurrencyCode(String currencyCode) async {
    final prefs = await getPreferences();
    if (prefs == null) return;

    await (update(userPreferences)..where((p) => p.id.equals(prefs.id))).write(
      UserPreferencesCompanion(
        currencyCode: Value(currencyCode),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> updateFavoriteTeamAlerts(bool enabled) async {
    final prefs = await getPreferences();
    if (prefs == null) return;

    await (update(userPreferences)..where((p) => p.id.equals(prefs.id))).write(
      UserPreferencesCompanion(
        favoriteTeamAlerts: Value(enabled),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> updateNotifications(bool enabled) async {
    final prefs = await getPreferences();
    if (prefs == null) return;

    await (update(userPreferences)..where((p) => p.id.equals(prefs.id))).write(
      UserPreferencesCompanion(
        notificationsOn: Value(enabled),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  UserPreferencesCompanion buildCompanion({String? email}) {
    return UserPreferencesCompanion(
      email: Value(email),
      updatedAt: Value(DateTime.now()),
    );
  }
}

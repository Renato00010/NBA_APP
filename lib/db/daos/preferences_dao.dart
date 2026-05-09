import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/user_preferences_table.dart';

part 'preferences_dao.g.dart';

@DriftAccessor(tables: [UserPreferences])
class PreferencesDao extends DatabaseAccessor<AppDatabase>
    with _$PreferencesDaoMixin {
  PreferencesDao(super.db);

  // Buscar preferências do utilizador
  Future<UserPreference?> getPreferences() =>
      select(userPreferences).getSingleOrNull();

  // Stream reativo — atualiza UI quando preferências mudam
  Stream<UserPreference?> watchPreferences() =>
      select(userPreferences).watchSingleOrNull();

  // Guardar preferências (cria ou atualiza)
  Future<void> upsertPreferences(UserPreferencesCompanion prefs) =>
      into(userPreferences).insertOnConflictUpdate(prefs);

  // Atualizar equipa favorita
  Future<void> updateFavoriteTeam(String teamId) async {
    final prefs = await getPreferences();
    if (prefs == null) {
      await upsertPreferences(
        UserPreferencesCompanion(favoriteTeamId: Value(teamId)),
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

  // Atualizar tema
  Future<void> updateThemeMode(String mode) async {
    final prefs = await getPreferences();
    if (prefs == null) {
      await upsertPreferences(UserPreferencesCompanion(themeMode: Value(mode)));
    } else {
      await (update(
        userPreferences,
      )..where((p) => p.id.equals(prefs.id))).write(
        UserPreferencesCompanion(
          themeMode: Value(mode),
          updatedAt: Value(DateTime.now()),
        ),
      );
    }
  }
}

import 'package:drift/drift.dart';

class NbaTeams extends Table {
  TextColumn get teamId => text()();
  TextColumn get name => text()();
  TextColumn get city => text()();
  TextColumn get conference => text()();
  TextColumn get division => text()();
  TextColumn get colorPrimary => text()();
  TextColumn get colorSecondary => text()();
  TextColumn get logoWebpPath => text().nullable()();

  @override
  Set<Column> get primaryKey => {teamId};
}

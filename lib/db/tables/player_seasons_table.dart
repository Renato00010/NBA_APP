import 'package:drift/drift.dart';
import 'players_table.dart';

class PlayerSeasons extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get playerId => text().references(Players, #playerId)();
  TextColumn get season => text()();
  TextColumn get team => text()();
  IntColumn get gp => integer().withDefault(const Constant(0))();
  IntColumn get gs => integer().withDefault(const Constant(0))();
  RealColumn get mpg => real().withDefault(const Constant(0.0))();
  RealColumn get ppg => real().withDefault(const Constant(0.0))();
  RealColumn get rpg => real().withDefault(const Constant(0.0))();
  RealColumn get apg => real().withDefault(const Constant(0.0))();
  RealColumn get spg => real().withDefault(const Constant(0.0))();
  RealColumn get bpg => real().withDefault(const Constant(0.0))();
  RealColumn get topg => real().withDefault(const Constant(0.0))();
  RealColumn get fgPct => real().withDefault(const Constant(0.0))();
  RealColumn get fg3Pct => real().withDefault(const Constant(0.0))();
  RealColumn get ftPct => real().withDefault(const Constant(0.0))();
  RealColumn get per => real().withDefault(const Constant(0.0))();
  RealColumn get tsPct => real().withDefault(const Constant(0.0))();
  RealColumn get usgPct => real().withDefault(const Constant(0.0))();
  
  // Cache timestamp
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

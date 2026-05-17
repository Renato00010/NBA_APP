import 'package:drift/drift.dart';

class CartItems extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get productId => text()();
  TextColumn get name => text()();
  TextColumn get category => text()();
  RealColumn get price => real()();
  TextColumn get image => text()();
  BoolColumn get isNew =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get addedAt =>
      dateTime().withDefault(currentDateAndTime)();
}

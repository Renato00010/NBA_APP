import 'package:drift/drift.dart';

class StoreOrders extends Table {
  TextColumn get id => text()();
  TextColumn get itemsJson => text()();
  RealColumn get totalEur => real()();
  TextColumn get currencyCode => text()();
  TextColumn get deliveryAddress => text()();
  TextColumn get paymentMethod => text()();
  TextColumn get status => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

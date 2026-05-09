import 'package:drift/drift.dart';

class ViewedHistory extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get contentType => text()();
  TextColumn get contentId => text()();
  DateTimeColumn get viewedAt => dateTime().withDefault(currentDateAndTime)();
}

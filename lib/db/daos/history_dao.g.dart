// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_dao.dart';

// ignore_for_file: type=lint
mixin _$HistoryDaoMixin on DatabaseAccessor<AppDatabase> {
  $ViewedHistoryTable get viewedHistory => attachedDatabase.viewedHistory;
  HistoryDaoManager get managers => HistoryDaoManager(this);
}

class HistoryDaoManager {
  final _$HistoryDaoMixin _db;
  HistoryDaoManager(this._db);
  $$ViewedHistoryTableTableManager get viewedHistory =>
      $$ViewedHistoryTableTableManager(_db.attachedDatabase, _db.viewedHistory);
}

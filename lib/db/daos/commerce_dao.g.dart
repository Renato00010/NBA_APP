// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'commerce_dao.dart';

// ignore_for_file: type=lint
mixin _$CommerceDaoMixin on DatabaseAccessor<AppDatabase> {
  $CartItemsTable get cartItems => attachedDatabase.cartItems;
  $StoreOrdersTable get storeOrders => attachedDatabase.storeOrders;
  CommerceDaoManager get managers => CommerceDaoManager(this);
}

class CommerceDaoManager {
  final _$CommerceDaoMixin _db;
  CommerceDaoManager(this._db);
  $$CartItemsTableTableManager get cartItems =>
      $$CartItemsTableTableManager(_db.attachedDatabase, _db.cartItems);
  $$StoreOrdersTableTableManager get storeOrders =>
      $$StoreOrdersTableTableManager(_db.attachedDatabase, _db.storeOrders);
}

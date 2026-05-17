import 'dart:convert';

import 'package:drift/drift.dart';
import '../app_database.dart';
import '../tables/cart_items_table.dart';
import '../tables/store_orders_table.dart';
import '../../services/cart_service.dart';

part 'commerce_dao.g.dart';

@DriftAccessor(tables: [CartItems, StoreOrders])
class CommerceDao extends DatabaseAccessor<AppDatabase>
    with _$CommerceDaoMixin {
  CommerceDao(super.db);

  Future<List<CartItem>> getAllCartItems() => select(cartItems).get();

  Future<void> replaceCartItems(List<Map<String, dynamic>> items) async {
    await delete(cartItems).go();
    if (items.isEmpty) return;
    await batch((batch) {
      batch.insertAll(
        cartItems,
        items.map(
          (p) => CartItemsCompanion.insert(
            productId: p['id'] as String,
            name: p['name'] as String,
            category: p['category'] as String,
            price: p['price'] as double,
            image: p['image'] as String,
            isNew: Value(p['isNew'] as bool? ?? false),
          ),
        ),
      );
    });
  }

  Future<List<OrderRecord>> getAllOrders() async {
    final rows = await (select(storeOrders)
          ..orderBy([(o) => OrderingTerm.desc(o.createdAt)]))
        .get();
    return rows.map(_orderFromRow).toList();
  }

  Future<void> insertOrder(OrderRecord order) async {
    await into(storeOrders).insert(
      StoreOrdersCompanion.insert(
        id: order.id,
        itemsJson: jsonEncode(order.items),
        totalEur: order.totalEur,
        currencyCode: order.currencyCode,
        deliveryAddress: order.deliveryAddress,
        paymentMethod: order.paymentMethod,
        status: order.status,
        createdAt: order.createdAt,
      ),
      mode: InsertMode.insertOrReplace,
    );
  }

  OrderRecord _orderFromRow(StoreOrder row) {
    final decoded = jsonDecode(row.itemsJson) as List<dynamic>;
    return OrderRecord(
      id: row.id,
      items: decoded
          .map((e) => Map<String, dynamic>.from(e as Map))
          .toList(),
      totalEur: row.totalEur,
      currencyCode: row.currencyCode,
      deliveryAddress: row.deliveryAddress,
      paymentMethod: row.paymentMethod,
      status: row.status,
      createdAt: row.createdAt,
    );
  }
}

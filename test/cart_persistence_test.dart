import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nba_app/db/app_database.dart';
import 'package:nba_app/services/cart_service.dart';

void main() {
  late AppDatabase db;

  setUp(() async {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    await CartService.instance.init(db);
    await CartService.instance.clear();
  });

  tearDown(() async {
    await db.close();
  });

  test('cart items persist across service reload', () async {
    await CartService.instance.addItem({
      'id': '1',
      'name': 'Test Jersey',
      'category': 'Jerseys',
      'price': 99.99,
      'image': 'assets/store/lakers_jersey.webp',
      'isNew': false,
    });

    await CartService.instance.init(db);
    expect(CartService.instance.items.length, 1);
    expect(CartService.instance.items.first['name'], 'Test Jersey');
  });

  test('orders persist in database', () async {
    final order = OrderRecord(
      id: 'ORD-TEST-1',
      items: [
        {
          'id': '1',
          'name': 'Ball',
          'price': 50.0,
        },
      ],
      totalEur: 50,
      currencyCode: 'EUR',
      deliveryAddress: 'Test',
      paymentMethod: 'Card',
      status: 'Processing',
      createdAt: DateTime(2026, 5, 16),
    );

    await CartService.instance.addOrder(order);
    await CartService.instance.init(db);

    expect(CartService.instance.orders.length, 1);
    expect(CartService.instance.orders.first.id, 'ORD-TEST-1');
  });
}

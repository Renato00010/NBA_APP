import 'package:flutter/foundation.dart';

import '../db/app_database.dart';

class OrderRecord {
  final String id;
  final List<Map<String, dynamic>> items;
  final double totalEur;
  final String currencyCode;
  final String deliveryAddress;
  final String paymentMethod;
  final String status;
  final DateTime createdAt;

  const OrderRecord({
    required this.id,
    required this.items,
    required this.totalEur,
    required this.currencyCode,
    required this.deliveryAddress,
    required this.paymentMethod,
    required this.status,
    required this.createdAt,
  });
}

class CartService extends ChangeNotifier {
  static final CartService _instance = CartService._internal();
  static CartService get instance => _instance;

  factory CartService() => _instance;

  CartService._internal();

  AppDatabase? _db;
  final List<Map<String, dynamic>> _items = [];
  final List<OrderRecord> _orders = [];

  List<Map<String, dynamic>> get items => List.unmodifiable(_items);
  List<OrderRecord> get orders => List.unmodifiable(_orders);

  Future<void> init(AppDatabase db) async {
    _db = db;
    await _loadFromDb();
  }

  Future<void> _loadFromDb() async {
    final dao = _db?.commerceDao;
    if (dao == null) return;

    final rows = await dao.getAllCartItems();
    _items
      ..clear()
      ..addAll(
        rows.map(
          (r) => {
            'id': r.productId,
            'name': r.name,
            'category': r.category,
            'price': r.price,
            'image': r.image,
            'isNew': r.isNew,
          },
        ),
      );

    _orders
      ..clear()
      ..addAll(await dao.getAllOrders());
    notifyListeners();
  }

  Future<void> _persistCart() async {
    await _db?.commerceDao.replaceCartItems(_items);
  }

  Future<void> addItem(Map<String, dynamic> product) async {
    _items.add(product);
    notifyListeners();
    await _persistCart();
  }

  Future<void> removeItem(int index) async {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
      await _persistCart();
    }
  }

  Future<void> clear() async {
    _items.clear();
    notifyListeners();
    await _persistCart();
  }

  Future<void> addOrder(OrderRecord order) async {
    _orders.insert(0, order);
    await _db?.commerceDao.insertOrder(order);
    notifyListeners();
  }

  double get total =>
      _items.fold(0.0, (sum, p) => sum + (p['price'] as double));
}

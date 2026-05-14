// lib/services/cart_service.dart
import 'package:flutter/foundation.dart';

class CartService extends ChangeNotifier {
  // Singleton instance
  static final CartService _instance = CartService._internal();
  static CartService get instance => _instance;

  // Factory returns the singleton
  factory CartService() => _instance;

  // Private constructor
  CartService._internal();

  // Internal list of cart items
  final List<Map<String, dynamic>> _items = [];

  // Read‑only view of items
  List<Map<String, dynamic>> get items => List.unmodifiable(_items);

  // Add a product to the cart
  void addItem(Map<String, dynamic> product) {
    _items.add(product);
    notifyListeners();
  }

  // Remove a product by index
  void removeItem(int index) {
    if (index >= 0 && index < _items.length) {
      _items.removeAt(index);
      notifyListeners();
    }
  }

  // Clear all items
  void clear() {
    _items.clear();
    notifyListeners();
  }

  // Total price of the cart
  double get total => _items.fold(0.0, (sum, p) => sum + (p['price'] as double));
}

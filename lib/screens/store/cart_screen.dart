// lib/screens/store/cart_screen.dart
import 'package:flutter/material.dart';
import '../../services/cart_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartService _cart = CartService.instance;

  @override
  void initState() {
    super.initState();
    _cart.addListener(_onCartChanged);
  }

  @override
  void dispose() {
    _cart.removeListener(_onCartChanged);
    super.dispose();
  }

  void _onCartChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final items = _cart.items;
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        title: const Text(
          'Carrinho',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w900),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_forever, color: Colors.white),
            onPressed: () {
              _cart.clear();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Carrinho esvaziado')));
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: items.isEmpty
          ? const Center(
              child: Text('O carrinho está vazio.', style: TextStyle(color: Colors.white70, fontSize: 16)),
            )
          : ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, __) => const Divider(color: Colors.white10, height: 1),
              itemBuilder: (context, index) {
                final product = items[index];
                return ListTile(
                  leading: product['image'].startsWith('http')
                      ? CachedNetworkImage(
                          imageUrl: product['image'],
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                          placeholder: (_, __) => Container(color: Colors.grey[900]),
                          errorWidget: (_, __, ___) => const Icon(Icons.image_not_supported, color: Colors.white24),
                        )
                      : Image.asset(
                          product['image'],
                          width: 48,
                          height: 48,
                          fit: BoxFit.cover,
                        ),
                  title: Text(product['name'], style: const TextStyle(color: Colors.white)),
                  subtitle: Text('€${product['price']}', style: const TextStyle(color: Colors.white70)),
                  trailing: IconButton(
                    icon: const Icon(Icons.remove_circle_outline, color: Colors.white70),
                    onPressed: () => _cart.removeItem(index),
                  ),
                );
              },
            ),
      bottomNavigationBar: items.isEmpty
          ? null
          : Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: const Color(0xFF151515),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total: €${_cart.total.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const CheckoutScreen()),
                      );
                    },
                    child: const Text('Finalizar'),
                  ),
                ],
              ),
            ),
    );
  }
}

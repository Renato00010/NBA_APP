import 'package:flutter/material.dart';
import '../../db/app_database.dart';
import '../../main.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  static const List<_StoreProduct> _products = [
    _StoreProduct('Camisola Lakers', 'Los Angeles Lakers', 89.99),
    _StoreProduct('Camisola Celtics', 'Boston Celtics', 89.99),
    _StoreProduct('Hoodie Warriors', 'Golden State Warriors', 74.99),
    _StoreProduct('Boné Bulls', 'Chicago Bulls', 29.99),
    _StoreProduct('T-shirt Heat', 'Miami Heat', 34.99),
    _StoreProduct('Bola NBA', 'NBA', 44.99),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        title: const Text(
          'Loja',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: StreamBuilder<UserPreference?>(
        stream: database.preferencesDao.watchPreferences(),
        builder: (context, snapshot) {
          final currencyCode = snapshot.data?.currencyCode ?? 'EUR';
          return Column(
            children: [
              SizedBox(
                height: 50,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  children:
                      [
                        'Todos',
                        'Lakers',
                        'Celtics',
                        'Warriors',
                        'Bulls',
                        'Heat',
                      ].map((team) {
                        final isSelected = team == 'Todos';
                        return Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? theme.colorScheme.primary
                                : const Color(0xFF1A1A1A),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              team,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.white54,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.75,
                  ),
                  itemCount: _products.length,
                  itemBuilder: (context, index) {
                    final product = _products[index];
                    return Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A1A),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary.withValues(
                                  alpha: 0.2,
                                ),
                                borderRadius: const BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                              ),
                              child: const Center(
                                child: Icon(
                                  Icons.checkroom_outlined,
                                  color: Colors.white54,
                                  size: 48,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  product.team,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white38,
                                    fontSize: 11,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  _formatPrice(product.eurPrice, currencyCode),
                                  style: TextStyle(
                                    color: theme.colorScheme.tertiary,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _formatPrice(double eurPrice, String currencyCode) {
    final convertedPrice = eurPrice * _currencyRate(currencyCode);
    final symbol = switch (currencyCode) {
      'USD' => r'$',
      'GBP' => '£',
      'BRL' => r'R$',
      _ => '€',
    };
    return '$symbol${convertedPrice.toStringAsFixed(2)}';
  }

  double _currencyRate(String currencyCode) {
    return switch (currencyCode) {
      'USD' => 1.08,
      'GBP' => 0.86,
      'BRL' => 5.75,
      _ => 1.0,
    };
  }
}

class _StoreProduct {
  final String name;
  final String team;
  final double eurPrice;

  const _StoreProduct(this.name, this.team, this.eurPrice);
}

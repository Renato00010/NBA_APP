import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../services/cart_service.dart';
import 'cart_screen.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  final List<Map<String, dynamic>> _products = [
    {
      'id': '1',
      'name': 'Camisola Lakers Icon Edition 2024',
      'category': 'Camisolas',
      'price': 119.99,
      'image': 'assets/store/lakers_jersey.webp',
      'isNew': true,
    },
    {
      'id': '2',
      'name': 'Sapatilhas Air Jordan XXXVIII',
      'category': 'Sapatilhas',
      'price': 199.99,
      'image': 'assets/store/jordan_shoes.webp',
      'isNew': true,
    },
    {
      'id': '3',
      'name': 'Bola Oficial Spalding NBA',
      'category': 'Bolas',
      'price': 89.99,
      'image': 'assets/store/spalding_ball.webp',
      'isNew': false,
    },
    {
      'id': '4',
      'name': 'Boné Celtics Finals Champions',
      'category': 'Vestuário',
      'price': 34.99,
      'image': 'assets/store/celtics_cap.webp',
      'isNew': false,
    },
    {
      'id': '5',
      'name': 'Camisola Warriors City Edition',
      'category': 'Camisolas',
      'price': 129.99,
      'image': 'assets/store/warriors_jersey.webp',
      'isNew': false,
    },
    {
      'id': '6',
      'name': 'Meias NBA Performance',
      'category': 'Vestuário',
      'price': 19.99,
      'image': 'assets/store/nba_socks.webp',
      'isNew': false,
    },
    {
      'id': '7',
      'name': 'Sapatilhas LeBron 21',
      'category': 'Sapatilhas',
      'price': 189.99,
      'image': 'assets/store/lebron_shoes.webp',
      'isNew': true,
    },
    {
      'id': '8',
      'name': 'Camisola Bulls Retro 1998',
      'category': 'Camisolas',
      'price': 149.99,
      'image': 'assets/store/bulls_jersey.webp',
      'isNew': false,
    },
    {
      'id': '9',
      'name': 'Sapatilhas Curry 11',
      'category': 'Sapatilhas',
      'price': 159.99,
      'image': 'assets/store/curry_shoes.webp',
      'isNew': false,
    },
    {
      'id': '10',
      'name': 'Bola de Treino Wilson',
      'category': 'Bolas',
      'price': 49.99,
      'image': 'assets/store/wilson_ball.webp',
      'isNew': false,
    },
    {
      'id': '11',
      'name': 'Mochila NBA Elite',
      'category': 'Acessórios',
      'price': 65.99,
      'image': 'assets/store/nba_backpack.webp',
      'isNew': true,
    },
    {
      'id': '12',
      'name': 'T-Shirt Lakers Mamba Mentality',
      'category': 'Vestuário',
      'price': 39.99,
      'image': 'assets/store/lakers_tshirt.webp',
      'isNew': false,
    },
  ];

  String _selectedCategory = 'Tudo';
  final List<String> _categories = ['Tudo', 'Camisolas', 'Sapatilhas', 'Vestuário', 'Bolas', 'Acessórios'];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    final filteredProducts = _selectedCategory == 'Tudo' 
        ? _products 
        : _products.where((p) => p['category'] == _selectedCategory).toList();

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        elevation: 0,
        centerTitle: false,
        title: const Text(
          'NBA STORE',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CartScreen()),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner
          Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [theme.colorScheme.primary.withValues(alpha: 0.8), theme.colorScheme.secondary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  right: -20,
                  bottom: -20,
                  child: Icon(Icons.sports_basketball, size: 140, color: Colors.white.withValues(alpha: 0.1)),
                ),
                const Padding(
                  padding: EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'NOVA COLEÇÃO',
                        style: TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 2),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'City Edition 24/25',
                        style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          
          // Categories
          Container(
            height: 60,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final category = _categories[index];
                final isSelected = category == _selectedCategory;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedCategory = category;
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: isSelected ? theme.colorScheme.primary : const Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? theme.colorScheme.primary : Colors.white.withValues(alpha: 0.1),
                      ),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      category,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.white70,
                        fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          
          // Products Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.65,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return _buildProductCard(product, theme);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(Map<String, dynamic> product, ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF151515),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  product['image'].startsWith('http')
                      ? CachedNetworkImage(
                          imageUrl: product['image'],
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(color: Colors.grey[900]),
                          errorWidget: (context, url, error) => const Icon(Icons.image_not_supported, color: Colors.white24),
                        )
                      : Image.asset(
                          product['image'],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.image_not_supported, color: Colors.white24),
                        ),
                  if (product['isNew'] == true)
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'NOVO',
                          style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          // Product Details
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['category'].toUpperCase(),
                        style: TextStyle(color: theme.colorScheme.primary, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        product['name'],
                        style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600, height: 1.2),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '€${product['price']}',
                        style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w900),
                      ),
                      GestureDetector(
                        onTap: () {
                          CartService.instance.addItem(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${product['name']} adicionado ao carrinho!'),
                              duration: const Duration(milliseconds: 1500),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.add_shopping_cart, color: Colors.white, size: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

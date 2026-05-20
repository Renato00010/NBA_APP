import 'package:flutter/material.dart';

import '../../main.dart';
import '../../services/cart_service.dart';
import '../../services/preferences_format_service.dart';
import 'cart_screen.dart';
import 'store_image.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.product});

  final Map<String, dynamic> product;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String? _selectedSize;

  Map<String, dynamic> get product => widget.product;

  bool get _hasSizes => _sizeOptions.isNotEmpty;

  List<String> get _sizeOptions {
    switch (product['id']) {
      case '1':
      case '5':
      case '8':
        return const ['S', 'M', 'L', 'XL'];
      case '2':
      case '7':
      case '9':
        return const ['40', '41', '42', '43', '44', '45'];
      default:
        return const [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          _t(isEnglish, 'Detalhes do produto', 'Product Details'),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w800,
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
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
          decoration: BoxDecoration(
            color: const Color(0xFF111111),
            border: Border(
              top: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: StreamBuilder(
                  stream: database.preferencesDao.watchPreferences(),
                  builder: (context, snapshot) {
                    final currencyCode = snapshot.data?.currencyCode ?? 'EUR';
                    return Text(
                      PreferencesFormatService.formatCurrency(
                        product['price'],
                        currencyCode: currencyCode,
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 2,
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_hasSizes && _selectedSize == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            _t(
                              isEnglish,
                              'Escolhe um tamanho primeiro.',
                              'Choose a size first.',
                            ),
                          ),
                          duration: const Duration(milliseconds: 1500),
                        ),
                      );
                      return;
                    }

                    CartService.instance.addItem({
                      ...product,
                      if (_selectedSize != null) 'size': _selectedSize,
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          _t(
                            isEnglish,
                            '${product['name']} adicionado ao carrinho!',
                            '${product['name']} added to cart!',
                          ),
                        ),
                        duration: const Duration(milliseconds: 1500),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add_shopping_cart),
                  label: Text(
                    _t(isEnglish, 'Adicionar', 'Add'),
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Stack(
              fit: StackFit.expand,
              children: [
                StoreImage(imagePath: product['image']),
                Positioned(
                  left: 20,
                  bottom: 20,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _categoryLabel(
                        product['category'].toString(),
                        isEnglish,
                      ).toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
                if (product['isNew'] == true)
                  Positioned(
                    right: 20,
                    bottom: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _t(isEnglish, 'NOVO', 'NEW'),
                        style: TextStyle(
                          color: theme.colorScheme.primary,
                          fontSize: 11,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  _descriptionFor(product, isEnglish),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    height: 1.45,
                  ),
                ),
                const SizedBox(height: 28),
                if (_hasSizes) ...[
                  Text(
                    _t(isEnglish, 'Tamanho', 'Size'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _sizeOptions.map((size) {
                      final isSelected = size == _selectedSize;
                      return ChoiceChip(
                        label: Text(size),
                        selected: isSelected,
                        showCheckmark: false,
                        labelStyle: TextStyle(
                          color: isSelected ? Colors.white : Colors.white70,
                          fontWeight: FontWeight.w800,
                        ),
                        selectedColor: theme.colorScheme.primary,
                        backgroundColor: const Color(0xFF151515),
                        side: BorderSide(
                          color: isSelected
                              ? theme.colorScheme.primary
                              : Colors.white.withValues(alpha: 0.12),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onSelected: (_) {
                          setState(() {
                            _selectedSize = size;
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 28),
                ],
                Text(
                  _t(isEnglish, 'Caracteristicas', 'Features'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 12),
                ..._detailsFor(product, isEnglish).map(
                  (detail) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: theme.colorScheme.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            detail,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF151515),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.06),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.local_shipping_outlined,
                        color: Colors.white70,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          _t(
                            isEnglish,
                            'Entrega estimada em 2 a 4 dias uteis',
                            'Estimated delivery in 2 to 4 business days',
                          ),
                          style: const TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _descriptionFor(Map<String, dynamic> product, bool isEnglish) {
    final name = product['name'];
    final category = product['category'];
    if (isEnglish) {
      return '$name is an official NBA product from the ${_categoryLabel(category, isEnglish)} category, selected for fans who want premium quality, comfort and game-day style.';
    }
    return '$name e um produto oficial NBA da categoria $category, escolhido para fas que querem qualidade premium, conforto e estilo de dia de jogo.';
  }

  List<String> _detailsFor(Map<String, dynamic> product, bool isEnglish) {
    switch (product['id']) {
      case '1':
      case '5':
      case '8':
        return isEnglish
            ? const [
                'Light breathable fabric',
                'Comfortable fit',
                'Official team details',
              ]
            : const [
                'Tecido leve e respiravel',
                'Corte confortavel',
                'Detalhes oficiais da equipa',
              ];
      case '2':
      case '7':
      case '9':
        return isEnglish
            ? const [
                'Responsive cushioning',
                'Good on-court traction',
                'Support for quick movements',
              ]
            : const [
                'Amortecimento responsivo',
                'Boa tracao em campo',
                'Suporte para movimentos rapidos',
              ];
      case '3':
      case '10':
        return isEnglish
            ? const [
                'Consistent feel',
                'Good grip',
                'Made for practice and games',
              ]
            : const [
                'Toque consistente',
                'Boa aderencia',
                'Indicada para treino e jogo',
              ];
      case '4':
      case '6':
      case '12':
        return isEnglish
            ? const [
                'Comfortable material',
                'Official NBA design',
                'Ideal for daily wear',
              ]
            : const [
                'Material confortavel',
                'Design oficial NBA',
                'Ideal para uso diario',
              ];
      case '11':
        return isEnglish
            ? const [
                'Durable finish',
                'Practical design',
                'Space for essential gear',
              ]
            : const [
                'Acabamento resistente',
                'Design pratico',
                'Espaco para equipamento essencial',
              ];
      default:
        return isEnglish
            ? const [
                'Official NBA product',
                'Premium quality',
                'Ready for game day',
              ]
            : const [
                'Produto oficial NBA',
                'Qualidade premium',
                'Pronto para dia de jogo',
              ];
    }
  }

  String _categoryLabel(String category, bool isEnglish) {
    if (!isEnglish) return category;
    return switch (category) {
      'Camisolas' => 'Jerseys',
      'Sapatilhas' => 'Shoes',
      'Vestuário' => 'Clothing',
      'Bolas' => 'Balls',
      'Acessórios' => 'Accessories',
      _ => category,
    };
  }

  String _t(bool isEnglish, String pt, String en) {
    return isEnglish ? en : pt;
  }
}

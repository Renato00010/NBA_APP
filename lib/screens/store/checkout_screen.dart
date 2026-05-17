// lib/screens/store/checkout_screen.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../main.dart';
import '../../services/cart_service.dart';
import '../../services/preferences_format_service.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _postalCodeController = TextEditingController();
  String _paymentMethod = 'Cartão fictício';
  bool _processing = false;

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _postalCodeController.dispose();
    super.dispose();
  }

  Future<void> _processCheckout(
    BuildContext context,
    CartService cart,
    ThemeData theme,
    String currencyCode,
  ) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _processing = true);
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';
    final createdAt = DateTime.now();
    final order = OrderRecord(
      id: PreferencesFormatService.orderId(createdAt),
      items: cart.items.map((item) => Map<String, dynamic>.from(item)).toList(),
      totalEur: cart.total,
      currencyCode: currencyCode,
      deliveryAddress:
          '${_nameController.text.trim()}\n${_addressController.text.trim()}\n'
          '${_postalCodeController.text.trim()} ${_cityController.text.trim()}',
      paymentMethod: _paymentMethod,
      status: isEnglish ? 'Processing' : 'Em processamento',
      createdAt: createdAt,
    );

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF151515),
        title: Text(
          _t(isEnglish, 'Confirmar encomenda', 'Confirm order'),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          '${_t(isEnglish, 'Total', 'Total')}: '
          '${PreferencesFormatService.formatCurrency(order.totalEur, currencyCode: currencyCode)}\n'
          '${_t(isEnglish, 'Pagamento', 'Payment')}: ${order.paymentMethod}',
          style: const TextStyle(color: Colors.white70),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(
              _t(isEnglish, 'Cancelar', 'Cancel'),
              style: const TextStyle(color: Colors.grey),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(_t(isEnglish, 'Confirmar', 'Confirm')),
          ),
        ],
      ),
    );

    if (confirmed != true) {
      if (mounted) setState(() => _processing = false);
      return;
    }

    await _printInvoice(order, isEnglish);
    await cart.addOrder(order);
    await cart.clear();

    if (context.mounted) {
      setState(() => _processing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _t(
              isEnglish,
              'Encomenda criada. A fatura foi gerada.',
              'Order created. The invoice was generated.',
            ),
          ),
        ),
      );
    }
  }

  Future<void> _printInvoice(OrderRecord order, bool isEnglish) async {
    final doc = pw.Document();

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                _t(isEnglish, 'Fatura NBA App', 'NBA App Invoice'),
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Text('${_t(isEnglish, 'Encomenda', 'Order')}: ${order.id}'),
              pw.Text('${_t(isEnglish, 'Estado', 'Status')}: ${order.status}'),
              pw.SizedBox(height: 20),
              pw.Text(
                _t(isEnglish, 'Morada de entrega', 'Delivery address'),
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.Text(order.deliveryAddress),
              pw.SizedBox(height: 20),
              pw.Text(
                _t(isEnglish, 'Itens', 'Items'),
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 8),
              ...order.items.map(
                (item) => pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 4),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(_invoiceName(item, isEnglish)),
                      pw.Text(
                        PreferencesFormatService.formatCurrency(
                          item['price'],
                          currencyCode: order.currencyCode,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              pw.Divider(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'TOTAL',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                  pw.Text(
                    PreferencesFormatService.formatCurrency(
                      order.totalEur,
                      currencyCode: order.currencyCode,
                    ),
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                '${_t(isEnglish, 'Pagamento', 'Payment')}: '
                '${order.paymentMethod}',
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save(),
      name: '${order.id}.pdf',
    );
  }

  @override
  Widget build(BuildContext context) {
    final cart = CartService.instance;
    final theme = Theme.of(context);
    final isEnglish = Localizations.localeOf(context).languageCode == 'en';

    return StreamBuilder(
      stream: database.preferencesDao.watchPreferences(),
      builder: (context, snapshot) {
        final currencyCode = snapshot.data?.currencyCode ?? 'EUR';
        return Scaffold(
          backgroundColor: const Color(0xFF0A0A0A),
          appBar: AppBar(
            backgroundColor: theme.colorScheme.primary,
            title: Text(
              _t(isEnglish, 'Checkout', 'Checkout'),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: AnimatedBuilder(
            animation: cart,
            builder: (context, _) {
              if (cart.items.isEmpty) {
                return _OrderHistory(
                  orders: cart.orders,
                  currencyCode: currencyCode,
                  isEnglish: isEnglish,
                );
              }

              return Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _CheckoutSection(
                      title: _t(isEnglish, 'Entrega', 'Delivery'),
                      child: Column(
                        children: [
                          _field(
                            _nameController,
                            _t(isEnglish, 'Nome completo', 'Full name'),
                          ),
                          _field(
                            _addressController,
                            _t(isEnglish, 'Morada', 'Address'),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: _field(
                                  _postalCodeController,
                                  _t(isEnglish, 'Código postal', 'Postal code'),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: _field(
                                  _cityController,
                                  _t(isEnglish, 'Cidade', 'City'),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 14),
                    _CheckoutSection(
                      title: _t(
                        isEnglish,
                        'Pagamento fictício',
                        'Mock payment',
                      ),
                      child: DropdownButtonFormField<String>(
                        initialValue: _paymentMethod,
                        dropdownColor: const Color(0xFF151515),
                        decoration: _inputDecoration(
                          _t(isEnglish, 'Método', 'Method'),
                        ),
                        style: const TextStyle(color: Colors.white),
                        items: const [
                          DropdownMenuItem(
                            value: 'Cartão fictício',
                            child: Text('Cartão fictício'),
                          ),
                          DropdownMenuItem(
                            value: 'PayPal Sandbox',
                            child: Text('PayPal Sandbox'),
                          ),
                          DropdownMenuItem(
                            value: 'MB Way Demo',
                            child: Text('MB Way Demo'),
                          ),
                        ],
                        onChanged: (value) {
                          if (value != null) {
                            setState(() => _paymentMethod = value);
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 14),
                    _CheckoutSection(
                      title: _t(isEnglish, 'Resumo', 'Summary'),
                      child: Column(
                        children: [
                          ...cart.items.map(
                            (product) => _OrderItemRow(
                              product: product,
                              currencyCode: currencyCode,
                              isEnglish: isEnglish,
                            ),
                          ),
                          const Divider(color: Colors.white12),
                          _totalRow(cart.total, currencyCode, isEnglish),
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      onPressed: _processing
                          ? null
                          : () => _processCheckout(
                              context,
                              cart,
                              theme,
                              currencyCode,
                            ),
                      icon: _processing
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : const Icon(Icons.lock_outline),
                      label: Text(
                        _t(isEnglish, 'Confirmar encomenda', 'Confirm order'),
                      ),
                    ),
                    const SizedBox(height: 18),
                    _OrderHistory(
                      orders: cart.orders,
                      currencyCode: currencyCode,
                      isEnglish: isEnglish,
                      compact: true,
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _field(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(color: Colors.white),
        validator: (value) =>
            value == null || value.trim().isEmpty ? 'Obrigatório' : null,
        decoration: _inputDecoration(label),
      ),
    );
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white54),
      filled: true,
      fillColor: const Color(0xFF101010),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: Colors.white12),
      ),
    );
  }

  Widget _totalRow(double total, String currencyCode, bool isEnglish) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          _t(isEnglish, 'Total', 'Total'),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w800,
          ),
        ),
        Text(
          PreferencesFormatService.formatCurrency(
            total,
            currencyCode: currencyCode,
          ),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }

  static String _invoiceName(Map<String, dynamic> product, bool isEnglish) {
    final size = product['size'];
    return size == null
        ? product['name']
        : '${product['name']} - ${isEnglish ? 'Size' : 'Tam.'} $size';
  }

  static String _t(bool isEnglish, String pt, String en) {
    return isEnglish ? en : pt;
  }
}

class _CheckoutSection extends StatelessWidget {
  final String title;
  final Widget child;

  const _CheckoutSection({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF151515),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }
}

class _OrderItemRow extends StatelessWidget {
  final Map<String, dynamic> product;
  final String currencyCode;
  final bool isEnglish;

  const _OrderItemRow({
    required this.product,
    required this.currencyCode,
    required this.isEnglish,
  });

  @override
  Widget build(BuildContext context) {
    final size = product['size'];
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: product['image'].startsWith('http')
          ? CachedNetworkImage(
              imageUrl: product['image'],
              width: 46,
              height: 46,
              fit: BoxFit.cover,
            )
          : Image.asset(
              product['image'],
              width: 46,
              height: 46,
              fit: BoxFit.cover,
            ),
      title: Text(product['name'], style: const TextStyle(color: Colors.white)),
      subtitle: size == null
          ? null
          : Text(
              '${isEnglish ? 'Size' : 'Tamanho'} $size',
              style: const TextStyle(color: Colors.white54),
            ),
      trailing: Text(
        PreferencesFormatService.formatCurrency(
          product['price'],
          currencyCode: currencyCode,
        ),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}

class _OrderHistory extends StatelessWidget {
  final List<OrderRecord> orders;
  final String currencyCode;
  final bool isEnglish;
  final bool compact;

  const _OrderHistory({
    required this.orders,
    required this.currencyCode,
    required this.isEnglish,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      if (compact) return const SizedBox.shrink();
      return Center(
        child: Text(
          isEnglish
              ? 'Your cart is empty and there are no orders yet.'
              : 'O carrinho está vazio e ainda não existem encomendas.',
          style: const TextStyle(color: Colors.white70),
          textAlign: TextAlign.center,
        ),
      );
    }

    final content = Column(
      children: orders
          .map(
            (order) => ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.local_shipping_outlined,
                color: Color(0xFFFFC72C),
              ),
              title: Text(
                order.id,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              subtitle: Text(
                '${order.status} - ${order.items.length} item(s)',
                style: const TextStyle(color: Colors.white54),
              ),
              trailing: Text(
                PreferencesFormatService.formatCurrency(
                  order.totalEur,
                  currencyCode: order.currencyCode,
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          )
          .toList(),
    );

    if (compact) {
      return _CheckoutSection(
        title: isEnglish ? 'Recent orders' : 'Encomendas recentes',
        child: content,
      );
    }

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _CheckoutSection(
          title: isEnglish ? 'Order history' : 'Histórico de encomendas',
          child: content,
        ),
      ],
    );
  }
}

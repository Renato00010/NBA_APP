// lib/screens/store/checkout_screen.dart
import 'package:flutter/material.dart';
import '../../services/cart_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  Future<void> _processCheckout(BuildContext context, CartService cart, ThemeData theme) async {
    // 1. Mostrar diálogo de confirmação
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF151515),
          title: const Text('Confirmar Compra', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          content: const Text('Tem a certeza que deseja finalizar esta compra?', style: TextStyle(color: Colors.white70)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar', style: TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: theme.colorScheme.primary, foregroundColor: Colors.white),
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    // 2. Gerar Fatura em PDF
    final doc = pw.Document();
    
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Fatura da Compra - NBA App', style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 30),
              pw.Text('Itens Comprados:', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              ...cart.items.map((item) {
                return pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 4),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text(item['name']),
                      pw.Text('EUR ${item['price']}'),
                    ]
                  )
                );
              }).toList(),
              pw.SizedBox(height: 10),
              pw.Divider(),
              pw.SizedBox(height: 10),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text('TOTAL', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                  pw.Text('EUR ${cart.total.toStringAsFixed(2)}', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
                ]
              ),
              pw.SizedBox(height: 50),
              pw.Text('Obrigado pela sua compra e por apoiar a sua equipa favorita!', style: pw.TextStyle(fontStyle: pw.FontStyle.italic, color: PdfColors.grey700)),
            ]
          );
        }
      )
    );

    // 3. Mostrar preview do PDF (o utilizador pode guardar/imprimir)
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => doc.save(),
      name: 'Fatura_NBA_App.pdf',
    );

    // 4. Limpar o carrinho e voltar ao início
    cart.clear();
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Compra concluída! A fatura foi gerada.')));
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = CartService.instance;
    final items = cart.items;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: theme.colorScheme.primary,
        title: const Text('Checkout', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      body: items.isEmpty
          ? const Center(child: Text('O carrinho está vazio.', style: TextStyle(color: Colors.white70)))
          : Column(
              children: [
                Expanded(
                  child: ListView.separated(
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
                            : Image.asset(product['image'], width: 48, height: 48, fit: BoxFit.cover),
                        title: Text(product['name'], style: const TextStyle(color: Colors.white)),
                        subtitle: Text('€${product['price']}', style: const TextStyle(color: Colors.white70)),
                      );
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  color: const Color(0xFF151515),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total: €${cart.total.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w700)),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: theme.colorScheme.primary, foregroundColor: Colors.white),
                        onPressed: () => _processCheckout(context, cart, theme),
                        child: const Text('Confirmar Compra'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

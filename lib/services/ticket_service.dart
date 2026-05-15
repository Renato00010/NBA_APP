import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:barcode/barcode.dart';

class TicketService {
  static Future<void> generateAndPrintTicket({
    required String gameId,
    required String homeTeam,
    required String awayTeam,
    required String venue,
    required String date,
    required String time,
  }) async {
    final pdf = pw.Document();
    
    // Generate QR code data
    final qrData = 'NBA-TICKET-$gameId-${DateTime.now().millisecondsSinceEpoch}';
    
    // Create QR code using the barcode package
    final bc = Barcode.qrCode();
    
    // Create PDF page
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Bilhete NBA - $gameId',
                style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 30),
              pw.Text(
                'Detalhes do Jogo:',
                style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 10),
              pw.Text('Equipa Visitante: $awayTeam'),
              pw.Text('Equipa Casa: $homeTeam'),
              pw.SizedBox(height: 10),
              pw.Text('Data: $date'),
              pw.Text('Hora: $time'),
              pw.Text('Local: $venue'),
              pw.SizedBox(height: 20),
              pw.Divider(),
              pw.SizedBox(height: 20),
              pw.Text(
                'Código QR:',
                style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 10),
              pw.BarcodeWidget(
                barcode: bc,
                data: qrData,
                width: 150,
                height: 150,
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                qrData,
                style: pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
              ),
              pw.SizedBox(height: 30),
              pw.Divider(),
              pw.SizedBox(height: 20),
              pw.Text(
                'Este bilhete é válido apenas para o jogo acima mencionado.',
                style: pw.TextStyle(fontStyle: pw.FontStyle.italic, color: PdfColors.grey700),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                'Apresente este bilhete na entrada do estádio.',
                style: pw.TextStyle(fontStyle: pw.FontStyle.italic, color: PdfColors.grey700),
              ),
            ],
          );
        },
      ),
    );
    
    // Print or save the PDF
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) => pdf.save(),
      name: 'NBA_Ticket_$gameId.pdf',
    );
  }
}

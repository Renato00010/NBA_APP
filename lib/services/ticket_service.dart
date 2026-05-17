import 'package:barcode/barcode.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class TicketService {
  static Future<void> generateAndPrintTicket({
    required String gameId,
    required String homeTeam,
    required String awayTeam,
    required String venue,
    required String date,
    required String time,
    String languageCode = 'pt',
  }) async {
    final pdf = pw.Document();
    final isEnglish = languageCode == 'en';

    final qrData =
        'NBA-TICKET-$gameId-${DateTime.now().millisecondsSinceEpoch}';
    final bc = Barcode.qrCode();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                '${_t(isEnglish, 'Bilhete NBA', 'NBA Ticket')} - $gameId',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 30),
              pw.Text(
                _t(isEnglish, 'Detalhes do Jogo:', 'Game Details:'),
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                '${_t(isEnglish, 'Equipa Visitante', 'Away Team')}: $awayTeam',
              ),
              pw.Text(
                '${_t(isEnglish, 'Equipa Casa', 'Home Team')}: $homeTeam',
              ),
              pw.SizedBox(height: 10),
              pw.Text('${_t(isEnglish, 'Data', 'Date')}: $date'),
              pw.Text('${_t(isEnglish, 'Hora', 'Time')}: $time'),
              pw.Text('${_t(isEnglish, 'Local', 'Venue')}: $venue'),
              pw.SizedBox(height: 20),
              pw.Divider(),
              pw.SizedBox(height: 20),
              pw.Text(
                _t(isEnglish, 'Codigo QR:', 'QR Code:'),
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
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
                _t(
                  isEnglish,
                  'Este bilhete e valido apenas para o jogo acima mencionado.',
                  'This ticket is valid only for the game listed above.',
                ),
                style: pw.TextStyle(
                  fontStyle: pw.FontStyle.italic,
                  color: PdfColors.grey700,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                _t(
                  isEnglish,
                  'Apresente este bilhete na entrada do estadio.',
                  'Show this ticket at the arena entrance.',
                ),
                style: pw.TextStyle(
                  fontStyle: pw.FontStyle.italic,
                  color: PdfColors.grey700,
                ),
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) => pdf.save(),
      name: isEnglish ? 'NBA_Ticket_$gameId.pdf' : 'Bilhete_NBA_$gameId.pdf',
    );
  }

  static String _t(bool isEnglish, String pt, String en) => isEnglish ? en : pt;
}

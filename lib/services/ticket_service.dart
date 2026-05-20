import 'dart:typed_data';
import 'package:barcode/barcode.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class TicketService {
  static Future<Uint8List> generateAndPrintTicket({
    required String gameId,
    required String homeTeam,
    required String awayTeam,
    required String venue,
    required String date,
    required String time,
    String? sector,
    String? row,
    String? seat,
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
              if (sector != null && row != null && seat != null) ...[
                pw.SizedBox(height: 15),
                pw.Container(
                  padding: const pw.EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: pw.BoxDecoration(
                    color: PdfColor.fromInt(0xFFFFF8E1), // light amber background
                    border: pw.Border.all(color: PdfColor.fromInt(0xFFFFB300), width: 2),
                    borderRadius: const pw.BorderRadius.all(pw.Radius.circular(8)),
                  ),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                    children: [
                      pw.Column(
                        children: [
                          pw.Text(
                            _t(isEnglish, 'SETOR', 'SECTOR'),
                            style: pw.TextStyle(
                              fontSize: 10,
                              color: PdfColors.grey700,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.SizedBox(height: 4),
                          pw.Text(
                            sector,
                            style: pw.TextStyle(
                              fontSize: 18,
                              color: PdfColor.fromInt(0xFFFF8F00), // amber bold
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      pw.Column(
                        children: [
                          pw.Text(
                            _t(isEnglish, 'FILA', 'ROW'),
                            style: pw.TextStyle(
                              fontSize: 10,
                              color: PdfColors.grey700,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.SizedBox(height: 4),
                          pw.Text(
                            row,
                            style: pw.TextStyle(
                              fontSize: 18,
                              color: PdfColor.fromInt(0xFFFF8F00),
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      pw.Column(
                        children: [
                          pw.Text(
                            _t(isEnglish, 'LUGAR', 'SEAT'),
                            style: pw.TextStyle(
                              fontSize: 10,
                              color: PdfColors.grey700,
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                          pw.SizedBox(height: 4),
                          pw.Text(
                            seat,
                            style: pw.TextStyle(
                              fontSize: 18,
                              color: PdfColor.fromInt(0xFFFF8F00),
                              fontWeight: pw.FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
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

    final pdfBytes = await pdf.save();
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) => pdfBytes,
      name: isEnglish ? 'NBA_Ticket_$gameId.pdf' : 'Bilhete_NBA_$gameId.pdf',
    );
    return pdfBytes;
  }

  static String _t(bool isEnglish, String pt, String en) => isEnglish ? en : pt;
}

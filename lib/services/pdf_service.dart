import 'dart:io';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import '../db/app_database.dart';

class PdfService {
  // Gera PDF de comparação de jogadores
  static Future<File?> generatePlayerComparisonPdf({
    required Player player1,
    required Player player2,
  }) async {
    try {
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                // Título
                pw.Container(
                  width: double.infinity,
                  padding: const pw.EdgeInsets.all(16),
                  decoration: const pw.BoxDecoration(color: PdfColors.blue900),
                  child: pw.Text(
                    'NBA — Comparação de Jogadores',
                    style: pw.TextStyle(
                      color: PdfColors.white,
                      fontSize: 22,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
                pw.SizedBox(height: 24),

                // Nomes dos jogadores
                pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                  children: [
                    pw.Text(
                      player1.fullName,
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                    pw.Text(
                      'VS',
                      style: pw.TextStyle(
                        fontSize: 20,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.red,
                      ),
                    ),
                    pw.Text(
                      player2.fullName,
                      style: pw.TextStyle(
                        fontSize: 16,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                pw.SizedBox(height: 24),
                pw.Divider(),
                pw.SizedBox(height: 16),

                // Tabela de estatísticas
                pw.Text(
                  'Estatísticas por jogo',
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 12),
                pw.Table(
                  border: pw.TableBorder.all(color: PdfColors.grey300),
                  children: [
                    // Header
                    pw.TableRow(
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.blue900,
                      ),
                      children: [
                        _tableCell('Estatística', isHeader: true),
                        _tableCell(
                          player1.fullName.split(' ').first,
                          isHeader: true,
                        ),
                        _tableCell(
                          player2.fullName.split(' ').first,
                          isHeader: true,
                        ),
                      ],
                    ),
                    _statRow('Pontos (PPG)', player1.ppg, player2.ppg),
                    _statRow('Ressaltos (RPG)', player1.rpg, player2.rpg),
                    _statRow('Assistências (APG)', player1.apg, player2.apg),
                    _statRow('Roubos (SPG)', player1.spg, player2.spg),
                    _statRow('Blocos (BPG)', player1.bpg, player2.bpg),
                  ],
                ),
                pw.SizedBox(height: 24),
                pw.Divider(),
                pw.SizedBox(height: 8),

                // Rodapé
                pw.Text(
                  'Gerado pela NBA App — ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                  style: const pw.TextStyle(
                    fontSize: 10,
                    color: PdfColors.grey,
                  ),
                ),
              ],
            );
          },
        ),
      );

      // Guarda o PDF
      final dir = await getApplicationDocumentsDirectory();
      final fileName =
          'comparacao_${DateTime.now().millisecondsSinceEpoch}.pdf';
      final file = File(p.join(dir.path, fileName));
      await file.writeAsBytes(await pdf.save());
      return file;
    } catch (e) {
      return null;
    }
  }

  // Partilha / imprime o PDF
  static Future<void> sharePdf(File pdfFile) async {
    await Printing.sharePdf(
      bytes: await pdfFile.readAsBytes(),
      filename: pdfFile.path.split('/').last,
    );
  }

  static pw.Widget _tableCell(String text, {bool isHeader = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          color: isHeader ? PdfColors.white : PdfColors.black,
          fontWeight: isHeader ? pw.FontWeight.bold : pw.FontWeight.normal,
          fontSize: 11,
        ),
      ),
    );
  }

  static pw.TableRow _statRow(String label, double val1, double val2) {
    final p1Wins = val1 > val2;
    return pw.TableRow(
      children: [
        _tableCell(label),
        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text(
            val1.toStringAsFixed(1),
            style: pw.TextStyle(
              fontWeight: p1Wins ? pw.FontWeight.bold : pw.FontWeight.normal,
              color: p1Wins ? PdfColors.blue900 : PdfColors.black,
              fontSize: 11,
            ),
          ),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(8),
          child: pw.Text(
            val2.toStringAsFixed(1),
            style: pw.TextStyle(
              fontWeight: !p1Wins ? pw.FontWeight.bold : pw.FontWeight.normal,
              color: !p1Wins ? PdfColors.blue900 : PdfColors.black,
              fontSize: 11,
            ),
          ),
        ),
      ],
    );
  }
}

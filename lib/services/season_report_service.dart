import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../../db/app_database.dart';
import '../../main.dart';

class SeasonReportService {
  static Future<void> generateAndPrintSeasonReport({
    required String teamId,
    required String teamName,
    required String city,
    required List<Player> players,
    required List<CachedGame> games,
  }) async {
    final pdf = pw.Document();
    
    // Calculate statistics
    final totalGames = games.length;
    final wins = games.where((g) {
      final isHome = g.homeTeamId == teamId;
      final teamScore = isHome ? g.scoreHome : g.scoreAway;
      final opponentScore = isHome ? g.scoreAway : g.scoreHome;
      return teamScore > opponentScore;
    }).length;
    
    final losses = totalGames - wins;
    final winPercentage = totalGames > 0 ? (wins / totalGames * 100).toStringAsFixed(1) : '0.0';
    
    // Calculate positions
    final guards = players.where((p) => (p.position ?? '').contains('G')).length;
    final forwards = players.where((p) => (p.position ?? '').contains('F')).length;
    final centers = players.where((p) => (p.position ?? '').contains('C')).length;
    
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
                'Relatório de Época - $teamName',
                style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                city.toUpperCase(),
                style: pw.TextStyle(fontSize: 14, color: PdfColors.grey700),
              ),
              pw.SizedBox(height: 30),
              pw.Text(
                'Resumo da Época:',
                style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 10),
              pw.Text('Jogos: $totalGames'),
              pw.Text('Vitórias: $wins'),
              pw.Text('Derrotas: $losses'),
              pw.Text('Percentagem de Vitórias: $winPercentage%'),
              pw.SizedBox(height: 20),
              pw.Divider(),
              pw.SizedBox(height: 20),
              pw.Text(
                'Plantel:',
                style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 10),
              pw.Text('Guardas: $guards'),
              pw.Text('Avançados: $forwards'),
              pw.Text('Pivôs: $centers'),
              pw.Text('Total: ${players.length} jogadores'),
              pw.SizedBox(height: 20),
              pw.Divider(),
              pw.SizedBox(height: 20),
              pw.Text(
                'Jogos Recentes:',
                style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 10),
              ...games.take(10).map((game) {
                final opponentId = game.homeTeamId == teamId
                    ? game.awayTeamId
                    : game.homeTeamId;
                final opponentName = repository.getTeamName(opponentId);
                final isHome = game.homeTeamId == teamId;
                final teamScore = isHome ? game.scoreHome : game.scoreAway;
                final opponentScore = isHome ? game.scoreAway : game.scoreHome;
                final isWin = teamScore > opponentScore;
                
                return pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 4),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('${isHome ? 'vs' : '@'} $opponentName'),
                      pw.Text('$teamScore - $opponentScore'),
                    ]
                  )
                );
              }).toList(),
              pw.SizedBox(height: 20),
              pw.Divider(),
              pw.SizedBox(height: 20),
              pw.Text(
                'Principais Jogadores:',
                style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 10),
              ...players.take(10).map((player) {
                return pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 4),
                  child: pw.Text('${player.displayName ?? player.fullName} - ${player.position ?? '-'} • #${player.jerseyNumber ?? '-'}')
                );
              }).toList(),
              pw.SizedBox(height: 30),
              pw.Divider(),
              pw.SizedBox(height: 20),
              pw.Text(
                'Relatório gerado automaticamente pela NBA App',
                style: pw.TextStyle(fontStyle: pw.FontStyle.italic, color: PdfColors.grey700),
              ),
              pw.SizedBox(height: 5),
              pw.Text(
                'Data: ${DateTime.now().toString().split(' ')[0]}',
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
      name: 'Relatorio_Epoca_$teamName.pdf',
    );
  }
}

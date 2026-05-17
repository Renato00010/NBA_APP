import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../db/app_database.dart';
import '../../main.dart';
import '../utils/game_status_utils.dart';

class SeasonReportService {
  static Future<void> generateAndPrintSeasonReport({
    required String teamId,
    required String teamName,
    required String city,
    required List<Player> players,
    required List<CachedGame> games,
    String languageCode = 'pt',
  }) async {
    final pdf = pw.Document();
    final isEnglish = languageCode == 'en';

    final completedGames =
        games.where((g) => GameStatusUtils.isFinal(g.status)).toList();

    final totalGames = completedGames.length;
    final wins = completedGames.where((g) {
      final isHome = g.homeTeamId == teamId;
      final teamScore = isHome ? g.scoreHome : g.scoreAway;
      final opponentScore = isHome ? g.scoreAway : g.scoreHome;
      return teamScore > opponentScore;
    }).length;

    final losses = totalGames - wins;
    final winPercentage = totalGames > 0
        ? (wins / totalGames * 100).toStringAsFixed(1)
        : '0.0';

    final guards = players
        .where((p) => (p.position ?? '').contains('G'))
        .length;
    final forwards = players
        .where((p) => (p.position ?? '').contains('F'))
        .length;
    final centers = players
        .where((p) => (p.position ?? '').contains('C'))
        .length;

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(40),
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                _t(
                  isEnglish,
                  'Relatorio de Epoca - $teamName',
                  'Season Report - $teamName',
                ),
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 10),
              pw.Text(
                city.toUpperCase(),
                style: pw.TextStyle(fontSize: 14, color: PdfColors.grey700),
              ),
              pw.SizedBox(height: 30),
              _sectionTitle(
                _t(isEnglish, 'Resumo da Epoca:', 'Season Summary:'),
              ),
              pw.SizedBox(height: 10),
              pw.Text('${_t(isEnglish, 'Jogos', 'Games')}: $totalGames'),
              pw.Text('${_t(isEnglish, 'Vitorias', 'Wins')}: $wins'),
              pw.Text('${_t(isEnglish, 'Derrotas', 'Losses')}: $losses'),
              pw.Text(
                '${_t(isEnglish, 'Percentagem de Vitorias', 'Win Percentage')}: $winPercentage%',
              ),
              pw.SizedBox(height: 20),
              pw.Divider(),
              pw.SizedBox(height: 20),
              _sectionTitle(_t(isEnglish, 'Plantel:', 'Roster:')),
              pw.SizedBox(height: 10),
              pw.Text('${_t(isEnglish, 'Guardas', 'Guards')}: $guards'),
              pw.Text('${_t(isEnglish, 'Avancados', 'Forwards')}: $forwards'),
              pw.Text('${_t(isEnglish, 'Pivos', 'Centers')}: $centers'),
              pw.Text(
                '${_t(isEnglish, 'Total', 'Total')}: ${players.length} ${_t(isEnglish, 'jogadores', 'players')}',
              ),
              pw.SizedBox(height: 20),
              pw.Divider(),
              pw.SizedBox(height: 20),
              _sectionTitle(
                _t(
                  isEnglish,
                  'Jogos da epoca (ultimos 15):',
                  'Season games (last 15):',
                ),
              ),
              pw.SizedBox(height: 10),
              if (completedGames.isEmpty)
                pw.Text(
                  _t(
                    isEnglish,
                    'Sem jogos finalizados na cache.',
                    'No completed games in cache.',
                  ),
                ),
              ...completedGames.take(15).map((game) {
                final opponentId = game.homeTeamId == teamId
                    ? game.awayTeamId
                    : game.homeTeamId;
                final opponentName = repository.getTeamName(opponentId);
                final isHome = game.homeTeamId == teamId;
                final teamScore = isHome ? game.scoreHome : game.scoreAway;
                final opponentScore = isHome ? game.scoreAway : game.scoreHome;

                return pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 4),
                  child: pw.Row(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.Text('${isHome ? 'vs' : '@'} $opponentName'),
                      pw.Text('$teamScore - $opponentScore'),
                    ],
                  ),
                );
              }),
              pw.SizedBox(height: 20),
              pw.Divider(),
              pw.SizedBox(height: 20),
              _sectionTitle(
                _t(isEnglish, 'Principais Jogadores:', 'Key Players:'),
              ),
              pw.SizedBox(height: 10),
              ...players.take(10).map((player) {
                return pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 4),
                  child: pw.Text(
                    '${player.displayName ?? player.fullName} - ${player.position ?? '-'} - #${player.jerseyNumber ?? '-'}',
                  ),
                );
              }),
              pw.SizedBox(height: 30),
              pw.Divider(),
              pw.SizedBox(height: 20),
              pw.Text(
                _t(
                  isEnglish,
                  'Relatorio gerado automaticamente pela NBA App',
                  'Report automatically generated by NBA App',
                ),
                style: pw.TextStyle(
                  fontStyle: pw.FontStyle.italic,
                  color: PdfColors.grey700,
                ),
              ),
              pw.SizedBox(height: 5),
              pw.Text(
                '${_t(isEnglish, 'Data', 'Date')}: ${DateTime.now().toString().split(' ')[0]}',
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
      name: isEnglish
          ? 'Season_Report_$teamName.pdf'
          : 'Relatorio_Epoca_$teamName.pdf',
    );
  }

  static pw.Text _sectionTitle(String text) {
    return pw.Text(
      text,
      style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold),
    );
  }

  static String _t(bool isEnglish, String pt, String en) => isEnglish ? en : pt;
}

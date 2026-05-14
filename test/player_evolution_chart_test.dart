import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:nba_app/widgets/player_evolution_chart.dart';
import 'package:nba_app/models/player_season_stats.dart';

void main() {
  testWidgets('PlayerEvolutionChart renders correctly with data', (WidgetTester tester) async {
    final stats = [
      PlayerSeasonStats(season: '2022-23', ppg: 20.0, rpg: 5.0, apg: 5.0, per: 15.0, tsPct: 55.0),
      PlayerSeasonStats(season: '2023-24', ppg: 25.0, rpg: 6.0, apg: 6.0, per: 18.0, tsPct: 58.0),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PlayerEvolutionChart(seasons: stats),
        ),
      ),
    );

    // Verify the title exists
    expect(find.text('Career Evolution'), findsOneWidget);

    // Verify Dropdown exists with default 'Points' for 'PPG'
    expect(find.text('Points'), findsOneWidget);
    
    // Verify LineChart is rendered
    expect(find.byType(LineChart), findsOneWidget);
  });

  testWidgets('PlayerEvolutionChart renders empty state', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: PlayerEvolutionChart(seasons: []),
        ),
      ),
    );

    expect(find.text('No season data available'), findsOneWidget);
  });
}

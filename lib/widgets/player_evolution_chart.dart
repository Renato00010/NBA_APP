import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../models/player_season_stats.dart';

class PlayerEvolutionChart extends StatefulWidget {
  final List<PlayerSeasonStats> seasons;

  const PlayerEvolutionChart({super.key, required this.seasons});

  @override
  State<PlayerEvolutionChart> createState() => _PlayerEvolutionChartState();
}

class _PlayerEvolutionChartState extends State<PlayerEvolutionChart> {
  String _selectedStat = 'PPG'; // 'PPG', 'RPG', 'APG'

  @override
  Widget build(BuildContext context) {
    if (widget.seasons.isEmpty) {
      return const Center(child: Text('No season data available'));
    }

    final stats = widget.seasons.toList()
      ..sort(
        (a, b) => a.season.compareTo(b.season),
      ); // Assumes format like '2022-23'

    List<FlSpot> spots = [];
    double maxY = 0;

    for (int i = 0; i < stats.length; i++) {
      double val = 0;
      switch (_selectedStat) {
        case 'PPG':
          val = stats[i].ppg;
          break;
        case 'RPG':
          val = stats[i].rpg;
          break;
        case 'APG':
          val = stats[i].apg;
          break;
      }
      spots.add(FlSpot(i.toDouble(), val));
      if (val > maxY) maxY = val;
    }

    maxY = maxY < 10 ? 10 : maxY * 1.2;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Career Evolution',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: _selectedStat,
              items: const [
                DropdownMenuItem(value: 'PPG', child: Text('Points')),
                DropdownMenuItem(value: 'RPG', child: Text('Rebounds')),
                DropdownMenuItem(value: 'APG', child: Text('Assists')),
              ],
              onChanged: (val) {
                if (val != null) setState(() => _selectedStat = val);
              },
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 250,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(
                show: true,
                drawVerticalLine: true,
                horizontalInterval: maxY / 5,
                getDrawingHorizontalLine: (value) =>
                    FlLine(color: Colors.white12, strokeWidth: 1),
                getDrawingVerticalLine: (value) =>
                    FlLine(color: Colors.white12, strokeWidth: 1),
              ),
              titlesData: FlTitlesData(
                show: true,
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 30,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      int idx = value.toInt();
                      if (idx >= 0 && idx < stats.length) {
                        String season = stats[idx].season;
                        // Show e.g. "22" instead of "2022-23" for space
                        String shortSeason = season.split('-').last;
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            shortSeason,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.grey,
                            ),
                          ),
                        );
                      }
                      return const Text('');
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: maxY / 5,
                    reservedSize: 42,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        value.toStringAsFixed(1),
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                        ),
                      );
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: Colors.white24),
              ),
              minX: 0,
              maxX: stats.length > 1 ? (stats.length - 1).toDouble() : 1.0,
              minY: 0,
              maxY: maxY,
              lineBarsData: [
                LineChartBarData(
                  spots: spots,
                  isCurved: true,
                  color: Theme.of(context).primaryColor,
                  barWidth: 3,
                  isStrokeCapRound: true,
                  dotData: FlDotData(show: true),
                  belowBarData: BarAreaData(
                    show: true,
                    color: Theme.of(
                      context,
                    ).primaryColor.withValues(alpha: 0.2),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

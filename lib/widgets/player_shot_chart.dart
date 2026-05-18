import 'dart:math';
import 'package:flutter/material.dart';

class PlayerShotChart extends StatelessWidget {
  final double fgPct;
  final double fg3Pct;
  final String position;

  const PlayerShotChart({
    super.key,
    required this.fgPct,
    required this.fg3Pct,
    required this.position,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Zonas Quentes (Heatmap Simulado)',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Baseado em FG% (${fgPct.toStringAsFixed(1)}%) e 3P% (${fg3Pct.toStringAsFixed(1)}%)',
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 24),
        Center(
          child: Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 400),
            child: AspectRatio(
              aspectRatio: 1.2,
              child: CustomPaint(
                painter: _CourtPainter(
                  fgPct: fgPct,
                  fg3Pct: fg3Pct,
                  position: position,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLegendItem(Colors.blue, 'Frio'),
            const SizedBox(width: 8),
            _buildLegendItem(Colors.yellow, 'Médio'),
            const SizedBox(width: 8),
            _buildLegendItem(Colors.red, 'Quente'),
          ],
        )
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.7),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
      ],
    );
  }
}

class _CourtPainter extends CustomPainter {
  final double fgPct;
  final double fg3Pct;
  final String position;

  _CourtPainter({
    required this.fgPct,
    required this.fg3Pct,
    required this.position,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final courtPaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.1)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final fillPaint = Paint()
      ..color = const Color(0xFF151515)
      ..style = PaintingStyle.fill;

    // Draw background
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), fillPaint);
    
    // Bottom-based layout (Hoop at the bottom)
    final hoopY = size.height * 0.88;
    final arcRadius = size.width * 0.42;

    // 1. Paint bounds (Garrafão na base)
    final paintWidth = size.width * 0.32;
    final paintHeight = size.height * 0.40;
    final paintLeft = (size.width - paintWidth) / 2;
    canvas.drawRect(
      Rect.fromLTWH(paintLeft, size.height - paintHeight, paintWidth, paintHeight),
      courtPaint,
    );

    // 2. Hoop and backboard (Tabela e aro no fundo)
    final backboardWidth = size.width * 0.12;
    final backboardY = hoopY + size.height * 0.03; // Backboard behind hoop
    canvas.drawLine(
      Offset((size.width - backboardWidth) / 2, backboardY),
      Offset((size.width + backboardWidth) / 2, backboardY),
      courtPaint,
    );
    
    final hoopRadius = size.height * 0.03;
    canvas.drawCircle(Offset(size.width / 2, hoopY), hoopRadius, courtPaint);

    // 3. 3-Point line (Arc + straight lines extending from baseline at bottom)
    final path = Path();
    path.moveTo(size.width * 0.08, size.height);
    path.lineTo(size.width * 0.08, hoopY);
    
    // Draw arc from left to right (Top half of the circle)
    path.arcTo(
      Rect.fromCircle(center: Offset(size.width / 2, hoopY), radius: arcRadius),
      pi, // Start on the left
      pi, // Sweep clockwise (upwards) to the right
      false,
    );
    
    path.lineTo(size.width * 0.92, size.height);
    canvas.drawPath(path, courtPaint);

    // Draw Heat points
    _drawHeatPoints(canvas, size, hoopY, arcRadius);
  }

  void _drawHeatPoints(Canvas canvas, Size size, double hoopY, double arcRadius) {
    final random = Random(42); // Seeded for consistency per player
    
    int paintZonePoints = 0;
    int midRangePoints = 0;
    int threePtPoints = 0;
    
    // Determine shot distribution based on position
    final isCenter = position.contains('C') || position.contains('F');
    final isGuard = position.contains('G');
    
    if (isCenter) {
      paintZonePoints = 40;
      midRangePoints = 10;
      threePtPoints = fg3Pct > 30 ? 15 : 5;
    } else if (isGuard) {
      paintZonePoints = 15;
      midRangePoints = 20;
      threePtPoints = 45;
    } else {
      paintZonePoints = 22;
      midRangePoints = 20;
      threePtPoints = 33;
    }

    // Determine colors based on efficiency
    final paintColor = _getColorForEfficiency(fgPct + 10); // Paint has higher percentage
    final midColor = _getColorForEfficiency(fgPct - 5);
    final threeColor = _getColorForEfficiency(fg3Pct);

    // Draw Paint Zone (Close to hoop / garrafão at the bottom)
    for (int i = 0; i < paintZonePoints; i++) {
      final dx = size.width / 2 + (random.nextDouble() - 0.5) * size.width * 0.25;
      final dy = hoopY - random.nextDouble() * size.height * 0.28;
      _drawHexagon(canvas, Offset(dx, dy), size.width * 0.02, paintColor);
    }

    // Draw Mid Range (Between paint and 3pt line)
    for (int i = 0; i < midRangePoints; i++) {
      double dx, dy;
      int attempts = 0;
      do {
        dx = size.width / 2 + (random.nextDouble() - 0.5) * size.width * 0.7;
        dy = size.height * 0.1 + random.nextDouble() * size.height * 0.8;
        attempts++;
      } while ((_isInsidePaint(dx, dy, size) || _isOutside3Pt(dx, dy, size, hoopY, arcRadius)) && attempts < 100);
      _drawHexagon(canvas, Offset(dx, dy), size.width * 0.02, midColor);
    }

    // Draw 3-Point (Outside the arc)
    for (int i = 0; i < threePtPoints; i++) {
      double dx, dy;
      int attempts = 0;
      do {
        dx = size.width / 2 + (random.nextDouble() - 0.5) * size.width * 0.9;
        dy = random.nextDouble() * size.height * 0.75;
        attempts++;
      } while (!_isOutside3Pt(dx, dy, size, hoopY, arcRadius) && attempts < 100);
      _drawHexagon(canvas, Offset(dx, dy), size.width * 0.02, threeColor);
    }
  }

  bool _isInsidePaint(double x, double y, Size size) {
    final paintWidth = size.width * 0.32;
    final paintHeight = size.height * 0.40;
    final paintLeft = (size.width - paintWidth) / 2;
    return x >= paintLeft && x <= paintLeft + paintWidth && y >= size.height - paintHeight;
  }

  bool _isOutside3Pt(double x, double y, Size size, double hoopY, double arcRadius) {
    if (y >= hoopY) {
      return x < size.width * 0.08 || x > size.width * 0.92;
    }
    
    final distToHoop = sqrt(pow(x - size.width / 2, 2) + pow(y - hoopY, 2));
    return distToHoop > arcRadius;
  }

  Color _getColorForEfficiency(double pct) {
    if (pct >= 45) return Colors.red.withValues(alpha: 0.7);
    if (pct >= 35) return Colors.yellow.withValues(alpha: 0.7);
    return Colors.blue.withValues(alpha: 0.7);
  }

  void _drawHexagon(Canvas canvas, Offset center, double size, Color color) {
    final path = Path();
    for (int i = 0; i < 6; i++) {
      final angle = (pi / 3) * i;
      final dx = center.dx + size * cos(angle);
      final dy = center.dy + size * sin(angle);
      if (i == 0) {
        path.moveTo(dx, dy);
      } else {
        path.lineTo(dx, dy);
      }
    }
    path.close();

    // Draw soft glow
    final glowPaint = Paint()
      ..color = color.withValues(alpha: 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);
    canvas.drawPath(path, glowPaint);

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

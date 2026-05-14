import 'package:flutter/material.dart';
import '../models/standing.dart';
import '../widgets/team_logo.dart';
import '../screens/teams/team_detail_screen.dart';

class PlayoffBracketWidget extends StatefulWidget {
  final List<Standing> standings;
  const PlayoffBracketWidget({super.key, required this.standings});

  @override
  State<PlayoffBracketWidget> createState() => _PlayoffBracketWidgetState();
}

class _PlayoffBracketWidgetState extends State<PlayoffBracketWidget> {
  final TransformationController _controller = TransformationController();

  static const double boxW = 100.0;
  static const double boxH = 50.0;
  static const double vGap = 20.0;
  static const double hGap = 80.0;

  @override
  void initState() {
    super.initState();
    _controller.value = Matrix4.identity()..scale(0.85);
  }

  @override
  Widget build(BuildContext context) {
    final east = _getConf(widget.standings, 'East');
    final west = _getConf(widget.standings, 'West');

    if (east.length < 8 || west.length < 8) return const Center(child: Text('Loading...'));

    const bracketW = boxW * 3 + hGap * 2;
    const centerW = 250.0;
    const totalW = bracketW * 2 + centerW;
    const totalH = (boxH + vGap) * 4 + 60;

    return Container(
      color: Colors.black,
      child: InteractiveViewer(
        transformationController: _controller,
        constrained: false,
        boundaryMargin: const EdgeInsets.symmetric(horizontal: 100, vertical: 200),
        minScale: 0.1,
        maxScale: 2.0,
        child: SizedBox(
          width: totalW,
          height: totalH,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(left: 0, top: 0, bottom: 0, child: _buildConfBracket(east, Colors.blue, false)),
              Positioned(right: 0, top: 0, bottom: 0, child: _buildConfBracket(west, Colors.red, true)),
              Positioned(left: bracketW, width: centerW, top: 0, bottom: 0, child: _buildFinalsCenter(east, west)),
            ],
          ),
        ),
      ),
    );
  }

  List<Standing> _getConf(List<Standing> l, String c) {
    return l.where((s) => s.conference == c).toList()..sort((a, b) => b.winPercentage.compareTo(a.winPercentage));
  }

  Widget _buildConfBracket(List<Standing> teams, Color color, bool isWest) {
    // Robust year detection based on East #1 seed from the json file.
    final east1 = widget.standings.firstWhere((s) => s.conference == 'East', orElse: () => teams[0]);
    final is25_26 = east1.abbreviation == 'DET' && east1.wins == 61;
    final is24_25 = east1.abbreviation == 'DET' && east1.wins == 60;
    final is23_24 = east1.abbreviation == 'BOS' && east1.wins == 64;
    final is22_23 = east1.abbreviation == 'MIL' && east1.wins == 58;

    Standing getTeam(String abbr) {
      return widget.standings.firstWhere((s) => s.abbreviation == abbr, orElse: () => teams[0]);
    }

    List<List<Standing>> r1P = [[teams[0], teams[7]], [teams[3], teams[4]], [teams[2], teams[5]], [teams[1], teams[6]]];
    List<List<String>> s1 = List.generate(4, (_) => ['0', '0']);
    List<List<String>> s2 = List.generate(2, (_) => ['0', '0']);
    List<String> s3 = ['0', '0'];

    if (is25_26) { // 2025/26 - User Image Ongoing
      if (!isWest) {
        r1P = [[getTeam('DET'), getTeam('ORL')], [getTeam('CLE'), getTeam('TOR')], [getTeam('NYK'), getTeam('ATL')], [getTeam('BOS'), getTeam('PHI')]];
        s1 = [['4', '3'], ['4', '3'], ['4', '2'], ['2', '4']]; // DET, CLE, NYK, PHI
        s2 = [['2', '2'], ['4', '0']]; // DET vs CLE (2-2), NYK vs PHI (4-0)
        s3 = ['0', '0']; // TBD vs NYK
      } else {
        r1P = [[getTeam('OKC'), getTeam('PHX')], [getTeam('LAL'), getTeam('HOU')], [getTeam('DEN'), getTeam('MIN')], [getTeam('SAS'), getTeam('POR')]];
        s1 = [['4', '0'], ['4', '2'], ['2', '4'], ['4', '1']]; // OKC, LAL, MIN, SAS
        s2 = [['4', '0'], ['2', '3']]; // OKC vs LAL (4-0), MIN vs SAS (2-3)
        s3 = ['0', '0']; // OKC vs TBD
      }
    } else if (is24_25) { // 2024/25 - HIGH RES IMAGE EXACT MATCH
      if (!isWest) {
        // 1vs8, 4vs5, 3vs6, 2vs7
        r1P = [[getTeam('CLE'), getTeam('MIA')], [getTeam('IND'), getTeam('MIL')], [getTeam('NYK'), getTeam('DET')], [getTeam('BOS'), getTeam('ORL')]];
        s1 = [['4', '0'], ['4', '1'], ['4', '2'], ['4', '1']];
        s2 = [['1', '4'], ['4', '2']]; // CLE vs IND (1-4), NYK vs BOS (4-2)
        s3 = ['4', '2']; // IND vs NYK (4-2)
      } else {
        r1P = [[getTeam('OKC'), getTeam('MEM')], [getTeam('DEN'), getTeam('LAC')], [getTeam('LAL'), getTeam('MIN')], [getTeam('HOU'), getTeam('GSW')]];
        s1 = [['4', '0'], ['4', '3'], ['1', '4'], ['3', '4']]; // OKC 4-0, DEN 4-3, LAL 1-4 MIN, HOU 3-4 GSW
        s2 = [['4', '3'], ['4', '1']]; // OKC vs DEN (4-3), MIN vs GSW (4-1)
        s3 = ['4', '1']; // OKC vs MIN (4-1)
      }
    } else if (is23_24) { // 2023/24 - REAL LIFE RESULTS
      if (!isWest) {
        r1P = [[getTeam('BOS'), getTeam('MIA')], [getTeam('CLE'), getTeam('ORL')], [getTeam('MIL'), getTeam('IND')], [getTeam('NYK'), getTeam('PHI')]];
        s1 = [['4', '1'], ['4', '3'], ['2', '4'], ['4', '2']];
        s2 = [['4', '1'], ['4', '3']]; // BOS vs CLE (4-1), IND vs NYK (4-3)
        s3 = ['4', '0']; // BOS vs IND (4-0)
      } else {
        r1P = [[getTeam('OKC'), getTeam('NOP')], [getTeam('LAC'), getTeam('DAL')], [getTeam('MIN'), getTeam('PHX')], [getTeam('DEN'), getTeam('LAL')]];
        s1 = [['4', '0'], ['2', '4'], ['4', '0'], ['4', '1']];
        s2 = [['2', '4'], ['4', '3']]; // OKC vs DAL (2-4), MIN vs DEN (4-3)
        s3 = ['4', '1']; // DAL vs MIN (4-1)
      }
    } else if (is22_23) { // 2022/23 - REAL LIFE RESULTS
      if (!isWest) {
        r1P = [[getTeam('MIL'), getTeam('MIA')], [getTeam('CLE'), getTeam('NYK')], [getTeam('PHI'), getTeam('BKN')], [getTeam('BOS'), getTeam('ATL')]];
        s1 = [['1', '4'], ['1', '4'], ['4', '0'], ['4', '2']];
        s2 = [['4', '2'], ['3', '4']]; // MIA vs NYK (4-2), PHI vs BOS (3-4)
        s3 = ['4', '3']; // MIA vs BOS (4-3)
      } else {
        r1P = [[getTeam('DEN'), getTeam('MIN')], [getTeam('PHX'), getTeam('LAC')], [getTeam('SAC'), getTeam('GSW')], [getTeam('MEM'), getTeam('LAL')]];
        s1 = [['4', '1'], ['4', '1'], ['3', '4'], ['2', '4']];
        s2 = [['4', '2'], ['2', '4']]; // DEN vs PHX (4-2), GSW vs LAL (2-4)
        s3 = ['4', '0']; // DEN vs LAL (4-0)
      }
    }

    final r2P = [[_getW(r1P[0], s1[0]), _getW(r1P[1], s1[1])], [_getW(r1P[2], s1[2]), _getW(r1P[3], s1[3])]];
    final r3P = [_getW(r2P[0], s2[0]), _getW(r2P[1], s2[1])];

    final c1 = isWest ? 2 : 0;
    final c2 = 1;
    final c3 = isWest ? 0 : 2;

    return SizedBox(
      width: boxW * 3 + hGap * 2,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          _posBox(0 * (boxH + vGap), c1, r1P[0][0], r1P[0][1], s1[0][0], s1[0][1], color),
          _posBox(1 * (boxH + vGap), c1, r1P[1][0], r1P[1][1], s1[1][0], s1[1][1], color),
          _posBox(2 * (boxH + vGap), c1, r1P[2][0], r1P[2][1], s1[2][0], s1[2][1], color),
          _posBox(3 * (boxH + vGap), c1, r1P[3][0], r1P[3][1], s1[3][0], s1[3][1], color),
          _posBox(0.5 * (boxH + vGap), c2, r2P[0][0], r2P[0][1], s2[0][0], s2[0][1], color),
          _posBox(2.5 * (boxH + vGap), c2, r2P[1][0], r2P[1][1], s2[1][0], s2[1][1], color),
          _posBox(1.5 * (boxH + vGap), c3, r3P[0], r3P[1], s3[0], s3[1], color),
          _drawLines(boxH / 2, boxH + vGap, isWest ? 1 : 0, color, isWest),
          _drawLines(2 * (boxH + vGap) + boxH / 2, boxH + vGap, isWest ? 1 : 0, color, isWest),
          _drawLines(0.5 * (boxH + vGap) + boxH / 2, (boxH + vGap) * 2, isWest ? 0 : 1, color, isWest),
        ],
      ),
    );
  }

  Widget _posBox(double t, int c, Standing? tA, Standing? tB, String sA, String sB, Color col) {
    return Positioned(top: t, left: c * (boxW + hGap), child: _MatchBox(tA: tA, tB: tB, sA: sA, sB: sB, color: col));
  }

  Widget _drawLines(double top, double height, int startCol, Color color, bool isWest) {
    final leftPos = (startCol * (boxW + hGap)) + boxW;
    return Positioned(top: top, left: leftPos, child: SizedBox(width: hGap, height: height, child: CustomPaint(painter: _BracketPainter(color: color.withOpacity(0.4), rev: isWest))));
  }

  Widget _buildFinalsCenter(List<Standing> east, List<Standing> west) {
    final east1 = widget.standings.firstWhere((s) => s.conference == 'East', orElse: () => east[0]);
    final is24_25 = east1.abbreviation == 'DET' && east1.wins == 60;
    final is23_24 = east1.abbreviation == 'BOS' && east1.wins == 64;
    final is22_23 = east1.abbreviation == 'MIL' && east1.wins == 58;

    Standing getT(List<Standing> l, String abbr) => l.firstWhere((s) => s.abbreviation == abbr, orElse: () => l[0]);

    Standing? tA, tB;
    String sA = '0', sB = '0';

    if (is24_25) { 
      tA = getT(east, 'IND'); tB = getT(west, 'OKC'); sA = '3'; sB = '4';
    } else if (is23_24) { 
      tA = getT(east, 'BOS'); tB = getT(west, 'DAL'); sA = '4'; sB = '1';
    } else if (is22_23) { 
      tA = getT(east, 'MIA'); tB = getT(west, 'DEN'); sA = '1'; sB = '4';
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.emoji_events, color: Colors.amber, size: 50),
        const Text('NBA FINALS', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 2)),
        const SizedBox(height: 30),
        Container(
          width: 120,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(color: const Color(0xFF111111), borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.amber.withOpacity(0.5))),
          child: Column(
            children: [
              _finalsRow(tA, sA),
              const Padding(padding: EdgeInsets.symmetric(vertical: 8), child: Text('VS', style: TextStyle(color: Colors.amber, fontSize: 18, fontWeight: FontWeight.w900))),
              _finalsRow(tB, sB),
            ],
          ),
        ),
      ],
    );
  }

  Widget _finalsRow(Standing? t, String score) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (t != null) TeamLogo(teamId: t.teamId.toString(), size: 16) else const Icon(Icons.help_outline, size: 16, color: Colors.grey),
        Text(t?.abbreviation ?? 'TBD', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11)),
        Text(t == null ? '' : score, style: const TextStyle(color: Colors.white70, fontWeight: FontWeight.bold, fontSize: 11)),
      ],
    );
  }

  Standing? _getW(List<dynamic> p, List<String> s) {
    if (s[0] == '4') return p[0] as Standing?;
    if (s[1] == '4') return p[1] as Standing?;
    return null;
  }
}

class _BracketPainter extends CustomPainter {
  final Color color; final bool rev;
  _BracketPainter({required this.color, required this.rev});
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = color..style = PaintingStyle.stroke..strokeWidth = 2.0;
    final path = Path(); final w = size.width; final h = size.height;
    if (!rev) {
      path.moveTo(0, 0); path.lineTo(w / 2, 0); path.lineTo(w / 2, h); path.lineTo(0, h);
      path.moveTo(w / 2, h / 2); path.lineTo(w, h / 2);
    } else {
      path.moveTo(w, 0); path.lineTo(w / 2, 0); path.lineTo(w / 2, h); path.lineTo(w, h);
      path.moveTo(w / 2, h / 2); path.lineTo(0, h / 2);
    }
    canvas.drawPath(path, p);
  }
  @override bool shouldRepaint(CustomPainter old) => false;
}

class _MatchBox extends StatelessWidget {
  final Standing? tA, tB; final String sA, sB; final Color color;
  const _MatchBox({this.tA, this.tB, required this.sA, required this.sB, required this.color});
  @override
  Widget build(BuildContext context) {
    final wA = sA == '4'; final wB = sB == '4';
    return Container(
      width: 100, height: 50,
      decoration: BoxDecoration(color: const Color(0xFF1A1A1A), borderRadius: BorderRadius.circular(4), border: Border.all(color: (wA || wB) ? color : Colors.white.withOpacity(0.1))),
      child: Column(
        children: [
          _row(context, tA, sA, wA),
          Container(height: 1, color: Colors.white.withOpacity(0.05)),
          _row(context, tB, sB, wB),
        ],
      ),
    );
  }
  Widget _row(BuildContext context, Standing? t, String s, bool w) {
    return Expanded(
      child: InkWell(
        onTap: t == null ? null : () => Navigator.push(context, MaterialPageRoute(builder: (c) => TeamDetailScreen(teamId: t.teamId.toString()))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6),
          child: Row(
            children: [
              if (t != null) TeamLogo(teamId: t.teamId.toString(), size: 14) else const Icon(Icons.help_outline, size: 12, color: Colors.white10),
              const SizedBox(width: 4),
              Expanded(child: Text(t?.abbreviation ?? 'TBD', style: TextStyle(color: t == null ? Colors.white10 : (w ? Colors.white : Colors.white60), fontSize: 9, fontWeight: w ? FontWeight.bold : FontWeight.w500), overflow: TextOverflow.ellipsis)),
              Text(t == null ? '' : s, style: TextStyle(color: w ? color.withOpacity(0.8) : Colors.white24, fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}

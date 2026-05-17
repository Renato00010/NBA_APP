import 'package:flutter/material.dart';
import '../../main.dart';
import '../../services/ticket_service.dart';

bool _isEnglish(BuildContext context) =>
    Localizations.localeOf(context).languageCode == 'en';

String _t(BuildContext context, String pt, String en) =>
    _isEnglish(context) ? en : pt;

class GameDetailScreen extends StatefulWidget {
  final String gameId;
  final String homeName;
  final String awayName;

  const GameDetailScreen({
    super.key,
    required this.gameId,
    required this.homeName,
    required this.awayName,
  });

  @override
  State<GameDetailScreen> createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> {
  Map<String, dynamic>? _summary;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadSummary();
  }

  Future<void> _loadSummary() async {
    try {
      final data = await repository.getGameSummary(widget.gameId);
      if (mounted) {
        setState(() {
          _summary = data;
          _loading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _loading = false);
      }
    }
  }

  String _getTvChannels() {
    if (_summary == null) return 'N/A';
    final broadcasts = _summary!['broadcasts'] as List<dynamic>? ?? [];
    if (broadcasts.isEmpty) return 'N/A';
    final names = broadcasts[0]['names'] as List<dynamic>? ?? [];
    if (names.isEmpty) return 'N/A';
    return names.join(', ');
  }

  String _getVenue() {
    if (_summary == null) return 'N/A';
    final venue = _summary!['gameInfo']?['venue'];
    if (venue == null) return 'N/A';

    final name = venue['fullName']?.toString() ?? '';
    final city = venue['address']?['city']?.toString() ?? '';

    if (name.isNotEmpty && city.isNotEmpty) {
      return '$name, $city';
    } else if (name.isNotEmpty) {
      return name;
    } else if (city.isNotEmpty) {
      return city;
    }
    return 'N/A';
  }

  Widget _buildScoreHeader() {
    if (_summary == null) return const SizedBox();
    final header = _summary!['header'];
    if (header == null) return const SizedBox();
    final comps = header['competitions'] as List<dynamic>? ?? [];
    if (comps.isEmpty) return const SizedBox();
    final competitors = comps[0]['competitors'] as List<dynamic>? ?? [];
    if (competitors.length < 2) return const SizedBox();

    Map<String, dynamic>? home;
    Map<String, dynamic>? away;

    for (final c in competitors) {
      if (c['homeAway'] == 'home') home = c;
      if (c['homeAway'] == 'away') away = c;
    }

    if (home == null || away == null) return const SizedBox();

    final status = comps[0]['status']?['type']?['detail'] ?? '';

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF151515),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Away Team
          Expanded(child: _buildTeamColumn(away)),
          // Score & Status
          Column(
            children: [
              Text(
                '${away['score'] ?? '0'} - ${home['score'] ?? '0'}',
                style: const TextStyle(
                  color: Color(0xFFFFB800), // Yellow/Orange
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                status,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          // Home Team
          Expanded(child: _buildTeamColumn(home)),
        ],
      ),
    );
  }

  Widget _buildTeamColumn(Map<String, dynamic> competitor) {
    final team = competitor['team'] ?? {};
    final logos = team['logos'] as List<dynamic>? ?? [];
    final logoUrl = logos.isNotEmpty ? logos[0]['href'] : '';
    final location = team['location'] ?? '';
    final name = team['name'] ?? '';

    return Column(
      children: [
        if (logoUrl.isNotEmpty)
          Image.network(
            logoUrl,
            height: 48,
            width: 48,
            errorBuilder: (_, __, ___) => const Icon(
              Icons.sports_basketball,
              color: Colors.white54,
              size: 48,
            ),
          )
        else
          const Icon(Icons.sports_basketball, color: Colors.white54, size: 48),
        const SizedBox(height: 8),
        Text(
          location,
          style: const TextStyle(
            color: Colors.white54,
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        Text(
          name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  double _americanToDecimal(dynamic moneyLine) {
    if (moneyLine == null) return 0.0;
    double value = double.tryParse(moneyLine.toString()) ?? 0.0;
    if (value == 0) return 0.0;
    if (value > 0) {
      return (value / 100) + 1.0;
    } else {
      return (100 / value.abs()) + 1.0;
    }
  }

  Widget _buildOddsSection() {
    if (_summary == null) return const SizedBox.shrink();
    final pickcenter = _summary!['pickcenter'] as List<dynamic>? ?? [];
    if (pickcenter.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(child: SizedBox()),
            const SizedBox(
              width: 80,
              child: Text(
                '1',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 8),
            const SizedBox(
              width: 80,
              child: Text(
                '2',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ...pickcenter.map((pick) {
          final providerName = pick['provider']?['name'] ?? 'Provider';

          final homeMoneyLine = pick['homeTeamOdds']?['moneyLine'];
          final awayMoneyLine = pick['awayTeamOdds']?['moneyLine'];

          final homeDecVal = _americanToDecimal(homeMoneyLine);
          final awayDecVal = _americanToDecimal(awayMoneyLine);

          final homeDec = homeDecVal.toStringAsFixed(2);
          final awayDec = awayDecVal.toStringAsFixed(2);

          final homeIsFavorite = homeDecVal <= awayDecVal;

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    providerName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                _buildOddButton(homeDec, homeIsFavorite),
                const SizedBox(width: 8),
                _buildOddButton(awayDec, !homeIsFavorite),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  Widget _buildOddButton(String odds, bool isFavorite) {
    return Container(
      width: 80,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: isFavorite ? Colors.transparent : const Color(0xFFFFC040),
        border: Border.all(
          color: isFavorite ? Colors.white38 : const Color(0xFFFFC040),
        ),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(
          odds == '0.00' ? '-' : odds,
          style: TextStyle(
            color: isFavorite ? Colors.white : Colors.black,
            fontWeight: FontWeight.w800,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  // Returns a list of all players, sorted by points descending
  List<Map<String, String>> _getTopPerformers() {
    if (_summary == null) return [];
    final boxscore = _summary!['boxscore'];
    if (boxscore == null) return [];
    final playersData = boxscore['players'] as List<dynamic>? ?? [];
    if (playersData.isEmpty) return [];
    List<Map<String, String>> stats = [];
    for (final teamData in playersData) {
      final teamName = teamData['team']?['displayName'] ?? '';
      final statsList = teamData['statistics'] as List<dynamic>? ?? [];
      if (statsList.isEmpty) continue;
      final names = statsList[0]['names'] as List<dynamic>? ?? [];
      final ptsIdx = names.indexOf('PTS');
      final rebIdx = names.indexOf('REB');
      final astIdx = names.indexOf('AST');
      final athletes = statsList[0]['athletes'] as List<dynamic>? ?? [];
      for (final a in athletes) {
        final athleteName = a['athlete']?['displayName'] ?? '';
        final statVals = a['stats'] as List<dynamic>? ?? [];
        int pts = ptsIdx != -1 && ptsIdx < statVals.length
            ? int.tryParse(statVals[ptsIdx].toString()) ?? 0
            : 0;
        int reb = rebIdx != -1 && rebIdx < statVals.length
            ? int.tryParse(statVals[rebIdx].toString()) ?? 0
            : 0;
        int ast = astIdx != -1 && astIdx < statVals.length
            ? int.tryParse(statVals[astIdx].toString()) ?? 0
            : 0;
        stats.add({
          'title': '',
          'player': athleteName,
          'team': teamName,
          'value': '${pts} PTS | ${reb} REB | ${ast} AST',
        });
      }
    }
    // Sort descending by points (extract pts from value string)
    stats.sort((a, b) {
      int ptsA = int.tryParse(a['value']?.split(' ')[0] ?? '0') ?? 0;
      int ptsB = int.tryParse(b['value']?.split(' ')[0] ?? '0') ?? 0;
      return ptsB.compareTo(ptsA);
    });
    return stats;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        title: const SizedBox.shrink(),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Custom Game Result Header
                  _buildScoreHeader(),
                  const SizedBox(height: 24),
                  // Buy Ticket Button
                  _buildBuyTicketButton(),
                  const SizedBox(height: 24),
                  // TV Channel info
                  _buildInfoRow('TV', _getTvChannels()),
                  const SizedBox(height: 8),
                  // Venue info
                  _buildInfoRow(_t(context, 'Local', 'Venue'), _getVenue()),
                  const SizedBox(height: 8),
                  // Odds list
                  _buildOddsSection(),
                  const SizedBox(height: 24),
                  Text(
                    _t(context, 'JOGADORES', 'PLAYERS'),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 12),
                  // Player cards sorted by points
                  ..._getTopPerformers()
                      .map((player) => _buildPlayerCard(player))
                      .toList(),
                ],
              ),
            ),
    );
  }

  // Compact row for TV and Odds
  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // Compact player card
  Widget _buildPlayerCard(Map<String, String> player) {
    return Container(
      margin: const EdgeInsets.only(bottom: 6),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF151515),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  player['player'] ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  player['team'] ?? '',
                  style: const TextStyle(color: Colors.white38, fontSize: 11),
                ),
              ],
            ),
          ),
          Text(
            player['value'] ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBuyTicketButton() {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [theme.colorScheme.primary, theme.colorScheme.secondary],
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _handleBuyTicket,
          borderRadius: BorderRadius.circular(16),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.confirmation_number_outlined,
                  color: Colors.white,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  _t(context, 'COMPRAR BILHETE', 'BUY TICKET'),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleBuyTicket() async {
    try {
      final venue = _getVenue();
      final date = DateTime.now().toString().split(' ')[0];
      final time = '19:00';

      await TicketService.generateAndPrintTicket(
        gameId: widget.gameId,
        homeTeam: widget.homeName,
        awayTeam: widget.awayName,
        venue: venue,
        date: date,
        time: time,
        languageCode: Localizations.localeOf(context).languageCode,
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${_t(context, 'Erro ao gerar bilhete', 'Error generating ticket')}: $e',
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildLeaderCard(Map<String, String> leader, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A1A),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.colorScheme.primary.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                leader['title']!,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                leader['player']!,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                leader['team']!,
                style: const TextStyle(color: Colors.white38, fontSize: 12),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              leader['value']!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

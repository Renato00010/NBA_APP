import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';
import '../../services/youtube_highlights_service.dart';
import '../../services/ticket_service.dart';
import '../../services/email_simulation_service.dart';
import '../../services/ai_assistant_service.dart';
import '../../services/preferences_format_service.dart';
import '../../utils/game_status_utils.dart';
import '../../widgets/basketball_loader.dart';
import '../../widgets/live_game_clock.dart';

bool _isEnglish(BuildContext context) =>
    Localizations.localeOf(context).languageCode == 'en';

String _t(BuildContext context, String pt, String en) =>
    _isEnglish(context) ? en : pt;

// Added HighlightStatus enum to represent the loading state of highlights
enum HighlightStatus { loading, available, unavailable, error }

class GameDetailScreen extends StatefulWidget {
  final String gameId;
  final String homeName;
  final String awayName;
  final DateTime? gameDate;

  const GameDetailScreen({
    super.key,
    required this.gameId,
    required this.homeName,
    required this.awayName,
    this.gameDate,
  });

  @override
  State<GameDetailScreen> createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> {
  Map<String, dynamic>? _summary;
  bool _loading = true;
  // Highlight handling
  HighlightStatus _highlightStatus = HighlightStatus.loading;
  HighlightVideo? _highlightVideo;
  bool _showPlayer = false; // toggles thumbnail → player
  bool _loadingSummary = false;
  Timer? _liveRefreshTimer;

  // AI Hype analysis fields
  Map<String, dynamic>? _hypeData;
  bool _loadingHype = true;
  String? _hypeError;

  @override
  void initState() {
    super.initState();
    _loadSummary();
    _loadHighlights();
    _loadMatchupHype();
    _liveRefreshTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (_shouldAutoRefreshSummary) {
        _loadSummary();
      }
    });
  }

  @override
  void dispose() {
    _liveRefreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadHighlights() async {
    try {
      final highlight = await YoutubeHighlightsService().findGameHighlights(
        widget.homeName,
        widget.awayName,
      );
      if (mounted) {
        setState(() {
          if (highlight != null) {
            _highlightVideo = highlight;
            _highlightStatus = HighlightStatus.available;
          } else {
            _highlightStatus = HighlightStatus.unavailable;
          }
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() => _highlightStatus = HighlightStatus.error);
      }
    }
  }

  Future<void> _loadSummary() async {
    if (_loadingSummary) return;
    _loadingSummary = true;
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
    } finally {
      _loadingSummary = false;
    }
  }

  Future<void> _loadMatchupHype() async {
    if (!mounted) return;
    setState(() {
      _loadingHype = true;
      _hypeError = null;
    });
    try {
      final lang = Localizations.localeOf(context).languageCode;
      final data = await AiAssistantService.generateMatchupHype(
        homeTeam: widget.homeName,
        awayTeam: widget.awayName,
        languageCode: lang,
      );
      if (mounted) {
        setState(() {
          _hypeData = data;
          _loadingHype = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _hypeError = e.toString();
          _loadingHype = false;
        });
      }
    }
  }

  Widget _buildHypePanel() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF151515),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header with AI Icon and Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.psychology_outlined,
                          color: Color(0xFFFFB800),
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _t(context, 'ANALISADOR DE HYPE IA', 'AI HYPE ANALYZER'),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF3F51B5), Color(0xFFE91E63)],
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'GEMINI FLASH',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                if (_loadingHype) ...[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Column(
                        children: [
                          const SizedBox(
                            width: 32,
                            height: 32,
                            child: CircularProgressIndicator(
                              strokeWidth: 3,
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFFB800)),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _t(context, 'A processar histórico do duelo...', 'Processing matchup history...'),
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ] else if (_hypeError != null) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          _t(context, 'Erro ao carregar dados da IA.', 'Error loading AI analysis.'),
                          style: const TextStyle(color: Colors.redAccent, fontSize: 13),
                        ),
                      ),
                      TextButton(
                        onPressed: _loadMatchupHype,
                        child: Text(
                          _t(context, 'Tentar Novamente', 'Retry'),
                          style: const TextStyle(color: Color(0xFFFFB800), fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ] else if (_hypeData != null) ...[
                  // Visual Hype Meter Gauges
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Arched Hype Meter
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.bottomCenter,
                              children: [
                                CustomPaint(
                                  size: const Size(120, 65),
                                  painter: _HypeGaugePainter((_hypeData!['hypeIndex'] as num).toDouble()),
                                ),
                                Positioned(
                                  bottom: 2,
                                  child: Column(
                                    children: [
                                      Text(
                                        '${_hypeData!['hypeIndex']}%',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Text(
                                        _hypeData!['hypeIndex'] >= 90
                                            ? _t(context, 'FOGO LOUCO', 'INSANE FIRE')
                                            : _hypeData!['hypeIndex'] >= 75
                                                ? _t(context, 'HYPE ALTO', 'HIGH HYPE')
                                                : _t(context, 'HYPE MODERADO', 'MID HYPE'),
                                        style: TextStyle(
                                          color: _hypeData!['hypeIndex'] >= 90
                                              ? Colors.redAccent
                                              : _hypeData!['hypeIndex'] >= 75
                                                  ? Colors.orange
                                                  : Colors.blueAccent,
                                          fontSize: 8,
                                          fontWeight: FontWeight.w900,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _t(context, 'HYPE METER', 'HYPE GAUGE'),
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Divider
                      Container(
                        height: 70,
                        width: 1,
                        color: Colors.white10,
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                      ),
                      // Linear Rivalry Bar
                      Expanded(
                        flex: 6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _t(context, 'RIVALIDADE', 'RIVALRY SCORE'),
                                  style: const TextStyle(
                                    color: Colors.white54,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                                Text(
                                  '${_hypeData!['rivalryScore']}/100',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            // Gradient linear indicator
                            Container(
                              height: 10,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white10,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: (_hypeData!['rivalryScore'] as num) / 100,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [Colors.blue, Colors.purple, Colors.red],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _hypeData!['rivalryScore'] >= 90
                                                          ? _t(context, 'INIMIGOS MORTAIS', 'LEGENDARY RIVALS')
                                                          : _hypeData!['rivalryScore'] >= 70
                                                              ? _t(context, 'CONFRONTO QUENTE', 'HEATED MATCHUP')
                                                              : _t(context, 'COMPETIÇÃO PADRÃO', 'STANDARD MATCHUP'),
                              style: const TextStyle(
                                color: Colors.white38,
                                fontSize: 9,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: Colors.white10),
                  const SizedBox(height: 12),

                  // Duel Title
                  Text(
                    _hypeData!['title'] ?? '',
                    style: const TextStyle(
                      color: Color(0xFFFFB800),
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Duel Analysis
                  Text(
                    _hypeData!['analysis'] ?? '',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 13,
                      height: 1.4,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Prediction Box
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFB800).withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFFFB800).withValues(alpha: 0.2)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.auto_awesome, color: Color(0xFFFFB800), size: 16),
                            const SizedBox(width: 6),
                            Text(
                              _t(context, 'PREVISÃO DA INTELIGÊNCIA ARTIFICIAL', 'AI MATCHUP PREDICTION'),
                              style: const TextStyle(
                                color: Color(0xFFFFB800),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _hypeData!['prediction'] ?? '',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            height: 1.4,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool get _shouldAutoRefreshSummary {
    final status = _summary?['header']?['competitions']?[0]?['status']?['type'];
    final detail = status?['detail']?.toString() ?? '';
    final state = status?['state']?.toString().toLowerCase() ?? '';
    if (state == 'post' || GameStatusUtils.isFinal(detail)) return false;
    return true;
  }

  DateTime? get _gameStartTime {
    final providedDate = widget.gameDate;
    if (providedDate != null) return providedDate;

    final competitions =
        _summary?['header']?['competitions'] as List<dynamic>? ?? [];
    if (competitions.isEmpty) return null;

    final rawDate = competitions.first['date']?.toString();
    if (rawDate == null || rawDate.isEmpty) return null;
    return DateTime.tryParse(rawDate)?.toLocal();
  }

  bool get _isGameAlreadyUnavailable {
    final status = _summary?['header']?['competitions']?[0]?['status']?['type'];
    final detail = status?['detail']?.toString() ?? '';
    final state = status?['state']?.toString().toLowerCase() ?? '';
    if (state == 'post' || GameStatusUtils.isFinal(detail)) return true;

    final start = _gameStartTime;
    return start != null && !start.isAfter(DateTime.now());
  }

  bool get _isTicketSoldOut {
    final start = _gameStartTime;
    if (start == null || _isGameAlreadyUnavailable) return false;
    final timeUntilGame = start.difference(DateTime.now());
    return timeUntilGame <= const Duration(hours: 8);
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
      child: Column(
        children: [
          Row(
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
                  LiveGameClock(
                    status: status,
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
          // Insert the highlight card inside the score header only when appropriate
          _buildHighlightsCard(),
        ],
      ),
    );
  }

  Widget _buildHighlightsCard() {
    bool shouldShowHighlightCard() {
      // Show only when the game is finished (post)
      final status = _summary?['header']?['competitions']?[0]?['status']?['type'];
      final detail = status?['detail']?.toString() ?? '';
      final state = status?['state']?.toString().toLowerCase() ?? '';
      return state == 'post' || GameStatusUtils.isFinal(detail);
    }

    if (!shouldShowHighlightCard()) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _t(context, 'DESTAQUES DA PARTIDA', 'GAME HIGHLIGHTS'),
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 12),
                if (_showPlayer && _highlightVideo != null)
                  // Show the embedded player when user taps thumbnail
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: _InlineYoutubePlayer(
                      videoId: _highlightVideo!.videoId,
                      thumbnailUrl: _highlightVideo!.thumbnailUrl,
                    ),
                  )
                else if (_highlightVideo != null)
                  // Show thumbnail with play overlay
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: GestureDetector(
                      onTap: () {
                        setState(() => _showPlayer = true);
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Positioned.fill(
                            child: CachedNetworkImage(
                              imageUrl: _highlightVideo!.thumbnailUrl,
                              fit: BoxFit.cover,
                              placeholder: (c, u) => const Center(child: CircularProgressIndicator()),
                              errorWidget: (c, u, e) => const Icon(Icons.videocam_off, color: Colors.white38, size: 48),
                            ),
                          ),
                          const Icon(Icons.play_circle_filled, size: 64, color: Colors.white70),
                        ],
                      ),
                    ),
                  )
                else
                  // Loading / unavailable state
                  _HighlightLoadingState(
                    thumbnailUrl: 'https://images.unsplash.com/photo-1546519638-68e109498ffc?q=80&w=400',
                    text: _highlightStatus == HighlightStatus.loading
                        ? _t(context, 'A procurar video...', 'Finding video...')
                        : _t(context, 'Highlight indisponível', 'Highlight unavailable'),
                    onOpenSearch: _highlightStatus == HighlightStatus.unavailable ? _openHighlightSearch : null,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
// Duplicate highlights block removed - original UI handled by _buildHighlightsCard()

  Future<void> _openHighlightSearch() async {
    final url = YoutubeHighlightsService().searchUrl(
      widget.homeName,
      widget.awayName,
    );
    await launchUrl(Uri.parse(url), webOnlyWindowName: '_blank');
  }

  Widget _buildTeamColumn(Map<String, dynamic> competitor) {
    final team = competitor['team'] ?? {};
    final logos = team['logos'] as List<dynamic>? ?? [];
    final logoUrl = logos.isNotEmpty ? logos[0]['href'] : '';
    final location = team['location'] ?? '';
    final name = team['name'] ?? '';

    final teamId = team['id']?.toString() ?? '';
    Widget logoWidget;

    if (logoUrl.isNotEmpty) {
      logoWidget = Image.network(
        logoUrl,
        height: 48,
        width: 48,
        errorBuilder: (context, error, stackTrace) => const Icon(
          Icons.sports_basketball,
          color: Colors.white54,
          size: 48,
        ),
      );
    } else {
      logoWidget = const Icon(
        Icons.sports_basketball,
        color: Colors.white54,
        size: 48,
      );
    }

    if (teamId.isNotEmpty) {
      logoWidget = Hero(
        tag: 'game_${widget.gameId}_$teamId',
        child: logoWidget,
      );
    }

    return Column(
      children: [
        logoWidget,
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
        }),
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
          'value': '$pts PTS | $reb REB | $ast AST',
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
          ? const Center(child: BasketballLoader())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Custom Game Result Header
                  _buildScoreHeader(),
                  _buildHypePanel(),
                  const SizedBox(height: 24),
                  if (!_isGameAlreadyUnavailable) ...[
                    _buildBuyTicketButton(),
                    const SizedBox(height: 24),
                  ],
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
                  ..._getTopPerformers().map(
                    (player) => _buildPlayerCard(player),
                  ),
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
            color: theme.colorScheme.primary.withValues(alpha: 0.3),
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
    if (_isTicketSoldOut) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_t(context, 'Esgotado', 'Sold out')),
          backgroundColor: Colors.orange.shade800,
        ),
      );
      return;
    }

    final venue = _getVenue();
    final start = _gameStartTime ?? DateTime.now();
    final date = _formatTicketDate(start);
    final time = _formatTicketTime(start);

    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _SeatingSelectorDialog(
        gameId: widget.gameId,
        homeTeam: widget.homeName,
        awayTeam: widget.awayName,
        venue: venue,
        date: date,
        time: time,
      ),
    );
  }

  String _formatTicketDate(DateTime value) {
    final day = value.day.toString().padLeft(2, '0');
    final month = value.month.toString().padLeft(2, '0');
    return '$day/$month/${value.year}';
  }

  String _formatTicketTime(DateTime value) {
    final hour = value.hour.toString().padLeft(2, '0');
    final minute = value.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}

class _InlineYoutubePlayer extends StatefulWidget {
  final String videoId;
  final String thumbnailUrl;

  const _InlineYoutubePlayer({
    required this.videoId,
    required this.thumbnailUrl,
  });

  @override
  State<_InlineYoutubePlayer> createState() => _InlineYoutubePlayerState();
}

class _InlineYoutubePlayerState extends State<_InlineYoutubePlayer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.videoId,
      autoPlay: false,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      aspectRatio: 16 / 9,
    );
  }
}

class _HighlightLoadingState extends StatelessWidget {
  final String thumbnailUrl;
  final String text;
  final VoidCallback? onOpenSearch;

  const _HighlightLoadingState({
    required this.thumbnailUrl,
    required this.text,
    this.onOpenSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 120,
          height: 68,
          child: _YoutubePoster(thumbnailUrl: thumbnailUrl),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (onOpenSearch != null) ...[
                const SizedBox(height: 8),
                TextButton.icon(
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFFFFC72C),
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 32),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: onOpenSearch,
                  icon: const Icon(Icons.open_in_new, size: 16),
                  label: const Text(
                    'Procurar no YouTube',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _YoutubePoster extends StatelessWidget {
  final String thumbnailUrl;

  const _YoutubePoster({required this.thumbnailUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: CachedNetworkImage(
            imageUrl: thumbnailUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(color: Colors.black26),
            errorWidget: (context, url, error) => Container(
              color: Colors.black26,
              child: const Icon(
                Icons.play_circle_outline,
                color: Colors.white24,
                size: 30,
              ),
            ),
          ),
        ),
        Container(
          width: 44,
          height: 30,
          decoration: BoxDecoration(
            color: const Color(0xFFFF0000),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Icon(Icons.play_arrow, color: Colors.white, size: 20),
        ),
      ],
    );
  }
}

class _HypeGaugePainter extends CustomPainter {
  final double score;
  _HypeGaugePainter(this.score);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = size.width / 2 - 8;
    final rect = Rect.fromCircle(center: center, radius: radius);

    final bgPaint = Paint()
      ..color = Colors.white10
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, 3.14159, 3.14159, false, bgPaint);

    final gradient = const SweepGradient(
      colors: [Colors.blue, Colors.orange, Colors.red],
      startAngle: 3.14159,
      endAngle: 2 * 3.14159,
    );
    final activePaint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12
      ..strokeCap = StrokeCap.round;
    
    final sweepAngle = (score / 100) * 3.14159;
    canvas.drawArc(rect, 3.14159, sweepAngle.clamp(0.0, 3.14159), false, activePaint);
  }

  @override
  bool shouldRepaint(covariant _HypeGaugePainter oldDelegate) => oldDelegate.score != score;
}

class _SeatingSelectorDialog extends StatefulWidget {
  final String gameId;
  final String homeTeam;
  final String awayTeam;
  final String venue;
  final String date;
  final String time;

  const _SeatingSelectorDialog({
    required this.gameId,
    required this.homeTeam,
    required this.awayTeam,
    required this.venue,
    required this.date,
    required this.time,
  });

  @override
  State<_SeatingSelectorDialog> createState() => _SeatingSelectorDialogState();
}

class _SeatingSelectorDialogState extends State<_SeatingSelectorDialog> {
  int _selectedSectorIndex = -1;
  bool _isProcessing = false;

  final List<Map<String, dynamic>> _sectors = [
    {
      'index': 0,
      'namePt': 'VIP Courtside',
      'nameEn': 'VIP Courtside',
      'price': 250.00,
      'color': const Color(0xFFFFD700), // Gold
      'code': 'VIP',
    },
    {
      'index': 1,
      'namePt': 'Lower Bowl Central',
      'nameEn': 'Lower Bowl Central',
      'price': 120.00,
      'color': const Color(0xFFFF8C00), // Orange
      'code': 'LBC',
    },
    {
      'index': 2,
      'namePt': 'Bancada Inferior (Tabelas)',
      'nameEn': 'Lower Bowl Behind Baskets',
      'price': 80.00,
      'color': const Color(0xFFFF4500), // Red-Orange
      'code': 'LBB',
    },
    {
      'index': 3,
      'namePt': 'Bancada Superior Central',
      'nameEn': 'Upper Deck Central',
      'price': 45.00,
      'color': const Color(0xFF1E90FF), // Dodger Blue
      'code': 'UDC',
    },
    {
      'index': 4,
      'namePt': 'Cantos Superiores',
      'nameEn': 'Upper Deck Corners',
      'price': 30.00,
      'color': const Color(0xFF9E9E9E), // Grey
      'code': 'UDC-C',
    },
  ];

  bool get _isEn => Localizations.localeOf(context).languageCode == 'en';
  String _t(String pt, String en) => _isEn ? en : pt;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedSector = _selectedSectorIndex != -1 ? _sectors[_selectedSectorIndex] : null;

    return StreamBuilder(
      stream: database.preferencesDao.watchPreferences(),
      builder: (context, snapshot) {
        final currencyCode = snapshot.data?.currencyCode ?? 'EUR';

        return Dialog(
          backgroundColor: const Color(0xFF121212),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
            side: const BorderSide(color: Colors.white10),
          ),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 480),
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Dialog Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _t('SELETOR DE ASSENTOS', 'ARENA SEATING SELECTOR'),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          letterSpacing: 1.0,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white54),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _t(
                      'Selecione a zona desejada no pavilhão para reservar o seu assento.',
                      'Select the desired area in the arena to reserve your seat.',
                    ),
                    style: const TextStyle(color: Colors.white54, fontSize: 11),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),

                  // Arena Map Visualization
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.white.withValues(alpha: 0.03)),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Upper Deck Central (Top side)
                        _buildSectorCard(3, currencyCode),
                        const SizedBox(height: 8),
                        
                        Row(
                          children: [
                            // Left Corners
                            Expanded(child: _buildSectorCard(4, currencyCode, labelSide: 'L')),
                            const SizedBox(width: 8),
                            // Behind Baskets Left
                            Expanded(child: _buildSectorCard(2, currencyCode, labelSide: 'L')),
                            const SizedBox(width: 8),
                            // Basketball Court in center
                            _buildCourtMini(),
                            const SizedBox(width: 8),
                            // Behind Baskets Right
                            Expanded(child: _buildSectorCard(2, currencyCode, labelSide: 'R')),
                            const SizedBox(width: 8),
                            // Right Corners
                            Expanded(child: _buildSectorCard(4, currencyCode, labelSide: 'R')),
                          ],
                        ),
                        
                        const SizedBox(height: 8),
                        
                        // Bottom row (VIP Courtside & Lower Bowl Central)
                        Row(
                          children: [
                            Expanded(child: _buildSectorCard(1, currencyCode)),
                            const SizedBox(width: 8),
                            Expanded(child: _buildSectorCard(0, currencyCode)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Selected Seat Details Block
                  if (selectedSector != null) ...[
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      decoration: BoxDecoration(
                        color: (selectedSector['color'] as Color).withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: (selectedSector['color'] as Color).withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _t('ZONA SELECIONADA', 'SELECTED SECTOR'),
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                _t(selectedSector['namePt'], selectedSector['nameEn']),
                                style: TextStyle(
                                  color: selectedSector['color'] as Color,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                _t('PREÇO DO BILHETE', 'TICKET PRICE'),
                                style: const TextStyle(
                                  color: Colors.white54,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                PreferencesFormatService.formatCurrency(
                                  selectedSector['price'],
                                  currencyCode: currencyCode,
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // Action Button
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: selectedSector != null && !_isProcessing
                              ? [theme.colorScheme.primary, theme.colorScheme.secondary]
                              : [Colors.grey.shade800, Colors.grey.shade900],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: selectedSector != null && !_isProcessing
                            ? [
                                BoxShadow(
                                  color: theme.colorScheme.primary.withValues(alpha: 0.3),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ]
                            : null,
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        onPressed: selectedSector != null && !_isProcessing
                            ? () => _processSeatSelection(selectedSector)
                            : null,
                        child: _isProcessing
                            ? const SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2.5,
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(Icons.confirmation_number, color: Colors.white, size: 20),
                                  const SizedBox(width: 8),
                                  Text(
                                    _t('RESERVAR E EMITIR BILHETE', 'BOOK & ISSUE TICKET'),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 13,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCourtMini() {
    return Container(
      width: 70,
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFF1B5E20), // deep green
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: Colors.white30, width: 1.5),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.sports_basketball, color: Colors.white54, size: 14),
            const SizedBox(height: 2),
            Text(
              _t('CAMPO', 'COURT'),
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 7,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectorCard(int index, String currencyCode, {String? labelSide}) {
    final sector = _sectors[index];
    final isSelected = _selectedSectorIndex == index;
    final color = sector['color'] as Color;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedSectorIndex = index;
          });
        },
        borderRadius: BorderRadius.circular(10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
          decoration: BoxDecoration(
            color: isSelected ? color.withValues(alpha: 0.15) : Colors.white.withValues(alpha: 0.02),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: isSelected ? color : Colors.white.withValues(alpha: 0.08),
              width: isSelected ? 2 : 1.0,
            ),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: color.withValues(alpha: 0.25),
                      blurRadius: 8,
                      spreadRadius: 1,
                    )
                  ]
                : null,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${sector['code']}${labelSide ?? ''}',
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.white70,
                  fontSize: 10,
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                PreferencesFormatService.formatCurrency(
                  sector['price'],
                  currencyCode: currencyCode,
                ),
                style: TextStyle(
                  color: isSelected ? color : Colors.white38,
                  fontSize: 8.5,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _processSeatSelection(Map<String, dynamic> sector) async {
    setState(() {
      _isProcessing = true;
    });

    try {
      // Generate row and seat randomly but in a structured realistic manner
      final random = DateTime.now().millisecondsSinceEpoch;
      final row = String.fromCharCode(65 + (random % 12)); // Fila A até L
      final seat = ((random % 24) + 1).toString(); // Assento 1 até 24

      final sectorNamePt = sector['namePt'];
      final sectorNameEn = sector['nameEn'];
      final sectorLabel = _t(sectorNamePt, sectorNameEn);

      final pdfBytes = await TicketService.generateAndPrintTicket(
        gameId: widget.gameId,
        homeTeam: widget.homeTeam,
        awayTeam: widget.awayTeam,
        venue: widget.venue,
        date: widget.date,
        time: widget.time,
        sector: sectorLabel,
        row: row,
        seat: seat,
        languageCode: Localizations.localeOf(context).languageCode,
      );

      if (mounted) {
        Navigator.of(context).pop(); // Close dialog

        final isEnglish = Localizations.localeOf(context).languageCode == 'en';
        await EmailSimulationService.showEmailPrompt(
          context: context,
          documentName: isEnglish ? 'NBA_Ticket_${widget.gameId}.pdf' : 'Bilhete_NBA_${widget.gameId}.pdf',
          documentTypePt: 'Bilhete de Jogo (Lugar $sectorLabel, Fila $row, Assento $seat)',
          documentTypeEn: 'Game Ticket (Seat $sectorLabel, Row $row, Seat $seat)',
          pdfBytes: pdfBytes,
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isProcessing = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(_t('Erro ao reservar assento: ', 'Error booking seat: ') + e.toString()),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}

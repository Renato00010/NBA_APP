import 'package:flutter/material.dart';
import 'basket_grid_screen.dart';
import 'fantasy_draft_screen.dart';
import 'nba_trivia_screen.dart';

class PlaygroundHubScreen extends StatefulWidget {
  const PlaygroundHubScreen({super.key});

  @override
  State<PlaygroundHubScreen> createState() => _PlaygroundHubScreenState();
}

class _PlaygroundHubScreenState extends State<PlaygroundHubScreen> {
  int _fanXp = 450; // Dynamic local XP for the session

  void _addXp(int xp) {
    setState(() {
      _fanXp += xp;
    });
  }

  bool _isEnglish(BuildContext context) =>
      Localizations.localeOf(context).languageCode == 'en';

  String _t(String pt, String en) => _isEnglish(context) ? en : pt;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          _t('ZONA PLAYGROUND', 'PLAYGROUND ZONE'),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.5,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Fan XP Banner
            _buildXpBanner(theme),
            const SizedBox(height: 28),

            Text(
              _t('JOGOS DISPONÍVEIS', 'AVAILABLE GAMES'),
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
                fontWeight: FontWeight.w900,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 16),

            // Game Cards
            _buildGameCard(
              title: _t('BASKET GRID', 'BASKET GRID'),
              subtitle: _t(
                'O clássico Tic-Tac-Toe de crossovers. Encontra os jogadores comuns!',
                'The classic crossover Tic-Tac-Toe. Find the common players!',
              ),
              icon: Icons.grid_on_outlined,
              colors: [const Color(0xFFFF8C00), const Color(0xFFFF2D55)],
              xpReward: '+150 XP',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BasketGridScreen(
                      onGameCompleted: (score) => _addXp(score * 20),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),

            _buildGameCard(
              title: _t('FANTASY DRAFT (5 INICIAL)', 'FANTASY DRAFT (DREAM 5)'),
              subtitle: _t(
                'Drafta o teu 5 Inicial ideal sob um teto salarial de \$100M fictícios.',
                'Draft your ideal starting 5 under a \$100M salary cap.',
              ),
              icon: Icons.groups_outlined,
              colors: [const Color(0xFF8A2BE2), const Color(0xFF4A00E0)],
              xpReward: '+100 XP',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FantasyDraftScreen(
                      onDraftCompleted: () => _addXp(100),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 16),

            _buildGameCard(
              title: _t('NBA TRIVIA QUIZ', 'NBA TRIVIA QUIZ'),
              subtitle: _t(
                'Testa o teu conhecimento lendário contra o tempo sob pressão!',
                'Test your legendary basketball knowledge under pressure!',
              ),
              icon: Icons.quiz_outlined,
              colors: [const Color(0xFF00BFFF), const Color(0xFF00F2FE)],
              xpReward: '+120 XP',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NbaTriviaScreen(
                      onTriviaCompleted: (score) => _addXp(score * 12),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildXpBanner(ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFFB800), Color(0xFFFF5E00)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFFB800).withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const Icon(Icons.emoji_events, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _t('REPUTAÇÃO DE FÃ', 'FAN REPUTATION'),
                  style: const TextStyle(
                    color: Colors.white54,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$_fanXp XP',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: (_fanXp % 1000) / 1000,
                    backgroundColor: Colors.white.withValues(alpha: 0.05),
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFFB800)),
                    minHeight: 5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _t(
                    'Subir para o Nível ${(_fanXp ~/ 1000) + 2} (${1000 - (_fanXp % 1000)} XP restantes)',
                    'Reach Level ${(_fanXp ~/ 1000) + 2} (${1000 - (_fanXp % 1000)} XP left)',
                  ),
                  style: const TextStyle(color: Colors.white38, fontSize: 9, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required List<Color> colors,
    required String xpReward,
    required VoidCallback onTap,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF141414),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.04)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            splashColor: colors.first.withValues(alpha: 0.1),
            highlightColor: colors.first.withValues(alpha: 0.05),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: colors,
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Icon(icon, color: Colors.white, size: 24),
                  ),
                  const SizedBox(width: 18),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.5,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.05),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                xpReward,
                                style: const TextStyle(
                                  color: Color(0xFFFFB800),
                                  fontSize: 8.5,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 11.5,
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

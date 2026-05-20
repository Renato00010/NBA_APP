import 'dart:async';
import 'package:flutter/material.dart';

class TriviaQuestion {
  final Map<String, String> question;
  final List<Map<String, String>> options;
  final int correctIndex;

  TriviaQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
  });
}

class NbaTriviaScreen extends StatefulWidget {
  final Function(int score) onTriviaCompleted;

  const NbaTriviaScreen({super.key, required this.onTriviaCompleted});

  @override
  State<NbaTriviaScreen> createState() => _NbaTriviaScreenState();
}

class _NbaTriviaScreenState extends State<NbaTriviaScreen> with SingleTickerProviderStateMixin {
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _answered = false;
  int? _selectedOptionIndex;
  bool _triviaOver = false;

  late AnimationController _timerController;
  late Animation<double> _timerAnimation;
  final int _questionTimeoutSeconds = 15;

  final List<TriviaQuestion> _questions = [
    TriviaQuestion(
      question: {
        'pt': 'Quem marcou 100 pontos num único jogo da NBA?',
        'en': 'Who scored 100 points in a single NBA game?'
      },
      options: [
        {'pt': 'Wilt Chamberlain', 'en': 'Wilt Chamberlain'},
        {'pt': 'Michael Jordan', 'en': 'Michael Jordan'},
        {'pt': 'Kobe Bryant', 'en': 'Kobe Bryant'},
        {'pt': 'LeBron James', 'en': 'LeBron James'},
      ],
      correctIndex: 0,
    ),
    TriviaQuestion(
      question: {
        'pt': 'Que equipa conquistou o "three-peat" (3 títulos seguidos) duas vezes na década de 1990?',
        'en': 'Which team won the "three-peat" (3 consecutive titles) twice in the 1990s?'
      },
      options: [
        {'pt': 'Los Angeles Lakers', 'en': 'Los Angeles Lakers'},
        {'pt': 'Boston Celtics', 'en': 'Boston Celtics'},
        {'pt': 'Chicago Bulls', 'en': 'Chicago Bulls'},
        {'pt': 'Detroit Pistons', 'en': 'Detroit Pistons'},
      ],
      correctIndex: 2,
    ),
    TriviaQuestion(
      question: {
        'pt': 'Quem é o maior pontuador de sempre da história da NBA?',
        'en': 'Who is the all-time leading scorer in NBA history?'
      },
      options: [
        {'pt': 'Kareem Abdul-Jabbar', 'en': 'Kareem Abdul-Jabbar'},
        {'pt': 'LeBron James', 'en': 'LeBron James'},
        {'pt': 'Karl Malone', 'en': 'Karl Malone'},
        {'pt': 'Kobe Bryant', 'en': 'Kobe Bryant'},
      ],
      correctIndex: 1,
    ),
    TriviaQuestion(
      question: {
        'pt': 'Que jogador está desenhado na silhueta do logótipo da NBA?',
        'en': 'Which player is depicted in the silhouette of the NBA logo?'
      },
      options: [
        {'pt': 'Jerry West', 'en': 'Jerry West'},
        {'pt': 'Michael Jordan', 'en': 'Michael Jordan'},
        {'pt': 'Magic Johnson', 'en': 'Magic Johnson'},
        {'pt': 'Larry Bird', 'en': 'Larry Bird'},
      ],
      correctIndex: 0,
    ),
    TriviaQuestion(
      question: {
        'pt': 'Que equipa draftou Kobe Bryant em 1996?',
        'en': 'Which team drafted Kobe Bryant in 1996?'
      },
      options: [
        {'pt': 'Los Angeles Lakers', 'en': 'Los Angeles Lakers'},
        {'pt': 'Charlotte Hornets', 'en': 'Charlotte Hornets'},
        {'pt': 'Boston Celtics', 'en': 'Boston Celtics'},
        {'pt': 'Phoenix Suns', 'en': 'Phoenix Suns'},
      ],
      correctIndex: 1,
    ),
    TriviaQuestion(
      question: {
        'pt': 'Quem tem mais anéis de campeão da NBA como jogador (11 anéis)?',
        'en': 'Who has the most NBA championship rings as a player (11 rings)?'
      },
      options: [
        {'pt': 'Michael Jordan', 'en': 'Michael Jordan'},
        {'pt': 'Bill Russell', 'en': 'Bill Russell'},
        {'pt': 'Sam Jones', 'en': 'Sam Jones'},
        {'pt': 'Robert Horry', 'en': 'Robert Horry'},
      ],
      correctIndex: 1,
    ),
    TriviaQuestion(
      question: {
        'pt': 'Que equipa detém o recorde de maior sequência de vitórias (33 jogos)?',
        'en': 'Which team holds the record for the longest winning streak (33 games)?'
      },
      options: [
        {'pt': 'Golden State Warriors', 'en': 'Golden State Warriors'},
        {'pt': 'Los Angeles Lakers', 'en': 'Los Angeles Lakers'},
        {'pt': 'Chicago Bulls', 'en': 'Chicago Bulls'},
        {'pt': 'Miami Heat', 'en': 'Miami Heat'},
      ],
      correctIndex: 1,
    ),
    TriviaQuestion(
      question: {
        'pt': 'Quem é o jogador mais jovem de sempre a vencer o prémio de MVP da NBA?',
        'en': 'Who is the youngest player in history to win the NBA MVP award?'
      },
      options: [
        {'pt': 'LeBron James', 'en': 'LeBron James'},
        {'pt': 'Derrick Rose', 'en': 'Derrick Rose'},
        {'pt': 'Wes Unseld', 'en': 'Wes Unseld'},
        {'pt': 'Bob McAdoo', 'en': 'Bob McAdoo'},
      ],
      correctIndex: 1,
    ),
    TriviaQuestion(
      question: {
        'pt': 'Quem foi o primeiro MVP unânime na história da NBA?',
        'en': 'Who was the first unanimous MVP in NBA history?'
      },
      options: [
        {'pt': 'Michael Jordan', 'en': 'Michael Jordan'},
        {'pt': 'LeBron James', 'en': 'LeBron James'},
        {'pt': 'Shaquille O\'Neal', 'en': 'Shaquille O\'Neal'},
        {'pt': 'Stephen Curry', 'en': 'Stephen Curry'},
      ],
      correctIndex: 3,
    ),
    TriviaQuestion(
      question: {
        'pt': 'Que jogador tem o maior número de assistências na história da NBA?',
        'en': 'Which player has the highest number of assists in NBA history?'
      },
      options: [
        {'pt': 'John Stockton', 'en': 'John Stockton'},
        {'pt': 'Jason Kidd', 'en': 'Jason Kidd'},
        {'pt': 'Steve Nash', 'en': 'Steve Nash'},
        {'pt': 'Magic Johnson', 'en': 'Magic Johnson'},
      ],
      correctIndex: 0,
    ),
  ];

  bool _isEnglish(BuildContext context) =>
      Localizations.localeOf(context).languageCode == 'en';

  String _t(String pt, String en) => _isEnglish(context) ? en : pt;

  @override
  void initState() {
    super.initState();
    _timerController = AnimationController(
      duration: Duration(seconds: _questionTimeoutSeconds),
      vsync: this,
    );
    
    _timerAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_timerController)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _handleTimeout();
        }
      });

    _startQuestionTimer();
  }

  @override
  void dispose() {
    _timerController.dispose();
    super.dispose();
  }

  void _startQuestionTimer() {
    _timerController.reset();
    _timerController.forward();
  }

  void _handleTimeout() {
    if (_answered) return;
    _selectOption(-1); // Treats as wrong selection / timeout
  }

  void _selectOption(int optionIndex) {
    if (_answered) return;

    _timerController.stop();

    setState(() {
      _answered = true;
      _selectedOptionIndex = optionIndex;

      final correctIndex = _questions[_currentQuestionIndex].correctIndex;
      if (optionIndex == correctIndex) {
        _score++;
      }
    });

    // Short delay before moving to next question
    Timer(const Duration(milliseconds: 1600), () {
      if (!mounted) return;
      _nextQuestion();
    });
  }

  void _nextQuestion() {
    if (_currentQuestionIndex < _questions.length - 1) {
      setState(() {
        _currentQuestionIndex++;
        _answered = false;
        _selectedOptionIndex = null;
      });
      _startQuestionTimer();
    } else {
      setState(() {
        _triviaOver = true;
      });
      widget.onTriviaCompleted(_score);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_triviaOver) {
      return _buildTriviaOverView();
    }

    final currentQuestion = _questions[_currentQuestionIndex];
    final progress = (_timerAnimation.value);
    final timerColor = Color.lerp(Colors.redAccent, Colors.greenAccent, progress) ?? Colors.greenAccent;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A0A0A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          _t('NBA TRIVIA CHALLENGE', 'NBA TRIVIA CHALLENGE'),
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.0,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Question Tracker & Score tracker
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _t(
                      'PERGUNTA ${_currentQuestionIndex + 1} DE ${_questions.length}',
                      'QUESTION ${_currentQuestionIndex + 1} OF ${_questions.length}',
                    ),
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                  Text(
                    _t('ACERTOS: $_score', 'CORRECT: $_score'),
                    style: const TextStyle(
                      color: Colors.amber,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Countdown progress bar
              Container(
                width: double.infinity,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: progress,
                  child: Container(
                    decoration: BoxDecoration(
                      color: timerColor,
                      borderRadius: BorderRadius.circular(3),
                      boxShadow: [
                        BoxShadow(
                          color: timerColor.withValues(alpha: 0.3),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Question Glassmorphic Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF141414),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Text(
                  _t(currentQuestion.question['pt']!, currentQuestion.question['en']!),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    height: 1.45,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              const SizedBox(height: 36),

              // Options
              Expanded(
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: currentQuestion.options.length,
                  itemBuilder: (context, index) {
                    final option = currentQuestion.options[index];
                    final optionText = _t(option['pt']!, option['en']!);
                    return _buildOptionButton(index, optionText, currentQuestion.correctIndex);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOptionButton(int index, String text, int correctIndex) {
    Color cardColor = const Color(0xFF141414);
    Color borderColor = Colors.white.withValues(alpha: 0.05);
    Color textColor = Colors.white;
    List<BoxShadow>? glow;

    if (_answered) {
      if (index == correctIndex) {
        // Highlight correct option in glowing neon green
        cardColor = const Color(0xFF0F2C11);
        borderColor = Colors.green;
        textColor = Colors.greenAccent;
        glow = [
          BoxShadow(
            color: Colors.green.withValues(alpha: 0.25),
            blurRadius: 12,
            spreadRadius: 1,
          )
        ];
      } else if (index == _selectedOptionIndex) {
        // Highlight chosen wrong option in glowing neon red
        cardColor = const Color(0xFF2C0F11);
        borderColor = Colors.redAccent;
        textColor = Colors.redAccent;
        glow = [
          BoxShadow(
            color: Colors.redAccent.withValues(alpha: 0.25),
            blurRadius: 12,
            spreadRadius: 1,
          )
        ];
      } else {
        textColor = Colors.white30;
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 14.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: double.infinity,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: _answered ? 2.0 : 1.0),
          boxShadow: glow,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _answered ? null : () => _selectOption(index),
              splashColor: Colors.cyan.withValues(alpha: 0.15),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                child: Row(
                  children: [
                    // Position label identifier (A, B, C, D)
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: _answered
                            ? (index == correctIndex
                                ? Colors.green.withValues(alpha: 0.2)
                                : (index == _selectedOptionIndex ? Colors.redAccent.withValues(alpha: 0.2) : Colors.white.withValues(alpha: 0.03)))
                            : Colors.white.withValues(alpha: 0.05),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        String.fromCharCode(65 + index), // A, B, C, D
                        style: TextStyle(
                          color: _answered
                              ? (index == correctIndex
                                  ? Colors.greenAccent
                                  : (index == _selectedOptionIndex ? Colors.redAccent : Colors.white38))
                              : Colors.white54,
                          fontSize: 12,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        text,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTriviaOverView() {
    final perfect = _score == _questions.length;
    final xpEarned = _score * 12;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Icon(
                perfect ? Icons.stars : Icons.emoji_events,
                color: Colors.cyanAccent,
                size: 72,
              ),
              const SizedBox(height: 24),
              Text(
                perfect ? _t('PERFEITO! SABES TUDO!', 'PERFECT! YOU KNOW IT ALL!') : _t('QUIZ CONCLUÍDO!', 'QUIZ COMPLETED!'),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.0,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                _t(
                  'Acertaste em $_score de ${_questions.length} perguntas lendárias sobre o basquetebol mundial.',
                  'You correctly answered $_score of ${_questions.length} legendary basketball questions.',
                ),
                style: const TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              
              // XP Reward Display
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFF141414),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.cyan.withValues(alpha: 0.15)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.flash_on, color: Colors.cyanAccent, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      '+$xpEarned XP',
                      style: const TextStyle(
                        color: Colors.cyanAccent,
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00BFFF),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    shadowColor: const Color(0xFF00BFFF).withValues(alpha: 0.4),
                    elevation: 8,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    _t('VOLTAR AO HUB', 'BACK TO HUB'),
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

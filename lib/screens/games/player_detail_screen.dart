import 'package:flutter/material.dart';
import '../../db/app_database.dart';
import '../../main.dart';

class PlayerDetailScreen extends StatefulWidget {
  final Player player;
  const PlayerDetailScreen({super.key, required this.player});

  @override
  State<PlayerDetailScreen> createState() => _PlayerDetailScreenState();
}

class _PlayerDetailScreenState extends State<PlayerDetailScreen> {
  Map<String, dynamic>? _stats;
  bool _loading = true;
  String _teamName = '';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    // Busca nome da equipa
    final teamName = repository.getTeamName(widget.player.teamId);

    // Busca stats
    final stats = await repository.getPlayerStats(
      int.parse(widget.player.playerId),
    );
    setState(() {
      _stats = stats;
      _teamName = teamName;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final player = widget.player;

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: theme.colorScheme.primary,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                player.fullName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Container(color: theme.colorScheme.primary),
                  // Silhueta placeholder centralizada
                  const Center(
                    child: Icon(Icons.person, size: 140, color: Colors.white12),
                  ),
                  // Gradiente bottom
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [
                            theme.colorScheme.primary,
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info básica
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A1A),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _infoItem('Posição', player.position ?? '-'),
                        _divider(),
                        _infoItem(
                          'Equipa',
                          _teamName.isNotEmpty ? _teamName : player.teamId,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  Text(
                    'Estatísticas 2024-25',
                    style: TextStyle(
                      color: theme.colorScheme.tertiary,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),

                  _loading
                      ? const Center(child: CircularProgressIndicator())
                      : _stats == null
                      ? Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1A1A1A),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Text(
                              'Sem estatísticas disponíveis',
                              style: TextStyle(color: Colors.white54),
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            Row(
                              children: [
                                _statCard(
                                  'PTS',
                                  _fmt(_stats!['pts']),
                                  theme,
                                  isMain: true,
                                ),
                                const SizedBox(width: 10),
                                _statCard(
                                  'REB',
                                  _fmt(_stats!['reb']),
                                  theme,
                                  isMain: true,
                                ),
                                const SizedBox(width: 10),
                                _statCard(
                                  'AST',
                                  _fmt(_stats!['ast']),
                                  theme,
                                  isMain: true,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                _statCard('STL', _fmt(_stats!['stl']), theme),
                                const SizedBox(width: 10),
                                _statCard('BLK', _fmt(_stats!['blk']), theme),
                                const SizedBox(width: 10),
                                _statCard(
                                  'MIN',
                                  _stats!['min']?.toString() ?? '0',
                                  theme,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                _statCard(
                                  'FG%',
                                  _fmtPct(_stats!['fg_pct']),
                                  theme,
                                ),
                                const SizedBox(width: 10),
                                _statCard(
                                  '3P%',
                                  _fmtPct(_stats!['fg3_pct']),
                                  theme,
                                ),
                                const SizedBox(width: 10),
                                _statCard(
                                  'FT%',
                                  _fmtPct(_stats!['ft_pct']),
                                  theme,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                _statCard(
                                  'TO',
                                  _fmt(_stats!['turnover']),
                                  theme,
                                ),
                                const SizedBox(width: 10),
                                _statCard('PF', _fmt(_stats!['pf']), theme),
                                const SizedBox(width: 10),
                                _statCard(
                                  'GP',
                                  _stats!['games_played']?.toString() ?? '0',
                                  theme,
                                ),
                              ],
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _fmt(dynamic value) =>
      value != null ? value.toStringAsFixed(1) : '0.0';

  String _fmtPct(dynamic value) {
    if (value == null) return '0%';
    return '${(value * 100).toStringAsFixed(1)}%';
  }

  Widget _statCard(
    String label,
    String value,
    ThemeData theme, {
    bool isMain = false,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isMain
              ? theme.colorScheme.primary.withOpacity(0.2)
              : const Color(0xFF1A1A1A),
          borderRadius: BorderRadius.circular(10),
          border: isMain
              ? Border.all(color: theme.colorScheme.primary.withOpacity(0.4))
              : null,
        ),
        child: Column(
          children: [
            Text(
              value,
              style: TextStyle(
                color: isMain ? theme.colorScheme.tertiary : Colors.white,
                fontSize: isMain ? 22 : 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white54, fontSize: 12),
        ),
      ],
    );
  }

  Widget _divider() => Container(height: 40, width: 0.5, color: Colors.white24);
}

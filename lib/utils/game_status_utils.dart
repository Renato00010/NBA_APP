/// Interpretação consistente dos estados ESPN guardados em [CachedGame.status].
abstract final class GameStatusUtils {
  static bool isFinal(String status) {
    final s = status.toLowerCase();
    return s.contains('final') ||
        s == 'completed' ||
        s.contains('postponed') ||
        s.contains('cancelled');
  }

  static bool isScheduled(String status) {
    final s = status.toLowerCase();
    return s.contains('scheduled') || s == 'pre' || s.contains('pre ');
  }

  /// Jogo em curso (não finalizado, não apenas agendado).
  static bool isLive(String status) {
    final s = status.toLowerCase().trim();
    if (isFinal(s) || isScheduled(s)) return false;

    return s == 'live' ||
        s == 'in' ||
        s.contains('in progress') ||
        s.contains('progress') ||
        s.contains('qtr') ||
        s.contains('quarter') ||
        RegExp(r'\b(1st|2nd|3rd|4th|q1|q2|q3|q4)\b').hasMatch(s) ||
        s.contains('halftime') ||
        s.contains('half time') ||
        s == 'half' ||
        s == 'ot' ||
        s.startsWith('ot ') ||
        s.endsWith(' ot');
  }
}

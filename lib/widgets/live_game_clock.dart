import 'dart:async';

import 'package:flutter/material.dart';

import '../utils/game_status_utils.dart';

class LiveGameClock extends StatefulWidget {
  final String status;
  final TextStyle? style;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  const LiveGameClock({
    super.key,
    required this.status,
    this.style,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  State<LiveGameClock> createState() => _LiveGameClockState();
}

class _LiveGameClockState extends State<LiveGameClock> {
  Timer? _timer;
  late DateTime _startedAt;

  @override
  void initState() {
    super.initState();
    _startedAt = DateTime.now();
    _syncTimer();
  }

  @override
  void didUpdateWidget(covariant LiveGameClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.status != widget.status) {
      _startedAt = DateTime.now();
      _syncTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _syncTimer() {
    _timer?.cancel();
    if (!_shouldRunClock(widget.status)) {
      return;
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _displayStatus(),
      style: widget.style,
      textAlign: widget.textAlign,
      maxLines: widget.maxLines,
      overflow: widget.overflow,
    );
  }

  String _displayStatus() {
    final parsed = _parseClock(widget.status);
    if (parsed == null || !_shouldRunClock(widget.status)) {
      return widget.status.toUpperCase();
    }

    final elapsed = DateTime.now().difference(_startedAt).inSeconds;
    final remaining = (parsed.seconds - elapsed).clamp(0, parsed.seconds).toInt();
    final minutes = remaining ~/ 60;
    final seconds = remaining % 60;
    final clock = '$minutes:${seconds.toString().padLeft(2, '0')}';
    return widget.status.replaceFirst(parsed.raw, clock).toUpperCase();
  }

  bool _shouldRunClock(String status) {
    if (_parseClock(status) == null) return false;
    if (GameStatusUtils.isFinal(status) || GameStatusUtils.isScheduled(status)) {
      return false;
    }

    final s = status.toLowerCase();
    return GameStatusUtils.isLive(status) ||
        RegExp(r'\b(1st|2nd|3rd|4th|q1|q2|q3|q4)\b').hasMatch(s);
  }

  _ParsedClock? _parseClock(String status) {
    final match = RegExp(r'\b(\d{1,2}):([0-5]\d)\b').firstMatch(status);
    if (match == null) return null;

    final minutes = int.tryParse(match.group(1) ?? '');
    final seconds = int.tryParse(match.group(2) ?? '');
    if (minutes == null || seconds == null) return null;

    return _ParsedClock(
      raw: match.group(0)!,
      seconds: minutes * 60 + seconds,
    );
  }
}

class _ParsedClock {
  final String raw;
  final int seconds;

  const _ParsedClock({
    required this.raw,
    required this.seconds,
  });
}

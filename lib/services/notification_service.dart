import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart' as tz_data;
import 'package:timezone/timezone.dart' as tz;

import '../main.dart';

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    tz_data.initializeTimeZones();
    try {
      final name = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(name));
    } catch (_) {
      tz.setLocalLocation(tz.UTC);
    }

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    await _plugin.initialize(
      const InitializationSettings(android: android, iOS: ios),
    );
    _initialized = true;
  }

  Future<bool> requestPermissions() async {
    final android = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    if (android != null) {
      return await android.requestNotificationsPermission() ?? false;
    }
    final ios = _plugin
        .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin
        >();
    if (ios != null) {
      return await ios.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          ) ??
          false;
    }
    return true;
  }

  Future<void> rescheduleFromPreferences() async {
    await init();
    await _plugin.cancelAll();

    final prefs = await database.preferencesDao.getPreferences();
    if (prefs == null) return;
    if (!(prefs.notificationsOn && prefs.favoriteTeamAlerts)) return;

    final teamId = prefs.favoriteTeamId;
    if (teamId == null || teamId.isEmpty) return;

    await requestPermissions();

    final games = await repository.getUpcomingGamesForTeam(teamId);
    final teamName = repository.getTeamName(teamId);
    var scheduled = 0;

    for (final game in games) {
      if (scheduled >= 8) break;
      final notifyAt = game.gameDate.subtract(const Duration(hours: 1));
      if (!notifyAt.isAfter(DateTime.now())) continue;

      final opponentId = game.homeTeamId == teamId
          ? game.awayTeamId
          : game.homeTeamId;
      final opponent = repository.getTeamName(opponentId);
      final title = '$teamName vs $opponent';

      final id = game.gameId.hashCode & 0x7FFFFFFF;
      await _plugin.zonedSchedule(
        id,
        'Jogo da $teamName',
        'Começa em cerca de 1 hora — $title',
        tz.TZDateTime.from(notifyAt, tz.local),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'nba_team_games',
            'Jogos da equipa favorita',
            channelDescription: 'Lembretes antes dos jogos reais da tua equipa',
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: DarwinNotificationDetails(),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
      scheduled++;
    }

    debugPrint('NotificationService: $scheduled jogos agendados para $teamId');
  }
}

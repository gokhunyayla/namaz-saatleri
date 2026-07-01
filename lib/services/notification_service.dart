import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest_all.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

import 'prayer_service.dart';

/// Yerel bildirimlerle namaz vakti hatırlatmaları.
/// Sunucu yok: bildirimler cihazda önceden planlanır (iOS'ta UNUserNotificationCenter,
/// Android'de AlarmManager kullanılır).
class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final _plugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tzdata.initializeTimeZones();
    try {
      final info = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(info.identifier));
    } catch (_) {
      // Zaman dilimi bulunamazsa UTC ile devam edilir.
    }

    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
    await _plugin.initialize(
      settings: const InitializationSettings(android: android, iOS: ios),
    );
  }

  Future<bool> requestPermissions() async {
    final ios = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    if (ios != null) {
      return await ios.requestPermissions(
              alert: true, badge: true, sound: true) ??
          false;
    }
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android != null) {
      return await android.requestNotificationsPermission() ?? false;
    }
    return false;
  }

  Future<void> cancelAll() => _plugin.cancelAll();

  /// Önümüzdeki [days] gün için 5 vaktin hatırlatmalarını planlar.
  /// [minutesBefore] 0 ise vakit girdiğinde, değilse vakitten o kadar dakika
  /// önce bildirim gelir. iOS'un 64 bekleyen bildirim sınırına takılmamak için
  /// gün sayısı sınırlı tutulur; uygulama her açılışta yeniden planlar.
  Future<void> scheduleAll({
    required double lat,
    required double lng,
    required int minutesBefore,
    int days = 5,
  }) async {
    await _plugin.cancelAll();
    final now = DateTime.now();
    var id = 0;

    for (var d = 0; d <= days; d++) {
      final date = now.add(Duration(days: d));
      final times = PrayerService.timesFor(lat, lng, date);
      final entries = <String, DateTime>{
        'İmsak': times.fajr,
        'Öğle': times.dhuhr,
        'İkindi': times.asr,
        'Akşam': times.maghrib,
        'Yatsı': times.isha,
      };

      for (final e in entries.entries) {
        final fireAt = minutesBefore == 0
            ? e.value
            : e.value.subtract(Duration(minutes: minutesBefore));
        if (fireAt.isBefore(now)) {
          id++;
          continue;
        }
        final timeText = DateFormat.Hm().format(e.value);
        final body = minutesBefore == 0
            ? '${e.key} vakti girdi ($timeText).'
            : '${e.key} vaktine $minutesBefore dakika kaldı ($timeText).';
        await _schedule(id++, '${e.key} Vakti', body, fireAt);
      }
    }
  }

  Future<void> _schedule(
      int id, String title, String body, DateTime at) async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails(
        'namaz_vakitleri',
        'Namaz Vakitleri',
        channelDescription: 'Namaz vakti hatırlatmaları',
        importance: Importance.high,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(),
    );
    final when = tz.TZDateTime.from(at, tz.local);
    try {
      await _plugin.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: when,
        notificationDetails: details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      );
    } catch (_) {
      // Android 12+ kesin alarm izni verilmemişse yaklaşık zamanlamaya düş.
      await _plugin.zonedSchedule(
        id: id,
        title: title,
        body: body,
        scheduledDate: when,
        notificationDetails: details,
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      );
    }
  }
}

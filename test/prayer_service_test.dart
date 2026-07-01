import 'package:adhan/adhan.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:namaz_saatleri/services/prayer_service.dart';

void main() {
  test('İstanbul için namaz vakitleri makul sırada hesaplanır', () {
    // İstanbul koordinatları
    final times =
        PrayerService.timesFor(41.0082, 28.9784, DateTime(2026, 7, 1));

    expect(times.fajr.isBefore(times.sunrise), isTrue);
    expect(times.sunrise.isBefore(times.dhuhr), isTrue);
    expect(times.dhuhr.isBefore(times.asr), isTrue);
    expect(times.asr.isBefore(times.maghrib), isTrue);
    expect(times.maghrib.isBefore(times.isha), isTrue);
  });

  test('İstanbul için kıble yönü güneydoğudadır', () {
    final direction = PrayerService.qiblaDirection(41.0082, 28.9784);
    // İstanbul'dan kıble yaklaşık 151° (güneydoğu) yönündedir.
    expect(direction, greaterThan(140));
    expect(direction, lessThan(165));
  });

  test('Kıble hesabı Kabe koordinatlarını kullanır', () {
    expect(Qibla.MAKKAH.latitude, closeTo(21.42, 0.01));
  });
}

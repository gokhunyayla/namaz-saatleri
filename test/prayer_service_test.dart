import 'package:adhan/adhan.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geomag/geomag.dart';

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

  test('Kıble açısı bilinen değerlerle eşleşir (büyük daire, gerçek kuzey)', () {
    // Referans: standart büyük daire başlangıç açıları (±1°).
    expect(PrayerService.qiblaDirection(41.0082, 28.9784),
        closeTo(151.6, 1.0)); // İstanbul
    expect(PrayerService.qiblaDirection(51.5074, -0.1278),
        closeTo(119.0, 1.0)); // Londra
    expect(PrayerService.qiblaDirection(40.7128, -74.0060),
        closeTo(58.5, 1.0)); // New York
    expect(PrayerService.qiblaDirection(-6.2088, 106.8456),
        closeTo(295.1, 1.0)); // Cakarta
  });

  test('Kıble hesabı Kabe koordinatlarını kullanır', () {
    expect(Qibla.MAKKAH.latitude, closeTo(21.42, 0.01));
    expect(Qibla.MAKKAH.longitude, closeTo(39.83, 0.01));
  });

  test('Manyetik sapma (WMM-2025) İstanbul için makul aralıktadır', () {
    // İstanbul 2026: yaklaşık +6° doğu sapması. Android pusula düzeltmesi
    // bu değeri kullanır; iOS zaten gerçek kuzey bildirir.
    final dec = GeoMag().calculate(41.0082, 28.9784).dec;
    expect(dec, greaterThan(4));
    expect(dec, lessThan(8));
  });
}

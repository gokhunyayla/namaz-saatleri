import 'package:adhan/adhan.dart';

/// Namaz vakitlerini cihaz üzerinde, Diyanet (Türkiye) yöntemiyle hesaplar.
/// İnternet bağlantısı gerektirmez.
class PrayerService {
  static CalculationParameters get _params {
    final params = CalculationMethod.turkey.getParameters();
    params.madhab = Madhab.shafi;
    return params;
  }

  /// Verilen konum ve tarih için namaz vakitleri (yerel saat).
  static PrayerTimes timesFor(double lat, double lng, DateTime date) {
    return PrayerTimes(
      Coordinates(lat, lng),
      DateComponents.from(date),
      _params,
    );
  }

  /// Kıble yönü: kuzeyden saat yönünde derece.
  static double qiblaDirection(double lat, double lng) =>
      Qibla(Coordinates(lat, lng)).direction;

  /// Şu an içinde bulunulan vakit diliminin indeksi (0..5):
  /// İmsak, Güneş, Öğle, İkindi, Akşam, Yatsı.
  /// Gece yarısı ile imsak arasında dünün yatsısı sürdüğü için 5 döner.
  static int currentPeriodIndex(double lat, double lng, DateTime now) {
    final t = timesFor(lat, lng, now);
    final list = [t.fajr, t.sunrise, t.dhuhr, t.asr, t.maghrib, t.isha];
    var index = -1;
    for (var i = 0; i < list.length; i++) {
      if (!list[i].isAfter(now)) index = i;
    }
    return index == -1 ? 5 : index;
  }
}

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
}

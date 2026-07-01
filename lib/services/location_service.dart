import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationInfo {
  final double latitude;
  final double longitude;
  final String city;

  const LocationInfo(this.latitude, this.longitude, this.city);
}

/// Konum alınamama nedenleri. Arayüz bunları seçili dilde metne çevirir.
enum LocationFailure { serviceDisabled, permissionDenied }

class LocationException implements Exception {
  final LocationFailure failure;
  const LocationException(this.failure);
}

/// Cihaz konumunu alır, şehir adına çevirir ve son konumu önbelleğe yazar.
/// Şehir adı çevirisi internet ister; internet yoksa koordinatlarla devam edilir.
class LocationService {
  static const _kLat = 'last_lat';
  static const _kLng = 'last_lng';
  static const _kCity = 'last_city';

  /// Daha önce kaydedilmiş son konum (uygulama çevrimdışıyken de çalışsın diye).
  static Future<LocationInfo?> loadCached() async {
    final prefs = await SharedPreferences.getInstance();
    final lat = prefs.getDouble(_kLat);
    final lng = prefs.getDouble(_kLng);
    if (lat == null || lng == null) return null;
    return LocationInfo(lat, lng, prefs.getString(_kCity) ?? '');
  }

  static Future<LocationInfo> getCurrent() async {
    if (!await Geolocator.isLocationServiceEnabled()) {
      throw const LocationException(LocationFailure.serviceDisabled);
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      throw const LocationException(LocationFailure.permissionDenied);
    }

    final pos = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.low),
    );

    String city = '';
    try {
      final placemarks =
          await placemarkFromCoordinates(pos.latitude, pos.longitude);
      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        final parts = [p.subAdministrativeArea, p.administrativeArea]
            .where((s) => s != null && s.isNotEmpty)
            .cast<String>()
            .toList();
        city = parts.isNotEmpty ? parts.join(', ') : (p.locality ?? '');
      }
    } catch (_) {
      // İnternet yoksa şehir adı boş kalır; vakitler koordinatla yine hesaplanır.
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_kLat, pos.latitude);
    await prefs.setDouble(_kLng, pos.longitude);
    if (city.isNotEmpty) await prefs.setString(_kCity, city);

    return LocationInfo(pos.latitude, pos.longitude,
        city.isNotEmpty ? city : (prefs.getString(_kCity) ?? ''));
  }
}

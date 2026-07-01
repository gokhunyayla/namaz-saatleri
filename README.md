# Namaz Saatleri

Bulunulan konuma göre namaz vakitlerini gösteren, kıble pusulası ve vakit hatırlatma bildirimleri içeren Flutter uygulaması. **iOS ve Android**'de çalışır.

## Özellikler

- 🕌 **Namaz vakitleri** — İmsak'tan Yatsı'ya 6 vakit, Diyanet (Türkiye) hesaplama yöntemiyle **cihaz üzerinde** hesaplanır. Vakit hesaplaması için internet gerekmez; internet yalnızca şehir adının gösterilmesi (geocoding) için kullanılır.
- 📍 **Konuma göre** — GPS ile bulunduğunuz şehri algılar; son konum önbelleğe alınır, çevrimdışıyken de çalışır.
- ⏳ **Geri sayım** — Sıradaki vakte kalan süre canlı olarak gösterilir.
- 🧭 **Kıble pusulası** — Manyetometre sensörüyle kıble yönünü gösterir; hizalanınca titreşimle bildirir.
- 🔔 **Vakit hatırlatmaları** — Yerel bildirimlerle (iOS: UNUserNotificationCenter, Android: AlarmManager) vakit girince veya seçilen dakika kadar önce hatırlatır. Sunucu yok; bildirimler cihazda önceden planlanır.

## Mimari

Hiçbir arka uç (backend) bağımlılığı yoktur; uygulama tamamen kişinin telefonunda çalışır.

```
lib/
├── main.dart                        # Uygulama girişi, tema, sekmeli gezinme
├── screens/
│   ├── home_screen.dart             # Vakit listesi, geri sayım, bildirim ayarları
│   └── qibla_screen.dart            # Kıble pusulası
└── services/
    ├── prayer_service.dart          # Vakit + kıble hesabı (adhan, Diyanet yöntemi)
    ├── location_service.dart        # GPS + şehir adı + önbellek
    └── notification_service.dart    # Yerel bildirim planlama
```

## Geliştirme

```bash
flutter pub get
flutter test        # birim testleri
flutter analyze     # statik analiz
flutter run         # bağlı cihazda/simülatörde çalıştır
```

## Dağıtım (Deployment)

### Android
```bash
flutter build apk --release          # APK: build/app/outputs/flutter-apk/
flutter build appbundle --release    # Play Store için AAB
```

### iOS (yalnızca Xcode kurulu macOS'ta)
```bash
flutter build ipa --release          # App Store / TestFlight için
# veya cihaza doğrudan: flutter run --release -d <cihaz-id>
```
> Not: Cihaza kurulum ve App Store dağıtımı için Xcode'da imzalama (Signing & Capabilities) ayarlanmalıdır.

## Sürümleme (Versioning)

[Semantic Versioning](https://semver.org/lang/tr/) kullanılır: `MAJOR.MINOR.PATCH`

- Her sürüm `pubspec.yaml` içindeki `version:` alanında tutulur (`0.1.0+1` → sürüm `0.1.0`, derleme no `1`).
- Her yayın GitHub'da `vX.Y.Z` etiketiyle (tag) işaretlenir ve [CHANGELOG.md](CHANGELOG.md) güncellenir.
- Eski bir sürüme dönmek için:
  ```bash
  git tag -l                 # mevcut sürümleri listele
  git checkout v0.1.0        # istenen sürüme dön
  ```

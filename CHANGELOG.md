# Değişiklik Günlüğü

Bu projedeki tüm önemli değişiklikler bu dosyada belgelenir.
Biçim [Keep a Changelog](https://keepachangelog.com/tr/1.0.0/) standardına,
sürümleme [Semantic Versioning](https://semver.org/lang/tr/) kurallarına uyar.

## [0.5.0] - 2026-07-02

### Değişti
- Uygulama adı "Ezan Saatleri" → "Vakte" (tüm dillerde)
- Logo: sade beyaz kare üzerinde hat stili tek Elif (ا), Amiri hattıyla
- Başlıktaki الله ve محمد hat yazıları beyaz oldu; okunabilirlik için üst çubuk uygulamanın teal rengine boyandı

## [0.4.0] - 2026-07-01

### Eklendi
- Uygulama logosu: teal degrade üzerinde altın hilal ve beyaz cami silueti; iOS ve Android (adaptif dahil) tüm ikon boyutları üretildi
- Ana ekran başlığının sağında الله (Allah), solunda محمد (Muhammed) hat yazıları — Amiri Nesih hattı fontuyla, altın renkli, açık/koyu tema uyumlu

### Değişti
- Uygulama adı "Namaz Saatleri" → "Ezan Saatleri" (Arapça: مواقيت الأذان, İngilizce: Adhan Times)
- Konum yenileme butonu üst çubuktan kaldırıldı; listeyi aşağı çekerek yenileme aynı işi görüyor

## [0.3.0] - 2026-07-01

### Eklendi
- Tarih alanına dokununca açılan takvim ile istenilen güne gitme; takvimde "Bugüne Dön" butonu
- Alt menüye Ayarlar sekmesi
- Görünüm seçimi: Açık / Koyu / Sistem
- Üç dil desteği: Türkçe, Arapça (sağdan sola düzen dahil), İngilizce — cihaz dili Türkçe veya Arapça ise otomatik seçilir, diğer dillerde İngilizce; Ayarlar'dan elle değiştirilebilir
- Bildirim metinleri seçili dilde planlanır; dil değişince yeniden planlanır

### Değişti
- Bildirim ayarları ana ekrandaki zil menüsünden Ayarlar sekmesine taşındı

## [0.2.0] - 2026-07-01

### Eklendi
- İçinde bulunulan vakit diliminde, vaktin başından sonuna ilerlemeyi gösteren kırmızı ilerleme çizgisi (koyu/açık tema uyumlu)
- Geçerli vakit kartının belirginleştirilmesi (buton "hover" görünümü gibi yükselti ve gölge)
- Vakitler ekranında Dün / Yarın gezinme okları; tarihe dokununca bugüne dönüş

## [0.1.0] - 2026-07-01

### Eklendi
- Konuma göre namaz vakitleri (İmsak, Güneş, Öğle, İkindi, Akşam, Yatsı) — Diyanet (Türkiye) yöntemi, cihaz üzerinde hesaplama
- Sıradaki vakte canlı geri sayım
- Kıble pusulası (manyetometre ile, hizalanınca titreşim)
- Vakit hatırlatma bildirimleri (vaktinde veya 5–45 dk önce, yerel bildirimlerle)
- Son konumun önbelleğe alınması (çevrimdışı çalışma)
- Türkçe arayüz, açık/koyu tema

# Değişiklik Günlüğü

Bu projedeki tüm önemli değişiklikler bu dosyada belgelenir.
Biçim [Keep a Changelog](https://keepachangelog.com/tr/1.0.0/) standardına,
sürümleme [Semantic Versioning](https://semver.org/lang/tr/) kurallarına uyar.

## [1.1.0] - 2026-07-11

### Eklendi
- "İbadet" sekmesi iki bölüme ayrıldı: Namazlar ile Sureler ve Dualar
- Diğer Namazlar: Cuma (16 rekat: 4 ilk sünnet + hutbe + 2 farz + 4 son sünnet + 4 zuhr-i âhir + 2 vaktin sünneti), Bayram (zevaid tekbirleri adım adım), Cenaze (4 tekbir), Teravih, Teheccüd, Evvâbin, Kuşluk, İstihâre ve Tesbih namazı (75'lik tesbih dağılımı) — hepsi vakit namazları gibi bölüm bölüm, rekat rekat anlatımla
- Çok okunan sureler: Âyete'l-Kürsî, Yâsîn ve Mülk (Tebâreke) — Yâsîn ve Mülk gerçek Mushaf sayfa düzeniyle (sayfa sayfa, sağdan sola)
- Diğer namaz listesinde rekat sayılı daire göstergeleri

### Değişti
- Alt menüdeki "Namaz" sekmesinin adı "İbadet" oldu

## [1.0.0] - 2026-07-02

### Eklendi
- App Store sürümü: 3 dilli mağaza metinleri, ekran görüntüleri, gizlilik politikası
- GitHub tag → TestFlight otomasyonu (self-hosted runner, yerel derleme)
- Şifreleme muafiyeti beyanı (ITSAppUsesNonExemptEncryption)

## [0.7.1] - 2026-07-02

### Düzeltildi
- Geçerli vaktin ilerleme çubuğu bazı durumlarda boş (%0) görünüyordu: vakit aralığı artık dün-bugün-yarın vakitlerinin mutlak zaman çizgisinden seçiliyor; gece yarısı ve konum/saat dilimi farkı durumları doğru çalışıyor. Sıradaki vakit (geri sayım) da aynı yöntemle hesaplanıyor
- İlerleme çubuğu belirginleştirildi: 8 piksel kalınlık, tam dolgulu kırmızı ve yanında yüzde etiketi

## [0.7.0] - 2026-07-02

### Eklendi
- "Namaz" sekmesi (Namaz Nasıl Kılınır): her vakit için bölüm bölüm (sünnet/farz/vitir) ve rekat rekat kılınış rehberi — hangi rekatta ne okunacağı, rükû/secde/doğrulma tesbihleri dahil (Hanefî mezhebi, Diyanet İlmihali usulü)
- Sureler ve Dualar bölümü: Sübhâneke, Ettehiyyâtü, Salli-Bârik, Rabbenâ duaları, Kunut 1-2 ile Fâtiha'dan Nâs'a 11 namaz suresi — Arapça (Amiri hattı) + seçili dilde okunuş + meal (Arapça arayüzde okunuş gizlenir)
- Rehber kuralları birim testlerle doğrulandı: farzın 3-4. rekatında zammı sure okunmaz, vitirde kunut zammı sure ile rükû arasındadır, gayr-i müekkede sünnetlerin oturuş farkları vb.

## [0.6.1] - 2026-07-02

### Değişti
- Başlıktaki الله ve محمد hat yazıları: koyu temada beyaz, açık temada siyah (kontur kaldırıldı)

## [0.6.0] - 2026-07-02

### Eklendi
- "Vaktin Ayeti" sekmesi: içinde bulunulan vakte göre Kur'an-ı Kerim'den o vakitle ilgili bir ayet; Arapça metin Amiri hattıyla her zaman gösterilir, altında seçili dile göre meali ve kaynak (sure/ayet) yer alır. Ayetler uygulamaya gömülü, elle seçilmiş ve doğrulanmış sabit bir listedir (İsrâ 78, Kaf 39, Rûm 18, Tâhâ 130, Rûm 17, Hûd 114)
- Ezan sesi: Ayarlar'da "Vakit girdiğinde: Ezan oku / Bildirim sesi" seçimi. Ezan oku seçiliyken vakit bildirimi ezan sesiyle gelir (28 sn; iOS bildirim sesi sınırı 30 sn'dir). "Önceden hatırlat" seçeneği ayrıca vakitten 5–45 dk önce normal sesli hatırlatma ekler
- Android pusula düzeltmesi: manyetik sapma WMM-2025 modeliyle (geomag) düzeltilir; iOS zaten gerçek kuzey (trueHeading) kullanır. Kıble açıları bilinen şehir değerleriyle birim testlerle doğrulandı (±1°)

### Değişti
- Kıble pusulasının ortasındaki cami ikonu Kâbe (🕋) ile değiştirildi
- Başlıktaki الله ve محمد hat yazılarına koyu kontur eklendi; açık temada da net görünür

### Düzeltildi
- Ana ekran başlığı yeniden "Ezan Vakitleri" oldu ("Vakte" yalnızca uygulamanın adıdır)
- Üst çubuğun rengi varsayılan haline döndürüldü

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

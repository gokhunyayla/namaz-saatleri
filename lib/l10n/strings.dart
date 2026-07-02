/// Uygulama dilleri. Cihaz dili Türkçe → tr, Arapça → ar, diğerleri → en.
enum AppLang { tr, ar, en }

Strings stringsFor(AppLang lang) => switch (lang) {
      AppLang.tr => const StringsTr(),
      AppLang.ar => const StringsAr(),
      AppLang.en => const StringsEn(),
    };

/// Tüm arayüz metinleri. Her dil için bir uygulaması vardır.
abstract class Strings {
  const Strings();

  String get appTitle;
  String get tabTimes;
  String get tabQibla;
  String get tabVerse;
  String get tabSettings;

  /// Sırayla: İmsak, Güneş, Öğle, İkindi, Akşam, Yatsı.
  List<String> get prayerNames;

  String timeUntil(String prayer);
  String get today;
  String get yesterday;
  String get tomorrow;
  String daysAgo(int n);
  String daysLater(int n);
  String get backToToday;
  String get prevDay;
  String get nextDay;
  String get selectDate;
  String get cancel;
  String get refreshLocation;
  String get retry;

  String get locationServiceOff;
  String get locationPermissionDenied;
  String get locationError;

  String get qiblaTitle;
  String get facingQibla;
  String get turnRight;
  String get turnLeft;
  String get qiblaLabel;
  String get headingLabel;
  String get calibrateHint;
  String get compassNotFound;
  String get needLocationFirst;

  /// Sırayla: Kuzey, Doğu, Güney, Batı harfleri.
  List<String> get cardinals;

  String get settingsTitle;
  String get appearance;
  String get light;
  String get dark;
  String get system;
  String get language;
  String get deviceLanguage;
  String get notifications;
  String get prayerReminders;
  String get prayerRemindersSubtitle;
  String get minutesBeforeTitle;
  String get onTime;
  String minutesBeforeOption(int n);

  String notifTitle(String prayer);
  String notifBodyNow(String prayer, String time);
  String notifBodyBefore(String prayer, int minutes, String time);

  String get verseTitle;
  String verseOfPeriod(String prayer);
  String get translationLabel;
  String get anotherVerse;

  String get atPrayerTime;
  String get playAdhan;
  String get notificationSound;
  String get remindBefore;
  String get off;
}

class StringsTr extends Strings {
  const StringsTr();

  @override
  String get appTitle => 'Ezan Vakitleri';
  @override
  String get tabTimes => 'Vakitler';
  @override
  String get tabQibla => 'Kıble';
  @override
  String get tabVerse => 'Vaktin Ayeti';
  @override
  String get tabSettings => 'Ayarlar';

  @override
  List<String> get prayerNames =>
      const ['İmsak', 'Güneş', 'Öğle', 'İkindi', 'Akşam', 'Yatsı'];

  @override
  String timeUntil(String prayer) => '$prayer vaktine kalan';
  @override
  String get today => 'Bugün';
  @override
  String get yesterday => 'Dün';
  @override
  String get tomorrow => 'Yarın';
  @override
  String daysAgo(int n) => '$n gün önce';
  @override
  String daysLater(int n) => '$n gün sonra';
  @override
  String get backToToday => 'Bugüne Dön';
  @override
  String get prevDay => 'Önceki gün';
  @override
  String get nextDay => 'Sonraki gün';
  @override
  String get selectDate => 'Tarih seç';
  @override
  String get cancel => 'İptal';
  @override
  String get refreshLocation => 'Konumu yenile';
  @override
  String get retry => 'Tekrar Dene';

  @override
  String get locationServiceOff =>
      'Konum servisleri kapalı. Lütfen telefonunuzun konum servisini açın.';
  @override
  String get locationPermissionDenied =>
      'Konum izni verilmedi. Ayarlardan uygulamaya konum izni verebilirsiniz.';
  @override
  String get locationError => 'Konum alınamadı.';

  @override
  String get qiblaTitle => 'Kıble Pusulası';
  @override
  String get facingQibla => 'Kıbleye dönüksünüz';
  @override
  String get turnRight => 'Sağa dönün';
  @override
  String get turnLeft => 'Sola dönün';
  @override
  String get qiblaLabel => 'Kıble';
  @override
  String get headingLabel => 'Yönünüz';
  @override
  String get calibrateHint =>
      'Telefonu düz tutun. Doğruluk için telefonu 8 çizecek şekilde hareket ettirerek pusulayı kalibre edebilirsiniz.';
  @override
  String get compassNotFound => 'Bu cihazda pusula sensörü bulunamadı.';
  @override
  String get needLocationFirst =>
      'Kıble yönü için önce Vakitler ekranından konumunuzun alınması gerekiyor.';

  @override
  List<String> get cardinals => const ['K', 'D', 'G', 'B'];

  @override
  String get settingsTitle => 'Ayarlar';
  @override
  String get appearance => 'Görünüm';
  @override
  String get light => 'Açık';
  @override
  String get dark => 'Koyu';
  @override
  String get system => 'Sistem';
  @override
  String get language => 'Dil';
  @override
  String get deviceLanguage => 'Cihaz dili';
  @override
  String get notifications => 'Bildirimler';
  @override
  String get prayerReminders => 'Vakit hatırlatmaları';
  @override
  String get prayerRemindersSubtitle =>
      'Namaz vakti yaklaşınca bildirim gönderilir';
  @override
  String get minutesBeforeTitle => 'Kaç dakika önce?';
  @override
  String get onTime => 'Vaktinde';
  @override
  String minutesBeforeOption(int n) => '$n dk önce';

  @override
  String notifTitle(String prayer) => '$prayer Vakti';
  @override
  String notifBodyNow(String prayer, String time) =>
      '$prayer vakti girdi ($time).';
  @override
  String notifBodyBefore(String prayer, int minutes, String time) =>
      '$prayer vaktine $minutes dakika kaldı ($time).';

  @override
  String get verseTitle => 'Vaktin Ayeti';
  @override
  String verseOfPeriod(String prayer) => '$prayer vaktinin ayeti';
  @override
  String get translationLabel => 'Meali';
  @override
  String get anotherVerse => 'Başka Ayet';

  @override
  String get atPrayerTime => 'Vakit girdiğinde';
  @override
  String get playAdhan => 'Ezan oku';
  @override
  String get notificationSound => 'Bildirim sesi';
  @override
  String get remindBefore => 'Önceden hatırlat';
  @override
  String get off => 'Kapalı';
}

class StringsAr extends Strings {
  const StringsAr();

  @override
  String get appTitle => 'مواقيت الأذان';
  @override
  String get tabTimes => 'المواقيت';
  @override
  String get tabQibla => 'القبلة';
  @override
  String get tabVerse => 'آية الوقت';
  @override
  String get tabSettings => 'الإعدادات';

  @override
  List<String> get prayerNames =>
      const ['الفجر', 'الشروق', 'الظهر', 'العصر', 'المغرب', 'العشاء'];

  @override
  String timeUntil(String prayer) => 'الوقت المتبقي حتى $prayer';
  @override
  String get today => 'اليوم';
  @override
  String get yesterday => 'أمس';
  @override
  String get tomorrow => 'غدًا';
  @override
  String daysAgo(int n) => 'قبل $n أيام';
  @override
  String daysLater(int n) => 'بعد $n أيام';
  @override
  String get backToToday => 'العودة إلى اليوم';
  @override
  String get prevDay => 'اليوم السابق';
  @override
  String get nextDay => 'اليوم التالي';
  @override
  String get selectDate => 'اختر التاريخ';
  @override
  String get cancel => 'إلغاء';
  @override
  String get refreshLocation => 'تحديث الموقع';
  @override
  String get retry => 'أعد المحاولة';

  @override
  String get locationServiceOff =>
      'خدمة الموقع مغلقة. يرجى تشغيل خدمة الموقع في هاتفك.';
  @override
  String get locationPermissionDenied =>
      'لم يتم منح إذن الموقع. يمكنك منح الإذن للتطبيق من الإعدادات.';
  @override
  String get locationError => 'تعذر الحصول على الموقع.';

  @override
  String get qiblaTitle => 'بوصلة القبلة';
  @override
  String get facingQibla => 'أنت باتجاه القبلة';
  @override
  String get turnRight => 'استدر يمينًا';
  @override
  String get turnLeft => 'استدر يسارًا';
  @override
  String get qiblaLabel => 'القبلة';
  @override
  String get headingLabel => 'اتجاهك';
  @override
  String get calibrateHint =>
      'أمسك الهاتف بشكل مستوٍ. لمعايرة البوصلة حرّك الهاتف في الهواء على شكل الرقم 8.';
  @override
  String get compassNotFound => 'لا يوجد مستشعر بوصلة في هذا الجهاز.';
  @override
  String get needLocationFirst =>
      'لتحديد اتجاه القبلة، يجب الحصول على موقعك من شاشة المواقيت أولاً.';

  @override
  List<String> get cardinals => const ['ش', 'ق', 'ج', 'غ'];

  @override
  String get settingsTitle => 'الإعدادات';
  @override
  String get appearance => 'المظهر';
  @override
  String get light => 'فاتح';
  @override
  String get dark => 'داكن';
  @override
  String get system => 'النظام';
  @override
  String get language => 'اللغة';
  @override
  String get deviceLanguage => 'لغة الجهاز';
  @override
  String get notifications => 'الإشعارات';
  @override
  String get prayerReminders => 'تذكيرات الصلاة';
  @override
  String get prayerRemindersSubtitle =>
      'يصلك إشعار عند اقتراب وقت الصلاة';
  @override
  String get minutesBeforeTitle => 'قبل كم دقيقة؟';
  @override
  String get onTime => 'في الوقت';
  @override
  String minutesBeforeOption(int n) => 'قبل $n دقيقة';

  @override
  String notifTitle(String prayer) => 'وقت $prayer';
  @override
  String notifBodyNow(String prayer, String time) =>
      'دخل وقت $prayer ($time).';
  @override
  String notifBodyBefore(String prayer, int minutes, String time) =>
      'بقي $minutes دقيقة على وقت $prayer ($time).';

  @override
  String get verseTitle => 'آية الوقت';
  @override
  String verseOfPeriod(String prayer) => 'آية وقت $prayer';
  @override
  String get translationLabel => 'المعنى';
  @override
  String get anotherVerse => 'آية أخرى';

  @override
  String get atPrayerTime => 'عند دخول الوقت';
  @override
  String get playAdhan => 'تشغيل الأذان';
  @override
  String get notificationSound => 'صوت الإشعار';
  @override
  String get remindBefore => 'تذكير مسبق';
  @override
  String get off => 'إيقاف';
}

class StringsEn extends Strings {
  const StringsEn();

  @override
  String get appTitle => 'Adhan Times';
  @override
  String get tabTimes => 'Times';
  @override
  String get tabQibla => 'Qibla';
  @override
  String get tabVerse => 'Verse';
  @override
  String get tabSettings => 'Settings';

  @override
  List<String> get prayerNames =>
      const ['Fajr', 'Sunrise', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'];

  @override
  String timeUntil(String prayer) => 'Time until $prayer';
  @override
  String get today => 'Today';
  @override
  String get yesterday => 'Yesterday';
  @override
  String get tomorrow => 'Tomorrow';
  @override
  String daysAgo(int n) => '$n days ago';
  @override
  String daysLater(int n) => 'in $n days';
  @override
  String get backToToday => 'Back to Today';
  @override
  String get prevDay => 'Previous day';
  @override
  String get nextDay => 'Next day';
  @override
  String get selectDate => 'Select date';
  @override
  String get cancel => 'Cancel';
  @override
  String get refreshLocation => 'Refresh location';
  @override
  String get retry => 'Try Again';

  @override
  String get locationServiceOff =>
      'Location services are off. Please enable location services on your phone.';
  @override
  String get locationPermissionDenied =>
      'Location permission was not granted. You can grant it in Settings.';
  @override
  String get locationError => 'Could not get your location.';

  @override
  String get qiblaTitle => 'Qibla Compass';
  @override
  String get facingQibla => 'You are facing the Qibla';
  @override
  String get turnRight => 'Turn right';
  @override
  String get turnLeft => 'Turn left';
  @override
  String get qiblaLabel => 'Qibla';
  @override
  String get headingLabel => 'Heading';
  @override
  String get calibrateHint =>
      'Hold the phone flat. To calibrate the compass, move the phone in a figure-8 motion.';
  @override
  String get compassNotFound => 'No compass sensor found on this device.';
  @override
  String get needLocationFirst =>
      'To find the Qibla direction, get your location from the Times screen first.';

  @override
  List<String> get cardinals => const ['N', 'E', 'S', 'W'];

  @override
  String get settingsTitle => 'Settings';
  @override
  String get appearance => 'Appearance';
  @override
  String get light => 'Light';
  @override
  String get dark => 'Dark';
  @override
  String get system => 'System';
  @override
  String get language => 'Language';
  @override
  String get deviceLanguage => 'Device language';
  @override
  String get notifications => 'Notifications';
  @override
  String get prayerReminders => 'Prayer reminders';
  @override
  String get prayerRemindersSubtitle =>
      'Get notified when prayer time approaches';
  @override
  String get minutesBeforeTitle => 'How many minutes before?';
  @override
  String get onTime => 'On time';
  @override
  String minutesBeforeOption(int n) => '$n min before';

  @override
  String notifTitle(String prayer) => '$prayer Time';
  @override
  String notifBodyNow(String prayer, String time) =>
      '$prayer time has begun ($time).';
  @override
  String notifBodyBefore(String prayer, int minutes, String time) =>
      '$minutes minutes until $prayer ($time).';

  @override
  String get verseTitle => 'Verse of the Hour';
  @override
  String verseOfPeriod(String prayer) => 'Verse for $prayer time';
  @override
  String get translationLabel => 'Meaning';
  @override
  String get anotherVerse => 'Another Verse';

  @override
  String get atPrayerTime => 'At prayer time';
  @override
  String get playAdhan => 'Play adhan';
  @override
  String get notificationSound => 'Notification sound';
  @override
  String get remindBefore => 'Remind before';
  @override
  String get off => 'Off';
}

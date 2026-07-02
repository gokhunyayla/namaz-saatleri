import '../l10n/strings.dart';

/// Vakit bilgi modalının metinleri (üç dilde).
/// Anlam/önem açıklamaları Hanefî mezhebi ve Diyanet İlmihali'ne dayanır.
class PeriodInfoL10n {
  final String entersAt;
  final String endsAt;
  final String remaining;
  final String startsIn;
  final String meaningTitle;
  final String kerahatTitle;
  final String noKerahat;
  final String esmaTitle;

  /// Vakit açıklamaları; sırayla İmsak, Güneş, Öğle, İkindi, Akşam, Yatsı.
  final List<String> meanings;

  final String Function(String t1, String t2, String t3, String t4) sunKerahat;
  final String Function(String t1, String t2) asrKerahat;
  final String Function(int h, int m) fmtDuration;

  const PeriodInfoL10n({
    required this.entersAt,
    required this.endsAt,
    required this.remaining,
    required this.startsIn,
    required this.meaningTitle,
    required this.kerahatTitle,
    required this.noKerahat,
    required this.esmaTitle,
    required this.meanings,
    required this.sunKerahat,
    required this.asrKerahat,
    required this.fmtDuration,
  });
}

final _tr = PeriodInfoL10n(
  entersAt: 'Vaktin girişi',
  endsAt: 'Vaktin çıkışı',
  remaining: 'Çıkmasına kalan',
  startsIn: 'Girmesine kalan',
  meaningTitle: 'Anlamı ve Önemi',
  kerahatTitle: 'Kerahat Vakti',
  noKerahat: 'Bu vakitte kerahat yoktur.',
  esmaTitle: 'Esmâü\'l-Hüsnâ',
  meanings: const [
    'Sabah namazının vaktidir; imsak ile başlar, güneşin doğuşuna kadar sürer. Kur\'an\'da "sabah namazı şahitlidir" buyrulur (İsrâ 78); gece ve gündüz meleklerinin buluştuğu vakit olarak bilinir. Oruç tutanlar için yeme-içmenin sona erdiği andır.',
    'Güneşin doğuşundan öğleye kadar süren bu dilim bir namaz vakti değildir. Kuşluk (Duhâ) namazı, doğuş kerahati çıktıktan sonra bu dilimde kılınır.',
    'Güneşin tepe noktasını aşıp batıya kaymasıyla (zeval) girer, ikindiye kadar sürer. Cuma namazı da bu vakitte kılınır. Vaktin içinde kerahat yoktur.',
    'Kur\'an\'da "orta namaz" (salât-ı vustâ) olarak yorumlanan ikindi namazının vaktidir (Bakara 238). Hadiste ikindiyi kaçırmanın büyük kayıp olduğu bildirilmiştir.',
    'Güneşin batmasıyla girer, şafağın kaybolmasına (yatsıya) kadar sürer. Vakti diğerlerine göre kısa olduğundan akşam namazını geciktirmeden kılmak müstehaptır. Oruçlular için iftar vaktidir.',
    'Şafağın kaybolmasıyla girer, imsağa kadar sürer. Vitir namazı da yatsıdan sonra kılınır; gece ibadetiyle (teheccüd) taçlanan gecenin son farz namazıdır.',
  ],
  sunKerahat: (t1, t2, t3, t4) =>
      'Güneş doğduktan sonra yaklaşık 45 dakika ($t1 – $t2) ve öğleden önce istivâ anında yaklaşık 10 dakika ($t3 – $t4) kerahat vaktidir; bu aralıklarda nafile namaz kılınmaz.',
  asrKerahat: (t1, t2) =>
      'Akşam ezanından önceki yaklaşık 45 dakika ($t1 – $t2), güneşin sararması (isfirâr) sebebiyle kerahat vaktidir; o günün ikindi farzı dışında namaz kılmak mekruhtur.',
  fmtDuration: (h, m) => h > 0 ? '$h sa $m dk' : '$m dk',
);

final _ar = PeriodInfoL10n(
  entersAt: 'دخول الوقت',
  endsAt: 'خروج الوقت',
  remaining: 'المتبقي حتى الخروج',
  startsIn: 'المتبقي حتى الدخول',
  meaningTitle: 'معناه وأهميته',
  kerahatTitle: 'وقت الكراهة',
  noKerahat: 'لا كراهة في هذا الوقت.',
  esmaTitle: 'أسماء الله الحسنى',
  meanings: const [
    'وقت صلاة الفجر؛ يبدأ بطلوع الفجر الصادق ويمتد إلى شروق الشمس. قال تعالى: «إن قرآن الفجر كان مشهودًا» (الإسراء ٧٨). وهو وقت إمساك الصائم.',
    'ما بين الشروق والظهر ليس وقت صلاة مفروضة. تُصلى فيه صلاة الضحى بعد خروج وقت كراهة الشروق.',
    'يدخل بزوال الشمس عن كبد السماء ويمتد إلى العصر. وفيه تُصلى الجمعة. لا كراهة داخل هذا الوقت.',
    'وقت صلاة العصر، وهي الصلاة الوسطى في قول كثير من المفسرين (البقرة ٢٣٨). وقد ورد التشديد في المحافظة عليها.',
    'يدخل بغروب الشمس ويمتد إلى مغيب الشفق. يُستحب تعجيل صلاة المغرب لقصر وقتها. وهو وقت إفطار الصائم.',
    'يدخل بمغيب الشفق ويمتد إلى الفجر. ويُصلى الوتر بعد العشاء، وهي آخر فريضة قبل قيام الليل.',
  ],
  sunKerahat: (t1, t2, t3, t4) =>
      'بعد الشروق نحو ٤٥ دقيقة ($t1 – $t2) وقبيل الظهر عند الاستواء نحو ١٠ دقائق ($t3 – $t4) وقتا كراهة؛ لا تُصلى فيهما النافلة.',
  asrKerahat: (t1, t2) =>
      'نحو ٤٥ دقيقة قبل المغرب ($t1 – $t2) وقت كراهة لاصفرار الشمس؛ يُكره فيه التنفل، ويُصلى فرض عصر اليوم.',
  fmtDuration: (h, m) => h > 0 ? '$h س $m د' : '$m د',
);

final _en = PeriodInfoL10n(
  entersAt: 'Begins at',
  endsAt: 'Ends at',
  remaining: 'Time remaining',
  startsIn: 'Starts in',
  meaningTitle: 'Meaning & Significance',
  kerahatTitle: 'Disliked (Makruh) Time',
  noKerahat: 'There is no makruh time within this period.',
  esmaTitle: '99 Names of Allah',
  meanings: const [
    'The time of the Fajr prayer; it begins at true dawn and lasts until sunrise. The Quran says "the recitation of dawn is ever witnessed" (17:78). For those fasting, it marks the start of the fast.',
    'The stretch from sunrise to noon is not a time of obligatory prayer. The Duha (forenoon) prayer is offered in this period once the post-sunrise makruh time has passed.',
    'It begins when the sun passes its zenith (zawal) and lasts until Asr. The Friday prayer is also held in this time. There is no makruh time within it.',
    'The time of the Asr prayer, widely interpreted as the "middle prayer" of the Quran (2:238). Hadiths strongly warn against missing it.',
    'It begins at sunset and lasts until the twilight disappears. As it is the shortest period, praying Maghrib promptly is recommended. It is also the time of breaking the fast.',
    'It begins when twilight disappears and lasts until dawn. The Witr prayer follows Isha; it is the final obligatory prayer before the night vigil.',
  ],
  sunKerahat: (t1, t2, t3, t4) =>
      'About 45 minutes after sunrise ($t1 – $t2) and about 10 minutes before Dhuhr at the zenith ($t3 – $t4) are makruh times; voluntary prayer is not offered then.',
  asrKerahat: (t1, t2) =>
      'About 45 minutes before Maghrib ($t1 – $t2) is a makruh time as the sun yellows (isfirar); only that day\'s Asr fard is prayed then.',
  fmtDuration: (h, m) => h > 0 ? '${h}h ${m}m' : '${m}m',
);

PeriodInfoL10n periodInfoFor(AppLang lang) => switch (lang) {
      AppLang.tr => _tr,
      AppLang.ar => _ar,
      AppLang.en => _en,
    };

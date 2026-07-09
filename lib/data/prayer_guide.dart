import '../l10n/strings.dart';

/// Namaz kılınış rehberi.
///
/// Anlatım Hanefî mezhebine (Diyanet İlmihali) göredir. Adımlar formülle
/// üretilir: rekat sayısı ve bölüm türüne göre hangi rekatta ne okunacağı
/// aşağıdaki kurallarla belirlenir:
/// - Farzların 1-2. rekatlarında Fâtiha + zammı sure, 3-4. rekatlarında
///   yalnız Fâtiha okunur. Sünnetlerin her rekatında zammı sure vardır.
/// - İkindi ve yatsının ilk sünnetleri (gayr-i müekkede) ilk oturuşta
///   Salli-Bârik de okunur ve 3. rekata kalkınca Sübhâneke tekrarlanır.
/// - Vitir namazının 3. rekatında zammı sureden sonra tekbir alınıp
///   Kunut duaları okunur.
enum PartKind { sunnah, sunnahFirst, sunnahLast, fard, witr }

class PrayerPart {
  final PartKind kind;
  final int rakats;

  /// Gayr-i müekkede sünnet (ikindi ve yatsının ilk sünnetleri).
  final bool gayriMuekkede;

  const PrayerPart(this.kind, this.rakats, {this.gayriMuekkede = false});
}

class PrayerGuideDef {
  /// prayerNames dizisindeki vakit indeksi (0 İmsak/Sabah ... 5 Yatsı).
  final int prayerIndex;
  final List<PrayerPart> parts;

  const PrayerGuideDef(this.prayerIndex, this.parts);
}

const List<PrayerGuideDef> prayerGuides = [
  // Sabah: 2 sünnet + 2 farz
  PrayerGuideDef(0, [
    PrayerPart(PartKind.sunnah, 2),
    PrayerPart(PartKind.fard, 2),
  ]),
  // Öğle: 4 ilk sünnet + 4 farz + 2 son sünnet
  PrayerGuideDef(2, [
    PrayerPart(PartKind.sunnahFirst, 4),
    PrayerPart(PartKind.fard, 4),
    PrayerPart(PartKind.sunnahLast, 2),
  ]),
  // İkindi: 4 sünnet (gayr-i müekkede) + 4 farz
  PrayerGuideDef(3, [
    PrayerPart(PartKind.sunnah, 4, gayriMuekkede: true),
    PrayerPart(PartKind.fard, 4),
  ]),
  // Akşam: 3 farz + 2 sünnet
  PrayerGuideDef(4, [
    PrayerPart(PartKind.fard, 3),
    PrayerPart(PartKind.sunnahLast, 2),
  ]),
  // Yatsı: 4 ilk sünnet (gayr-i müekkede) + 4 farz + 2 son sünnet + 3 vitir
  PrayerGuideDef(5, [
    PrayerPart(PartKind.sunnahFirst, 4, gayriMuekkede: true),
    PrayerPart(PartKind.fard, 4),
    PrayerPart(PartKind.sunnahLast, 2),
    PrayerPart(PartKind.witr, 3),
  ]),
];

/// Rehber ekranının tüm metinleri (üç dilde).
class GuideL10n {
  final String tabGuide;
  final String guideTitle;
  final String prayersSection;
  final String textsSection;
  final String groupDaily;
  final String groupOther;
  final String popularGroup;
  final String duasGroup;
  final String surasGroup;
  final String guideNote;
  final String translitLabel;
  final String meaningLabel;

  final String partSunnah;
  final String partSunnahFirst;
  final String partSunnahLast;
  final String partFard;
  final String partWitr;

  /// Sabah, Öğle, İkindi, Akşam, Yatsı (namaz adları).
  final List<String> prayerNames;

  // Adımlar
  final String stIntention;
  final String stTakbir;
  final String stSubhaneke;
  final String stTaawwuz;
  final String stBasmala;
  final String stFatiha;
  final String stSurah;
  final String stRuku;
  final String stRise;
  final String stSujud;
  final String stSitBetween;
  final String stSujud2;
  final String stStand;
  final String stSitFirst;
  final String stSitFirstGM;
  final String stSitFinal;
  final String stSalam;
  final String stQunut;
  final String stSubhanekeAgain;

  final String Function(int) rakatTitle;
  final String Function(int) rakatCount;

  const GuideL10n({
    required this.tabGuide,
    required this.guideTitle,
    required this.prayersSection,
    required this.textsSection,
    required this.groupDaily,
    required this.groupOther,
    required this.popularGroup,
    required this.duasGroup,
    required this.surasGroup,
    required this.guideNote,
    required this.translitLabel,
    required this.meaningLabel,
    required this.partSunnah,
    required this.partSunnahFirst,
    required this.partSunnahLast,
    required this.partFard,
    required this.partWitr,
    required this.prayerNames,
    required this.stIntention,
    required this.stTakbir,
    required this.stSubhaneke,
    required this.stTaawwuz,
    required this.stBasmala,
    required this.stFatiha,
    required this.stSurah,
    required this.stRuku,
    required this.stRise,
    required this.stSujud,
    required this.stSitBetween,
    required this.stSujud2,
    required this.stStand,
    required this.stSitFirst,
    required this.stSitFirstGM,
    required this.stSitFinal,
    required this.stSalam,
    required this.stQunut,
    required this.stSubhanekeAgain,
    required this.rakatTitle,
    required this.rakatCount,
  });

  String partLabel(PartKind kind) => switch (kind) {
        PartKind.sunnah => partSunnah,
        PartKind.sunnahFirst => partSunnahFirst,
        PartKind.sunnahLast => partSunnahLast,
        PartKind.fard => partFard,
        PartKind.witr => partWitr,
      };
}

String _trRakat(int n) => '$n. Rekat';
String _trCount(int n) => '$n Rekat';
String _arRakat(int n) => 'الركعة $n';
String _arCount(int n) => '$n ركعات';
String _enRakat(int n) => 'Rak\'ah $n';
String _enCount(int n) => '$n Rak\'ahs';

final _tr = GuideL10n(
  tabGuide: 'Namaz',
  guideTitle: 'Namaz Nasıl Kılınır',
  prayersSection: 'Namazlar',
  textsSection: 'Sureler ve Dualar',
  groupDaily: 'Vakit Namazları',
  groupOther: 'Diğer Namazlar',
  popularGroup: 'Çok Okunan Sureler',
  duasGroup: 'Namaz Duaları',
  surasGroup: 'Namaz Sureleri (Zammı Sure)',
  guideNote:
      'Anlatım, Hanefî mezhebine (Diyanet İlmihali) göredir. Okunan sure ve duaların metinleri için "Sureler ve Dualar" bölümüne bakabilirsiniz.',
  translitLabel: 'Okunuşu',
  meaningLabel: 'Meali',
  partSunnah: 'Sünnet',
  partSunnahFirst: 'İlk Sünnet',
  partSunnahLast: 'Son Sünnet',
  partFard: 'Farz',
  partWitr: 'Vitir',
  prayerNames: const ['Sabah', 'Öğle', 'İkindi', 'Akşam', 'Yatsı'],
  stIntention: 'Niyet edilir (hangi namazın kılınacağı kalpten geçirilir)',
  stTakbir: 'İftitah tekbiri alınır: "Allâhü Ekber" (eller kulak hizasına kaldırılır, sonra bağlanır)',
  stSubhaneke: 'Sübhâneke okunur',
  stTaawwuz: 'Eûzü besmele çekilir',
  stBasmala: 'Besmele çekilir',
  stFatiha: 'Fâtiha Suresi okunur',
  stSurah: 'Zammı sure okunur (kısa bir sure, örneğin İhlâs)',
  stRuku: 'Rükûya eğilir; 3 kez "Sübhâne Rabbiye\'l-azîm" denir',
  stRise: 'Doğrulurken "Semiallâhü limen hamideh", doğrulunca "Rabbenâ leke\'l-hamd" denir',
  stSujud: '"Allâhü Ekber" diyerek secdeye varılır; 3 kez "Sübhâne Rabbiye\'l-a\'lâ" denir',
  stSitBetween: '"Allâhü Ekber" ile doğrulup kısa bir süre oturulur',
  stSujud2: 'İkinci secde yapılır; yine 3 kez "Sübhâne Rabbiye\'l-a\'lâ" denir',
  stStand: '"Allâhü Ekber" diyerek ayağa kalkılır, sonraki rekata geçilir',
  stSitFirst: 'Oturulur; Ettehiyyâtü okunur',
  stSitFirstGM: 'Oturulur; Ettehiyyâtü, Allâhümme Salli ve Allâhümme Bârik okunur',
  stSitFinal: 'Son oturuş: Ettehiyyâtü, Allâhümme Salli, Allâhümme Bârik, Rabbenâ Âtinâ ve Rabbenâğfirlî okunur',
  stSalam: 'Önce sağa, sonra sola dönerek selam verilir: "Esselâmü aleyküm ve rahmetullâh"',
  stQunut: 'Zammı sureden sonra eller kaldırılıp tekbir alınır ve Kunut duaları okunur',
  stSubhanekeAgain: '3. rekata kalkınca Sübhâneke okunur ve eûzü besmele çekilerek devam edilir',
  rakatTitle: _trRakat,
  rakatCount: _trCount,
);

final _ar = GuideL10n(
  tabGuide: 'الصلاة',
  guideTitle: 'كيفية الصلاة',
  prayersSection: 'الصلوات',
  textsSection: 'السور والأدعية',
  groupDaily: 'الصلوات الخمس',
  groupOther: 'صلوات أخرى',
  popularGroup: 'سور كثيرة القراءة',
  duasGroup: 'أدعية الصلاة',
  surasGroup: 'سور الصلاة',
  guideNote: 'الشرح وفق المذهب الحنفي. تجد نصوص السور والأدعية في قسم "السور والأدعية".',
  translitLabel: 'النطق',
  meaningLabel: 'المعنى',
  partSunnah: 'السنة',
  partSunnahFirst: 'السنة القبلية',
  partSunnahLast: 'السنة البعدية',
  partFard: 'الفرض',
  partWitr: 'الوتر',
  prayerNames: const ['الفجر', 'الظهر', 'العصر', 'المغرب', 'العشاء'],
  stIntention: 'تُعقد النية',
  stTakbir: 'تكبيرة الإحرام: «الله أكبر»',
  stSubhaneke: 'يُقرأ دعاء الاستفتاح (سبحانك)',
  stTaawwuz: 'يُقرأ التعوذ والبسملة',
  stBasmala: 'تُقرأ البسملة',
  stFatiha: 'تُقرأ سورة الفاتحة',
  stSurah: 'تُقرأ سورة قصيرة (مثل الإخلاص)',
  stRuku: 'الركوع: «سبحان ربي العظيم» (٣ مرات)',
  stRise: 'الرفع من الركوع: «سمع الله لمن حمده، ربنا لك الحمد»',
  stSujud: 'السجود مع التكبير: «سبحان ربي الأعلى» (٣ مرات)',
  stSitBetween: 'جلسة قصيرة بين السجدتين مع التكبير',
  stSujud2: 'السجدة الثانية: «سبحان ربي الأعلى» (٣ مرات)',
  stStand: 'القيام إلى الركعة التالية مع التكبير',
  stSitFirst: 'الجلوس الأول: تُقرأ التحيات',
  stSitFirstGM: 'الجلوس: تُقرأ التحيات والصلاة الإبراهيمية (اللهم صلِّ وبارك)',
  stSitFinal: 'الجلوس الأخير: التحيات والصلاة الإبراهيمية ودعاء "ربنا آتنا" و"ربنا اغفر لي"',
  stSalam: 'التسليم يمينًا ثم يسارًا: «السلام عليكم ورحمة الله»',
  stQunut: 'بعد السورة تُرفع اليدان بالتكبير ثم يُقرأ دعاء القنوت',
  stSubhanekeAgain: 'عند القيام للركعة الثالثة يُقرأ الاستفتاح ثم التعوذ والبسملة',
  rakatTitle: _arRakat,
  rakatCount: _arCount,
);

final _en = GuideL10n(
  tabGuide: 'Prayer',
  guideTitle: 'How to Pray',
  prayersSection: 'Prayers',
  textsSection: 'Surahs & Supplications',
  groupDaily: 'Daily Prayers',
  groupOther: 'Other Prayers',
  popularGroup: 'Frequently Read Surahs',
  duasGroup: 'Prayer Supplications',
  surasGroup: 'Prayer Surahs',
  guideNote:
      'The description follows the Hanafi school (Turkish Diyanet). See the "Surahs & Supplications" section for the full texts.',
  translitLabel: 'Transliteration',
  meaningLabel: 'Meaning',
  partSunnah: 'Sunnah',
  partSunnahFirst: 'First Sunnah',
  partSunnahLast: 'Final Sunnah',
  partFard: 'Fard',
  partWitr: 'Witr',
  prayerNames: const ['Fajr', 'Dhuhr', 'Asr', 'Maghrib', 'Isha'],
  stIntention: 'Make the intention for the prayer',
  stTakbir: 'Opening takbir: "Allahu Akbar" (raise hands, then fold them)',
  stSubhaneke: 'Recite Subhanaka',
  stTaawwuz: 'Recite ta\'awwudh and basmala',
  stBasmala: 'Recite basmala',
  stFatiha: 'Recite Surah Al-Fatiha',
  stSurah: 'Recite a short surah (e.g. Al-Ikhlas)',
  stRuku: 'Bow (ruku): say "Subhana Rabbiyal-\'Azim" 3 times',
  stRise: 'Rise saying "Sami\'Allahu liman hamidah", then "Rabbana lakal-hamd"',
  stSujud: 'Prostrate with takbir: say "Subhana Rabbiyal-A\'la" 3 times',
  stSitBetween: 'Sit up briefly between the two prostrations with takbir',
  stSujud2: 'Second prostration: "Subhana Rabbiyal-A\'la" 3 times',
  stStand: 'Stand up for the next rak\'ah with takbir',
  stSitFirst: 'First sitting: recite At-Tahiyyat',
  stSitFirstGM: 'Sitting: recite At-Tahiyyat, Allahumma Salli and Allahumma Barik',
  stSitFinal: 'Final sitting: At-Tahiyyat, Allahumma Salli, Allahumma Barik, Rabbana Atina and Rabbanaghfirli',
  stSalam: 'Give salam to the right, then to the left: "As-salamu \'alaykum wa rahmatullah"',
  stQunut: 'After the surah, raise hands with takbir and recite the Qunut supplications',
  stSubhanekeAgain: 'When rising for the 3rd rak\'ah, recite Subhanaka, then ta\'awwudh and basmala',
  rakatTitle: _enRakat,
  rakatCount: _enCount,
);

GuideL10n guideL10nFor(AppLang lang) => switch (lang) {
      AppLang.tr => _tr,
      AppLang.ar => _ar,
      AppLang.en => _en,
    };

/// Bir namaz bölümünün rekat rekat adımlarını üretir.
List<(String title, List<String> steps)> buildRakats(
    GuideL10n g, PrayerPart part) {
  final isFard = part.kind == PartKind.fard;
  final isWitr = part.kind == PartKind.witr;
  final n = part.rakats;
  final out = <(String, List<String>)>[];

  for (var r = 1; r <= n; r++) {
    final steps = <String>[];

    // Kıyam (ayakta okuma) bölümü.
    if (r == 1) {
      steps.add(g.stIntention);
      steps.add(g.stTakbir);
      steps.add(g.stSubhaneke);
      steps.add(g.stTaawwuz);
    } else if (r == 3 && part.gayriMuekkede) {
      steps.add(g.stSubhanekeAgain);
    } else {
      steps.add(g.stBasmala);
    }
    steps.add(g.stFatiha);

    // Zammı sure: farzlarda yalnız 1-2. rekatlarda, diğerlerinde her rekatta.
    if (!isFard || r <= 2) steps.add(g.stSurah);

    // Vitirde 3. rekatta kunut.
    if (isWitr && r == 3) steps.add(g.stQunut);

    // Rükû ve secdeler.
    steps.add(g.stRuku);
    steps.add(g.stRise);
    steps.add(g.stSujud);
    steps.add(g.stSitBetween);
    steps.add(g.stSujud2);

    // Oturuş / kalkış.
    if (r == n) {
      steps.add(g.stSitFinal);
      steps.add(g.stSalam);
    } else if (r == 2 && n > 2) {
      steps.add(part.gayriMuekkede ? g.stSitFirstGM : g.stSitFirst);
      steps.add(g.stStand);
    } else {
      steps.add(g.stStand);
    }

    out.add((g.rakatTitle(r), steps));
  }
  return out;
}

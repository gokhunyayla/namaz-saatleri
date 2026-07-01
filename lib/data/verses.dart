/// Vaktin Ayeti verileri.
///
/// ÖNEMLİ: Buradaki ayetler sabit, elle seçilmiş ve doğrulanmış bir listedir;
/// hiçbir metin çalışma anında üretilmez veya internetten çekilmez.
/// Her vakit için, o vakitle tematik olarak ilgili, Kur'an-ı Kerim'den
/// TAM bir ayet yer alır (kısaltma/alıntı yapılmamıştır).
/// Sıra, vakit listesiyle aynıdır: İmsak, Güneş, Öğle, İkindi, Akşam, Yatsı.
class Verse {
  /// Ayetin Arapça tam metni.
  final String arabic;

  /// Türkçe meal.
  final String tr;

  /// İngilizce meal.
  final String en;

  /// Kaynak gösterimi (sure adı ve ayet numarası), üç dilde.
  final String refTr;
  final String refAr;
  final String refEn;

  const Verse({
    required this.arabic,
    required this.tr,
    required this.en,
    required this.refTr,
    required this.refAr,
    required this.refEn,
  });
}

/// İndeks 0..5 → İmsak, Güneş, Öğle, İkindi, Akşam, Yatsı.
const List<Verse> versesByPeriod = [
  // İmsak — sabah namazına işaret eden ayet.
  Verse(
    arabic:
        'أَقِمِ الصَّلَاةَ لِدُلُوكِ الشَّمْسِ إِلَىٰ غَسَقِ اللَّيْلِ وَقُرْآنَ الْفَجْرِ ۖ إِنَّ قُرْآنَ الْفَجْرِ كَانَ مَشْهُودًا',
    tr: 'Güneşin batıya kaymasından gecenin karanlığına kadar namazı kıl; sabah namazını da. Çünkü sabah namazı şahitlidir.',
    en: 'Establish prayer from the decline of the sun until the darkness of the night, and the recitation of dawn. Indeed, the recitation of dawn is ever witnessed.',
    refTr: 'İsrâ Suresi, 78. Ayet',
    refAr: 'سورة الإسراء، الآية ٧٨',
    refEn: 'Surah Al-Isra, 17:78',
  ),
  // Güneş — güneş doğmadan önce tesbihi emreden ayet.
  Verse(
    arabic:
        'فَاصْبِرْ عَلَىٰ مَا يَقُولُونَ وَسَبِّحْ بِحَمْدِ رَبِّكَ قَبْلَ طُلُوعِ الشَّمْسِ وَقَبْلَ الْغُرُوبِ',
    tr: 'Onların söylediklerine sabret; güneşin doğuşundan önce ve batışından önce Rabbini hamd ile tesbih et.',
    en: 'So be patient over what they say, and exalt with praise of your Lord before the rising of the sun and before its setting.',
    refTr: 'Kaf Suresi, 39. Ayet',
    refAr: 'سورة ق، الآية ٣٩',
    refEn: 'Surah Qaf, 50:39',
  ),
  // Öğle — öğle vaktini anan ayet.
  Verse(
    arabic:
        'وَلَهُ الْحَمْدُ فِي السَّمَاوَاتِ وَالْأَرْضِ وَعَشِيًّا وَحِينَ تُظْهِرُونَ',
    tr: 'Göklerde ve yerde hamd O\'na mahsustur. Gündüzün sonunda ve öğle vaktine girdiğinizde de (O\'nu tesbih edin).',
    en: 'And to Him is due all praise in the heavens and the earth, and in the evening and when you are at noon.',
    refTr: 'Rûm Suresi, 18. Ayet',
    refAr: 'سورة الروم، الآية ١٨',
    refEn: 'Surah Ar-Rum, 30:18',
  ),
  // İkindi — güneş batmadan önce tesbihi emreden ayet.
  Verse(
    arabic:
        'فَاصْبِرْ عَلَىٰ مَا يَقُولُونَ وَسَبِّحْ بِحَمْدِ رَبِّكَ قَبْلَ طُلُوعِ الشَّمْسِ وَقَبْلَ غُرُوبِهَا ۖ وَمِنْ آنَاءِ اللَّيْلِ فَسَبِّحْ وَأَطْرَافَ النَّهَارِ لَعَلَّكَ تَرْضَىٰ',
    tr: 'Onların söylediklerine sabret. Güneşin doğuşundan önce ve batışından önce Rabbini hamd ile tesbih et. Gecenin bazı saatlerinde ve gündüzün uçlarında da tesbih et ki hoşnut olasın.',
    en: 'So be patient over what they say and exalt with praise of your Lord before the rising of the sun and before its setting; and during periods of the night exalt Him and at the ends of the day, that you may be satisfied.',
    refTr: 'Tâhâ Suresi, 130. Ayet',
    refAr: 'سورة طه، الآية ١٣٠',
    refEn: 'Surah Ta-Ha, 20:130',
  ),
  // Akşam — akşama girerken tesbihi anan ayet.
  Verse(
    arabic: 'فَسُبْحَانَ اللَّهِ حِينَ تُمْسُونَ وَحِينَ تُصْبِحُونَ',
    tr: 'Akşama girdiğinizde ve sabaha kavuştuğunuzda Allah\'ı tesbih edin.',
    en: 'So glorify Allah when you reach the evening and when you rise in the morning.',
    refTr: 'Rûm Suresi, 17. Ayet',
    refAr: 'سورة الروم، الآية ١٧',
    refEn: 'Surah Ar-Rum, 30:17',
  ),
  // Yatsı — gecenin ilk saatlerinde namazı emreden ayet.
  Verse(
    arabic:
        'وَأَقِمِ الصَّلَاةَ طَرَفَيِ النَّهَارِ وَزُلَفًا مِّنَ اللَّيْلِ ۚ إِنَّ الْحَسَنَاتِ يُذْهِبْنَ السَّيِّئَاتِ ۚ ذَٰلِكَ ذِكْرَىٰ لِلذَّاكِرِينَ',
    tr: 'Gündüzün iki ucunda ve gecenin ilk saatlerinde namazı kıl. Şüphesiz iyilikler kötülükleri giderir. Bu, öğüt alanlar için bir hatırlatmadır.',
    en: 'And establish prayer at the two ends of the day and at the approach of the night. Indeed, good deeds do away with misdeeds. That is a reminder for those who remember.',
    refTr: 'Hûd Suresi, 114. Ayet',
    refAr: 'سورة هود، الآية ١١٤',
    refEn: 'Surah Hud, 11:114',
  ),
];

import 'prayer_guide.dart';

/// Vakit namazlari disindaki namazlar. Her namaz bolumlerden (OtherSection)
/// olusur: bolum ya rekat motoruyla (part) vakit namazlari gibi rekat rekat
/// anlatilir, ya ozel adim listesiyle (Bayram tekbirleri, Cenaze, Tesbih),
/// ya da bilgi kartidir (Hutbe gibi).
/// Icerik sabittir; Hanefi mezhebi / Diyanet Ilmihali esas alinmistir.
class OtherSection {
  final String labelTr;
  final String labelAr;
  final String labelEn;

  /// Rekat motoru ile anlatim (vakit namazlariyla ayni).
  final PrayerPart? part;

  /// Ozel adimlar (motorun karsilayamadigi kilinislar).
  final List<String>? stepsTr;
  final List<String>? stepsAr;
  final List<String>? stepsEn;

  /// Bolum hakkinda bilgi notu.
  final String? infoTr;
  final String? infoAr;
  final String? infoEn;

  const OtherSection(this.labelTr, this.labelAr, this.labelEn,
      {this.part,
      this.stepsTr,
      this.stepsAr,
      this.stepsEn,
      this.infoTr,
      this.infoAr,
      this.infoEn});
}

class OtherPrayer {
  final String nameTr;
  final String nameAr;
  final String nameEn;
  final String subtitleTr;
  final String subtitleAr;
  final String subtitleEn;
  final String introTr;
  final String introAr;
  final String introEn;

  /// Listede gosterilen rekat sayisi (orn. '16', '2-8').
  final String countLabel;
  final List<OtherSection> sections;

  const OtherPrayer(
      this.nameTr, this.nameAr, this.nameEn,
      this.subtitleTr, this.subtitleAr, this.subtitleEn,
      this.introTr, this.introAr, this.introEn,
      this.countLabel, this.sections);
}

const List<OtherPrayer> otherPrayers = [
  OtherPrayer(
    'Cuma Namazı', 'صلاة الجمعة', 'Friday Prayer',
    'Cuma günü öğle vaktinde, cemaatle — 16 rekat', 'يوم الجمعة جماعة — ١٦ ركعة', 'Friday noon, in congregation — 16 rak\'ahs',
    'Cuma namazı, cuma günü öğle vakti cemaatle kılınır ve o günün öğle namazının yerine geçer; erkeklere farzdır. Hutbe, cuma namazının şartıdır. Türkiye\'deki yaygın uygulamada (Diyanet İlmihali) toplam 16 rekattır: 4 ilk sünnet + 2 farz + 4 son sünnet + 4 zuhr-i âhir + 2 vaktin sünneti. Namazdan sonra tesbihat yapılır ve dua edilir.',
    'تُصلى الجمعة جماعة وقت الظهر وهي فرض على الرجال، والخطبة شرط لها. في التطبيق الشائع بتركيا مجموعها ١٦ ركعة: ٤ سنة قبلية + ٢ فرض + ٤ سنة بعدية + ٤ ظهر آخر + ٢ سنة الوقت، ثم التسبيحات والدعاء.',
    'The Friday prayer is held in congregation at noon and replaces Dhuhr; it is obligatory for men, and the khutbah is its condition. In common Turkish practice (Diyanet) it totals 16 rak\'ahs: 4 first sunnah + 2 fard + 4 final sunnah + 4 zuhr akhir + 2 sunnah of the time, followed by tasbihat and supplication.',
    '16',
    [
      OtherSection('İlk Sünnet • 4 Rekat', 'السنة القبلية • ٤ ركعات', 'First Sunnah • 4 Rak\'ahs',
        part: PrayerPart(PartKind.sunnahFirst, 4),
      ),
      OtherSection('Hutbe', 'الخطبة', 'Khutbah',
        infoTr: 'İmam minbere çıkar ve hutbe okur. Hutbeyi sessizce dinlemek gerekir; hutbe esnasında konuşulmaz, namaz kılınmaz.',
        infoAr: 'يصعد الإمام المنبر ويخطب؛ يجب الإنصات للخطبة ولا يُتكلم أثناءها.',
        infoEn: 'The imam delivers the sermon from the minbar. It must be listened to silently; no talking or praying during it.',
      ),
      OtherSection('Farz • 2 Rekat (Cemaatle)', 'الفرض • ركعتان (جماعة)', 'Fard • 2 Rak\'ahs (Congregation)',
        part: PrayerPart(PartKind.fard, 2),
        infoTr: 'İmama uyularak kılınır; imam Fâtiha ve sureyi sesli okur, cemaat dinler.',
        infoAr: 'تُصلى خلف الإمام ويجهر بالقراءة وينصت المأموم.',
        infoEn: 'Prayed behind the imam, who recites aloud while the congregation listens.',
      ),
      OtherSection('Son Sünnet • 4 Rekat', 'السنة البعدية • ٤ ركعات', 'Final Sunnah • 4 Rak\'ahs',
        part: PrayerPart(PartKind.sunnahFirst, 4),
      ),
      OtherSection('Zuhr-i Âhir • 4 Rekat', 'ظهر آخر • ٤ ركعات', 'Zuhr Akhir • 4 Rak\'ahs',
        part: PrayerPart(PartKind.sunnahFirst, 4),
        infoTr: '"Vaktine yetişip henüz kılamadığım son öğle namazı" niyetiyle ihtiyaten kılınır.',
        infoAr: 'تُصلى احتياطًا بنية آخر ظهر أدركتُ وقته ولم أصله بعد.',
        infoEn: 'Prayed as a precaution with the intention of the last Dhuhr whose time was reached but not yet prayed.',
      ),
      OtherSection('Vaktin Sünneti • 2 Rekat', 'سنة الوقت • ركعتان', 'Sunnah of the Time • 2 Rak\'ahs',
        part: PrayerPart(PartKind.sunnahLast, 2),
        infoTr: 'Namazın ardından tesbihat yapılır (33 Sübhânallah, 33 Elhamdülillah, 33 Allâhü Ekber) ve dua edilir.',
        infoAr: 'بعد الصلاة تُقال التسبيحات (٣٣ سبحان الله، ٣٣ الحمد لله، ٣٣ الله أكبر) ثم الدعاء.',
        infoEn: 'Afterwards, tasbihat is recited (33x Subhanallah, Alhamdulillah, Allahu Akbar) followed by supplication.',
      ),
    ]),
  OtherPrayer(
    'Bayram Namazı', 'صلاة العيد', 'Eid Prayer',
    'Bayram sabahı, cemaatle — zevaid tekbirli', 'صباح العيد جماعة — بتكبيرات زوائد', 'Eid morning, congregation — extra takbirs',
    'Bayram namazı, bayram sabahı güneş doğup kerahat vakti çıktıktan sonra cemaatle kılınan 2 rekatlık vacip namazdır. Farkı, her rekattaki üçer zevaid tekbiridir. Hutbe bayramda namazdan sonradır.',
    'صلاة العيد ركعتان واجبة تُصليان جماعة بعد ارتفاع الشمس، وتمتاز بثلاث تكبيرات زوائد في كل ركعة، وخطبتها بعد الصلاة.',
    'The Eid prayer is 2 obligatory rak\'ahs in congregation after sunrise, distinguished by three extra takbirs in each rak\'ah; the sermon follows the prayer.',
    '2',
    [
      OtherSection('1. Rekat', 'الركعة الأولى', 'Rak\'ah 1',
        stepsTr: [
          'Niyet edilir (bayram namazına, imama uyarak) ve iftitah tekbiri alınır; Sübhâneke okunur',
          '1. zevaid tekbiri: eller kulak hizasına kaldırılır ve yanlara salınır',
          '2. zevaid tekbiri: eller yine kaldırılır ve salınır',
          '3. zevaid tekbiri: eller kaldırılır ve bu kez bağlanır',
          'İmam Fâtiha ve sureyi sesli okur; cemaat dinler',
          'Rükû ve secdeler yapılır, 2. rekata kalkılır',
        ],
        stepsAr: [
          'النية وتكبيرة الإحرام ثم دعاء الاستفتاح',
          'التكبيرة الزائدة الأولى: تُرفع اليدان ثم تُرسلان',
          'الثانية: تُرفعان ثم تُرسلان',
          'الثالثة: تُرفعان ثم تُعقدان',
          'يجهر الإمام بالفاتحة وسورة',
          'الركوع والسجود ثم القيام للثانية',
        ],
        stepsEn: [
          'Make intention (Eid prayer, following the imam); opening takbir and Subhanaka',
          '1st extra takbir: raise hands, then let them fall',
          '2nd extra takbir: raise and release again',
          '3rd extra takbir: raise hands and fold them',
          'The imam recites Fatiha and a surah aloud',
          'Bow, prostrate, and rise for the 2nd rak\'ah',
        ],
      ),
      OtherSection('2. Rekat', 'الركعة الثانية', 'Rak\'ah 2',
        stepsTr: [
          'İmam Fâtiha ve sureyi okur',
          '3 zevaid tekbiri alınır: her defasında eller kaldırılıp salınır',
          '4. tekbirle birlikte rükûya varılır',
          'Secdeler yapılır; oturuşta Ettehiyyâtü, Salli-Bârik ve dualar okunur',
          'Selam verilir; bayram hutbesi namazdan sonra dinlenir',
        ],
        stepsAr: [
          'يقرأ الإمام الفاتحة وسورة',
          'ثلاث تكبيرات زوائد تُرفع فيها اليدان ثم تُرسلان',
          'يُركع مع التكبيرة الرابعة',
          'السجود ثم الجلوس للتشهد والصلاة الإبراهيمية',
          'التسليم؛ وخطبة العيد بعد الصلاة',
        ],
        stepsEn: [
          'The imam recites Fatiha and a surah',
          '3 extra takbirs, raising and releasing the hands each time',
          'Bow together with the 4th takbir',
          'Prostrate; in the sitting recite At-Tahiyyat, Salli-Barik and the duas',
          'Salam; the Eid sermon follows the prayer',
        ],
      ),
    ]),
  OtherPrayer(
    'Cenaze Namazı', 'صلاة الجنازة', 'Funeral Prayer',
    'Ayakta, 4 tekbirle — rükûsuz ve secdesiz', 'قيامًا بأربع تكبيرات — بلا ركوع ولا سجود', 'Standing, 4 takbirs — no bowing or prostration',
    'Cenaze namazı farz-ı kifâyedir: bir kısım Müslüman kılınca diğerlerinden düşer. Rükûsu, secdesi ve oturuşu yoktur; ayakta 4 tekbirle kılınır. Cenaze imamın önüne konur, cemaat saf tutar.',
    'صلاة الجنازة فرض كفاية، قيام بأربع تكبيرات بلا ركوع ولا سجود؛ يوضع الميت أمام الإمام ويصطف الناس خلفه.',
    'The funeral prayer is a communal obligation performed standing with four takbirs - no bowing or prostration. The deceased is placed before the imam.',
    '4',
    [
      OtherSection('Kılınışı • 4 Tekbir', 'كيفيتها • ٤ تكبيرات', 'How It Is Prayed • 4 Takbirs',
        stepsTr: [
          'Niyet edilir (kimin için kılındığı belirtilerek) ve 1. tekbir alınır; Sübhâneke "ve celle senâük" ilavesiyle okunur',
          '2. tekbir: Allâhümme Salli ve Allâhümme Bârik okunur',
          '3. tekbir: cenaze duası okunur (bilinmiyorsa Rabbenâ duaları veya dua niyetiyle Fâtiha okunabilir)',
          '4. tekbir alınır; önce sağa, sonra sola selam verilir',
        ],
        stepsAr: [
          'النية ثم التكبيرة الأولى ويُقرأ الاستفتاح مع «وجل ثناؤك»',
          'الثانية: الصلاة الإبراهيمية',
          'الثالثة: الدعاء للميت',
          'الرابعة ثم التسليم يمينًا ويسارًا',
        ],
        stepsEn: [
          'Make intention (specifying for whom); 1st takbir, recite Subhanaka adding \'wa jalla thana\'uk\'',
          '2nd takbir: Allahumma Salli and Barik',
          '3rd takbir: the funeral supplication',
          '4th takbir; salam right then left',
        ],
      ),
    ]),
  OtherPrayer(
    'Teravih Namazı', 'صلاة التراويح', 'Tarawih Prayer',
    'Ramazan gecelerine mahsus — 20 rekat', 'في ليالي رمضان — ٢٠ ركعة', 'Ramadan nights — 20 rak\'ahs',
    'Teravih, Ramazan ayına mahsus müekked sünnettir; yatsının farzı ve son sünnetinden sonra, vitirden önce kılınır. Hanefî mezhebinde 20 rekattır; ikişer (veya dörder) rekat hâlinde kılınır, aralarda salavat ve tesbihlerle dinlenilir. Ramazan\'da vitir de cemaatle kılınabilir.',
    'التراويح سنة مؤكدة في رمضان بعد العشاء وقبل الوتر، وهي عشرون ركعة تُصلى مثنى مثنى أو أربعًا أربعًا مع استراحات بينها.',
    'Tarawih is an emphasized sunnah of Ramadan, after Isha and before Witr - 20 rak\'ahs in sets of two (or four), with brief rests between sets.',
    '20',
    [
      OtherSection('2 Rekat • 10 kez tekrarlanır', 'ركعتان • تُكرر ١٠ مرات', '2 Rak\'ahs • repeated 10 times',
        part: PrayerPart(PartKind.sunnah, 2),
        infoTr: 'Bu 2 rekatlık düzen 10 kez tekrarlanır (toplam 20 rekat). Dörder rekat hâlinde kılınırsa ilk oturuşta Salli-Bârik de okunur. Teravihten sonra vitir kılınır.',
        infoAr: 'يُكرر هذا النسق عشر مرات (٢٠ ركعة). وإن صُليت أربعًا تُقرأ الصلاة الإبراهيمية في القعدة الأولى. وبعدها الوتر.',
        infoEn: 'This 2-rak\'ah set is repeated 10 times (20 total). If prayed in fours, Salli-Barik is added in the first sitting. Witr follows.',
      ),
    ]),
  OtherPrayer(
    'Teheccüd Namazı', 'صلاة التهجد', 'Tahajjud Prayer',
    'Gece uykudan kalkıp kılınır — 2-8 rekat', 'قيام الليل بعد النوم — ٢-٨ ركعات', 'Night vigil after sleeping — 2-8 rak\'ahs',
    'Teheccüd, yatsıdan sonra bir miktar uyuyup gece kalkarak kılınan nafiledir; ikişer rekat hâlinde 2-8 rekat kılınır. Gecenin son üçte biri en faziletli vaktidir (İsrâ 79).',
    'التهجد نافلة تُصلى بعد نوم في الليل، مثنى مثنى من ركعتين إلى ثمان، وأفضل وقتها الثلث الأخير من الليل.',
    'Tahajjud is a voluntary prayer after sleeping at night, in pairs of 2 up to 8 rak\'ahs; the last third of the night is most virtuous (17:79).',
    '2-8',
    [
      OtherSection('2 Rekat', 'ركعتان', '2 Rak\'ahs',
        part: PrayerPart(PartKind.sunnah, 2),
        infoTr: 'Dilenirse ikişer rekat hâlinde 8 rekata kadar devam edilir; namazdan sonra dua ve istiğfar edilir.',
        infoAr: 'يُزاد مثنى مثنى إلى ثمانٍ لمن شاء، ويُختم بالدعاء والاستغفار.',
        infoEn: 'Continue in pairs up to 8 rak\'ahs if desired; conclude with dua and istighfar.',
      ),
    ]),
  OtherPrayer(
    'Evvâbin Namazı', 'صلاة الأوابين', 'Awwabin Prayer',
    'Akşam namazından sonra — 6 rekat', 'بعد المغرب — ست ركعات', 'After Maghrib — 6 rak\'ahs',
    'Evvâbin, akşamın farzı ve sünnetinden sonra ikişer rekat hâlinde kılınan 6 rekatlık nafiledir. Evvâbin, çokça tövbe edip Allah\'a yönelenler demektir.',
    'الأوابين ست ركعات بعد فرض المغرب وسنته، مثنى مثنى. والأوابون هم الرجّاعون إلى الله بالتوبة.',
    'Awwabin is 6 voluntary rak\'ahs after the fard and sunnah of Maghrib, prayed in pairs. Awwabin means those who often turn to Allah in repentance.',
    '6',
    [
      OtherSection('2 Rekat • 3 kez tekrarlanır', 'ركعتان • تُكرر ٣ مرات', '2 Rak\'ahs • repeated 3 times',
        part: PrayerPart(PartKind.sunnah, 2),
        infoTr: 'Bu 2 rekatlık düzen 3 kez tekrarlanır (toplam 6 rekat); her ikide selam verilir.',
        infoAr: 'يُكرر هذا النسق ثلاث مرات (٦ ركعات) ويُسلَّم بعد كل ركعتين.',
        infoEn: 'This set is repeated 3 times (6 total), with salam after each pair.',
      ),
    ]),
  OtherPrayer(
    'Kuşluk (Duhâ) Namazı', 'صلاة الضحى', 'Duha (Forenoon) Prayer',
    'Kuşluk vaktinde — 2-8 rekat', 'في الضحى — ٢-٨ ركعات', 'Mid-morning — 2-8 rak\'ahs',
    'Kuşluk namazı, güneş doğup kerahat çıktıktan sonra (doğuştan yaklaşık 45 dk sonra) öğleye yakın vakte kadar kılınabilen nafiledir; 2, 4, 6 veya 8 rekat kılınır.',
    'صلاة الضحى نافلة بعد خروج وقت الكراهة عقب الشروق إلى قبيل الظهر، من ركعتين إلى ثمان.',
    'The Duha prayer is voluntary, from about 45 minutes after sunrise until shortly before Dhuhr - 2, 4, 6 or 8 rak\'ahs.',
    '2-8',
    [
      OtherSection('2 Rekat', 'ركعتان', '2 Rak\'ahs',
        part: PrayerPart(PartKind.sunnah, 2),
        infoTr: 'Dilenirse ikişer rekat hâlinde 8 rekata kadar artırılır.',
        infoAr: 'تُزاد مثنى مثنى إلى ثمانٍ لمن شاء.',
        infoEn: 'Increase in pairs up to 8 rak\'ahs if desired.',
      ),
    ]),
  OtherPrayer(
    'İstihâre Namazı', 'صلاة الاستخارة', 'Istikhara Prayer',
    'Hayırlısını dilemek için — 2 rekat', 'لطلب الخيرة — ركعتان', 'To seek what is best — 2 rak\'ahs',
    'İstihâre, bir işin hakkında hayırlı olup olmadığını Allah\'tan dilemek için kılınan 2 rekatlık nafiledir; ardından istihâre duası okunur ve iş Allah\'a havale edilir. Gerekirse 7 güne kadar tekrarlanır; kalbin yatıştığı taraf tercih edilir.',
    'الاستخارة ركعتان لطلب الخيرة من الله في أمر مباح، يُدعى بعدهما بدعاء الاستخارة ويُفوَّض الأمر إلى الله، وتُكرر إلى سبعة أيام إن لزم.',
    'Istikhara is 2 voluntary rak\'ahs to ask Allah for the better outcome, followed by the istikhara supplication; repeat up to seven days if needed.',
    '2',
    [
      OtherSection('2 Rekat', 'ركعتان', '2 Rak\'ahs',
        part: PrayerPart(PartKind.sunnah, 2),
        infoTr: '1. rekatta zammı sure olarak Kâfirûn, 2. rekatta İhlâs okunması tavsiye edilir. Selamdan sonra istihâre duası okunur.',
        infoAr: 'يُستحب قراءة الكافرون في الأولى والإخلاص في الثانية، وبعد السلام دعاء الاستخارة.',
        infoEn: 'Al-Kafirun in the 1st rak\'ah and Al-Ikhlas in the 2nd are recommended; after salam, recite the istikhara dua.',
      ),
    ]),
  OtherPrayer(
    'Tesbih Namazı', 'صلاة التسبيح', 'Tasbih Prayer',
    '4 rekat — toplam 300 tesbih', 'أربع ركعات — ٣٠٠ تسبيحة', '4 rak\'ahs — 300 tasbihs in total',
    'Tesbih namazı, her rekatında 75 olmak üzere toplam 300 kez tesbih okunan 4 rekatlık nafiledir; günahların bağışlanmasına vesile olduğu hadiste bildirilmiştir. Ömürde bir kez olsun kılınması tavsiye edilir.',
    'صلاة التسبيح أربع ركعات فيها ثلاثمئة تسبيحة: خمس وسبعون في كل ركعة، وقد ورد فضلها في الحديث.',
    'The Tasbih prayer is 4 rak\'ahs containing 300 tasbihs - 75 in each; its virtue is reported in hadith.',
    '4',
    [
      OtherSection('1. Rekat • 75 Tesbih', 'الركعة الأولى • ٧٥ تسبيحة', 'Rak\'ah 1 • 75 Tasbihs',
        stepsTr: [
          'Niyet ve iftitah tekbiri; Sübhâneke\'den sonra 15 kez tesbih okunur: Sübhânallâhi ve\'l-hamdü lillâhi ve lâ ilâhe illallâhü vallâhü ekber',
          'Eûzü besmele, Fâtiha ve zammı sureden sonra 10 kez tesbih',
          'Rükûda (Sübhâne Rabbiye\'l-azîm\'den sonra) 10 kez',
          'Rükûdan doğrulunca 10 kez',
          '1. secdede 10 kez',
          'İki secde arasındaki oturuşta 10 kez',
          '2. secdede 10 kez — rekat toplamı 75 tesbih',
        ],
        stepsAr: [
          'بعد النية والاستفتاح يُسبَّح ١٥ مرة: سبحان الله والحمد لله ولا إله إلا الله والله أكبر',
          'بعد الفاتحة والسورة ١٠',
          'في الركوع ١٠',
          'بعد الرفع ١٠',
          'في السجدة الأولى ١٠',
          'بين السجدتين ١٠',
          'في السجدة الثانية ١٠ — المجموع ٧٥ في الركعة',
        ],
        stepsEn: [
          'After intention, opening takbir and Subhanaka, say the tasbih 15 times: Subhanallahi wal-hamdu lillahi wa la ilaha illallahu wallahu akbar',
          'After Fatiha and a surah, 10 times',
          'In ruku (after Subhana Rabbiyal-Azim), 10',
          'Upon rising, 10',
          'In the 1st prostration, 10',
          'Sitting between prostrations, 10',
          'In the 2nd prostration, 10 - 75 per rak\'ah',
        ],
      ),
      OtherSection('2-4. Rekatlar', 'الركعات ٢-٤', 'Rak\'ahs 2-4',
        infoTr: 'Aynı düzenle kılınır (rekat başına 75, toplam 300). Oturuşlarda tesbihler Ettehiyyâtü\'den önce okunur. Son oturuşta Ettehiyyâtü, Salli-Bârik ve dualardan sonra selam verilir.',
        infoAr: 'تُصلى بالنسق نفسه (٧٥ لكل ركعة، المجموع ٣٠٠). في القعدات يُسبَّح قبل التشهد، وفي الأخيرة بعد التشهد والصلاة الإبراهيمية يُسلَّم.',
        infoEn: 'Prayed likewise (75 each, 300 total). In the sittings the tasbihs come before At-Tahiyyat; in the final sitting, salam follows the tashahhud and Salli-Barik.',
      ),
    ]),
];

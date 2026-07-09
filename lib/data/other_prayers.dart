/// Vakit namazları dışındaki namazlar: Cuma, Bayram, Cenaze, Teravih,
/// Teheccüd, Evvâbin, Kuşluk (Duhâ), İstihâre ve Tesbih namazı.
/// İçerik sabittir; Hanefî mezhebi / Diyanet İlmihali esas alınmıştır.
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
  final List<String> stepsTr;
  final List<String> stepsAr;
  final List<String> stepsEn;

  const OtherPrayer(
      this.nameTr, this.nameAr, this.nameEn,
      this.subtitleTr, this.subtitleAr, this.subtitleEn,
      this.introTr, this.introAr, this.introEn,
      this.stepsTr, this.stepsAr, this.stepsEn);
}

const List<OtherPrayer> otherPrayers = [
  OtherPrayer(
    'Cuma Namazı', 'صلاة الجمعة', 'Friday Prayer',
    'Cuma günü öğle vaktinde, cemaatle', 'يوم الجمعة جماعة', 'Friday noon, in congregation',
    'Cuma namazı, cuma günü öğle vakti cemaatle kılınır ve o günün öğle namazının yerine geçer; erkeklere farzdır. Hutbe, cuma namazının şartıdır ve farzdan önce okunur.',
    'تُصلى الجمعة جماعةً وقت الظهر يوم الجمعة وهي فرض على الرجال، وتقوم مقام صلاة الظهر. الخطبة شرط لها وتكون قبل الفرض.',
    'The Friday prayer is performed in congregation at noon on Friday and replaces that day\'s Dhuhr; it is obligatory for men. The sermon (khutbah) is an essential condition and precedes the fard.',
    [
      'Camiye gidilir; ilk sünnet olarak 4 rekat kılınır (öğle namazının ilk sünneti gibi)',
      'Hutbe dinlenir (hutbe okunurken konuşulmaz)',
      'İmamla birlikte 2 rekat farz kılınır; imam Fâtiha ve sureyi sesli okur',
      'Son sünnet olarak 4 rekat kılınır',
    ],
    [
      'تُصلى أربع ركعات سنة قبلية',
      'يُستمع إلى الخطبة بصمت',
      'تُصلى ركعتا الفرض خلف الإمام ويجهر الإمام بالقراءة',
      'تُصلى أربع ركعات سنة بعدية',
    ],
    [
      'Pray 4 rak\'ahs of the first sunnah (like the Dhuhr sunnah)',
      'Listen to the khutbah silently',
      'Pray the 2 fard rak\'ahs behind the imam, who recites aloud',
      'Pray 4 rak\'ahs of the final sunnah',
    ]),
  OtherPrayer(
    'Bayram Namazı', 'صلاة العيد', 'Eid Prayer',
    'Ramazan ve Kurban bayramı sabahı', 'صباح العيدين', 'Morning of the two Eids',
    'Bayram namazı, bayram sabahı güneş doğup kerahat vakti çıktıktan sonra cemaatle kılınan 2 rekatlık vacip bir namazdır. Diğer namazlardan farkı, her rekatta fazladan üçer \'zevaid\' tekbiri bulunmasıdır. Hutbe, bayramda namazdan sonra okunur.',
    'صلاة العيد ركعتان تُصليان جماعة صباح العيد بعد ارتفاع الشمس، وفيها تكبيرات زوائد: ثلاث في كل ركعة. والخطبة في العيد بعد الصلاة.',
    'The Eid prayer is 2 rak\'ahs performed in congregation on Eid morning after sunrise. Its distinction is the extra (zawaid) takbirs: three in each rak\'ah. The sermon follows the prayer.',
    [
      'Niyet edilir, iftitah tekbiri alınır, Sübhâneke okunur',
      '3 zevaid tekbiri alınır: her tekbirde eller kulaklara kaldırılıp yanlara salınır; üçüncüsünden sonra eller bağlanır',
      'İmam Fâtiha ve sureyi okur, rükû ve secdeler yapılır',
      '2. rekatta imam Fâtiha ve sureyi okur; rükûdan ÖNCE yine 3 zevaid tekbiri alınır, dördüncü tekbirle rükûya varılır',
      'Oturuş ve selamdan sonra hutbe dinlenir',
    ],
    [
      'النية وتكبيرة الإحرام ثم دعاء الاستفتاح',
      'ثلاث تكبيرات زوائد تُرفع فيها اليدان ثم تُرسلان، وبعد الثالثة تُعقدان',
      'يقرأ الإمام الفاتحة وسورة ثم الركوع والسجود',
      'في الثانية يقرأ الإمام ثم ثلاث تكبيرات قبل الركوع ويُركع بالرابعة',
      'بعد السلام تُستمع الخطبة',
    ],
    [
      'Make intention, opening takbir, recite Subhanaka',
      'Three extra takbirs: raise hands at each and let them fall; fold hands after the third',
      'The imam recites Fatiha and a surah; bow and prostrate',
      'In the 2nd rak\'ah, after recitation, three extra takbirs BEFORE bowing; bow on the fourth',
      'After salam, listen to the Eid sermon',
    ]),
  OtherPrayer(
    'Cenaze Namazı', 'صلاة الجنازة', 'Funeral Prayer',
    'Ayakta, rükûsuz ve secdesiz', 'قيامًا بلا ركوع ولا سجود', 'Standing, no bowing or prostration',
    'Cenaze namazı farz-ı kifâyedir: Müslümanlardan bir kısmı kılınca diğerlerinden düşer. Rükûsu, secdesi ve oturuşu yoktur; ayakta 4 tekbirle kılınır. Cenaze imamın önüne konur, cemaat saf tutar.',
    'صلاة الجنازة فرض كفاية، وهي قيام وأربع تكبيرات بلا ركوع ولا سجود. يوضع الميت أمام الإمام ويصطف الناس خلفه.',
    'The funeral prayer is a communal obligation (fard kifayah). It is performed standing with four takbirs - no bowing, prostration, or sitting. The deceased is placed before the imam.',
    [
      'Niyet edilir (kimin için kılındığı belirtilerek), 1. tekbir alınır ve Sübhâneke \'ve celle senâük\' ilavesiyle okunur',
      '2. tekbir: Allâhümme Salli ve Allâhümme Bârik okunur',
      '3. tekbir: cenaze duası okunur (bilinmiyorsa Rabbenâ duaları veya Fâtiha dua niyetiyle okunabilir)',
      '4. tekbir alınır, ardından önce sağa sonra sola selam verilir',
    ],
    [
      'النية ثم التكبيرة الأولى ويُقرأ الاستفتاح مع «وجل ثناؤك»',
      'التكبيرة الثانية: الصلاة الإبراهيمية',
      'التكبيرة الثالثة: الدعاء للميت',
      'التكبيرة الرابعة ثم التسليم يمينًا ويسارًا',
    ],
    [
      'Make intention, first takbir, recite Subhanaka adding \'wa jalla thana\'uk\'',
      'Second takbir: recite Allahumma Salli and Barik',
      'Third takbir: supplicate for the deceased',
      'Fourth takbir, then salam to the right and left',
    ]),
  OtherPrayer(
    'Teravih Namazı', 'صلاة التراويح', 'Tarawih Prayer',
    'Ramazan gecelerine mahsus, 20 rekat', 'في ليالي رمضان، ٢٠ ركعة', 'Ramadan nights, 20 rak\'ahs',
    'Teravih, Ramazan ayına mahsus müekked bir sünnettir; yatsı namazından sonra, vitirden önce kılınır. Hanefî mezhebinde 20 rekattır; ikişer veya dörder rekat hâlinde kılınabilir. Cemaatle de yalnız da kılınabilir.',
    'التراويح سنة مؤكدة في رمضان، تُصلى بعد العشاء وقبل الوتر، وهي عشرون ركعة تُصلى مثنى مثنى أو أربعًا أربعًا.',
    'Tarawih is an emphasized sunnah specific to Ramadan, prayed after Isha and before Witr. In the Hanafi school it is 20 rak\'ahs, prayed in sets of two or four.',
    [
      'Yatsının farzı ve son sünneti kılındıktan sonra teravihe niyet edilir',
      'İkişer (veya dörder) rekat hâlinde toplam 20 rekat kılınır; her rekatta Fâtiha ve zammı sure okunur',
      'Her iki (veya dört) rekatın sonunda selam verilir; aralarda salavat ve tesbihlerle dinlenilir',
      'Teravihten sonra vitir namazı kılınır (Ramazan\'da vitir cemaatle kılınabilir)',
    ],
    [
      'بعد فرض العشاء وسنته تُعقد نية التراويح',
      'تُصلى عشرون ركعة مثنى مثنى أو أربعًا أربعًا',
      'يُسلَّم بعد كل ركعتين أو أربع ويُستراح بينها بالصلوات والتسبيح',
      'بعد التراويح تُصلى صلاة الوتر',
    ],
    [
      'After the fard and sunnah of Isha, make intention for Tarawih',
      'Pray 20 rak\'ahs in sets of two (or four), each with Fatiha and a surah',
      'Give salam after each set; brief rest with salawat between sets',
      'After Tarawih, pray the Witr prayer',
    ]),
  OtherPrayer(
    'Teheccüd Namazı', 'صلاة التهجد', 'Tahajjud Prayer',
    'Gece uykudan kalkıp kılınır', 'قيام الليل بعد النوم', 'Night vigil after sleeping',
    'Teheccüd, yatsıdan sonra bir miktar uyuyup gece kalkarak kılınan nafile namazdır; 2 ile 8 rekat arasında, ikişer rekat hâlinde kılınması tavsiye edilir. Gecenin son üçte biri en faziletli vaktidir. Kur\'an\'da \'sana mahsus bir nafile\' olarak anılır (İsrâ 79).',
    'التهجد نافلة تُصلى في الليل بعد نوم، من ركعتين إلى ثمانٍ، مثنى مثنى، وأفضل وقتها الثلث الأخير من الليل.',
    'Tahajjud is a voluntary prayer performed at night after sleeping - between 2 and 8 rak\'ahs, in pairs. The last third of the night is its most virtuous time (see Quran 17:79).',
    [
      'Yatsıdan sonra bir süre uyunur; gece kalkılır ve abdest alınır',
      'Teheccüde niyet edilerek 2 rekat kılınır (normal nafile gibi: Sübhâneke, Fâtiha, zammı sure...)',
      'Dilenirse ikişer rekat hâlinde 8 rekata kadar devam edilir',
      'Namazdan sonra dua ve istiğfarla meşgul olunur',
    ],
    [
      'يُنام بعد العشاء ثم يُستيقظ ويُتوضأ',
      'تُصلى ركعتان بنية التهجد',
      'يُزاد مثنى مثنى إلى ثماني ركعات لمن شاء',
      'يُختم بالدعاء والاستغفار',
    ],
    [
      'Sleep after Isha, then wake and make wudu',
      'Pray 2 rak\'ahs with the intention of Tahajjud (as a regular voluntary prayer)',
      'Continue in pairs up to 8 rak\'ahs if desired',
      'Conclude with supplication and istighfar',
    ]),
  OtherPrayer(
    'Evvâbin Namazı', 'صلاة الأوابين', 'Awwabin Prayer',
    'Akşam namazından sonra 6 rekat', 'بعد المغرب، ست ركعات', 'After Maghrib, 6 rak\'ahs',
    'Evvâbin, akşam namazının farzı ve sünnetinden sonra kılınan 6 rekatlık nafile namazdır; ikişer rekat hâlinde kılınır. \'Evvâbin\' çokça tövbe edip Allah\'a yönelenler demektir.',
    'الأوابين ست ركعات تُصلى بعد فرض المغرب وسنته، مثنى مثنى. والأوابون هم الرجّاعون إلى الله بالتوبة.',
    'Awwabin is a voluntary prayer of 6 rak\'ahs after the fard and sunnah of Maghrib, prayed in pairs. \'Awwabin\' means those who frequently turn to Allah in repentance.',
    [
      'Akşamın farzı ve 2 rekat sünneti kılındıktan sonra niyet edilir',
      'İkişer rekat hâlinde toplam 6 rekat kılınır',
      'Her rekatta Fâtiha ve zammı sure okunur; her 2 rekatta selam verilir',
    ],
    [
      'بعد فرض المغرب وسنته تُعقد النية',
      'تُصلى ست ركعات مثنى مثنى',
      'في كل ركعة الفاتحة وسورة، ويُسلَّم بعد كل ركعتين',
    ],
    [
      'After the fard and 2-rak\'ah sunnah of Maghrib, make intention',
      'Pray 6 rak\'ahs in pairs',
      'Each rak\'ah has Fatiha and a surah; salam after every two',
    ]),
  OtherPrayer(
    'Kuşluk (Duhâ) Namazı', 'صلاة الضحى', 'Duha (Forenoon) Prayer',
    'Kuşluk vaktinde 2-8 rekat', 'في الضحى، ٢-٨ ركعات', 'Mid-morning, 2-8 rak\'ahs',
    'Kuşluk namazı, güneş doğup kerahat vakti çıktıktan sonra (doğuştan yaklaşık 45 dakika sonra) öğle vaktine yakın zamana kadar kılınabilen nafile namazdır; 2, 4, 6 veya 8 rekat kılınır.',
    'صلاة الضحى نافلة تُصلى بعد خروج وقت الكراهة عقب الشروق إلى قبيل الظهر، من ركعتين إلى ثمانٍ.',
    'The Duha prayer is voluntary, performed after the post-sunrise makruh period ends (about 45 minutes after sunrise) until shortly before Dhuhr - 2, 4, 6 or 8 rak\'ahs.',
    [
      'Güneşin doğuşundan yaklaşık 45 dakika sonra kılınabilir hâle gelir',
      'Niyet edilip 2 rekat kılınır (normal nafile gibi)',
      'Dilenirse ikişer rekat hâlinde 8 rekata kadar artırılır',
    ],
    [
      'يدخل وقتها بعد نحو ٤٥ دقيقة من الشروق',
      'تُصلى ركعتان بنيتها',
      'تُزاد مثنى مثنى إلى ثمان لمن شاء',
    ],
    [
      'Its time begins about 45 minutes after sunrise',
      'Make intention and pray 2 rak\'ahs (as a regular voluntary prayer)',
      'Increase in pairs up to 8 rak\'ahs if desired',
    ]),
  OtherPrayer(
    'İstihâre Namazı', 'صلاة الاستخارة', 'Istikhara Prayer',
    'Hayırlısını dilemek için 2 rekat', 'ركعتان لطلب الخيرة', '2 rak\'ahs to seek guidance',
    'İstihâre, bir işin hakkında hayırlı olup olmadığını Allah\'tan dilemek için kılınan 2 rekatlık nafile namazdır; ardından istihâre duası okunur ve karar Allah\'a havale edilir.',
    'الاستخارة ركعتان لطلب الخيرة من الله في أمر مباح، يُدعى بعدهما بدعاء الاستخارة ويُفوَّض الأمر إلى الله.',
    'Istikhara is a 2-rak\'ah voluntary prayer to ask Allah for the better outcome in a permissible matter, followed by the istikhara supplication.',
    [
      'Abdest alınıp istihâreye niyet edilir',
      '2 rekat kılınır: 1. rekatta Kâfirûn, 2. rekatta İhlâs okunması tavsiye edilir',
      'Selamdan sonra istihâre duası okunur ve iş Allah\'a havale edilir',
      'Gerekirse istihâre 7 güne kadar tekrarlanabilir; kalbin yatıştığı taraf tercih edilir',
    ],
    [
      'يُتوضأ وتُعقد نية الاستخارة',
      'تُصلى ركعتان: يُستحب في الأولى الكافرون وفي الثانية الإخلاص',
      'بعد السلام يُقرأ دعاء الاستخارة ويُفوض الأمر إلى الله',
      'تُكرر إلى سبعة أيام إن لزم ويُمضى لما ينشرح له الصدر',
    ],
    [
      'Make wudu and intend istikhara',
      'Pray 2 rak\'ahs: Al-Kafirun in the first and Al-Ikhlas in the second are recommended',
      'After salam, recite the istikhara supplication and entrust the matter to Allah',
      'Repeat up to seven days if needed; incline to what the heart settles upon',
    ]),
  OtherPrayer(
    'Tesbih Namazı', 'صلاة التسبيح', 'Tasbih Prayer',
    '4 rekat, 300 tesbihli', 'أربع ركعات بثلاثمئة تسبيحة', '4 rak\'ahs with 300 tasbihs',
    'Tesbih namazı, her rekatında 75 kez olmak üzere toplam 300 kez \'Sübhânallâhi ve\'l-hamdü lillâhi ve lâ ilâhe illallâhü vallâhü ekber\' denilen 4 rekatlık nafile namazdır; günahların bağışlanmasına vesile olduğu hadiste bildirilmiştir.',
    'صلاة التسبيح أربع ركعات يقال فيها «سبحان الله والحمد لله ولا إله إلا الله والله أكبر» ثلاثمئة مرة: خمسًا وسبعين في كل ركعة.',
    'The Tasbih prayer is 4 rak\'ahs in which the tasbih \'Subhanallahi wal-hamdu lillahi wa la ilaha illallahu wallahu akbar\' is said 300 times - 75 in each rak\'ah.',
    [
      'Niyet, iftitah tekbiri ve Sübhâneke\'den sonra 15 kez tesbih okunur',
      'Fâtiha ve zammı sureden sonra 10, rükûda 10, rükûdan doğrulunca 10',
      'Her iki secdede 10\'ar, iki secde arasında 10, ikinci secdeden kalkmadan 10 (rekat toplamı 75)',
      'Aynı düzenle 4 rekat tamamlanır (toplam 300 tesbih)',
    ],
    [
      'بعد النية والاستفتاح يُسبَّح ١٥ مرة',
      'بعد الفاتحة والسورة ١٠، وفي الركوع ١٠، وبعد الرفع ١٠',
      'في كل سجدة ١٠، وبين السجدتين ١٠، وقبل القيام ١٠ (٧٥ في الركعة)',
      'تُتم أربع ركعات بالمثل (٣٠٠ تسبيحة)',
    ],
    [
      'After intention, opening takbir and Subhanaka, say the tasbih 15 times',
      'After Fatiha and a surah 10, in ruku 10, upon rising 10',
      'In each prostration 10, between them 10, before standing 10 (75 per rak\'ah)',
      'Complete 4 rak\'ahs likewise (300 total)',
    ]),
];

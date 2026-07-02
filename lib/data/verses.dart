/// Vaktin Ayeti verileri.
///
/// ÖNEMLİ: Buradaki ayetler sabit, elle seçilmiş ve doğrulanmış bir listedir;
/// hiçbir metin çalışma anında üretilmez veya internetten çekilmez.
/// Her vakit için, o vakitle tematik olarak ilgili, Kur'an-ı Kerim'den
/// TAM ayetler yer alır (kısaltma/alıntı yapılmamıştır).
/// Sıra, vakit listesiyle aynıdır: İmsak, Güneş, Öğle, İkindi, Akşam, Yatsı.
class Verse {
  /// Ayetin Arapça tam metni.
  final String arabic;

  /// Okunuş (Türkçe ve Latin harfli).
  final String translitTr;
  final String translitEn;

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
    required this.translitTr,
    required this.translitEn,
    required this.tr,
    required this.en,
    required this.refTr,
    required this.refAr,
    required this.refEn,
  });
}

/// İndeks 0..5 → İmsak, Güneş, Öğle, İkindi, Akşam, Yatsı.
/// Her vakit için birden çok ayet vardır; ekranlar sırayla gösterir.
const List<List<Verse>> versesByPeriod = [
  // ---- İmsak ----
  [
    Verse(
      arabic:
          'أَقِمِ الصَّلَاةَ لِدُلُوكِ الشَّمْسِ إِلَىٰ غَسَقِ اللَّيْلِ وَقُرْآنَ الْفَجْرِ ۖ إِنَّ قُرْآنَ الْفَجْرِ كَانَ مَشْهُودًا',
      tr: 'Güneşin batıya kaymasından gecenin karanlığına kadar namazı kıl; sabah namazını da. Çünkü sabah namazı şahitlidir.',
      en: 'Establish prayer from the decline of the sun until the darkness of the night, and the recitation of dawn. Indeed, the recitation of dawn is ever witnessed.',
      translitTr:
          'Ekımis-salâte li dülûkiş-şemsi ilâ ğasekıl-leyli ve kur\'ânel-fecr. İnne kur\'ânel-fecri kâne meşhûdâ.',
      translitEn:
          'Aqimis-salata li-dulukish-shamsi ila ghasaqil-layli wa qur\'anal-fajr. Inna qur\'anal-fajri kana mashhuda.',
      refTr: 'İsrâ Suresi, 78. Ayet',
      refAr: 'سورة الإسراء، الآية ٧٨',
      refEn: 'Surah Al-Isra, 17:78',
    ),
    Verse(
      arabic:
          'فَالِقُ الْإِصْبَاحِ وَجَعَلَ اللَّيْلَ سَكَنًا وَالشَّمْسَ وَالْقَمَرَ حُسْبَانًا ۚ ذَٰلِكَ تَقْدِيرُ الْعَزِيزِ الْعَلِيمِ',
      tr: 'O, sabahı yarıp çıkarandır. Geceyi dinlenme zamanı, güneşi ve ayı birer hesap ölçüsü kılmıştır. İşte bu, mutlak güç sahibi ve her şeyi bilen Allah\'ın takdiridir.',
      en: 'He is the cleaver of daybreak and has made the night for rest and the sun and moon for calculation. That is the determination of the Exalted in Might, the Knowing.',
      translitTr:
          'Fâlikul-ısbâh. Ve cealel-leyle sekenen veş-şemse vel-kamera husbânâ. Zâlike takdîrul-azîzil-alîm.',
      translitEn:
          'Faliqul-isbah. Wa ja\'alal-layla sakanan wash-shamsa wal-qamara husbana. Dhalika taqdirul-\'azizil-\'alim.',
      refTr: 'En\'âm Suresi, 96. Ayet',
      refAr: 'سورة الأنعام، الآية ٩٦',
      refEn: 'Surah Al-An\'am, 6:96',
    ),
    Verse(
      arabic:
          'وَإِذَا سَأَلَكَ عِبَادِي عَنِّي فَإِنِّي قَرِيبٌ ۖ أُجِيبُ دَعْوَةَ الدَّاعِ إِذَا دَعَانِ ۖ فَلْيَسْتَجِيبُوا لِي وَلْيُؤْمِنُوا بِي لَعَلَّهُمْ يَرْشُدُونَ',
      tr: 'Kullarım sana beni sorduklarında (bilsinler ki) şüphesiz ben çok yakınım. Bana dua ettiğinde dua edenin duasına karşılık veririm. O hâlde onlar da benim çağrıma uysunlar ve bana iman etsinler ki doğru yolu bulsunlar.',
      en: 'And when My servants ask you concerning Me — indeed I am near. I respond to the call of the caller when he calls upon Me. So let them respond to Me and believe in Me, that they may be guided.',
      translitTr:
          'Ve izâ seeleke ıbâdî annî fe innî karîb. Ücîbü da\'veted-dâı izâ deân. Felyestecîbû lî velyü\'minû bî leallehüm yerşüdûn.',
      translitEn:
          'Wa idha sa\'alaka \'ibadi \'anni fa-inni qarib. Ujibu da\'watad-da\'i idha da\'an. Falyastajibu li walyu\'minu bi la\'allahum yarshudun.',
      refTr: 'Bakara Suresi, 186. Ayet',
      refAr: 'سورة البقرة، الآية ١٨٦',
      refEn: 'Surah Al-Baqarah, 2:186',
    ),
  ],
  // ---- Güneş ----
  [
    Verse(
      arabic:
          'فَاصْبِرْ عَلَىٰ مَا يَقُولُونَ وَسَبِّحْ بِحَمْدِ رَبِّكَ قَبْلَ طُلُوعِ الشَّمْسِ وَقَبْلَ الْغُرُوبِ',
      tr: 'Onların söylediklerine sabret; güneşin doğuşundan önce ve batışından önce Rabbini hamd ile tesbih et.',
      en: 'So be patient over what they say, and exalt with praise of your Lord before the rising of the sun and before its setting.',
      translitTr:
          'Fasbir alâ mâ yekûlûne ve sebbih bi hamdi rabbike kable tulûış-şemsi ve kablel-ğurûb.',
      translitEn:
          'Fasbir \'ala ma yaquluna wa sabbih bihamdi rabbika qabla tulu\'ish-shamsi wa qablal-ghurub.',
      refTr: 'Kaf Suresi, 39. Ayet',
      refAr: 'سورة ق، الآية ٣٩',
      refEn: 'Surah Qaf, 50:39',
    ),
    Verse(
      arabic: 'وَالشَّمْسِ وَضُحَاهَا',
      tr: 'Güneşe ve onun aydınlığına andolsun.',
      en: 'By the sun and its brightness.',
      translitTr:
          'Veş-şemsi ve duhâhâ.',
      translitEn:
          'Wash-shamsi wa duhaha.',
      refTr: 'Şems Suresi, 1. Ayet',
      refAr: 'سورة الشمس، الآية ١',
      refEn: 'Surah Ash-Shams, 91:1',
    ),
    Verse(
      arabic: 'وَجَعَلْنَا اللَّيْلَ لِبَاسًا ﴿١٠﴾ وَجَعَلْنَا النَّهَارَ مَعَاشًا ﴿١١﴾',
      tr: 'Geceyi bir örtü yaptık. Gündüzü de geçim vakti kıldık.',
      en: 'And We made the night as a covering, and We made the day for livelihood.',
      translitTr:
          'Ve cealnel-leyle libâsâ. Ve cealnen-nehâra meâşâ.',
      translitEn:
          'Wa ja\'alnal-layla libasa. Wa ja\'alnan-nahara ma\'asha.',
      refTr: 'Nebe Suresi, 10-11. Ayetler',
      refAr: 'سورة النبأ، الآيتان ١٠-١١',
      refEn: 'Surah An-Naba, 78:10-11',
    ),
  ],
  // ---- Öğle ----
  [
    Verse(
      arabic:
          'وَلَهُ الْحَمْدُ فِي السَّمَاوَاتِ وَالْأَرْضِ وَعَشِيًّا وَحِينَ تُظْهِرُونَ',
      tr: 'Göklerde ve yerde hamd O\'na mahsustur. Gündüzün sonunda ve öğle vaktine girdiğinizde de (O\'nu tesbih edin).',
      en: 'And to Him is due all praise in the heavens and the earth, and in the evening and when you are at noon.',
      translitTr:
          'Ve lehül-hamdü fis-semâvâti vel-ardı ve aşiyyen ve hîne tuzhirûn.',
      translitEn:
          'Wa lahul-hamdu fis-samawati wal-ardi wa \'ashiyyan wa hina tuzhirun.',
      refTr: 'Rûm Suresi, 18. Ayet',
      refAr: 'سورة الروم، الآية ١٨',
      refEn: 'Surah Ar-Rum, 30:18',
    ),
    Verse(
      arabic: 'فَاذْكُرُونِي أَذْكُرْكُمْ وَاشْكُرُوا لِي وَلَا تَكْفُرُونِ',
      tr: 'Öyleyse beni anın ki ben de sizi anayım. Bana şükredin, nankörlük etmeyin.',
      en: 'So remember Me; I will remember you. And be grateful to Me and do not deny Me.',
      translitTr:
          'Fezkürûnî ezkürküm veşkürû lî ve lâ tekfürûn.',
      translitEn:
          'Fadhkuruni adhkurkum washkuru li wa la takfurun.',
      refTr: 'Bakara Suresi, 152. Ayet',
      refAr: 'سورة البقرة، الآية ١٥٢',
      refEn: 'Surah Al-Baqarah, 2:152',
    ),
    Verse(
      arabic:
          'اتْلُ مَا أُوحِيَ إِلَيْكَ مِنَ الْكِتَابِ وَأَقِمِ الصَّلَاةَ ۖ إِنَّ الصَّلَاةَ تَنْهَىٰ عَنِ الْفَحْشَاءِ وَالْمُنكَرِ ۗ وَلَذِكْرُ اللَّهِ أَكْبَرُ ۗ وَاللَّهُ يَعْلَمُ مَا تَصْنَعُونَ',
      tr: 'Kitaptan sana vahyedileni oku, namazı da dosdoğru kıl. Çünkü namaz, insanı hayâsızlıktan ve kötülükten alıkoyar. Allah\'ı anmak elbette en büyük ibadettir. Allah yaptıklarınızı bilir.',
      en: 'Recite what has been revealed to you of the Book and establish prayer. Indeed, prayer prohibits immorality and wrongdoing, and the remembrance of Allah is greater. And Allah knows what you do.',
      translitTr:
          'Ütlü mâ ûhıye ileyke minel-kitâbi ve ekımis-salâh. İnnes-salâte tenhâ anil-fahşâi vel-münker. Ve lezikrullâhi ekber. Vallâhü ya\'lemü mâ tasneûn.',
      translitEn:
          'Utlu ma uhiya ilayka minal-kitabi wa aqimis-salah. Innas-salata tanha \'anil-fahsha\'i wal-munkar. Wa ladhikrullahi akbar. Wallahu ya\'lamu ma tasna\'un.',
      refTr: 'Ankebût Suresi, 45. Ayet',
      refAr: 'سورة العنكبوت، الآية ٤٥',
      refEn: 'Surah Al-Ankabut, 29:45',
    ),
  ],
  // ---- İkindi ----
  [
    Verse(
      arabic:
          'فَاصْبِرْ عَلَىٰ مَا يَقُولُونَ وَسَبِّحْ بِحَمْدِ رَبِّكَ قَبْلَ طُلُوعِ الشَّمْسِ وَقَبْلَ غُرُوبِهَا ۖ وَمِنْ آنَاءِ اللَّيْلِ فَسَبِّحْ وَأَطْرَافَ النَّهَارِ لَعَلَّكَ تَرْضَىٰ',
      tr: 'Onların söylediklerine sabret. Güneşin doğuşundan önce ve batışından önce Rabbini hamd ile tesbih et. Gecenin bazı saatlerinde ve gündüzün uçlarında da tesbih et ki hoşnut olasın.',
      en: 'So be patient over what they say and exalt with praise of your Lord before the rising of the sun and before its setting; and during periods of the night exalt Him and at the ends of the day, that you may be satisfied.',
      translitTr:
          'Fasbir alâ mâ yekûlûne ve sebbih bi hamdi rabbike kable tulûış-şemsi ve kable ğurûbihâ. Ve min ânâil-leyli fesebbih ve etrâfen-nehâri lealleke terdâ.',
      translitEn:
          'Fasbir \'ala ma yaquluna wa sabbih bihamdi rabbika qabla tulu\'ish-shamsi wa qabla ghurubiha. Wa min ana\'il-layli fasabbih wa atrafan-nahari la\'allaka tarda.',
      refTr: 'Tâhâ Suresi, 130. Ayet',
      refAr: 'سورة طه، الآية ١٣٠',
      refEn: 'Surah Ta-Ha, 20:130',
    ),
    Verse(
      arabic:
          'حَافِظُوا عَلَى الصَّلَوَاتِ وَالصَّلَاةِ الْوُسْطَىٰ وَقُومُوا لِلَّهِ قَانِتِينَ',
      tr: 'Namazlara ve orta namaza (ikindi namazına) devam edin. Allah\'a gönülden boyun eğerek namaza durun.',
      en: 'Maintain with care the prayers and the middle prayer, and stand before Allah devoutly obedient.',
      translitTr:
          'Hâfizû ales-salavâti ves-salâtil-vustâ ve kûmû lillâhi kânitîn.',
      translitEn:
          'Hafizu \'alas-salawati was-salatil-wusta wa qumu lillahi qanitin.',
      refTr: 'Bakara Suresi, 238. Ayet',
      refAr: 'سورة البقرة، الآية ٢٣٨',
      refEn: 'Surah Al-Baqarah, 2:238',
    ),
    Verse(
      arabic:
          'وَالْعَصْرِ ﴿١﴾ إِنَّ الْإِنسَانَ لَفِي خُسْرٍ ﴿٢﴾ إِلَّا الَّذِينَ آمَنُوا وَعَمِلُوا الصَّالِحَاتِ وَتَوَاصَوْا بِالْحَقِّ وَتَوَاصَوْا بِالصَّبْرِ ﴿٣﴾',
      tr: 'Asra (ikindi vaktine) andolsun ki insan gerçekten ziyan içindedir. Ancak iman edip salih ameller işleyenler, birbirlerine hakkı tavsiye edenler ve sabrı tavsiye edenler başka.',
      en: 'By time, indeed mankind is in loss — except those who believe and do righteous deeds and advise each other to truth and advise each other to patience.',
      translitTr:
          'Vel-asr. İnnel-insâne lefî husr. İllellezîne âmenû ve amilüs-sâlihâti ve tevâsav bil-hakkı ve tevâsav bis-sabr.',
      translitEn:
          'Wal-\'asr. Innal-insana lafi khusr. Illal-ladhina amanu wa \'amilus-salihati wa tawasaw bil-haqqi wa tawasaw bis-sabr.',
      refTr: 'Asr Suresi, 1-3. Ayetler',
      refAr: 'سورة العصر، الآيات ١-٣',
      refEn: 'Surah Al-Asr, 103:1-3',
    ),
  ],
  // ---- Akşam ----
  [
    Verse(
      arabic: 'فَسُبْحَانَ اللَّهِ حِينَ تُمْسُونَ وَحِينَ تُصْبِحُونَ',
      tr: 'Akşama girdiğinizde ve sabaha kavuştuğunuzda Allah\'ı tesbih edin.',
      en: 'So glorify Allah when you reach the evening and when you rise in the morning.',
      translitTr:
          'Fesübhânallâhi hîne tümsûne ve hîne tusbihûn.',
      translitEn:
          'Fasubhanallahi hina tumsuna wa hina tusbihun.',
      refTr: 'Rûm Suresi, 17. Ayet',
      refAr: 'سورة الروم، الآية ١٧',
      refEn: 'Surah Ar-Rum, 30:17',
    ),
    Verse(
      arabic:
          'فَاصْبِرْ إِنَّ وَعْدَ اللَّهِ حَقٌّ وَاسْتَغْفِرْ لِذَنبِكَ وَسَبِّحْ بِحَمْدِ رَبِّكَ بِالْعَشِيِّ وَالْإِبْكَارِ',
      tr: 'Sabret! Şüphesiz Allah\'ın vaadi gerçektir. Günahın için bağışlanma dile; akşam ve sabah Rabbini hamd ile tesbih et.',
      en: 'So be patient; indeed, the promise of Allah is truth. Ask forgiveness for your sin and exalt with praise of your Lord in the evening and the morning.',
      translitTr:
          'Fasbir inne va\'dallâhi hakkun vestağfir li zenbike ve sebbih bi hamdi rabbike bil-aşiyyi vel-ibkâr.',
      translitEn:
          'Fasbir inna wa\'dallahi haqqun wastaghfir lidhanbika wa sabbih bihamdi rabbika bil-\'ashiyyi wal-ibkar.',
      refTr: 'Mü\'min Suresi, 55. Ayet',
      refAr: 'سورة غافر، الآية ٥٥',
      refEn: 'Surah Ghafir, 40:55',
    ),
    Verse(
      arabic:
          'إِنَّ فِي خَلْقِ السَّمَاوَاتِ وَالْأَرْضِ وَاخْتِلَافِ اللَّيْلِ وَالنَّهَارِ لَآيَاتٍ لِّأُولِي الْأَلْبَابِ',
      tr: 'Göklerin ve yerin yaratılışında, gece ile gündüzün birbiri ardınca gelişinde akıl sahipleri için elbette deliller vardır.',
      en: 'Indeed, in the creation of the heavens and the earth and the alternation of the night and the day are signs for those of understanding.',
      translitTr:
          'İnne fî halkıs-semâvâti vel-ardı vahtilâfil-leyli ven-nehâri le âyâtin li ülil-elbâb.',
      translitEn:
          'Inna fi khalqis-samawati wal-ardi wakhtilafil-layli wan-nahari la-ayatin li-ulil-albab.',
      refTr: 'Âl-i İmrân Suresi, 190. Ayet',
      refAr: 'سورة آل عمران، الآية ١٩٠',
      refEn: 'Surah Aal Imran, 3:190',
    ),
  ],
  // ---- Yatsı ----
  [
    Verse(
      arabic:
          'وَأَقِمِ الصَّلَاةَ طَرَفَيِ النَّهَارِ وَزُلَفًا مِّنَ اللَّيْلِ ۚ إِنَّ الْحَسَنَاتِ يُذْهِبْنَ السَّيِّئَاتِ ۚ ذَٰلِكَ ذِكْرَىٰ لِلذَّاكِرِينَ',
      tr: 'Gündüzün iki ucunda ve gecenin ilk saatlerinde namazı kıl. Şüphesiz iyilikler kötülükleri giderir. Bu, öğüt alanlar için bir hatırlatmadır.',
      en: 'And establish prayer at the two ends of the day and at the approach of the night. Indeed, good deeds do away with misdeeds. That is a reminder for those who remember.',
      translitTr:
          'Ve ekımis-salâte tarafeyin-nehâri ve zülefen minel-leyl. İnnel-hasenâti yüzhibnes-seyyiât. Zâlike zikrâ liz-zâkirîn.',
      translitEn:
          'Wa aqimis-salata tarafayin-nahari wa zulafan minal-layl. Innal-hasanati yudhhibnas-sayyi\'at. Dhalika dhikra lidh-dhakirin.',
      refTr: 'Hûd Suresi, 114. Ayet',
      refAr: 'سورة هود، الآية ١١٤',
      refEn: 'Surah Hud, 11:114',
    ),
    Verse(
      arabic:
          'وَهُوَ الَّذِي جَعَلَ لَكُمُ اللَّيْلَ لِبَاسًا وَالنَّوْمَ سُبَاتًا وَجَعَلَ النَّهَارَ نُشُورًا',
      tr: 'O, geceyi size bir örtü, uykuyu dinlenme, gündüzü de yayılıp çalışma vakti kılandır.',
      en: 'And it is He who has made the night for you as clothing and sleep a means for rest and has made the day a resurrection.',
      translitTr:
          'Ve hüvellezî ceale lekümül-leyle libâsen ven-nevme sübâten ve cealen-nehâra nüşûrâ.',
      translitEn:
          'Wa huwal-ladhi ja\'ala lakumul-layla libasan wan-nawma subatan wa ja\'alan-nahara nushura.',
      refTr: 'Furkân Suresi, 47. Ayet',
      refAr: 'سورة الفرقان، الآية ٤٧',
      refEn: 'Surah Al-Furqan, 25:47',
    ),
    Verse(
      arabic:
          'وَمِنَ اللَّيْلِ فَتَهَجَّدْ بِهِ نَافِلَةً لَّكَ عَسَىٰ أَن يَبْعَثَكَ رَبُّكَ مَقَامًا مَّحْمُودًا',
      tr: 'Gecenin bir kısmında da sana mahsus fazla bir ibadet olarak teheccüd namazı kıl ki Rabbin seni övülmüş bir makama ulaştırsın.',
      en: 'And from part of the night, pray with it as additional worship for you; it is expected that your Lord will raise you to a praised station.',
      translitTr:
          'Ve minel-leyli fetehecced bihî nâfileten lek. Asâ en yeb\'aseke rabbüke makâmen mahmûdâ.',
      translitEn:
          'Wa minal-layli fatahajjad bihi nafilatan lak. \'Asa an yab\'athaka rabbuka maqaman mahmuda.',
      refTr: 'İsrâ Suresi, 79. Ayet',
      refAr: 'سورة الإسراء، الآية ٧٩',
      refEn: 'Surah Al-Isra, 17:79',
    ),
  ],
];

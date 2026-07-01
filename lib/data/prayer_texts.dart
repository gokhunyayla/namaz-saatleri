/// Namaz sure ve duaları.
///
/// ÖNEMLİ: Bu metinler sabit, elle yazılmış ve doğrulanmış bir listedir;
/// çalışma anında üretilmez. Arapça metinler tam ve harekelidir.
/// Okunuşlar Türkçe (Diyanet usulü) ve Latin (İngilizce) olarak verilir.
class PrayerText {
  final String nameTr;
  final String nameAr;
  final String nameEn;

  /// Sure mi (true) yoksa dua mı (false)?
  final bool isSurah;

  final String arabic;
  final String translitTr;
  final String translitEn;
  final String mealTr;
  final String mealEn;

  const PrayerText({
    required this.nameTr,
    required this.nameAr,
    required this.nameEn,
    required this.isSurah,
    required this.arabic,
    required this.translitTr,
    required this.translitEn,
    required this.mealTr,
    required this.mealEn,
  });
}

const List<PrayerText> prayerDuas = [
  PrayerText(
    nameTr: 'Sübhâneke',
    nameAr: 'دعاء الاستفتاح (سبحانك)',
    nameEn: 'Subhanaka',
    isSurah: false,
    arabic:
        'سُبْحَانَكَ اللَّهُمَّ وَبِحَمْدِكَ وَتَبَارَكَ اسْمُكَ وَتَعَالَى جَدُّكَ وَلَا إِلَهَ غَيْرُكَ',
    translitTr:
        'Sübhânekellâhümme ve bi hamdik. Ve tebârakesmük. Ve teâlâ ceddük. Ve lâ ilâhe ğayruk.',
    translitEn:
        'Subhanaka Allahumma wa bihamdika, wa tabarakasmuka, wa ta\'ala jadduka, wa la ilaha ghayruk.',
    mealTr:
        'Allah\'ım! Sen eksik sıfatlardan uzaksın. Seni hamd ile tesbih ederim. Senin adın mübarektir, şanın yücedir. Senden başka ilâh yoktur.',
    mealEn:
        'Glory be to You, O Allah, and praise be to You. Blessed is Your name, exalted is Your majesty, and there is no god besides You.',
  ),
  PrayerText(
    nameTr: 'Ettehiyyâtü',
    nameAr: 'التشهد (التحيات)',
    nameEn: 'At-Tahiyyat',
    isSurah: false,
    arabic:
        'التَّحِيَّاتُ لِلَّهِ وَالصَّلَوَاتُ وَالطَّيِّبَاتُ، السَّلَامُ عَلَيْكَ أَيُّهَا النَّبِيُّ وَرَحْمَةُ اللَّهِ وَبَرَكَاتُهُ، السَّلَامُ عَلَيْنَا وَعَلَى عِبَادِ اللَّهِ الصَّالِحِينَ، أَشْهَدُ أَنْ لَا إِلَهَ إِلَّا اللَّهُ وَأَشْهَدُ أَنَّ مُحَمَّدًا عَبْدُهُ وَرَسُولُهُ',
    translitTr:
        'Ettehiyyâtü lillâhi vessalevâtü vettayyibât. Esselâmü aleyke eyyühen-nebiyyü ve rahmetullâhi ve berakâtüh. Esselâmü aleynâ ve alâ ibâdillâhis-sâlihîn. Eşhedü en lâ ilâhe illallâh ve eşhedü enne Muhammeden abdühû ve rasûlüh.',
    translitEn:
        'At-tahiyyatu lillahi was-salawatu wat-tayyibat. As-salamu \'alayka ayyuhan-nabiyyu wa rahmatullahi wa barakatuh. As-salamu \'alayna wa \'ala \'ibadillahis-salihin. Ash-hadu al-la ilaha illallah, wa ash-hadu anna Muhammadan \'abduhu wa rasuluh.',
    mealTr:
        'Bütün tâzimler, dualar ve güzel sözler Allah\'a mahsustur. Ey Peygamber! Selâm, Allah\'ın rahmeti ve bereketi senin üzerine olsun. Selâm bize ve Allah\'ın salih kullarına olsun. Şahitlik ederim ki Allah\'tan başka ilâh yoktur; yine şahitlik ederim ki Muhammed O\'nun kulu ve elçisidir.',
    mealEn:
        'All greetings, prayers and good things are for Allah. Peace be upon you, O Prophet, and the mercy and blessings of Allah. Peace be upon us and upon the righteous servants of Allah. I bear witness that there is no god but Allah, and I bear witness that Muhammad is His servant and messenger.',
  ),
  PrayerText(
    nameTr: 'Allâhümme Salli',
    nameAr: 'اللَّهُمَّ صَلِّ',
    nameEn: 'Allahumma Salli',
    isSurah: false,
    arabic:
        'اللَّهُمَّ صَلِّ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا صَلَّيْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ',
    translitTr:
        'Allâhümme salli alâ Muhammedin ve alâ âli Muhammed. Kemâ salleyte alâ İbrâhîme ve alâ âli İbrâhîm. İnneke hamîdün mecîd.',
    translitEn:
        'Allahumma salli \'ala Muhammadin wa \'ala ali Muhammad, kama sallayta \'ala Ibrahima wa \'ala ali Ibrahim, innaka Hamidun Majid.',
    mealTr:
        'Allah\'ım! Muhammed\'e ve Muhammed\'in ailesine rahmet et; İbrahim\'e ve İbrahim\'in ailesine rahmet ettiğin gibi. Şüphesiz sen övülmeye lâyıksın, şanı yüce olansın.',
    mealEn:
        'O Allah, send Your mercy upon Muhammad and the family of Muhammad, as You sent Your mercy upon Ibrahim and the family of Ibrahim. Indeed, You are Praiseworthy and Glorious.',
  ),
  PrayerText(
    nameTr: 'Allâhümme Bârik',
    nameAr: 'اللَّهُمَّ بَارِكْ',
    nameEn: 'Allahumma Barik',
    isSurah: false,
    arabic:
        'اللَّهُمَّ بَارِكْ عَلَى مُحَمَّدٍ وَعَلَى آلِ مُحَمَّدٍ كَمَا بَارَكْتَ عَلَى إِبْرَاهِيمَ وَعَلَى آلِ إِبْرَاهِيمَ إِنَّكَ حَمِيدٌ مَجِيدٌ',
    translitTr:
        'Allâhümme bârik alâ Muhammedin ve alâ âli Muhammed. Kemâ bârekte alâ İbrâhîme ve alâ âli İbrâhîm. İnneke hamîdün mecîd.',
    translitEn:
        'Allahumma barik \'ala Muhammadin wa \'ala ali Muhammad, kama barakta \'ala Ibrahima wa \'ala ali Ibrahim, innaka Hamidun Majid.',
    mealTr:
        'Allah\'ım! Muhammed\'e ve Muhammed\'in ailesine bereket ver; İbrahim\'e ve İbrahim\'in ailesine bereket verdiğin gibi. Şüphesiz sen övülmeye lâyıksın, şanı yüce olansın.',
    mealEn:
        'O Allah, bless Muhammad and the family of Muhammad, as You blessed Ibrahim and the family of Ibrahim. Indeed, You are Praiseworthy and Glorious.',
  ),
  PrayerText(
    nameTr: 'Rabbenâ Âtinâ',
    nameAr: 'رَبَّنَا آتِنَا',
    nameEn: 'Rabbana Atina',
    isSurah: false,
    arabic:
        'رَبَّنَا آتِنَا فِي الدُّنْيَا حَسَنَةً وَفِي الْآخِرَةِ حَسَنَةً وَقِنَا عَذَابَ النَّارِ',
    translitTr:
        'Rabbenâ âtinâ fid-dünyâ haseneten ve fil-âhirati haseneten ve kınâ azâben-nâr.',
    translitEn:
        'Rabbana atina fid-dunya hasanatan wa fil-akhirati hasanatan wa qina \'adhaban-nar.',
    mealTr:
        'Rabbimiz! Bize dünyada iyilik ver, ahirette de iyilik ver ve bizi ateş azabından koru. (Bakara, 2:201)',
    mealEn:
        'Our Lord, give us good in this world and good in the Hereafter, and protect us from the punishment of the Fire. (Al-Baqarah 2:201)',
  ),
  PrayerText(
    nameTr: 'Rabbenâğfirlî',
    nameAr: 'رَبَّنَا اغْفِرْ لِي',
    nameEn: 'Rabbanaghfirli',
    isSurah: false,
    arabic:
        'رَبَّنَا اغْفِرْ لِي وَلِوَالِدَيَّ وَلِلْمُؤْمِنِينَ يَوْمَ يَقُومُ الْحِسَابُ',
    translitTr:
        'Rabbenâğfirlî ve li-vâlideyye ve lil-mü\'minîne yevme yekûmül-hisâb.',
    translitEn:
        'Rabbanaghfirli wa liwalidayya wa lil-mu\'minina yawma yaqumul-hisab.',
    mealTr:
        'Rabbimiz! Hesabın görüleceği gün beni, anne-babamı ve bütün müminleri bağışla. (İbrahim, 14:41)',
    mealEn:
        'Our Lord, forgive me and my parents and the believers on the Day the account is established. (Ibrahim 14:41)',
  ),
  PrayerText(
    nameTr: 'Kunut Duası 1',
    nameAr: 'دعاء القنوت ١',
    nameEn: 'Qunut 1',
    isSurah: false,
    arabic:
        'اللَّهُمَّ إِنَّا نَسْتَعِينُكَ وَنَسْتَغْفِرُكَ وَنَسْتَهْدِيكَ وَنُؤْمِنُ بِكَ وَنَتُوبُ إِلَيْكَ وَنَتَوَكَّلُ عَلَيْكَ وَنُثْنِي عَلَيْكَ الْخَيْرَ كُلَّهُ نَشْكُرُكَ وَلَا نَكْفُرُكَ وَنَخْلَعُ وَنَتْرُكُ مَنْ يَفْجُرُكَ',
    translitTr:
        'Allâhümme innâ nesteînüke ve nestağfiruke ve nestehdîk. Ve nü\'minü bike ve netûbü ileyk. Ve netevekkelü aleyk. Ve nüsnî aleykel-hayra küllehû neşküruke ve lâ nekfüruk. Ve nahleu ve netrukü men yefcüruk.',
    translitEn:
        'Allahumma inna nasta\'inuka wa nastaghfiruka wa nastahdik, wa nu\'minu bika wa natubu ilayk, wa natawakkalu \'alayk, wa nuthni \'alaykal-khayra kullahu nashkuruka wa la nakfuruk, wa nakhla\'u wa natruku man yafjuruk.',
    mealTr:
        'Allah\'ım! Senden yardım, bağışlanma ve hidayet dileriz. Sana inanır, sana tövbe ederiz. Sana güveniriz. Bütün hayırlarla seni över, sana şükreder ve nankörlük etmeyiz. Sana karşı geleni bırakır, ondan uzaklaşırız.',
    mealEn:
        'O Allah, we seek Your help, Your forgiveness and Your guidance. We believe in You and turn to You in repentance. We rely upon You, praise You with all that is good, thank You and are not ungrateful to You; and we abandon and forsake whoever disobeys You.',
  ),
  PrayerText(
    nameTr: 'Kunut Duası 2',
    nameAr: 'دعاء القنوت ٢',
    nameEn: 'Qunut 2',
    isSurah: false,
    arabic:
        'اللَّهُمَّ إِيَّاكَ نَعْبُدُ وَلَكَ نُصَلِّي وَنَسْجُدُ وَإِلَيْكَ نَسْعَى وَنَحْفِدُ نَرْجُو رَحْمَتَكَ وَنَخْشَى عَذَابَكَ إِنَّ عَذَابَكَ بِالْكُفَّارِ مُلْحِقٌ',
    translitTr:
        'Allâhümme iyyâke na\'büdü ve leke nusallî ve nescüd. Ve ileyke nes\'â ve nahfid. Nercû rahmeteke ve nahşâ azâbek. İnne azâbeke bil-küffâri mülhık.',
    translitEn:
        'Allahumma iyyaka na\'budu wa laka nusalli wa nasjud, wa ilayka nas\'a wa nahfid. Narju rahmataka wa nakhsha \'adhabak, inna \'adhabaka bil-kuffari mulhiq.',
    mealTr:
        'Allah\'ım! Yalnız sana kulluk ederiz; namazı senin için kılar, sana secde ederiz. Sana koşar, sana yaklaştıracak işler yaparız. Rahmetini umar, azabından korkarız. Şüphesiz senin azabın kâfirlere ulaşacaktır.',
    mealEn:
        'O Allah, You alone we worship; for You we pray and prostrate; toward You we strive and hasten. We hope for Your mercy and fear Your punishment; indeed, Your punishment will overtake the disbelievers.',
  ),
];

const List<PrayerText> prayerSurahs = [
  PrayerText(
    nameTr: 'Fâtiha Suresi',
    nameAr: 'سورة الفاتحة',
    nameEn: 'Surah Al-Fatiha',
    isSurah: true,
    arabic:
        'بِسْمِ اللَّهِ الرَّحْمَٰنِ الرَّحِيمِ ﴿١﴾ الْحَمْدُ لِلَّهِ رَبِّ الْعَالَمِينَ ﴿٢﴾ الرَّحْمَٰنِ الرَّحِيمِ ﴿٣﴾ مَالِكِ يَوْمِ الدِّينِ ﴿٤﴾ إِيَّاكَ نَعْبُدُ وَإِيَّاكَ نَسْتَعِينُ ﴿٥﴾ اهْدِنَا الصِّرَاطَ الْمُسْتَقِيمَ ﴿٦﴾ صِرَاطَ الَّذِينَ أَنْعَمْتَ عَلَيْهِمْ غَيْرِ الْمَغْضُوبِ عَلَيْهِمْ وَلَا الضَّالِّينَ ﴿٧﴾',
    translitTr:
        'Bismillâhirrahmânirrahîm. Elhamdü lillâhi rabbil-âlemîn. Errahmânirrahîm. Mâliki yevmiddîn. İyyâke na\'büdü ve iyyâke nesteîn. İhdinas-sırâtal-müstakîm. Sırâtallezîne en\'amte aleyhim ğayril-mağdûbi aleyhim ve leddâllîn.',
    translitEn:
        'Bismillahir-Rahmanir-Rahim. Alhamdu lillahi Rabbil-\'alamin. Ar-Rahmanir-Rahim. Maliki yawmid-din. Iyyaka na\'budu wa iyyaka nasta\'in. Ihdinas-siratal-mustaqim. Siratal-ladhina an\'amta \'alayhim ghayril-maghdubi \'alayhim wa lad-dallin.',
    mealTr:
        'Rahmân ve Rahîm olan Allah\'ın adıyla. Hamd, âlemlerin Rabbi Allah\'a mahsustur. O Rahmân\'dır, Rahîm\'dir. Din (hesap) gününün sahibidir. (Rabbimiz!) Yalnız sana kulluk eder, yalnız senden yardım dileriz. Bizi dosdoğru yola ilet; kendilerine nimet verdiklerinin yoluna, gazaba uğrayanların ve sapkınların yoluna değil.',
    mealEn:
        'In the name of Allah, the Most Gracious, the Most Merciful. All praise is due to Allah, Lord of the worlds — the Most Gracious, the Most Merciful, Master of the Day of Judgment. You alone we worship, and You alone we ask for help. Guide us to the straight path — the path of those upon whom You have bestowed favor, not of those who have earned Your anger, nor of those who have gone astray.',
  ),
  PrayerText(
    nameTr: 'Fil Suresi',
    nameAr: 'سورة الفيل',
    nameEn: 'Surah Al-Fil',
    isSurah: true,
    arabic:
        'أَلَمْ تَرَ كَيْفَ فَعَلَ رَبُّكَ بِأَصْحَابِ الْفِيلِ ﴿١﴾ أَلَمْ يَجْعَلْ كَيْدَهُمْ فِي تَضْلِيلٍ ﴿٢﴾ وَأَرْسَلَ عَلَيْهِمْ طَيْرًا أَبَابِيلَ ﴿٣﴾ تَرْمِيهِم بِحِجَارَةٍ مِّن سِجِّيلٍ ﴿٤﴾ فَجَعَلَهُمْ كَعَصْفٍ مَّأْكُولٍ ﴿٥﴾',
    translitTr:
        'Elem tera keyfe feale rabbüke bi-ashâbil-fîl. Elem yec\'al keydehüm fî tadlîl. Ve ersele aleyhim tayran ebâbîl. Termîhim bi-hicâratin min siccîl. Fe cealehüm keasfin me\'kûl.',
    translitEn:
        'Alam tara kayfa fa\'ala Rabbuka bi-ashabil-fil. Alam yaj\'al kaydahum fi tadlil. Wa arsala \'alayhim tayran ababil. Tarmihim bihijaratin min sijjil. Faja\'alahum ka\'asfin ma\'kul.',
    mealTr:
        'Rabbinin, fil sahiplerine ne yaptığını görmedin mi? Onların tuzaklarını boşa çıkarmadı mı? Üzerlerine sürü sürü kuşlar gönderdi; onlara pişmiş çamurdan taşlar atıyorlardı. Sonunda onları yenmiş ekin yaprağı gibi yaptı.',
    mealEn:
        'Have you not seen how your Lord dealt with the companions of the elephant? Did He not make their plan go astray? He sent against them birds in flocks, striking them with stones of hard clay, and made them like eaten straw.',
  ),
  PrayerText(
    nameTr: 'Kureyş Suresi',
    nameAr: 'سورة قريش',
    nameEn: 'Surah Quraysh',
    isSurah: true,
    arabic:
        'لِإِيلَافِ قُرَيْشٍ ﴿١﴾ إِيلَافِهِمْ رِحْلَةَ الشِّتَاءِ وَالصَّيْفِ ﴿٢﴾ فَلْيَعْبُدُوا رَبَّ هَٰذَا الْبَيْتِ ﴿٣﴾ الَّذِي أَطْعَمَهُم مِّن جُوعٍ وَآمَنَهُم مِّنْ خَوْفٍ ﴿٤﴾',
    translitTr:
        'Li-îlâfi Kureyş. Îlâfihim rihleteş-şitâi vessayf. Felya\'büdû rabbe hâzel-beyt. Ellezî et\'amehüm min cûin ve âmenehüm min havf.',
    translitEn:
        'Li-ilafi Quraysh. Ilafihim rihlatash-shita\'i was-sayf. Falya\'budu Rabba hadhal-bayt. Alladhi at\'amahum min ju\'in wa amanahum min khawf.',
    mealTr:
        'Kureyş\'i alıştırdığı için; onları kış ve yaz yolculuklarına alıştırdığı için, bu Beyt\'in (Kâbe\'nin) Rabbine kulluk etsinler. O, onları açlıktan doyurdu ve korkudan güvende kıldı.',
    mealEn:
        'For the accustomed security of Quraysh — their security in the winter and summer journeys — let them worship the Lord of this House, who fed them against hunger and made them safe from fear.',
  ),
  PrayerText(
    nameTr: 'Mâûn Suresi',
    nameAr: 'سورة الماعون',
    nameEn: 'Surah Al-Ma\'un',
    isSurah: true,
    arabic:
        'أَرَأَيْتَ الَّذِي يُكَذِّبُ بِالدِّينِ ﴿١﴾ فَذَٰلِكَ الَّذِي يَدُعُّ الْيَتِيمَ ﴿٢﴾ وَلَا يَحُضُّ عَلَىٰ طَعَامِ الْمِسْكِينِ ﴿٣﴾ فَوَيْلٌ لِّلْمُصَلِّينَ ﴿٤﴾ الَّذِينَ هُمْ عَن صَلَاتِهِمْ سَاهُونَ ﴿٥﴾ الَّذِينَ هُمْ يُرَاءُونَ ﴿٦﴾ وَيَمْنَعُونَ الْمَاعُونَ ﴿٧﴾',
    translitTr:
        'Eraeytellezî yükezzibü biddîn. Fezâlikellezî yedu\'ul-yetîm. Ve lâ yehuddu alâ taâmil-miskîn. Feveylün lil-musallîn. Ellezîne hüm an salâtihim sâhûn. Ellezîne hüm yürâûn. Ve yemneûnel-mâûn.',
    translitEn:
        'Ara\'aytal-ladhi yukadhdhibu bid-din. Fadhalikal-ladhi yadu\'ul-yatim. Wa la yahuddu \'ala ta\'amil-miskin. Fawaylul-lil-musallin. Alladhina hum \'an salatihim sahun. Alladhina hum yura\'un. Wa yamna\'unal-ma\'un.',
    mealTr:
        'Dini yalanlayanı gördün mü? İşte o, yetimi itip kakar, yoksulu doyurmayı teşvik etmez. Vay o namaz kılanların hâline ki, onlar namazlarından gafildirler; gösteriş yaparlar ve en küçük yardımı bile esirgerler.',
    mealEn:
        'Have you seen the one who denies the Judgment? That is the one who pushes away the orphan and does not encourage feeding the poor. So woe to those who pray but are heedless of their prayer — those who make a show and withhold even small kindnesses.',
  ),
  PrayerText(
    nameTr: 'Kevser Suresi',
    nameAr: 'سورة الكوثر',
    nameEn: 'Surah Al-Kawthar',
    isSurah: true,
    arabic:
        'إِنَّا أَعْطَيْنَاكَ الْكَوْثَرَ ﴿١﴾ فَصَلِّ لِرَبِّكَ وَانْحَرْ ﴿٢﴾ إِنَّ شَانِئَكَ هُوَ الْأَبْتَرُ ﴿٣﴾',
    translitTr:
        'İnnâ a\'taynâkel-kevser. Fesalli li-rabbike venhar. İnne şânieke hüvel-ebter.',
    translitEn:
        'Inna a\'taynakal-kawthar. Fasalli li-Rabbika wanhar. Inna shani\'aka huwal-abtar.',
    mealTr:
        'Şüphesiz biz sana Kevser\'i verdik. O hâlde Rabbin için namaz kıl ve kurban kes. Asıl soyu kesik olan, sana buğzedendir.',
    mealEn:
        'Indeed, We have granted you al-Kawthar. So pray to your Lord and sacrifice. Indeed, your enemy is the one cut off.',
  ),
  PrayerText(
    nameTr: 'Kâfirûn Suresi',
    nameAr: 'سورة الكافرون',
    nameEn: 'Surah Al-Kafirun',
    isSurah: true,
    arabic:
        'قُلْ يَا أَيُّهَا الْكَافِرُونَ ﴿١﴾ لَا أَعْبُدُ مَا تَعْبُدُونَ ﴿٢﴾ وَلَا أَنتُمْ عَابِدُونَ مَا أَعْبُدُ ﴿٣﴾ وَلَا أَنَا عَابِدٌ مَّا عَبَدتُّمْ ﴿٤﴾ وَلَا أَنتُمْ عَابِدُونَ مَا أَعْبُدُ ﴿٥﴾ لَكُمْ دِينُكُمْ وَلِيَ دِينِ ﴿٦﴾',
    translitTr:
        'Kul yâ eyyühel-kâfirûn. Lâ a\'büdü mâ ta\'büdûn. Ve lâ entüm âbidûne mâ a\'büd. Ve lâ ene âbidün mâ abedtüm. Ve lâ entüm âbidûne mâ a\'büd. Leküm dînüküm ve liye dîn.',
    translitEn:
        'Qul ya ayyuhal-kafirun. La a\'budu ma ta\'budun. Wa la antum \'abiduna ma a\'bud. Wa la ana \'abidun ma \'abadtum. Wa la antum \'abiduna ma a\'bud. Lakum dinukum wa liya din.',
    mealTr:
        'De ki: Ey kâfirler! Ben sizin taptıklarınıza tapmam. Siz de benim ibadet ettiğime ibadet edecek değilsiniz. Ben sizin taptıklarınıza tapacak değilim. Siz de benim ibadet ettiğime ibadet edecek değilsiniz. Sizin dininiz size, benim dinim banadır.',
    mealEn:
        'Say: O disbelievers! I do not worship what you worship, nor are you worshippers of what I worship. Nor will I be a worshipper of what you worship, nor will you be worshippers of what I worship. For you is your religion, and for me is my religion.',
  ),
  PrayerText(
    nameTr: 'Nasr Suresi',
    nameAr: 'سورة النصر',
    nameEn: 'Surah An-Nasr',
    isSurah: true,
    arabic:
        'إِذَا جَاءَ نَصْرُ اللَّهِ وَالْفَتْحُ ﴿١﴾ وَرَأَيْتَ النَّاسَ يَدْخُلُونَ فِي دِينِ اللَّهِ أَفْوَاجًا ﴿٢﴾ فَسَبِّحْ بِحَمْدِ رَبِّكَ وَاسْتَغْفِرْهُ ۚ إِنَّهُ كَانَ تَوَّابًا ﴿٣﴾',
    translitTr:
        'İzâ câe nasrullâhi vel-feth. Ve raeyten-nâse yedhulûne fî dînillâhi efvâcâ. Fesebbih bi-hamdi rabbike vestağfirh. İnnehû kâne tevvâbâ.',
    translitEn:
        'Idha ja\'a nasrullahi wal-fath. Wa ra\'aytan-nasa yadkhuluna fi dinillahi afwaja. Fasabbih bihamdi Rabbika wastaghfirh, innahu kana tawwaba.',
    mealTr:
        'Allah\'ın yardımı ve fetih geldiğinde, insanların bölük bölük Allah\'ın dinine girdiğini gördüğünde, Rabbini hamd ile tesbih et ve O\'ndan bağışlanma dile. Çünkü O, tövbeleri çok kabul edendir.',
    mealEn:
        'When the victory of Allah has come and the conquest, and you see the people entering the religion of Allah in multitudes, then exalt with praise of your Lord and ask His forgiveness. Indeed, He is ever accepting of repentance.',
  ),
  PrayerText(
    nameTr: 'Tebbet Suresi',
    nameAr: 'سورة المسد',
    nameEn: 'Surah Al-Masad',
    isSurah: true,
    arabic:
        'تَبَّتْ يَدَا أَبِي لَهَبٍ وَتَبَّ ﴿١﴾ مَا أَغْنَىٰ عَنْهُ مَالُهُ وَمَا كَسَبَ ﴿٢﴾ سَيَصْلَىٰ نَارًا ذَاتَ لَهَبٍ ﴿٣﴾ وَامْرَأَتُهُ حَمَّالَةَ الْحَطَبِ ﴿٤﴾ فِي جِيدِهَا حَبْلٌ مِّن مَّسَدٍ ﴿٥﴾',
    translitTr:
        'Tebbet yedâ ebî lehebin ve tebb. Mâ ağnâ anhü mâlühû ve mâ keseb. Seyaslâ nâran zâte leheb. Vemraetühû hammâletel-hatab. Fî cîdihâ hablün min mesed.',
    translitEn:
        'Tabbat yada abi lahabin wa tabb. Ma aghna \'anhu maluhu wa ma kasab. Sayasla naran dhata lahab. Wamra\'atuhu hammalatal-hatab. Fi jidiha hablun min masad.',
    mealTr:
        'Ebû Leheb\'in iki eli kurusun, kurudu da! Malı ve kazandıkları ona fayda vermedi. O, alevli bir ateşe girecektir. Odun taşıyıcısı olarak karısı da. Boynunda bükülmüş bir ip olduğu hâlde.',
    mealEn:
        'May the hands of Abu Lahab be ruined, and ruined is he. His wealth will not avail him or that which he gained. He will burn in a Fire of flame, and his wife as well — the carrier of firewood, around her neck a rope of twisted fiber.',
  ),
  PrayerText(
    nameTr: 'İhlâs Suresi',
    nameAr: 'سورة الإخلاص',
    nameEn: 'Surah Al-Ikhlas',
    isSurah: true,
    arabic:
        'قُلْ هُوَ اللَّهُ أَحَدٌ ﴿١﴾ اللَّهُ الصَّمَدُ ﴿٢﴾ لَمْ يَلِدْ وَلَمْ يُولَدْ ﴿٣﴾ وَلَمْ يَكُن لَّهُ كُفُوًا أَحَدٌ ﴿٤﴾',
    translitTr:
        'Kul hüvallâhü ehad. Allâhüs-samed. Lem yelid ve lem yûled. Ve lem yekün lehû küfüven ehad.',
    translitEn:
        'Qul huwallahu ahad. Allahus-samad. Lam yalid wa lam yulad. Wa lam yakun lahu kufuwan ahad.',
    mealTr:
        'De ki: O, Allah\'tır, tektir. Allah Samed\'dir (her şey O\'na muhtaçtır, O hiçbir şeye muhtaç değildir). Doğurmamıştır, doğurulmamıştır. Hiçbir şey O\'na denk değildir.',
    mealEn:
        'Say: He is Allah, the One. Allah, the Eternal Refuge. He neither begets nor is born, nor is there to Him any equivalent.',
  ),
  PrayerText(
    nameTr: 'Felak Suresi',
    nameAr: 'سورة الفلق',
    nameEn: 'Surah Al-Falaq',
    isSurah: true,
    arabic:
        'قُلْ أَعُوذُ بِرَبِّ الْفَلَقِ ﴿١﴾ مِن شَرِّ مَا خَلَقَ ﴿٢﴾ وَمِن شَرِّ غَاسِقٍ إِذَا وَقَبَ ﴿٣﴾ وَمِن شَرِّ النَّفَّاثَاتِ فِي الْعُقَدِ ﴿٤﴾ وَمِن شَرِّ حَاسِدٍ إِذَا حَسَدَ ﴿٥﴾',
    translitTr:
        'Kul eûzü bi-rabbil-felak. Min şerri mâ halak. Ve min şerri ğâsikın izâ vekab. Ve min şerrin-neffâsâti fil-ukad. Ve min şerri hâsidin izâ hased.',
    translitEn:
        'Qul a\'udhu bi-Rabbil-falaq. Min sharri ma khalaq. Wa min sharri ghasiqin idha waqab. Wa min sharrin-naffathati fil-\'uqad. Wa min sharri hasidin idha hasad.',
    mealTr:
        'De ki: Yarattığı şeylerin şerrinden, karanlığı çöktüğünde gecenin şerrinden, düğümlere üfleyenlerin şerrinden ve haset ettiğinde hasetçinin şerrinden, sabahın Rabbine sığınırım.',
    mealEn:
        'Say: I seek refuge in the Lord of daybreak — from the evil of what He created, from the evil of darkness when it settles, from the evil of the blowers in knots, and from the evil of an envier when he envies.',
  ),
  PrayerText(
    nameTr: 'Nâs Suresi',
    nameAr: 'سورة الناس',
    nameEn: 'Surah An-Nas',
    isSurah: true,
    arabic:
        'قُلْ أَعُوذُ بِرَبِّ النَّاسِ ﴿١﴾ مَلِكِ النَّاسِ ﴿٢﴾ إِلَٰهِ النَّاسِ ﴿٣﴾ مِن شَرِّ الْوَسْوَاسِ الْخَنَّاسِ ﴿٤﴾ الَّذِي يُوَسْوِسُ فِي صُدُورِ النَّاسِ ﴿٥﴾ مِنَ الْجِنَّةِ وَالنَّاسِ ﴿٦﴾',
    translitTr:
        'Kul eûzü bi-rabbin-nâs. Melikin-nâs. İlâhin-nâs. Min şerril-vesvâsil-hannâs. Ellezî yüvesvisü fî sudûrin-nâs. Minel-cinneti ven-nâs.',
    translitEn:
        'Qul a\'udhu bi-Rabbin-nas. Malikin-nas. Ilahin-nas. Min sharril-waswasil-khannas. Alladhi yuwaswisu fi sudurin-nas. Minal-jinnati wan-nas.',
    mealTr:
        'De ki: İnsanların Rabbine, insanların Melikine, insanların İlâhına sığınırım; o sinsi vesvesecinin şerrinden — ki o, insanların göğüslerine vesvese verir; cinlerden ve insanlardan.',
    mealEn:
        'Say: I seek refuge in the Lord of mankind, the King of mankind, the God of mankind — from the evil of the retreating whisperer, who whispers in the breasts of mankind, from among jinn and mankind.',
  ),
];

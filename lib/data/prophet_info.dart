/// Hz. Muhammed'in (s.a.v.) hayatı: önemli olaylar, tarihler ve kişiliği.
///
/// ÖNEMLİ: İçerik sabit ve elle yazılmıştır; yaygın siyer kaynaklarındaki
/// (Diyanet İslam Ansiklopedisi vb.) genel kabul görmüş bilgilere dayanır.
class ProphetTopic {
  final String titleTr;
  final String titleAr;
  final String titleEn;
  final String subtitleTr;
  final String subtitleAr;
  final String subtitleEn;
  final String detailTr;
  final String detailAr;
  final String detailEn;

  const ProphetTopic(this.titleTr, this.titleAr, this.titleEn,
      this.subtitleTr, this.subtitleAr, this.subtitleEn,
      this.detailTr, this.detailAr, this.detailEn);
}

/// Sayfa başlıkları (TR, AR, EN).
const prophetTitleTr = 'Hz. Muhammed (s.a.v.)';
const prophetTitleAr = 'النبي محمد ﷺ';
const prophetTitleEn = 'Prophet Muhammad (pbuh)';

const List<ProphetTopic> prophetTopics = [
  ProphetTopic('Doğumu', 'مولده', 'His Birth',
      '571, Mekke', '٥٧١م، مكة', '571 CE, Mecca',
      'Hz. Muhammed (s.a.v.) 571 yılında (Fil Yılı) Mekke\'de doğdu; doğumu Rebiülevvel ayının 12\'sinde kabul edilir. Babası Abdullah, doğumundan önce vefat etmişti. Kureyş kabilesinin Hâşimoğulları koluna mensuptur.',
      'وُلد النبي محمد ﷺ عام الفيل (٥٧١م) بمكة في ١٢ ربيع الأول. توفي أبوه عبد الله قبل ولادته، وهو من بني هاشم من قريش.',
      'Prophet Muhammad (pbuh) was born in Mecca in 571 CE (the Year of the Elephant), on the 12th of Rabi al-Awwal. His father Abdullah died before his birth. He belonged to the Banu Hashim clan of Quraysh.'),
  ProphetTopic('Çocukluğu', 'طفولته', 'His Childhood',
      'Yetim büyüdü', 'نشأ يتيمًا', 'Raised an orphan',
      'Sütannesi Halime\'nin yanında çölde büyüdü. Altı yaşında annesi Âmine\'yi kaybetti; önce dedesi Abdülmuttalib, onun vefatıyla amcası Ebû Tâlib onu himayesine aldı.',
      'نشأ في البادية عند مرضعته حليمة السعدية. توفيت أمه آمنة وله ست سنوات، فكفله جده عبد المطلب ثم عمه أبو طالب.',
      'He was nursed in the desert by Halima. At six he lost his mother Amina; his grandfather Abdul-Muttalib and then his uncle Abu Talib took him into their care.'),
  ProphetTopic('el-Emîn', 'الأمين', 'Al-Amin (The Trustworthy)',
      'Gençliği ve ticaret', 'شبابه وتجارته', 'His youth and trade',
      'Gençliğinde ticaretle uğraştı; dürüstlüğü ve güvenilirliği sebebiyle Mekkeliler ona \'el-Emîn\' (güvenilir) lakabını verdi. İnsanlar kıymetli eşyalarını ona emanet ederdi.',
      'عمل بالتجارة في شبابه، ولقّبه أهل مكة بـ«الأمين» لصدقه وأمانته، وكانوا يودعون عنده ودائعهم.',
      'In his youth he worked in trade; the Meccans called him \'Al-Amin\' (the trustworthy) for his honesty. People entrusted their valuables to him.'),
  ProphetTopic('Hz. Hatice ile Evliliği', 'زواجه من خديجة', 'Marriage to Khadijah',
      '595', '٥٩٥م', '595 CE',
      '25 yaşında, ticaret kervanını yönettiği Hz. Hatice ile evlendi. Bu evlilik 25 yıl sürdü; altı çocuğu oldu ve Hatice hayatta olduğu sürece başka evlilik yapmadı.',
      'تزوج خديجة بنت خويلد وعمره ٢٥ سنة بعد أن أدار تجارتها. دام الزواج ٢٥ عامًا ورُزق منها بستة أولاد، ولم يتزوج عليها في حياتها.',
      'At 25 he married Khadijah, whose trade caravan he had managed. The marriage lasted 25 years and gave him six children; he took no other wife while she lived.'),
  ProphetTopic('Kâbe Hakemliği', 'تحكيمه في الكعبة', 'Arbitration at the Kaaba',
      '605', '٦٠٥م', '605 CE',
      'Kâbe onarımında Hacerülesved\'i yerine koyma şerefi için kabileler anlaşmazlığa düşünce hakem seçildi; taşı bir örtüye koyup bütün kabile temsilcilerine birlikte taşıtarak anlaşmazlığı çözdü.',
      'عند إعادة بناء الكعبة اختلفت القبائل فيمن يضع الحجر الأسود، فرضوا به حكمًا؛ فوضع الحجر في رداء ورفعته القبائل معًا فحسم الخلاف.',
      'When the clans disputed the honor of placing the Black Stone during the Kaaba\'s rebuilding, he was chosen as arbiter; he had all clans lift the stone together on a cloak, resolving the conflict.'),
  ProphetTopic('İlk Vahiy', 'الوحي الأول', 'The First Revelation',
      '610, Hira', '٦١٠م، غار حراء', '610 CE, Cave of Hira',
      '40 yaşında, Ramazan ayında Hira Mağarası\'nda ilk vahyi aldı: \'Yaratan Rabbinin adıyla oku!\' (Alak 1-5). Vahiy, Cebrail (a.s.) aracılığıyla 23 yıl boyunca devam etti.',
      'نزل عليه الوحي أول مرة في غار حراء وعمره ٤٠ سنة: «اقرأ باسم ربك الذي خلق» (العلق ١-٥)، واستمر الوحي بواسطة جبريل ٢٣ سنة.',
      'At 40, in Ramadan, he received the first revelation in the Cave of Hira: \'Read in the name of your Lord who created\' (96:1-5). Revelation continued through Gabriel for 23 years.'),
  ProphetTopic('Mekke Dönemi ve Davet', 'الدعوة بمكة', 'The Meccan Period',
      'Gizli ve açık davet', 'الدعوة سرًا وجهرًا', 'Secret and open call',
      'Önce gizli, üç yıl sonra açık davete başladı. Müşriklerin baskısı artınca bir grup Müslüman Habeşistan\'a hicret etti; Müslümanlar üç yıl süren boykota maruz kaldı.',
      'دعا سرًّا ثلاث سنين ثم جهر بالدعوة. ولما اشتد أذى قريش هاجر بعض المسلمين إلى الحبشة، وحوصر المسلمون في الشعب ثلاث سنين.',
      'He preached secretly for three years, then openly. As persecution grew, some Muslims emigrated to Abyssinia, and the Muslims endured a three-year boycott.'),
  ProphetTopic('Hüzün Yılı ve Tâif', 'عام الحزن والطائف', 'Year of Sorrow & Taif',
      '619-620', '٦١٩-٦٢٠م', '619-620 CE',
      'Eşi Hz. Hatice ile amcası Ebû Tâlib\'i aynı yıl kaybetti; bu yıla \'Hüzün Yılı\' denir. Davet için gittiği Tâif\'te taşlandı; yine de halkına beddua etmedi.',
      'توفيت زوجته خديجة وعمه أبو طالب في عام واحد سُمي «عام الحزن». وذهب إلى الطائف داعيًا فرُمي بالحجارة، ومع ذلك لم يدعُ على أهلها.',
      'He lost both Khadijah and Abu Talib in one year, called the \'Year of Sorrow.\' In Taif he was stoned while preaching, yet refused to curse its people.'),
  ProphetTopic('İsrâ ve Mi\'rac', 'الإسراء والمعراج', 'Isra and Mi\'raj',
      '~621; beş vakit namaz', 'نحو ٦٢١م؛ فرض الصلوات', 'c. 621 CE',
      'Bir gece Mescid-i Harâm\'dan Mescid-i Aksâ\'ya götürüldü (İsrâ) ve oradan göklere yükseltildi (Mi\'rac). Beş vakit namaz bu gece farz kılındı (İsrâ 1).',
      'أُسري به ليلًا من المسجد الحرام إلى المسجد الأقصى ثم عُرج به إلى السماوات، وفُرضت الصلوات الخمس في تلك الليلة (الإسراء ١).',
      'In one night he was taken from the Sacred Mosque to Al-Aqsa (Isra) and raised through the heavens (Mi\'raj). The five daily prayers were ordained that night (17:1).'),
  ProphetTopic('Hicret', 'الهجرة', 'The Hijra',
      '622, Medine', '٦٢٢م، المدينة', '622 CE, Medina',
      'Mekkeli müşriklerin suikast planı üzerine Hz. Ebû Bekir ile Medine\'ye hicret etti. Hicret, İslam takviminin başlangıcı kabul edilir.',
      'لما تآمرت قريش على قتله هاجر مع أبي بكر إلى المدينة. وجُعلت الهجرة مبدأ التقويم الهجري.',
      'When the Meccans plotted to kill him, he emigrated with Abu Bakr to Medina. The Hijra marks the start of the Islamic calendar.'),
  ProphetTopic('Medine\'de Toplum İnşası', 'بناء المجتمع بالمدينة', 'Building Community in Medina',
      'Mescid, kardeşlik, vesika', 'المسجد والمؤاخاة والصحيفة', 'Mosque, brotherhood, charter',
      'Mescid-i Nebevî\'yi inşa etti, Mekkeli muhacirlerle Medineli ensarı kardeş ilan etti ve şehirdeki topluluklarla \'Medine Vesikası\' adlı toplumsal sözleşmeyi yaptı.',
      'بنى المسجد النبوي، وآخى بين المهاجرين والأنصار، ووضع «صحيفة المدينة» ميثاقًا بين أهلها.',
      'He built the Prophet\'s Mosque, established brotherhood between the Meccan emigrants and Medinan helpers, and enacted the Charter of Medina among the city\'s communities.'),
  ProphetTopic('Bedir Savaşı', 'غزوة بدر', 'Battle of Badr',
      '624', '٦٢٤م', '624 CE',
      'Müslümanların Kureyş ile ilk büyük savaşıdır; yaklaşık 305 kişilik ordu, kendisinden üç kat kalabalık Mekke ordusunu yendi. Kur\'an bu günü \'Furkan günü\' olarak anar (Enfâl 41).',
      'أول معركة كبرى مع قريش؛ انتصر فيها نحو ٣١٣ من المسلمين على جيش يبلغ ثلاثة أمثالهم. وسماها القرآن «يوم الفرقان» (الأنفال ٤١).',
      'The Muslims\' first major battle with Quraysh; about 313 men defeated an army three times their size. The Quran calls it \'the day of the criterion\' (8:41).'),
  ProphetTopic('Uhud Savaşı', 'غزوة أحد', 'Battle of Uhud',
      '625', '٦٢٥م', '625 CE',
      'Uhud Dağı eteğinde yapıldı. Okçuların yerlerini terk etmesiyle Müslümanlar güç kaybetti; Hz. Hamza şehit oldu, Peygamberimiz yaralandı.',
      'وقعت عند جبل أحد. لما ترك الرماة مواقعهم انقلبت كفة المعركة؛ استُشهد حمزة وجُرح النبي ﷺ.',
      'Fought at Mount Uhud. When the archers left their posts the tide turned; Hamza was martyred and the Prophet was wounded.'),
  ProphetTopic('Hendek Savaşı', 'غزوة الخندق', 'Battle of the Trench',
      '627', '٦٢٧م', '627 CE',
      'Selmân-ı Fârisî\'nin önerisiyle Medine\'nin etrafına hendek kazıldı; müttefik müşrik ordusu şehri alamadan kuşatmayı bırakıp dağıldı.',
      'حُفر الخندق حول المدينة بمشورة سلمان الفارسي، فعجزت الأحزاب عن اقتحامها وانصرفت خائبة.',
      'On Salman al-Farisi\'s advice a trench was dug around Medina; the confederate army failed to take the city and withdrew.'),
  ProphetTopic('Hudeybiye ve Hayber', 'الحديبية وخيبر', 'Hudaybiyya & Khaybar',
      '628', '٦٢٨م', '628 CE',
      'Mekkelilerle 10 yıllık Hudeybiye Barış Antlaşması imzalandı; Kur\'an bunu \'apaçık fetih\' diye anar (Fetih 1). Aynı dönemde Hayber fethedildi.',
      'عُقد صلح الحديبية مع قريش لعشر سنين، وسماه القرآن «فتحًا مبينًا» (الفتح ١). وفي العام نفسه فُتحت خيبر.',
      'The ten-year Treaty of Hudaybiyya was signed with Mecca; the Quran calls it \'a clear victory\' (48:1). Khaybar was conquered the same year.'),
  ProphetTopic('Mekke\'nin Fethi', 'فتح مكة', 'Conquest of Mecca',
      '630; genel af', '٦٣٠م؛ العفو العام', '630 CE; general amnesty',
      'Antlaşmanın bozulması üzerine 10 bin kişilik orduyla Mekke\'ye girdi; kan dökülmeden genel af ilan etti ve Kâbe putlardan temizlendi. \'Bugün size kınama yok\' diyerek eski düşmanlarını bağışladı.',
      'بعد نقض قريش للصلح دخل مكة في عشرة آلاف؛ فأعلن العفو العام وطهّر الكعبة من الأصنام وقال: «اذهبوا فأنتم الطلقاء».',
      'After the treaty was violated he entered Mecca with 10,000 men, declared a general amnesty without bloodshed, cleansed the Kaaba of idols, and forgave his former enemies.'),
  ProphetTopic('Veda Haccı', 'حجة الوداع', 'The Farewell Pilgrimage',
      '632', '٦٣٢م', '632 CE',
      'Vefatından önce yüz binden fazla Müslümanla tek haccını yaptı. Veda Hutbesi\'nde can, mal ve ırz dokunulmazlığını, insanların eşitliğini ilan etti; \'Bugün dininizi tamamladım\' ayeti (Mâide 3) bu sırada indi.',
      'حج حجته الوحيدة مع أكثر من مئة ألف مسلم، وأعلن في خطبة الوداع حرمة الدماء والأموال والأعراض ومساواة الناس. ونزل قوله تعالى: «اليوم أكملت لكم دينكم» (المائدة ٣).',
      'He performed his only pilgrimage with over 100,000 Muslims. In the Farewell Sermon he proclaimed the sanctity of life, property and honor, and human equality; the verse \'This day I have perfected your religion\' (5:3) was revealed.'),
  ProphetTopic('Vefatı', 'وفاته', 'His Passing',
      '8 Haziran 632, Medine', '١٢ ربيع الأول ١١هـ', '8 June 632, Medina',
      '8 Haziran 632\'de (Hicrî 11, Rebiülevvel 12) Medine\'de vefat etti; Mescid-i Nebevî\'deki odasına defnedildi. Vefatında 63 yaşındaydı.',
      'توفي ﷺ في ١٢ ربيع الأول سنة ١١هـ (٦٣٢م) بالمدينة وعمره ٦٣ سنة، ودُفن في حجرته بجوار المسجد النبوي.',
      'He passed away on 8 June 632 (12 Rabi al-Awwal, 11 AH) in Medina at the age of 63, and was buried in his chamber beside the Prophet\'s Mosque.'),
  ProphetTopic('Kişiliği ve Ahlâkı', 'خُلقه وشمائله', 'Character & Morals',
      'Âlemlere rahmet', 'رحمة للعالمين', 'A mercy to the worlds',
      'Kur\'an onu \'üstün bir ahlâk üzere\' diye över (Kalem 4) ve \'âlemlere rahmet\' olarak gönderildiğini bildirir (Enbiyâ 107). Sade yaşar, kimseyi küçümsemez, istişareye önem verir; çocuklara, yaşlılara ve hayvanlara merhamet gösterirdi. Doğruluğu, adaleti ve affediciliği ile tanınırdı.',
      'أثنى الله عليه بقوله: «وإنك لعلى خلق عظيم» (القلم ٤) وأرسله «رحمة للعالمين» (الأنبياء ١٠٧). عاش بسيطًا متواضعًا، يشاور أصحابه ويرحم الصغير والكبير، وعُرف بالصدق والعدل والعفو.',
      'The Quran praises him as being \'of great moral character\' (68:4), sent as \'a mercy to the worlds\' (21:107). He lived simply, consulted his companions, showed mercy to children, elders and animals, and was known for honesty, justice and forgiveness.'),
];

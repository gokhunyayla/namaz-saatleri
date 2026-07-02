/// 32 Farz — İmanın 6, İslam'ın 5, Namazın 12, Abdestin 4, Guslün 3 ve
/// Teyemmümün 2 farzı. İçerik sabittir; Diyanet İlmihali'ne (Hanefî) dayanır.
class FardItem {
  final String nameTr;
  final String nameAr;
  final String nameEn;
  final String detailTr;
  final String detailAr;
  final String detailEn;

  const FardItem(this.nameTr, this.nameAr, this.nameEn,
      this.detailTr, this.detailAr, this.detailEn);
}

class FardGroup {
  final String titleTr;
  final String titleAr;
  final String titleEn;
  final List<FardItem> items;

  const FardGroup(this.titleTr, this.titleAr, this.titleEn, this.items);
}

/// Bölüm başlığı (TR, AR, EN).
const fardSectionTitleTr = '32 Farz';
const fardSectionTitleAr = 'الفرائض الاثنتان والثلاثون';
const fardSectionTitleEn = 'The 32 Obligations';

const List<FardGroup> thirtyTwoFard = [
  FardGroup('İmanın Şartları (6)', 'أركان الإيمان (٦)', 'Pillars of Faith (6)', [
    FardItem('Allah\'a iman', 'الإيمان بالله', 'Belief in Allah',
        'Allah\'ın varlığına, birliğine, eşi ve benzeri olmadığına inanmaktır. İmanın temeli ve ilk şartıdır.',
        'الإيمان بوجود الله ووحدانيته وأنه لا شريك له؛ وهو أساس الإيمان.',
        'To believe in the existence and oneness of Allah, who has no partner. It is the foundation of faith.'),
    FardItem('Meleklere iman', 'الإيمان بالملائكة', 'Belief in the Angels',
        'Nurdan yaratılmış, Allah\'ın emirlerini yerine getiren meleklerin varlığına inanmaktır (Cebrail, Mikail, İsrafil, Azrail ve diğerleri).',
        'الإيمان بوجود الملائكة المخلوقين من نور، المنفذين لأوامر الله كجبريل وميكائيل.',
        'To believe in the angels, created from light, who carry out Allah\'s commands (Gabriel, Michael and others).'),
    FardItem('Kitaplara iman', 'الإيمان بالكتب', 'Belief in the Books',
        'Allah\'ın peygamberlerine indirdiği kitaplara inanmaktır: Tevrat, Zebur, İncil ve son kitap Kur\'an-ı Kerim.',
        'الإيمان بالكتب المنزلة على الرسل: التوراة والزبور والإنجيل والقرآن الكريم خاتمها.',
        'To believe in the books revealed to the prophets: the Torah, Psalms, Gospel, and finally the Quran.'),
    FardItem('Peygamberlere iman', 'الإيمان بالرسل', 'Belief in the Prophets',
        'İlk peygamber Hz. Âdem\'den son peygamber Hz. Muhammed\'e (s.a.v.) kadar bütün peygamberlere inanmaktır.',
        'الإيمان بجميع الأنبياء من آدم إلى خاتمهم محمد ﷺ.',
        'To believe in all the prophets, from Adam to the final prophet Muhammad (pbuh).'),
    FardItem('Ahiret gününe iman', 'الإيمان باليوم الآخر', 'Belief in the Last Day',
        'Öldükten sonra dirilmeye, hesaba, cennet ve cehenneme inanmaktır.',
        'الإيمان بالبعث بعد الموت والحساب والجنة والنار.',
        'To believe in resurrection after death, the reckoning, Paradise and Hell.'),
    FardItem('Kadere iman', 'الإيمان بالقدر', 'Belief in Divine Decree',
        'Hayrın ve şerrin Allah\'ın takdiri ve yaratmasıyla olduğuna inanmaktır; kul irade ve sorumluluk sahibidir.',
        'الإيمان بأن الخير والشر بقدر الله وخلقه، مع إثبات إرادة العبد ومسؤوليته.',
        'To believe that good and evil occur by Allah\'s decree; humans retain will and responsibility.'),
  ]),
  FardGroup('İslam\'ın Şartları (5)', 'أركان الإسلام (٥)', 'Pillars of Islam (5)', [
    FardItem('Kelime-i şehadet', 'الشهادتان', 'The Testimony of Faith',
        '\'Eşhedü en lâ ilâhe illallah ve eşhedü enne Muhammeden abdühû ve rasûlüh\' diyerek Allah\'ın birliğine ve Hz. Muhammed\'in O\'nun kulu ve elçisi olduğuna şahitlik etmektir.',
        'شهادة أن لا إله إلا الله وأن محمدًا عبده ورسوله.',
        'To testify that there is no god but Allah and that Muhammad is His servant and messenger.'),
    FardItem('Namaz kılmak', 'إقام الصلاة', 'Performing the Prayer',
        'Günde beş vakit namazı vaktinde kılmaktır; dinin direği sayılır.',
        'أداء الصلوات الخمس في أوقاتها؛ وهي عماد الدين.',
        'To perform the five daily prayers on time; it is the pillar of the religion.'),
    FardItem('Oruç tutmak', 'صوم رمضان', 'Fasting Ramadan',
        'Ramazan ayında imsaktan iftara kadar yeme, içme ve orucu bozan şeylerden uzak durmaktır.',
        'الإمساك عن المفطرات من الفجر إلى الغروب في رمضان.',
        'To fast during Ramadan from dawn to sunset, abstaining from what breaks the fast.'),
    FardItem('Zekât vermek', 'إيتاء الزكاة', 'Giving Zakat',
        'Nisap miktarı mala sahip olanın, malının kırkta birini (%2,5) yılda bir kez ihtiyaç sahiplerine vermesidir.',
        'إخراج ربع العشر من المال البالغ النصاب كل عام لمستحقيه.',
        'For those with sufficient wealth to give 2.5% of it annually to those in need.'),
    FardItem('Hacca gitmek', 'حج البيت', 'Pilgrimage to Mecca',
        'Gücü yeten Müslümanın ömründe bir kez hac mevsiminde Kâbe\'yi ziyaret edip hac ibadetini yapmasıdır.',
        'حج البيت الحرام مرة في العمر لمن استطاع إليه سبيلًا.',
        'For those able, to perform the pilgrimage to the Kaaba once in a lifetime.'),
  ]),
  FardGroup('Namazın Farzları (12)', 'فرائض الصلاة (١٢)', 'Obligations of Prayer (12)', [
    FardItem('Hadesten taharet', 'الطهارة من الحدث', 'Purity from ritual impurity',
        'Namazdan önce abdestsizlik hâlinden abdestle, gerekiyorsa gusülle temizlenmektir. (Dışındaki şartlardandır.)',
        'رفع الحدث بالوضوء أو الغسل قبل الصلاة. (من شروط الصلاة)',
        'To remove ritual impurity with wudu or ghusl before prayer. (A precondition)'),
    FardItem('Necasetten taharet', 'الطهارة من النجاسة', 'Purity from filth',
        'Beden, elbise ve namaz kılınacak yerin temiz olmasıdır. (Şart)',
        'طهارة البدن والثوب ومكان الصلاة. (شرط)',
        'Cleanliness of body, clothing and place of prayer. (A precondition)'),
    FardItem('Setr-i avret', 'ستر العورة', 'Covering the body',
        'Örtülmesi gereken yerlerin namazda örtülü olmasıdır. (Şart)',
        'ستر ما يجب ستره في الصلاة. (شرط)',
        'Covering what must be covered during prayer. (A precondition)'),
    FardItem('İstikbâl-i kıble', 'استقبال القبلة', 'Facing the qibla',
        'Namazda Kâbe yönüne dönmektir. (Şart)',
        'التوجه إلى الكعبة في الصلاة. (شرط)',
        'Facing the direction of the Kaaba in prayer. (A precondition)'),
    FardItem('Vakit', 'الوقت', 'The prescribed time',
        'Her namazı kendi vakti içinde kılmaktır. (Şart)',
        'أداء كل صلاة في وقتها. (شرط)',
        'Praying each prayer within its time. (A precondition)'),
    FardItem('Niyet', 'النية', 'Intention',
        'Hangi namazın kılınacağını kalben belirlemektir. (Şart)',
        'عقد القلب على الصلاة المعينة. (شرط)',
        'To determine in the heart which prayer is being performed. (A precondition)'),
    FardItem('İftitah tekbiri', 'تكبيرة الإحرام', 'Opening takbir',
        'Namaza \'Allâhü Ekber\' diyerek başlamaktır. (İçindeki rükünlerdendir.)',
        'الدخول في الصلاة بقول «الله أكبر». (ركن)',
        'To begin the prayer saying \'Allahu Akbar.\' (An integral part)'),
    FardItem('Kıyam', 'القيام', 'Standing',
        'Gücü yetenin namazda ayakta durmasıdır. (Rükün)',
        'الوقوف في الصلاة للقادر. (ركن)',
        'Standing during prayer for those able. (An integral part)'),
    FardItem('Kıraat', 'القراءة', 'Recitation',
        'Namazda Kur\'an\'dan bir miktar okumaktır. (Rükün)',
        'قراءة ما تيسر من القرآن في الصلاة. (ركن)',
        'Reciting a portion of the Quran in prayer. (An integral part)'),
    FardItem('Rükû', 'الركوع', 'Bowing',
        'Eller dizlere erecek şekilde eğilmektir. (Rükün)',
        'الانحناء حتى تبلغ اليدان الركبتين. (ركن)',
        'Bowing until the hands reach the knees. (An integral part)'),
    FardItem('Secde', 'السجود', 'Prostration',
        'Alın, burun, eller, dizler ve ayak parmakları yere değecek şekilde iki kez secde etmektir. (Rükün)',
        'وضع الجبهة والأنف واليدين والركبتين وأطراف القدمين على الأرض مرتين. (ركن)',
        'Prostrating twice with forehead, nose, hands, knees and toes on the ground. (An integral part)'),
    FardItem('Ka\'de-i ahîre', 'القعدة الأخيرة', 'Final sitting',
        'Namazın sonunda Ettehiyyâtü okuyacak kadar oturmaktır. (Rükün)',
        'الجلوس آخر الصلاة بمقدار التشهد. (ركن)',
        'Sitting at the end of prayer long enough to recite the tashahhud. (An integral part)'),
  ]),
  FardGroup('Abdestin Farzları (4)', 'فرائض الوضوء (٤)', 'Obligations of Wudu (4)', [
    FardItem('Yüzü yıkamak', 'غسل الوجه', 'Washing the face',
        'Alın ile çene arası ve iki kulak yumuşağı arasını bir kez yıkamaktır.',
        'غسل الوجه من منابت الشعر إلى الذقن وما بين الأذنين.',
        'Washing the face from the hairline to the chin and between the ears.'),
    FardItem('Kolları yıkamak', 'غسل اليدين إلى المرفقين', 'Washing the arms',
        'İki kolu dirseklerle birlikte yıkamaktır.',
        'غسل اليدين مع المرفقين.',
        'Washing both arms including the elbows.'),
    FardItem('Başı meshetmek', 'مسح الرأس', 'Wiping the head',
        'Islak elle başın dörtte birini meshetmektir.',
        'مسح ربع الرأس بيد مبتلة.',
        'Wiping a quarter of the head with a wet hand.'),
    FardItem('Ayakları yıkamak', 'غسل الرجلين إلى الكعبين', 'Washing the feet',
        'İki ayağı topuklarla birlikte yıkamaktır.',
        'غسل الرجلين مع الكعبين.',
        'Washing both feet including the ankles.'),
  ]),
  FardGroup('Guslün Farzları (3)', 'فرائض الغسل (٣)', 'Obligations of Ghusl (3)', [
    FardItem('Ağza su vermek', 'المضمضة', 'Rinsing the mouth',
        'Ağzın içini su ile iyice çalkalamaktır (mazmaza).',
        'إيصال الماء إلى داخل الفم.',
        'Rinsing the inside of the mouth thoroughly with water.'),
    FardItem('Buruna su vermek', 'الاستنشاق', 'Rinsing the nose',
        'Burna su çekip temizlemektir (istinşak).',
        'إيصال الماء إلى داخل الأنف.',
        'Drawing water into the nose and cleansing it.'),
    FardItem('Bütün bedeni yıkamak', 'غسل جميع البدن', 'Washing the whole body',
        'Kuru yer kalmayacak şekilde bütün vücudu yıkamaktır.',
        'غسل جميع البدن بحيث لا يبقى موضع جاف.',
        'Washing the entire body so that no spot remains dry.'),
  ]),
  FardGroup('Teyemmümün Farzları (2)', 'فرضا التيمم (٢)', 'Obligations of Tayammum (2)', [
    FardItem('Niyet', 'النية', 'Intention',
        'Su bulunmadığında veya kullanılamadığında temiz toprakla taharete niyet etmektir.',
        'نية استباحة الصلاة عند فقد الماء أو العجز عنه.',
        'Intending purification with clean earth when water is unavailable or unusable.'),
    FardItem('İki vuruş (mesh)', 'الضربتان (المسح)', 'Two strikes (wiping)',
        'Elleri temiz toprağa iki kez vurup ilkinde yüzü, ikincisinde dirseklerle birlikte kolları meshetmektir.',
        'ضربتان على الصعيد الطاهر: يمسح بالأولى وجهه وبالثانية ذراعيه مع المرفقين.',
        'Striking clean earth twice: wiping the face after the first, and the arms with elbows after the second.'),
  ]),
];

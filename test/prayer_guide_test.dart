import 'package:flutter_test/flutter_test.dart';

import 'package:namaz_saatleri/data/prayer_guide.dart';
import 'package:namaz_saatleri/l10n/strings.dart';

void main() {
  final g = guideL10nFor(AppLang.tr);

  test('Sabah namazı: 2 sünnet + 2 farz', () {
    final sabah = prayerGuides[0];
    expect(sabah.parts.length, 2);
    expect(sabah.parts[0].rakats, 2);
    expect(sabah.parts[1].kind, PartKind.fard);
  });

  test('Farzın 3. ve 4. rekatlarında zammı sure okunmaz', () {
    final fard4 = buildRakats(g, const PrayerPart(PartKind.fard, 4));
    expect(fard4[0].$2.contains(g.stSurah), isTrue); // 1. rekat
    expect(fard4[1].$2.contains(g.stSurah), isTrue); // 2. rekat
    expect(fard4[2].$2.contains(g.stSurah), isFalse); // 3. rekat
    expect(fard4[3].$2.contains(g.stSurah), isFalse); // 4. rekat
  });

  test('Sünnetin her rekatında zammı sure okunur', () {
    final sunnah4 = buildRakats(g, const PrayerPart(PartKind.sunnah, 4));
    for (final rakat in sunnah4) {
      expect(rakat.$2.contains(g.stSurah), isTrue);
    }
  });

  test('İlk rekat Sübhâneke ile başlar, son rekat selamla biter', () {
    final fard2 = buildRakats(g, const PrayerPart(PartKind.fard, 2));
    expect(fard2.first.$2.contains(g.stSubhaneke), isTrue);
    expect(fard2.first.$2.contains(g.stIntention), isTrue);
    expect(fard2.last.$2.last, g.stSalam);
    expect(fard2.last.$2.contains(g.stSitFinal), isTrue);
  });

  test('4 rekatlı namazda 2. rekatta ilk oturuş vardır', () {
    final fard4 = buildRakats(g, const PrayerPart(PartKind.fard, 4));
    expect(fard4[1].$2.contains(g.stSitFirst), isTrue);
    expect(fard4[0].$2.contains(g.stSitFirst), isFalse);
  });

  test('Gayr-i müekkede sünnette ilk oturuşta Salli-Bârik, 3. rekatta Sübhâneke', () {
    final gm = buildRakats(
        g, const PrayerPart(PartKind.sunnah, 4, gayriMuekkede: true));
    expect(gm[1].$2.contains(g.stSitFirstGM), isTrue);
    expect(gm[2].$2.contains(g.stSubhanekeAgain), isTrue);
  });

  test('Vitirde 3. rekatta zammı sureden sonra Kunut okunur', () {
    final witr = buildRakats(g, const PrayerPart(PartKind.witr, 3));
    final steps = witr[2].$2;
    expect(steps.contains(g.stQunut), isTrue);
    expect(steps.indexOf(g.stQunut), greaterThan(steps.indexOf(g.stSurah)));
    expect(steps.indexOf(g.stQunut), lessThan(steps.indexOf(g.stRuku)));
  });

  test('Akşam farzı 3 rekattır ve 2. rekatta ilk oturuş vardır', () {
    final aksam = prayerGuides[3];
    expect(aksam.parts[0].kind, PartKind.fard);
    expect(aksam.parts[0].rakats, 3);
    final rakats = buildRakats(g, aksam.parts[0]);
    expect(rakats[1].$2.contains(g.stSitFirst), isTrue);
    expect(rakats[2].$2.contains(g.stSurah), isFalse); // 3. rekatta sure yok
  });
}

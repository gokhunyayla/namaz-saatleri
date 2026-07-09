import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../app_settings.dart';
import '../data/other_prayers.dart';
import '../data/popular_surahs.dart';
import '../data/prayer_guide.dart';
import '../data/prayer_texts.dart';
import '../l10n/strings.dart';

/// "Namaz Nasıl Kılınır" sekmesi: vakit vakit kılınış rehberi ile
/// namaz sure ve dualarının listesi.
class GuideScreen extends StatelessWidget {
  const GuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final g = guideL10nFor(AppSettings.instance.lang);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(g.guideTitle),
          bottom: TabBar(
            tabs: [
              Tab(text: g.prayersSection),
              Tab(text: g.textsSection),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _PrayersTab(g: g),
            _TextsTab(g: g),
          ],
        ),
      ),
    );
  }
}

/// Namazlar sekmesi: Vakit Namazları + Diğer Namazlar.
class _PrayersTab extends StatelessWidget {
  final GuideL10n g;

  const _PrayersTab({required this.g});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _groupHeader(context, g.groupDaily),
        ...prayerGuides.map((def) => _prayerTile(context, def)),
        const SizedBox(height: 16),
        _groupHeader(context, g.groupOther),
        ...otherPrayers.map((p) => _otherTile(context, p)),
        const SizedBox(height: 12),
        Text(
          g.guideNote,
          style: TextStyle(color: scheme.outline, fontSize: 12),
        ),
      ],
    );
  }

  Widget _groupHeader(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        text,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _prayerTile(BuildContext context, PrayerGuideDef def) {
    final scheme = Theme.of(context).colorScheme;
    final nameIdx = prayerGuides.indexOf(def);
    final summary = def.parts
        .map((p) => '${p.rakats} ${g.partLabel(p.kind)}')
        .join(' + ');
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: scheme.primaryContainer,
          child: Text(
            '${def.parts.fold<int>(0, (a, p) => a + p.rakats)}',
            style: TextStyle(
                color: scheme.onPrimaryContainer, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(g.prayerNames[nameIdx],
            style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(summary),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => PrayerGuideDetailScreen(def: def),
          ),
        ),
      ),
    );
  }

  Widget _otherTile(BuildContext context, OtherPrayer p) {
    final lang = AppSettings.instance.lang;
    final scheme = Theme.of(context).colorScheme;
    final name = switch (lang) {
      AppLang.tr => p.nameTr,
      AppLang.ar => p.nameAr,
      AppLang.en => p.nameEn,
    };
    final subtitle = switch (lang) {
      AppLang.tr => p.subtitleTr,
      AppLang.ar => p.subtitleAr,
      AppLang.en => p.subtitleEn,
    };
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: scheme.primaryContainer,
          child: Text(
            p.countLabel,
            style: TextStyle(
                color: scheme.onPrimaryContainer,
                fontWeight: FontWeight.bold,
                fontSize: p.countLabel.length > 2 ? 13 : 16),
          ),
        ),
        title: Text(name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => OtherPrayerDetailScreen(prayer: p)),
        ),
      ),
    );
  }
}

/// Sureler ve Dualar sekmesi: açılır-kapanır üç grup.
class _TextsTab extends StatelessWidget {
  final GuideL10n g;

  const _TextsTab({required this.g});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        _group(context, g.duasGroup, Icons.volunteer_activism, prayerDuas),
        _group(context, g.surasGroup, Icons.auto_stories_outlined,
            prayerSurahs),
        _group(context, g.popularGroup, Icons.star_outline, popularSurahs,
            initiallyExpanded: false),
      ],
    );
  }

  Widget _group(BuildContext context, String title, IconData icon,
      List<PrayerText> items,
      {bool initiallyExpanded = false}) {
    final scheme = Theme.of(context).colorScheme;
    final lang = AppSettings.instance.lang;
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      margin: const EdgeInsets.only(bottom: 10),
      child: ExpansionTile(
        shape: const Border(),
        leading: Icon(icon, color: scheme.primary),
        title: Text(title,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        initiallyExpanded: initiallyExpanded,
        children: [
          for (final t in items)
            ListTile(
              dense: true,
              contentPadding: const EdgeInsets.symmetric(horizontal: 24),
              title: Text(switch (lang) {
                AppLang.tr => t.nameTr,
                AppLang.ar => t.nameAr,
                AppLang.en => t.nameEn,
              }),
              trailing: const Icon(Icons.chevron_right, size: 20),
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (_) => PrayerTextDetailScreen(text: t)),
              ),
            ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

/// Cuma, Bayram, Cenaze gibi diğer namazların açıklamalı anlatımı.
class OtherPrayerDetailScreen extends StatelessWidget {
  final OtherPrayer prayer;

  const OtherPrayerDetailScreen({super.key, required this.prayer});

  @override
  Widget build(BuildContext context) {
    final g = guideL10nFor(AppSettings.instance.lang);
    final lang = AppSettings.instance.lang;
    final scheme = Theme.of(context).colorScheme;

    final name = switch (lang) {
      AppLang.tr => prayer.nameTr,
      AppLang.ar => prayer.nameAr,
      AppLang.en => prayer.nameEn,
    };
    final subtitle = switch (lang) {
      AppLang.tr => prayer.subtitleTr,
      AppLang.ar => prayer.subtitleAr,
      AppLang.en => prayer.subtitleEn,
    };
    final intro = switch (lang) {
      AppLang.tr => prayer.introTr,
      AppLang.ar => prayer.introAr,
      AppLang.en => prayer.introEn,
    };

    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: scheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                FaIcon(FontAwesomeIcons.personPraying,
                    size: 18, color: scheme.onPrimaryContainer),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    subtitle,
                    style: TextStyle(
                      color: scheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(intro, style: const TextStyle(fontSize: 15.5, height: 1.6)),
          const SizedBox(height: 16),
          for (final section in prayer.sections)
            _SectionView(section: section, g: g, lang: lang),
          const SizedBox(height: 8),
          Text(
            g.guideNote,
            style: TextStyle(color: scheme.outline, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

/// Diğer namazlardaki tek bir bölüm: başlık + (rekat motoru | özel adımlar)
/// + bilgi notu.
class _SectionView extends StatelessWidget {
  final OtherSection section;
  final GuideL10n g;
  final AppLang lang;

  const _SectionView(
      {required this.section, required this.g, required this.lang});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final label = switch (lang) {
      AppLang.tr => section.labelTr,
      AppLang.ar => section.labelAr,
      AppLang.en => section.labelEn,
    };
    final steps = switch (lang) {
      AppLang.tr => section.stepsTr,
      AppLang.ar => section.stepsAr,
      AppLang.en => section.stepsEn,
    };
    final info = switch (lang) {
      AppLang.tr => section.infoTr,
      AppLang.ar => section.infoAr,
      AppLang.en => section.infoEn,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: scheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              FaIcon(FontAwesomeIcons.personPraying,
                  size: 18, color: scheme.onPrimaryContainer),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    color: scheme.onPrimaryContainer,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        if (section.part != null)
          ...buildRakats(g, section.part!).map(
            (rakat) => Card(
              elevation: 0,
              color: scheme.surfaceContainerLow,
              margin: const EdgeInsets.only(bottom: 8),
              child: ExpansionTile(
                shape: const Border(),
                title: Text(rakat.$1,
                    style: const TextStyle(fontWeight: FontWeight.w600)),
                children: [
                  for (final (i, step) in rakat.$2.indexed)
                    ListTile(
                      dense: true,
                      leading: CircleAvatar(
                        radius: 12,
                        backgroundColor: scheme.primary,
                        child: Text(
                          '${i + 1}',
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white),
                        ),
                      ),
                      title: Text(step),
                    ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        if (steps != null)
          for (final (i, step) in steps.indexed)
            Card(
              elevation: 0,
              color: scheme.surfaceContainerLow,
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 14,
                  backgroundColor: scheme.primary,
                  child: Text(
                    '${i + 1}',
                    style: const TextStyle(fontSize: 13, color: Colors.white),
                  ),
                ),
                title: Text(step, style: const TextStyle(height: 1.4)),
              ),
            ),
        if (info != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 8, left: 4, right: 4),
            child: Text(
              info,
              style: TextStyle(
                color: scheme.onSurfaceVariant,
                fontSize: 13.5,
                fontStyle: FontStyle.italic,
                height: 1.5,
              ),
            ),
          ),
        const SizedBox(height: 12),
      ],
    );
  }
}

/// Bir namazın bölüm bölüm, rekat rekat kılınışı.
class PrayerGuideDetailScreen extends StatelessWidget {
  final PrayerGuideDef def;

  const PrayerGuideDetailScreen({super.key, required this.def});

  @override
  Widget build(BuildContext context) {
    final g = guideL10nFor(AppSettings.instance.lang);
    final scheme = Theme.of(context).colorScheme;
    final nameIdx = prayerGuides.indexOf(def);

    return Scaffold(
      appBar: AppBar(title: Text('${g.prayerNames[nameIdx]} — ${g.guideTitle}')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            g.guideNote,
            style: TextStyle(color: scheme.outline, fontSize: 12),
          ),
          const SizedBox(height: 12),
          for (final part in def.parts) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                color: scheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  FaIcon(FontAwesomeIcons.personPraying,
                      size: 18, color: scheme.onPrimaryContainer),
                  const SizedBox(width: 8),
                  Text(
                    '${g.partLabel(part.kind)} • ${g.rakatCount(part.rakats)}',
                    style: TextStyle(
                      color: scheme.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            ...buildRakats(g, part).map(
              (rakat) => Card(
                elevation: 0,
                color: scheme.surfaceContainerLow,
                margin: const EdgeInsets.only(bottom: 8),
                child: ExpansionTile(
                  shape: const Border(),
                  title: Text(rakat.$1,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  children: [
                    for (final (i, step) in rakat.$2.indexed)
                      ListTile(
                        dense: true,
                        leading: CircleAvatar(
                          radius: 12,
                          backgroundColor: scheme.primary,
                          child: Text(
                            '${i + 1}',
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white),
                          ),
                        ),
                        title: Text(step),
                      ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}

/// Bir sure veya duanın Arapçası, okunuşu ve meali.
class PrayerTextDetailScreen extends StatelessWidget {
  final PrayerText text;

  const PrayerTextDetailScreen({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final g = guideL10nFor(AppSettings.instance.lang);
    final lang = AppSettings.instance.lang;
    final scheme = Theme.of(context).colorScheme;

    final name = switch (lang) {
      AppLang.tr => text.nameTr,
      AppLang.ar => text.nameAr,
      AppLang.en => text.nameEn,
    };
    final translit = switch (lang) {
      AppLang.tr => text.translitTr,
      AppLang.en => text.translitEn,
      AppLang.ar => null, // Arapça arayüzde okunuşa gerek yok.
    };
    final meaning = switch (lang) {
      AppLang.tr => text.mealTr,
      AppLang.en => text.mealEn,
      AppLang.ar => null,
    };

    // Uzun sureler: Mushaf sayfa düzeninde, sayfa çevirerek okunur.
    if (text.pages != null) {
      return _PagedSurahView(text: text, g: g, lang: lang);
    }

    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Card(
            elevation: 0,
            color: scheme.surfaceContainerLow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(color: scheme.outlineVariant),
            ),
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Directionality(
                textDirection: ui.TextDirection.rtl,
                child: Text(
                  text.arabic,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Amiri',
                    fontSize: 26,
                    height: 2.0,
                  ),
                ),
              ),
            ),
          ),
          if (translit != null) ...[
            const SizedBox(height: 16),
            _labelDivider(context, g.translitLabel),
            const SizedBox(height: 8),
            Text(
              translit,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: 16, height: 1.6, fontStyle: FontStyle.italic),
            ),
          ],
          if (meaning != null) ...[
            const SizedBox(height: 16),
            _labelDivider(context, g.meaningLabel),
            const SizedBox(height: 8),
            Text(
              meaning,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, height: 1.6),
            ),
          ],
        ],
      ),
    );
  }

  Widget _labelDivider(BuildContext context, String label) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(child: Divider(color: scheme.outlineVariant)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            label,
            style: TextStyle(
              color: scheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
        Expanded(child: Divider(color: scheme.outlineVariant)),
      ],
    );
  }
}

/// Mushaf düzeninde sayfa sayfa sure görünümü (Yâsîn, Mülk...).
class _PagedSurahView extends StatefulWidget {
  final PrayerText text;
  final GuideL10n g;
  final AppLang lang;

  const _PagedSurahView(
      {required this.text, required this.g, required this.lang});

  @override
  State<_PagedSurahView> createState() => _PagedSurahViewState();
}

class _PagedSurahViewState extends State<_PagedSurahView> {
  final _controller = PageController();
  int _index = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final pages = widget.text.pages!;
    final name = switch (widget.lang) {
      AppLang.tr => widget.text.nameTr,
      AppLang.ar => widget.text.nameAr,
      AppLang.en => widget.text.nameEn,
    };

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 16),
              child: Text(
                '${widget.g.pageLabel} ${pages[_index].page} • ${_index + 1}/${pages.length}',
                style: TextStyle(
                  color: scheme.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Directionality(
              // Mushaf gibi sağdan sola sayfa çevrilir.
              textDirection: ui.TextDirection.rtl,
              child: PageView.builder(
                controller: _controller,
                itemCount: pages.length,
                onPageChanged: (i) => setState(() => _index = i),
                itemBuilder: (context, i) {
                  final page = pages[i];
                  final meal = switch (widget.lang) {
                    AppLang.tr => page.mealTr,
                    AppLang.en => page.mealEn,
                    AppLang.ar => null,
                  };
                  return Directionality(
                    textDirection: Directionality.of(context),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Card(
                            elevation: 0,
                            color: scheme.surfaceContainerLow,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(color: scheme.outlineVariant),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Directionality(
                                textDirection: ui.TextDirection.rtl,
                                child: Text(
                                  page.arabic,
                                  textAlign: TextAlign.justify,
                                  style: const TextStyle(
                                    fontFamily: 'Amiri',
                                    fontSize: 24,
                                    height: 2.1,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (meal != null) ...[
                            const SizedBox(height: 14),
                            Directionality(
                              textDirection: ui.TextDirection.ltr,
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                          child: Divider(
                                              color: scheme.outlineVariant)),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 12),
                                        child: Text(
                                          widget.g.meaningLabel,
                                          style: TextStyle(
                                            color: scheme.primary,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                          child: Divider(
                                              color: scheme.outlineVariant)),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    meal,
                                    style: const TextStyle(
                                        fontSize: 15, height: 1.6),
                                  ),
                                ],
                              ),
                            ),
                          ],
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

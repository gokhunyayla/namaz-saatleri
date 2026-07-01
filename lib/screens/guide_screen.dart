import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../app_settings.dart';
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
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text(g.guideTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionTitle(context, g.prayersSection, Icons.self_improvement),
          const SizedBox(height: 4),
          ...prayerGuides.map((def) => _prayerTile(context, g, def)),
          const SizedBox(height: 20),
          _sectionTitle(context, g.textsSection, Icons.menu_book_outlined),
          const SizedBox(height: 4),
          _groupHeader(context, g.duasGroup),
          ...prayerDuas.map((t) => _textTile(context, g, t)),
          const SizedBox(height: 8),
          _groupHeader(context, g.surasGroup),
          ...prayerSurahs.map((t) => _textTile(context, g, t)),
          const SizedBox(height: 12),
          Text(
            g.guideNote,
            style: TextStyle(color: scheme.outline, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String text, IconData icon) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(icon, size: 20, color: scheme.primary),
        const SizedBox(width: 8),
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _groupHeader(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Widget _prayerTile(BuildContext context, GuideL10n g, PrayerGuideDef def) {
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

  Widget _textTile(BuildContext context, GuideL10n g, PrayerText t) {
    final lang = AppSettings.instance.lang;
    final name = switch (lang) {
      AppLang.tr => t.nameTr,
      AppLang.ar => t.nameAr,
      AppLang.en => t.nameEn,
    };
    return ListTile(
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
      leading: Icon(
        t.isSurah ? Icons.auto_stories_outlined : Icons.volunteer_activism,
        size: 20,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(name),
      trailing: const Icon(Icons.chevron_right, size: 20),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => PrayerTextDetailScreen(text: t)),
      ),
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
                  Icon(Icons.self_improvement,
                      size: 20, color: scheme.onPrimaryContainer),
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

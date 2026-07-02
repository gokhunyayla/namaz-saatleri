import 'dart:async';

import 'package:flutter/material.dart';

import '../app_settings.dart';
import '../data/thirty_two_fard.dart';
import '../data/verses.dart';
import '../l10n/strings.dart';
import '../services/location_service.dart';
import '../services/prayer_service.dart';
import '../widgets/verse_card.dart';

/// Vaktin Ayeti: içinde bulunulan vakte göre Kur'an-ı Kerim'den,
/// o vakitle ilgili bir ayet gösterir. Ayetler uygulamaya gömülü,
/// elle seçilmiş ve doğrulanmış sabit bir listeden gelir (bkz. data/verses.dart).
class VerseScreen extends StatefulWidget {
  final ValueNotifier<LocationInfo?> location;

  const VerseScreen({super.key, required this.location});

  @override
  State<VerseScreen> createState() => _VerseScreenState();
}

class _VerseScreenState extends State<VerseScreen> {
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    // Vakit değiştiğinde ayetin de değişmesi için periyodik kontrol.
    _ticker = Timer.periodic(const Duration(seconds: 30), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final s = AppSettings.instance.strings;
    return Scaffold(
      appBar: AppBar(title: Text(s.verseTitle)),
      body: ValueListenableBuilder<LocationInfo?>(
        valueListenable: widget.location,
        builder: (context, info, _) {
          if (info == null) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Text(s.needLocationFirst, textAlign: TextAlign.center),
              ),
            );
          }
          final now = DateTime.now();
          final index = PrayerService.currentPeriodIndex(
              info.latitude, info.longitude, now);
          // Aynı gün içinde sabit kalsın, her gün sıradaki ayete geçsin.
          final list = versesByPeriod[index];
          final dayOfYear = now.difference(DateTime(now.year)).inDays;
          return _verseView(s, index, list[dayOfYear % list.length]);
        },
      ),
    );
  }

  Widget _verseView(Strings s, int periodIndex, Verse verse) {
    final scheme = Theme.of(context).colorScheme;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Vakit rozeti
        Center(
          child: Chip(
            avatar: Icon(Icons.access_time, size: 18, color: scheme.primary),
            label: Text(
              s.verseOfPeriod(s.prayerNames[periodIndex]),
              style: TextStyle(
                color: scheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: scheme.primaryContainer.withValues(alpha: 0.5),
            side: BorderSide.none,
          ),
        ),
        const SizedBox(height: 16),
        VerseCard(verse: verse),
        const SizedBox(height: 24),
        _fardSection(context),
      ],
    );
  }

  /// 32 Farz: gruplar hâlinde liste; her öğe dokununca modalda açıklanır.
  Widget _fardSection(BuildContext context) {
    final lang = AppSettings.instance.lang;
    final scheme = Theme.of(context).colorScheme;
    final title = switch (lang) {
      AppLang.tr => fardSectionTitleTr,
      AppLang.ar => fardSectionTitleAr,
      AppLang.en => fardSectionTitleEn,
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.checklist, size: 20, color: scheme.primary),
            const SizedBox(width: 8),
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 4),
        for (final group in thirtyTwoFard) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text(
              switch (lang) {
                AppLang.tr => group.titleTr,
                AppLang.ar => group.titleAr,
                AppLang.en => group.titleEn,
              },
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: scheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          for (final item in group.items)
            ListTile(
              dense: true,
              visualDensity: const VisualDensity(vertical: -3),
              contentPadding: const EdgeInsets.symmetric(horizontal: 8),
              leading: Icon(Icons.circle, size: 8, color: scheme.primary),
              title: Text(switch (lang) {
                AppLang.tr => item.nameTr,
                AppLang.ar => item.nameAr,
                AppLang.en => item.nameEn,
              }),
              trailing: const Icon(Icons.chevron_right, size: 18),
              onTap: () => _showFardDetail(context, lang, group, item),
            ),
        ],
      ],
    );
  }

  void _showFardDetail(
      BuildContext context, AppLang lang, FardGroup group, FardItem item) {
    final scheme = Theme.of(context).colorScheme;
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                switch (lang) {
                  AppLang.tr => item.nameTr,
                  AppLang.ar => item.nameAr,
                  AppLang.en => item.nameEn,
                },
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),
              Text(
                switch (lang) {
                  AppLang.tr => group.titleTr,
                  AppLang.ar => group.titleAr,
                  AppLang.en => group.titleEn,
                },
                style: TextStyle(color: scheme.primary, fontSize: 13),
              ),
              const SizedBox(height: 12),
              Text(
                switch (lang) {
                  AppLang.tr => item.detailTr,
                  AppLang.ar => item.detailAr,
                  AppLang.en => item.detailEn,
                },
                style: const TextStyle(fontSize: 15.5, height: 1.6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../app_settings.dart';
import '../data/verses.dart';
import '../l10n/strings.dart';
import '../services/location_service.dart';
import '../services/prayer_service.dart';

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
          final index = PrayerService.currentPeriodIndex(
              info.latitude, info.longitude, DateTime.now());
          return _verseView(s, index, versesByPeriod[index]);
        },
      ),
    );
  }

  Widget _verseView(Strings s, int periodIndex, Verse verse) {
    final scheme = Theme.of(context).colorScheme;
    final lang = AppSettings.instance.lang;

    final translation = switch (lang) {
      AppLang.tr => verse.tr,
      AppLang.en => verse.en,
      AppLang.ar => null, // Arapçada ayetin kendisi zaten gösteriliyor.
    };
    final reference = switch (lang) {
      AppLang.tr => verse.refTr,
      AppLang.en => verse.refEn,
      AppLang.ar => verse.refAr,
    };

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
        // Ayet kartı
        Card(
          elevation: 0,
          color: scheme.surfaceContainerLow,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: scheme.outlineVariant),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                // Arapça metin her zaman gösterilir.
                Directionality(
                  textDirection: ui.TextDirection.rtl,
                  child: Text(
                    verse.arabic,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Amiri',
                      fontSize: 26,
                      height: 2.0,
                    ),
                  ),
                ),
                if (translation != null) ...[
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(child: Divider(color: scheme.outlineVariant)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          s.translationLabel,
                          style: TextStyle(
                            color: scheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Expanded(child: Divider(color: scheme.outlineVariant)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    translation,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16, height: 1.6),
                  ),
                ],
                const SizedBox(height: 20),
                Text(
                  reference,
                  style: TextStyle(
                    color: scheme.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

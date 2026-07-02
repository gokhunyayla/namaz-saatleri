import 'dart:ui' as ui;

import 'package:flutter/material.dart';

import '../app_settings.dart';
import '../data/verses.dart';
import '../l10n/strings.dart';

/// Ayet kartı: Arapça metin (Amiri hattı), seçili dilde meal ve kaynak.
/// Vaktin Ayeti sayfası ile vakit satırına dokununca açılan modal
/// aynı kartı kullanır.
class VerseCard extends StatelessWidget {
  final Verse verse;

  const VerseCard({super.key, required this.verse});

  @override
  Widget build(BuildContext context) {
    final s = AppSettings.instance.strings;
    final lang = AppSettings.instance.lang;
    final scheme = Theme.of(context).colorScheme;

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

    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      margin: EdgeInsets.zero,
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
    );
  }
}

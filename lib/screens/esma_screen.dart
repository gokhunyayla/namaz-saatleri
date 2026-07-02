import 'package:flutter/material.dart';

import '../app_settings.dart';
import '../data/asma_ul_husna.dart';
import '../data/period_info.dart';
import '../l10n/strings.dart';

/// Esmâü'l-Hüsnâ: Allah'ın 99 ismi. Arapça (Amiri hattı) + okunuş;
/// isme dokununca anlamı modalda gösterilir.
class EsmaScreen extends StatelessWidget {
  const EsmaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = AppSettings.instance.lang;
    final title = periodInfoFor(lang).esmaTitle;

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 190,
          mainAxisExtent: 104,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: asmaUlHusna.length,
        itemBuilder: (context, i) => _nameCard(context, lang, i),
      ),
    );
  }

  Widget _nameCard(BuildContext context, AppLang lang, int index) {
    final scheme = Theme.of(context).colorScheme;
    final name = asmaUlHusna[index];
    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: scheme.outlineVariant),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => _showMeaning(context, lang, index),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                name.arabic,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Amiri',
                  fontSize: 24,
                  height: 1.4,
                ),
              ),
              if (lang != AppLang.ar) ...[
                const SizedBox(height: 2),
                Text(
                  lang == AppLang.tr ? name.translitTr : name.translitEn,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: scheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showMeaning(BuildContext context, AppLang lang, int index) {
    final scheme = Theme.of(context).colorScheme;
    final name = asmaUlHusna[index];
    final meaning = switch (lang) {
      AppLang.tr => name.meaningTr,
      AppLang.en => name.meaningEn,
      AppLang.ar => name.meaningAr,
    };

    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name.arabic,
                textAlign: TextAlign.center,
                style: const TextStyle(fontFamily: 'Amiri', fontSize: 40),
              ),
              if (lang != AppLang.ar) ...[
                const SizedBox(height: 4),
                Text(
                  lang == AppLang.tr ? name.translitTr : name.translitEn,
                  style: TextStyle(
                    fontSize: 16,
                    color: scheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              const SizedBox(height: 12),
              Text(
                meaning,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
              const SizedBox(height: 8),
              Text(
                '${index + 1} / 99',
                style: TextStyle(fontSize: 12, color: scheme.outline),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

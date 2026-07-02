import 'package:flutter/material.dart';

import '../app_settings.dart';
import '../data/thirty_two_fard.dart';
import '../l10n/strings.dart';

/// 32 Farz sayfası: Namazın 12 farzı (rükünler + şartlar) en üstte,
/// ardından çoktan aza İman 6, İslam 5, Abdest 4, Gusül 3, Teyemmüm 2.
/// Her maddeye dokununca açıklama modalda gösterilir.
class FardScreen extends StatelessWidget {
  const FardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = AppSettings.instance.lang;
    final scheme = Theme.of(context).colorScheme;
    final title = switch (lang) {
      AppLang.tr => fardSectionTitleTr,
      AppLang.ar => fardSectionTitleAr,
      AppLang.en => fardSectionTitleEn,
    };

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
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
      ),
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

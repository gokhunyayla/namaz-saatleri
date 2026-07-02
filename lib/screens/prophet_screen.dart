import 'package:flutter/material.dart';

import '../app_settings.dart';
import '../data/prophet_info.dart';
import '../l10n/strings.dart';

/// Hz. Muhammed'in (s.a.v.) hayatı: kronolojik başlıklar; dokununca
/// detay modalda gösterilir. Başlıktaki محمد hat yazısından açılır.
class ProphetScreen extends StatelessWidget {
  const ProphetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = AppSettings.instance.lang;
    final title = switch (lang) {
      AppLang.tr => prophetTitleTr,
      AppLang.ar => prophetTitleAr,
      AppLang.en => prophetTitleEn,
    };

    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: prophetTopics.length,
        itemBuilder: (context, i) => _topicTile(context, lang, i),
      ),
    );
  }

  Widget _topicTile(BuildContext context, AppLang lang, int index) {
    final scheme = Theme.of(context).colorScheme;
    final t = prophetTopics[index];
    final title = switch (lang) {
      AppLang.tr => t.titleTr,
      AppLang.ar => t.titleAr,
      AppLang.en => t.titleEn,
    };
    final subtitle = switch (lang) {
      AppLang.tr => t.subtitleTr,
      AppLang.ar => t.subtitleAr,
      AppLang.en => t.subtitleEn,
    };

    return Card(
      elevation: 0,
      color: scheme.surfaceContainerLow,
      margin: const EdgeInsets.only(bottom: 6),
      child: ListTile(
        leading: CircleAvatar(
          radius: 16,
          backgroundColor: scheme.primaryContainer,
          child: Text(
            '${index + 1}',
            style: TextStyle(
              fontSize: 13,
              color: scheme.onPrimaryContainer,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_right, size: 20),
        onTap: () => _showDetail(context, lang, index),
      ),
    );
  }

  void _showDetail(BuildContext context, AppLang lang, int index) {
    final scheme = Theme.of(context).colorScheme;
    final t = prophetTopics[index];
    final title = switch (lang) {
      AppLang.tr => t.titleTr,
      AppLang.ar => t.titleAr,
      AppLang.en => t.titleEn,
    };
    final subtitle = switch (lang) {
      AppLang.tr => t.subtitleTr,
      AppLang.ar => t.subtitleAr,
      AppLang.en => t.subtitleEn,
    };
    final detail = switch (lang) {
      AppLang.tr => t.detailTr,
      AppLang.ar => t.detailAr,
      AppLang.en => t.detailEn,
    };

    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) => SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: TextStyle(color: scheme.primary, fontSize: 13),
              ),
              const SizedBox(height: 12),
              Text(detail,
                  style: const TextStyle(fontSize: 15.5, height: 1.6)),
            ],
          ),
        ),
      ),
    );
  }
}

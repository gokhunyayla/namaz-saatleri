import 'dart:async';

import 'package:flutter/material.dart';

import '../app_settings.dart';
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
      ],
    );
  }
}

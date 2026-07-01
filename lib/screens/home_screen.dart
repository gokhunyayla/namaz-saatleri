import 'dart:async';
import 'dart:ui' as ui;

import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../app_settings.dart';
import '../services/location_service.dart';
import '../services/notification_service.dart';
import '../services/prayer_service.dart';

class HomeScreen extends StatefulWidget {
  final ValueNotifier<LocationInfo?> location;

  const HomeScreen({super.key, required this.location});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PrayerTimes? _times;
  LocationFailure? _failure;
  bool _genericError = false;
  bool _loading = true;
  Timer? _ticker;
  DateTime _now = DateTime.now();

  /// Görüntülenen günün bugüne göre farkı: 0 = bugün, -1 = dün, 1 = yarın...
  int _dayOffset = 0;

  DateTime get _displayedDate => _now.add(Duration(days: _dayOffset));

  String get _localeCode => AppSettings.instance.locale.languageCode;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      final now = DateTime.now();
      // Gün değiştiyse vakitleri yeniden hesapla.
      if (_now.day != now.day && widget.location.value != null) {
        _now = now;
        _recompute(widget.location.value!);
      }
      setState(() => _now = now);
    });
    _loadLocation();
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  Future<void> _loadLocation() async {
    // Önce önbellekteki konumla hemen göster, sonra güncel konumu al.
    final cached = await LocationService.loadCached();
    if (cached != null && mounted) {
      widget.location.value = cached;
      _recompute(cached);
      setState(() => _loading = false);
    }
    await _refreshLocation();
  }

  Future<void> _refreshLocation() async {
    setState(() {
      _failure = null;
      _genericError = false;
      if (_times == null) _loading = true;
    });
    try {
      final info = await LocationService.getCurrent();
      if (!mounted) return;
      widget.location.value = info;
      _recompute(info);
      await NotificationService.instance.rescheduleFromPrefs();
    } on LocationException catch (e) {
      if (!mounted) return;
      if (_times == null) _failure = e.failure;
    } catch (_) {
      if (!mounted) return;
      if (_times == null) _genericError = true;
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _recompute(LocationInfo info) {
    _times =
        PrayerService.timesFor(info.latitude, info.longitude, _displayedDate);
    setState(() {});
  }

  void _changeDay(int delta) {
    _dayOffset += delta;
    final info = widget.location.value;
    if (info != null) _recompute(info);
  }

  void _setDate(DateTime date) {
    final today = DateTime(_now.year, _now.month, _now.day);
    final target = DateTime(date.year, date.month, date.day);
    _dayOffset = target.difference(today).inDays;
    final info = widget.location.value;
    if (info != null) _recompute(info);
  }

  /// Takvim açar; seçilen güne gider. "Bugüne Dön" butonu bugünü seçer.
  Future<void> _pickDate() async {
    final s = AppSettings.instance.strings;
    final now = DateTime.now();
    final picked = await showDialog<DateTime>(
      context: context,
      builder: (context) => Dialog(
        child: SizedBox(
          width: 340,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CalendarDatePicker(
                initialDate: _displayedDate,
                firstDate: DateTime(now.year - 10),
                lastDate: DateTime(now.year + 10, 12, 31),
                onDateChanged: (d) => Navigator.of(context).pop(d),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      icon: const Icon(Icons.today),
                      label: Text(s.backToToday),
                      onPressed: () => Navigator.of(context).pop(now),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(s.cancel),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
    if (picked != null) _setDate(picked);
  }

  // ---- Vakit yardımcıları ----

  static List<DateTime> _timesListOf(PrayerTimes t) =>
      [t.fajr, t.sunrise, t.dhuhr, t.asr, t.maghrib, t.isha];

  PrayerTimes _timesForOffset(int dayDelta) {
    final info = widget.location.value!;
    return PrayerService.timesFor(
        info.latitude, info.longitude, _now.add(Duration(days: dayDelta)));
  }

  /// Sıradaki vakit (Güneş hariç) — her zaman bugüne göre.
  /// Bugün bittiyse yarının imsakı. (vakit indeksi, zaman) döner.
  (int, DateTime) get _next {
    final times = _timesListOf(_timesForOffset(0));
    for (var i = 0; i < times.length; i++) {
      if (i == 1) continue; // Güneş bir namaz vakti değil.
      if (times[i].isAfter(_now)) return (i, times[i]);
    }
    return (0, _timesForOffset(1).fajr);
  }

  /// İçinde bulunduğumuz vakit dilimi (bugün görüntüleniyorsa):
  /// satır indeksi ve 0..1 arası ilerleme.
  ({int index, double progress})? get _currentPeriod {
    if (_dayOffset != 0) return null;
    final times = _timesListOf(_timesForOffset(0));

    var index = -1;
    for (var i = 0; i < times.length; i++) {
      if (!times[i].isAfter(_now)) index = i;
    }

    DateTime start, end;
    if (index == -1) {
      // Gece yarısı ile imsak arası: dünün yatsısı hâlâ sürüyor.
      index = times.length - 1;
      start = _timesForOffset(-1).isha;
      end = times.first;
    } else if (index == times.length - 1) {
      // Yatsı: yarının imsakına kadar.
      start = times[index];
      end = _timesForOffset(1).fajr;
    } else {
      start = times[index];
      end = times[index + 1];
    }

    final total = end.difference(start).inSeconds;
    if (total <= 0) return (index: index, progress: 1.0);
    final progress =
        (_now.difference(start).inSeconds / total).clamp(0.0, 1.0);
    return (index: index, progress: progress);
  }

  String _countdown(DateTime to) {
    final d = to.difference(_now);
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  static const _icons = [
    Icons.nights_stay_outlined, // İmsak
    Icons.wb_twilight, // Güneş
    Icons.wb_sunny_outlined, // Öğle
    Icons.sunny_snowing, // İkindi
    Icons.wb_shade, // Akşam
    Icons.dark_mode_outlined, // Yatsı
  ];

  // ---- UI ----

  @override
  Widget build(BuildContext context) {
    final s = AppSettings.instance.strings;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // Hat yazıları dil yönünden bağımsız sabit dursun:
        // sağda "Allah", solda "Muhammed".
        title: Directionality(
          textDirection: ui.TextDirection.ltr,
          child: Row(
            children: [
              _calligraphy('محمد'),
              Expanded(
                child: Text(s.appTitle, textAlign: TextAlign.center),
              ),
              _calligraphy('الله'),
            ],
          ),
        ),
      ),
      body: _buildBody(),
    );
  }

  /// Amiri (Nesih hattı) fontuyla hat yazısı:
  /// koyu temada beyaz, açık temada siyah.
  Widget _calligraphy(String text) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Amiri',
          fontSize: 24,
          height: 1.0,
          fontWeight: FontWeight.w700,
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _buildBody() {
    final s = AppSettings.instance.strings;
    if (_loading && _times == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if ((_failure != null || _genericError) && _times == null) {
      final message = switch (_failure) {
        LocationFailure.serviceDisabled => s.locationServiceOff,
        LocationFailure.permissionDenied => s.locationPermissionDenied,
        null => s.locationError,
      };
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.location_off, size: 48, color: Colors.grey),
              const SizedBox(height: 16),
              Text(message, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _refreshLocation,
                icon: const Icon(Icons.refresh),
                label: Text(s.retry),
              ),
            ],
          ),
        ),
      );
    }

    final info = widget.location.value!;
    final next = _next;
    final current = _currentPeriod;
    final times = _timesListOf(_times!);

    return RefreshIndicator(
      onRefresh: _refreshLocation,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _headerCard(info, next),
          const SizedBox(height: 8),
          _dayNavigator(),
          const SizedBox(height: 4),
          ...List.generate(
            times.length,
            (i) => _timeRow(i, times[i], next, current),
          ),
        ],
      ),
    );
  }

  Widget _headerCard(LocationInfo info, (int, DateTime) next) {
    final s = AppSettings.instance.strings;
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [scheme.primary, scheme.tertiary],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.place, color: Colors.white70, size: 18),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  info.city.isNotEmpty
                      ? info.city
                      : '${info.latitude.toStringAsFixed(2)}, ${info.longitude.toStringAsFixed(2)}',
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(s.timeUntil(s.prayerNames[next.$1]),
              style: const TextStyle(color: Colors.white70)),
          Text(
            _countdown(next.$2),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 44,
              fontWeight: FontWeight.bold,
              fontFeatures: [FontFeature.tabularFigures()],
            ),
          ),
          Text(
            '${s.prayerNames[next.$1]}: ${DateFormat.Hm(_localeCode).format(next.$2)}',
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  /// Dün / Yarın gezinme çubuğu. Ortadaki alana dokununca takvim açılır.
  Widget _dayNavigator() {
    final s = AppSettings.instance.strings;
    final dateText =
        DateFormat('d MMMM y EEEE', _localeCode).format(_displayedDate);
    final label = switch (_dayOffset) {
      0 => s.today,
      -1 => s.yesterday,
      1 => s.tomorrow,
      final o when o < 0 => s.daysAgo(-o),
      final o => s.daysLater(o),
    };
    final scheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        IconButton(
          tooltip: s.prevDay,
          icon: const Icon(Icons.chevron_left),
          onPressed: () => _changeDay(-1),
        ),
        Expanded(
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: _pickDate,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.event,
                          size: 16,
                          color:
                              _dayOffset == 0 ? Colors.grey : scheme.primary),
                      const SizedBox(width: 6),
                      Text(
                        label,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: _dayOffset == 0 ? null : scheme.primary,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    dateText,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
        ),
        IconButton(
          tooltip: s.nextDay,
          icon: const Icon(Icons.chevron_right),
          onPressed: () => _changeDay(1),
        ),
      ],
    );
  }

  Widget _timeRow(
    int index,
    DateTime time,
    (int, DateTime) next,
    ({int index, double progress})? current,
  ) {
    final s = AppSettings.instance.strings;
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isNext = _dayOffset == 0 && next.$1 == index && next.$2 == time;
    final isCurrent = current != null && current.index == index;
    final passed = time.isBefore(_now) && !isCurrent;

    // Koyu temada daha açık, açık temada daha koyu bir kırmızı.
    final progressColor = isDark ? Colors.red.shade300 : Colors.red.shade600;

    return Card(
      // Geçerli vakit, üzerine gelinmiş bir buton gibi "yükselir".
      elevation: isCurrent ? 4 : 0,
      shadowColor: isCurrent ? Colors.black.withValues(alpha: 0.4) : null,
      color: isCurrent
          ? scheme.surfaceContainerHighest
          : isNext
              ? scheme.primaryContainer
              : scheme.surfaceContainerLow,
      margin: const EdgeInsets.only(bottom: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(
              _icons[index],
              color: isCurrent
                  ? progressColor
                  : isNext
                      ? scheme.primary
                      : passed
                          ? Colors.grey
                          : null,
            ),
            title: Text(
              s.prayerNames[index],
              style: TextStyle(
                fontWeight:
                    isNext || isCurrent ? FontWeight.bold : FontWeight.normal,
                color: passed && !isNext ? Colors.grey : null,
              ),
            ),
            trailing: Text(
              DateFormat.Hm(_localeCode).format(time),
              style: TextStyle(
                fontSize: 18,
                fontWeight:
                    isNext || isCurrent ? FontWeight.bold : FontWeight.w500,
                color: isNext
                    ? scheme.primary
                    : passed
                        ? Colors.grey
                        : null,
              ),
            ),
          ),
          if (isCurrent)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: LinearProgressIndicator(
                  value: current.progress,
                  minHeight: 4,
                  color: progressColor,
                  backgroundColor: progressColor.withValues(alpha: 0.15),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

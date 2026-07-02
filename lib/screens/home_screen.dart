import 'dart:async';
import 'dart:ui' as ui;

import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../app_settings.dart';
import '../data/period_info.dart';
import '../screens/esma_screen.dart';
import '../screens/prophet_screen.dart';
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

  /// Dün, bugün ve yarının vakitleri tek bir kronolojik zaman çizgisinde.
  /// Konum ile cihaz saat dilimi farklı olsa bile mutlak zamanlar doğrudur;
  /// içinde bulunulan aralık ve sıradaki vakit buradan güvenle seçilir.
  List<(int, DateTime)> get _timeline {
    final all = <(int, DateTime)>[];
    for (var d = -1; d <= 1; d++) {
      final times = _timesListOf(_timesForOffset(d));
      for (var i = 0; i < times.length; i++) {
        all.add((i, times[i]));
      }
    }
    all.sort((a, b) => a.$2.compareTo(b.$2));
    return all;
  }

  /// Sıradaki vakit (Güneş hariç): (vakit indeksi, zaman) döner.
  (int, DateTime) get _next {
    for (final e in _timeline) {
      if (e.$1 == 1) continue; // Güneş bir namaz vakti değil.
      if (e.$2.isAfter(_now)) return e;
    }
    return (0, _timesForOffset(1).fajr); // Erişilmez; güvenlik için.
  }

  /// İçinde bulunduğumuz vakit dilimi (bugün görüntüleniyorsa):
  /// satır indeksi, 0..1 arası ilerleme ve aralığın sınırları.
  ({int index, double progress, DateTime start, DateTime end})?
      get _currentPeriod {
    if (_dayOffset != 0) return null;
    final all = _timeline;

    var pos = -1;
    for (var i = 0; i < all.length; i++) {
      if (!all[i].$2.isAfter(_now)) pos = i;
    }
    if (pos == -1 || pos == all.length - 1) return null;

    final start = all[pos].$2;
    final end = all[pos + 1].$2;
    final total = end.difference(start).inSeconds;
    if (total <= 0) {
      return (index: all[pos].$1, progress: 1.0, start: start, end: end);
    }
    final progress =
        (_now.difference(start).inSeconds / total).clamp(0.0, 1.0);
    return (index: all[pos].$1, progress: progress, start: start, end: end);
  }

  // ---- Kerahat vakitleri (Hanefî / Diyanet İlmihali) ----
  // 1) Güneş doğduktan sonra ~45 dk (bir mızrak boyu yükselene kadar)
  // 2) İstivâ: öğle vaktinden önceki ~10 dk (güneş tam tepedeyken)
  // 3) İsfirâr: akşam vaktinden önceki ~45 dk (güneşin sararması)
  // Bu pencereler yalnızca Güneş (1) ve İkindi (3) dilimlerinin içindedir;
  // İmsak, Öğle, Akşam ve Yatsı dilimlerinde kerahat yoktur.
  static const _sunriseKerahat = Duration(minutes: 45);
  static const _istiwaKerahat = Duration(minutes: 10);
  static const _isfirarKerahat = Duration(minutes: 45);

  /// Dilim içindeki kerahat bölgeleri, 0..1 kesir aralıkları olarak.
  static List<(double, double)> _kerahatZones(
      int index, DateTime start, DateTime end) {
    final total = end.difference(start).inSeconds;
    if (total <= 0) return const [];
    double f(DateTime t) =>
        (t.difference(start).inSeconds / total).clamp(0.0, 1.0).toDouble();
    return switch (index) {
      1 => [
          (0.0, f(start.add(_sunriseKerahat))),
          (f(end.subtract(_istiwaKerahat)), 1.0),
        ],
      3 => [(f(end.subtract(_isfirarKerahat)), 1.0)],
      _ => const [],
    };
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
              // Dokununca Hz. Muhammed'in hayatı sayfası açılır.
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const ProphetScreen()),
                ),
                child: _calligraphy('محمد'),
              ),
              Expanded(
                child: Text(s.appTitle, textAlign: TextAlign.center),
              ),
              // Dokununca Esmâü'l-Hüsnâ (99 isim) sayfası açılır.
              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const EsmaScreen()),
                ),
                child: _calligraphy('الله'),
              ),
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
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        children: [
          _headerCard(info, next),
          const SizedBox(height: 4),
          _dayNavigator(),
          const SizedBox(height: 2),
          ...List.generate(
            times.length,
            (i) => _timeRow(i, times[i], current),
          ),
        ],
      ),
    );
  }

  Widget _headerCard(LocationInfo info, (int, DateTime) next) {
    final s = AppSettings.instance.strings;
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
          const SizedBox(height: 8),
          Text(s.timeUntil(s.prayerNames[next.$1]),
              style: const TextStyle(color: Colors.white70)),
          Text(
            _countdown(next.$2),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 34,
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
              padding: const EdgeInsets.symmetric(vertical: 2),
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

  /// Vakit bilgi modalı: giriş/çıkış saati, kalan süre, anlam ve kerahat.
  void _showPeriodInfoModal(int index) {
    final s = AppSettings.instance.strings;
    final info = periodInfoFor(AppSettings.instance.lang);
    final locale = _localeCode;

    // Görüntülenen günün vakitleri üzerinden dilimin sınırları.
    final dayTimes = _timesListOf(_timesForOffset(_dayOffset));
    final start = dayTimes[index];
    final end = index == dayTimes.length - 1
        ? _timesForOffset(_dayOffset + 1).fajr
        : dayTimes[index + 1];

    // Kalan süre: yalnızca bugünde anlamlı.
    final now = DateTime.now();
    String? durationLabel;
    String? durationValue;
    if (_dayOffset == 0) {
      Duration? d;
      if (!start.isAfter(now) && end.isAfter(now)) {
        durationLabel = info.remaining;
        d = end.difference(now);
      } else if (start.isAfter(now)) {
        durationLabel = info.startsIn;
        d = start.difference(now);
      }
      if (d != null) {
        durationValue = info.fmtDuration(d.inHours, d.inMinutes % 60);
      }
    }

    // Kerahat açıklaması (saat aralıklarıyla).
    String fmt(DateTime t) => DateFormat.Hm(locale).format(t);
    final kerahatText = switch (index) {
      1 => info.sunKerahat(
          fmt(start),
          fmt(start.add(_sunriseKerahat)),
          fmt(end.subtract(_istiwaKerahat)),
          fmt(end),
        ),
      3 => info.asrKerahat(fmt(end.subtract(_isfirarKerahat)), fmt(end)),
      _ => info.noKerahat,
    };

    final scheme = Theme.of(context).colorScheme;
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
              Row(
                children: [
                  Icon(_icons[index], color: scheme.primary),
                  const SizedBox(width: 10),
                  Text(
                    s.prayerNames[index],
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              _infoRow(info.entersAt, fmt(start), scheme),
              _infoRow(info.endsAt, fmt(end), scheme),
              if (durationLabel != null && durationValue != null)
                _infoRow(durationLabel, durationValue, scheme,
                    highlight: true),
              const SizedBox(height: 14),
              _sectionLabel(info.meaningTitle, scheme),
              const SizedBox(height: 6),
              Text(info.meanings[index],
                  style: const TextStyle(fontSize: 15, height: 1.55)),
              const SizedBox(height: 14),
              _sectionLabel(info.kerahatTitle, scheme),
              const SizedBox(height: 6),
              Text(kerahatText,
                  style: const TextStyle(fontSize: 15, height: 1.55)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value, ColorScheme scheme,
      {bool highlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(child: Text(label, style: TextStyle(color: scheme.outline))),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: highlight ? scheme.primary : null,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionLabel(String text, ColorScheme scheme) {
    return Text(
      text,
      style: TextStyle(
        color: scheme.primary,
        fontWeight: FontWeight.bold,
        fontSize: 13,
      ),
    );
  }

  Widget _timeRow(
    int index,
    DateTime time,
    ({int index, double progress, DateTime start, DateTime end})? current,
  ) {
    final s = AppSettings.instance.strings;
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isCurrent = current != null && current.index == index;
    final passed = time.isBefore(_now) && !isCurrent;

    // Bar renkleri: kerahate kadar yeşil→turuncu, kerahatte kırmızı.
    final green = isDark ? Colors.green.shade400 : Colors.green.shade600;
    final orange = isDark ? Colors.orange.shade400 : Colors.orange.shade700;
    final red = isDark ? Colors.red.shade300 : Colors.red.shade600;

    // Şu anki ilerlemeye karşılık gelen renk (ikon ve yüzde etiketi için).
    final zones = isCurrent
        ? _kerahatZones(index, current.start, current.end)
        : const <(double, double)>[];
    final inKerahat = isCurrent &&
        zones.any((z) => current.progress >= z.$1 && current.progress <= z.$2);
    final progressColor = !isCurrent
        ? red
        : inKerahat
            ? red
            : Color.lerp(green, orange, current.progress)!;

    return Card(
      // Geçerli vakit, üzerine gelinmiş bir buton gibi "yükselir".
      elevation: isCurrent ? 4 : 0,
      shadowColor: isCurrent ? Colors.black.withValues(alpha: 0.4) : null,
      color: isCurrent
          ? scheme.surfaceContainerHighest
          : scheme.surfaceContainerLow,
      margin: const EdgeInsets.only(bottom: 6),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            visualDensity: const VisualDensity(vertical: -2),
            onTap: () => _showPeriodInfoModal(index),
            leading: Icon(
              _icons[index],
              color: isCurrent
                  ? progressColor
                  : passed
                      ? Colors.grey
                      : null,
            ),
            title: Text(
              s.prayerNames[index],
              style: TextStyle(
                fontWeight: isCurrent ? FontWeight.bold : FontWeight.normal,
                color: passed ? Colors.grey : null,
              ),
            ),
            trailing: Text(
              DateFormat.Hm(_localeCode).format(time),
              style: TextStyle(
                fontSize: 18,
                fontWeight: isCurrent ? FontWeight.bold : FontWeight.w500,
                color: passed ? Colors.grey : null,
              ),
            ),
          ),
          if (isCurrent)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Row(
                children: [
                  Expanded(
                    child: _PeriodBar(
                      progress: current.progress.clamp(0.0, 1.0),
                      kerahatZones: zones,
                      green: green,
                      orange: orange,
                      red: red,
                      markerColor: scheme.onSurface,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    NumberFormat.percentPattern(_localeCode)
                        .format(current.progress),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: progressColor,
                      fontFeatures: const [FontFeature.tabularFigures()],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// Vakit ilerleme çubuğu: dolu kısım yeşilden turuncuya akar (gradyan),
/// kerahat bölgeleri kırmızıdır; kerahat sınırları ince çizgiyle işaretlenir.
class _PeriodBar extends StatelessWidget {
  final double progress;

  /// 0..1 kesirleriyle kırmızı (kerahat) bölgeler.
  final List<(double, double)> kerahatZones;
  final Color green;
  final Color orange;
  final Color red;
  final Color markerColor;

  const _PeriodBar({
    required this.progress,
    required this.kerahatZones,
    required this.green,
    required this.orange,
    required this.red,
    required this.markerColor,
  });

  /// Tam genişlik için renk/durak listesi: kerahat dışı yeşil→turuncu,
  /// kerahat içi kırmızı.
  (List<Color>, List<double>) _gradient() {
    if (kerahatZones.isEmpty) {
      return ([green, orange], [0.0, 1.0]);
    }
    final colors = <Color>[];
    final stops = <double>[];
    void add(Color c, double at) {
      colors.add(c);
      stops.add(at);
    }

    var cursor = 0.0;
    for (final (zStart, zEnd) in kerahatZones) {
      if (zStart > cursor) {
        // Kerahat öncesi: yeşilden turuncuya.
        add(green, cursor);
        add(orange, zStart);
      }
      add(red, zStart);
      add(red, zEnd);
      cursor = zEnd;
    }
    if (cursor < 1.0) {
      add(green, cursor);
      add(orange, 1.0);
    }
    return (colors, stops);
  }

  @override
  Widget build(BuildContext context) {
    final (colors, stops) = _gradient();
    return SizedBox(
      height: 14,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final w = constraints.maxWidth;
          return Stack(
            children: [
              // Zemin: tam gradyanın soluk hâli.
              Positioned.fill(
                top: 3,
                bottom: 3,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Opacity(
                    opacity: 0.22,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: AlignmentDirectional.centerStart,
                          end: AlignmentDirectional.centerEnd,
                          colors: colors,
                          stops: stops,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Dolu kısım: geçen süre kadar gradyan.
              PositionedDirectional(
                top: 3,
                bottom: 3,
                start: 0,
                width: w * progress,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: AlignmentDirectional.centerStart,
                        end: AlignmentDirectional.centerEnd,
                        // Dolu kısım, tam genişlik gradyanının soldan kesiti
                        // gibi görünsün diye duraklar ilerlemeye ölçeklenir.
                        colors: colors,
                        stops: [
                          for (final st in stops)
                            progress <= 0 ? 0.0 : (st / progress).clamp(0.0, 1.0)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Kerahat sınır çizgileri (0 ve 1 hariç).
              for (final (zStart, zEnd) in kerahatZones)
                for (final frac in [zStart, zEnd])
                  if (frac > 0.001 && frac < 0.999)
                    PositionedDirectional(
                      start: (w * frac) - 1,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        width: 2,
                        color: markerColor.withValues(alpha: 0.7),
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}

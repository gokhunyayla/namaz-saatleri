import 'dart:async';

import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String? _error;
  bool _loading = true;
  Timer? _ticker;
  DateTime _now = DateTime.now();

  /// Görüntülenen günün bugüne göre farkı: 0 = bugün, -1 = dün, 1 = yarın...
  int _dayOffset = 0;

  bool _notificationsOn = true;
  int _minutesBefore = 15;

  static const _kNotifOn = 'notifications_on';
  static const _kMinutesBefore = 'minutes_before';

  DateTime get _displayedDate => _now.add(Duration(days: _dayOffset));

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
    _loadSettingsAndLocation();
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  Future<void> _loadSettingsAndLocation() async {
    final prefs = await SharedPreferences.getInstance();
    _notificationsOn = prefs.getBool(_kNotifOn) ?? true;
    _minutesBefore = prefs.getInt(_kMinutesBefore) ?? 15;

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
      _error = null;
      if (_times == null) _loading = true;
    });
    try {
      final info = await LocationService.getCurrent();
      if (!mounted) return;
      widget.location.value = info;
      _recompute(info);
      await _rescheduleNotifications();
    } catch (e) {
      if (!mounted) return;
      // Güncel konum alınamadıysa ama önbellek varsa onunla devam et.
      if (_times == null) {
        _error = e.toString().replaceFirst('Exception: ', '');
      }
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
    _dayOffset = delta == 0 ? 0 : _dayOffset + delta;
    final info = widget.location.value;
    if (info != null) _recompute(info);
  }

  Future<void> _rescheduleNotifications() async {
    final info = widget.location.value;
    if (info == null) return;
    if (_notificationsOn) {
      final granted = await NotificationService.instance.requestPermissions();
      if (granted) {
        await NotificationService.instance.scheduleAll(
          lat: info.latitude,
          lng: info.longitude,
          minutesBefore: _minutesBefore,
        );
      }
    } else {
      await NotificationService.instance.cancelAll();
    }
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kNotifOn, _notificationsOn);
    await prefs.setInt(_kMinutesBefore, _minutesBefore);
    await _rescheduleNotifications();
  }

  // ---- Vakit yardımcıları ----

  static List<(String, DateTime)> _entriesOf(PrayerTimes t) => [
        ('İmsak', t.fajr),
        ('Güneş', t.sunrise),
        ('Öğle', t.dhuhr),
        ('İkindi', t.asr),
        ('Akşam', t.maghrib),
        ('Yatsı', t.isha),
      ];

  /// Görüntülenen günün vakitleri.
  List<(String, DateTime)> get _entries => _entriesOf(_times!);

  PrayerTimes _timesForOffset(int dayDelta) {
    final info = widget.location.value!;
    return PrayerService.timesFor(
        info.latitude, info.longitude, _now.add(Duration(days: dayDelta)));
  }

  /// Sıradaki vakit (Güneş hariç) — her zaman bugüne göre.
  /// Bugün bittiyse yarının imsakı.
  (String, DateTime) get _next {
    for (final e in _entriesOf(_timesForOffset(0))) {
      if (e.$1 == 'Güneş') continue;
      if (e.$2.isAfter(_now)) return e;
    }
    return ('İmsak', _timesForOffset(1).fajr);
  }

  /// İçinde bulunduğumuz vakit dilimi (bugün görüntüleniyorsa):
  /// satır indeksi ve 0..1 arası ilerleme.
  ({int index, double progress})? get _currentPeriod {
    if (_dayOffset != 0) return null;
    final entries = _entriesOf(_timesForOffset(0));

    var index = -1;
    for (var i = 0; i < entries.length; i++) {
      if (!entries[i].$2.isAfter(_now)) index = i;
    }

    DateTime start, end;
    if (index == -1) {
      // Gece yarısı ile imsak arası: dünün yatsısı hâlâ sürüyor.
      index = entries.length - 1;
      start = _timesForOffset(-1).isha;
      end = entries.first.$2;
    } else if (index == entries.length - 1) {
      // Yatsı: yarının imsakına kadar.
      start = entries[index].$2;
      end = _timesForOffset(1).fajr;
    } else {
      start = entries[index].$2;
      end = entries[index + 1].$2;
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

  static const _icons = <String, IconData>{
    'İmsak': Icons.nights_stay_outlined,
    'Güneş': Icons.wb_twilight,
    'Öğle': Icons.wb_sunny_outlined,
    'İkindi': Icons.sunny_snowing,
    'Akşam': Icons.wb_shade,
    'Yatsı': Icons.dark_mode_outlined,
  };

  // ---- UI ----

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Namaz Saatleri'),
        actions: [
          IconButton(
            tooltip: 'Konumu yenile',
            icon: const Icon(Icons.my_location),
            onPressed: _refreshLocation,
          ),
          IconButton(
            tooltip: 'Bildirim ayarları',
            icon: const Icon(Icons.notifications_outlined),
            onPressed: _showSettings,
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_loading && _times == null) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null && _times == null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.location_off, size: 48, color: Colors.grey),
              const SizedBox(height: 16),
              Text(_error!, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _refreshLocation,
                icon: const Icon(Icons.refresh),
                label: const Text('Tekrar Dene'),
              ),
            ],
          ),
        ),
      );
    }

    final info = widget.location.value!;
    final next = _next;
    final current = _currentPeriod;
    final entries = _entries;

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
            entries.length,
            (i) => _timeRow(i, entries[i], next, current),
          ),
        ],
      ),
    );
  }

  Widget _headerCard(LocationInfo info, (String, DateTime) next) {
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
          Text('${next.$1} vaktine kalan',
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
            '${next.$1}: ${DateFormat.Hm().format(next.$2)}',
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }

  /// Dün / Yarın gezinme çubuğu. Tarihe dokununca bugüne döner.
  Widget _dayNavigator() {
    final dateText = DateFormat('d MMMM y EEEE', 'tr_TR').format(_displayedDate);
    final label = switch (_dayOffset) {
      0 => 'Bugün',
      -1 => 'Dün',
      1 => 'Yarın',
      final o when o < 0 => '${-o} gün önce',
      final o => '$o gün sonra',
    };
    final scheme = Theme.of(context).colorScheme;

    return Row(
      children: [
        IconButton(
          tooltip: 'Önceki gün',
          icon: const Icon(Icons.chevron_left),
          onPressed: () => _changeDay(-1),
        ),
        Expanded(
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: _dayOffset != 0 ? () => _changeDay(0) : null,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Column(
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _dayOffset == 0 ? null : scheme.primary,
                    ),
                  ),
                  Text(
                    _dayOffset == 0 ? dateText : '$dateText • bugüne dön',
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
          tooltip: 'Sonraki gün',
          icon: const Icon(Icons.chevron_right),
          onPressed: () => _changeDay(1),
        ),
      ],
    );
  }

  Widget _timeRow(
    int index,
    (String, DateTime) e,
    (String, DateTime) next,
    ({int index, double progress})? current,
  ) {
    final scheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isNext = _dayOffset == 0 && e.$1 == next.$1 && e.$2 == next.$2;
    final isCurrent = current != null && current.index == index;
    final passed = e.$2.isBefore(_now) && !isCurrent;

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
              _icons[e.$1],
              color: isCurrent
                  ? progressColor
                  : isNext
                      ? scheme.primary
                      : passed
                          ? Colors.grey
                          : null,
            ),
            title: Text(
              e.$1,
              style: TextStyle(
                fontWeight:
                    isNext || isCurrent ? FontWeight.bold : FontWeight.normal,
                color: passed && !isNext ? Colors.grey : null,
              ),
            ),
            trailing: Text(
              DateFormat.Hm().format(e.$2),
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

  void _showSettings() {
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setSheetState) => Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Bildirim Ayarları',
                  style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8),
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Vakit hatırlatmaları'),
                subtitle:
                    const Text('Namaz vakti yaklaşınca bildirim gönderilir'),
                value: _notificationsOn,
                onChanged: (v) {
                  setSheetState(() => _notificationsOn = v);
                  setState(() {});
                  _saveSettings();
                },
              ),
              ListTile(
                contentPadding: EdgeInsets.zero,
                enabled: _notificationsOn,
                title: const Text('Kaç dakika önce?'),
                trailing: DropdownButton<int>(
                  value: _minutesBefore,
                  items: const [0, 5, 10, 15, 30, 45]
                      .map((m) => DropdownMenuItem(
                            value: m,
                            child: Text(m == 0 ? 'Vaktinde' : '$m dk önce'),
                          ))
                      .toList(),
                  onChanged: _notificationsOn
                      ? (v) {
                          if (v == null) return;
                          setSheetState(() => _minutesBefore = v);
                          setState(() {});
                          _saveSettings();
                        }
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

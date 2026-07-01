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

  bool _notificationsOn = true;
  int _minutesBefore = 15;

  static const _kNotifOn = 'notifications_on';
  static const _kMinutesBefore = 'minutes_before';

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      final now = DateTime.now();
      // Gün değiştiyse vakitleri yeniden hesapla.
      if (_now.day != now.day && widget.location.value != null) {
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
    _times = PrayerService.timesFor(info.latitude, info.longitude, _now);
    setState(() {});
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

  List<(String, DateTime)> get _entries {
    final t = _times!;
    return [
      ('İmsak', t.fajr),
      ('Güneş', t.sunrise),
      ('Öğle', t.dhuhr),
      ('İkindi', t.asr),
      ('Akşam', t.maghrib),
      ('Yatsı', t.isha),
    ];
  }

  /// Sıradaki vakit (Güneş hariç). Bugün bittiyse yarının imsakı.
  (String, DateTime) get _next {
    for (final e in _entries) {
      if (e.$1 == 'Güneş') continue;
      if (e.$2.isAfter(_now)) return e;
    }
    final info = widget.location.value!;
    final tomorrow = PrayerService.timesFor(
        info.latitude, info.longitude, _now.add(const Duration(days: 1)));
    return ('İmsak', tomorrow.fajr);
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
    final dateText =
        DateFormat('d MMMM y EEEE', 'tr_TR').format(_now);

    return RefreshIndicator(
      onRefresh: _refreshLocation,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _headerCard(info, next, dateText),
          const SizedBox(height: 16),
          ..._entries.map((e) => _timeRow(e, next)),
        ],
      ),
    );
  }

  Widget _headerCard(
      LocationInfo info, (String, DateTime) next, String dateText) {
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
          const SizedBox(height: 4),
          Text(dateText, style: const TextStyle(color: Colors.white70)),
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

  Widget _timeRow((String, DateTime) e, (String, DateTime) next) {
    final isNext = e.$1 == next.$1 && e.$2 == next.$2;
    final scheme = Theme.of(context).colorScheme;
    final passed = e.$2.isBefore(_now);
    return Card(
      elevation: 0,
      color: isNext ? scheme.primaryContainer : scheme.surfaceContainerLow,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(_icons[e.$1],
            color: isNext ? scheme.primary : (passed ? Colors.grey : null)),
        title: Text(
          e.$1,
          style: TextStyle(
            fontWeight: isNext ? FontWeight.bold : FontWeight.normal,
            color: passed && !isNext ? Colors.grey : null,
          ),
        ),
        trailing: Text(
          DateFormat.Hm().format(e.$2),
          style: TextStyle(
            fontSize: 18,
            fontWeight: isNext ? FontWeight.bold : FontWeight.w500,
            color: isNext
                ? scheme.primary
                : (passed ? Colors.grey : null),
          ),
        ),
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

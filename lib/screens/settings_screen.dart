import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app_settings.dart';
import '../l10n/strings.dart';
import '../services/notification_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifOn = true;
  int _minutesBefore = 15;
  bool _adhanSound = true;

  static const _kNotifOn = 'notifications_on';
  static const _kMinutesBefore = 'minutes_before';
  static const _kAdhanSound = 'adhan_sound';

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() {
      _notifOn = prefs.getBool(_kNotifOn) ?? true;
      _minutesBefore = prefs.getInt(_kMinutesBefore) ?? 15;
      _adhanSound = prefs.getBool(_kAdhanSound) ?? true;
    });
  }

  Future<void> _saveNotifPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kNotifOn, _notifOn);
    await prefs.setInt(_kMinutesBefore, _minutesBefore);
    await prefs.setBool(_kAdhanSound, _adhanSound);
    await NotificationService.instance.rescheduleFromPrefs();
  }

  @override
  Widget build(BuildContext context) {
    final settings = AppSettings.instance;
    final s = settings.strings;

    return Scaffold(
      appBar: AppBar(title: Text(s.settingsTitle)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _sectionTitle(s.appearance, Icons.palette_outlined),
          const SizedBox(height: 8),
          SegmentedButton<ThemeMode>(
            segments: [
              ButtonSegment(
                value: ThemeMode.light,
                icon: const Icon(Icons.light_mode_outlined),
                label: Text(s.light),
              ),
              ButtonSegment(
                value: ThemeMode.dark,
                icon: const Icon(Icons.dark_mode_outlined),
                label: Text(s.dark),
              ),
              ButtonSegment(
                value: ThemeMode.system,
                icon: const Icon(Icons.phone_iphone),
                label: Text(s.system),
              ),
            ],
            selected: {settings.themeMode},
            onSelectionChanged: (selection) =>
                settings.setThemeMode(selection.first),
          ),
          const SizedBox(height: 24),
          _sectionTitle(s.language, Icons.translate),
          _langTile(null, s.deviceLanguage, subtitle: _deviceLangName()),
          _langTile(AppLang.tr, 'Türkçe'),
          _langTile(AppLang.ar, 'العربية'),
          _langTile(AppLang.en, 'English'),
          const SizedBox(height: 24),
          _sectionTitle(s.notifications, Icons.notifications_outlined),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(s.prayerReminders),
            subtitle: Text(s.prayerRemindersSubtitle),
            value: _notifOn,
            onChanged: (v) {
              setState(() => _notifOn = v);
              _saveNotifPrefs();
            },
          ),
          // Vakit girdiğinde: ezan sesi mi, normal bildirim sesi mi?
          ListTile(
            contentPadding: EdgeInsets.zero,
            enabled: _notifOn,
            leading: Icon(
              _adhanSound ? Icons.volume_up : Icons.notifications_active,
              color: _notifOn ? Theme.of(context).colorScheme.primary : Colors.grey,
            ),
            title: Text(s.atPrayerTime),
            trailing: SegmentedButton<bool>(
              segments: [
                ButtonSegment(value: true, label: Text(s.playAdhan)),
                ButtonSegment(value: false, label: Text(s.notificationSound)),
              ],
              selected: {_adhanSound},
              onSelectionChanged: _notifOn
                  ? (sel) {
                      setState(() => _adhanSound = sel.first);
                      _saveNotifPrefs();
                    }
                  : null,
              showSelectedIcon: false,
            ),
          ),
          // Vakitten önce ek hatırlatma (her zaman normal bildirim sesiyle).
          ListTile(
            contentPadding: EdgeInsets.zero,
            enabled: _notifOn,
            leading: Icon(
              Icons.alarm,
              color: _notifOn ? Theme.of(context).colorScheme.primary : Colors.grey,
            ),
            title: Text(s.remindBefore),
            trailing: DropdownButton<int>(
              value: _minutesBefore,
              items: [0, 5, 10, 15, 30, 45]
                  .map((m) => DropdownMenuItem(
                        value: m,
                        child:
                            Text(m == 0 ? s.off : s.minutesBeforeOption(m)),
                      ))
                  .toList(),
              onChanged: _notifOn
                  ? (v) {
                      if (v == null) return;
                      setState(() => _minutesBefore = v);
                      _saveNotifPrefs();
                    }
                  : null,
            ),
          ),
          // Bildirim testi: ezan sesi + bildirim sesi + hatırlatma.
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(Icons.notification_add_outlined,
                color: Theme.of(context).colorScheme.primary),
            title: Text(s.testNotifications),
            subtitle: Text(s.testNotificationsSubtitle),
            trailing: const Icon(Icons.play_arrow),
            onTap: () async {
              final ok = await NotificationService.instance
                  .scheduleTestNotifications();
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      ok ? s.testScheduled : s.notifPermissionDenied),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  /// Dil seçilmemişken cihaz dilinin hangi uygulama diline düştüğünü gösterir.
  String _deviceLangName() {
    final auto = AppSettings.instance.langOverride == null
        ? AppSettings.instance.lang
        : null;
    return switch (auto) {
      AppLang.tr => 'Türkçe',
      AppLang.ar => 'العربية',
      AppLang.en => 'English',
      null => '',
    };
  }

  Widget _langTile(AppLang? value, String title, {String? subtitle}) {
    final settings = AppSettings.instance;
    final selected = settings.langOverride == value;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title),
      subtitle: subtitle != null && subtitle.isNotEmpty ? Text(subtitle) : null,
      trailing: selected
          ? Icon(Icons.check_circle,
              color: Theme.of(context).colorScheme.primary)
          : const Icon(Icons.circle_outlined, color: Colors.grey),
      onTap: () async {
        await settings.setLang(value);
        // Planlanmış bildirim metinleri de yeni dilde yenilensin.
        await NotificationService.instance.rescheduleFromPrefs();
      },
    );
  }

  Widget _sectionTitle(String text, IconData icon) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Icon(icon, size: 20, color: scheme.primary),
        const SizedBox(width: 8),
        Text(
          text,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

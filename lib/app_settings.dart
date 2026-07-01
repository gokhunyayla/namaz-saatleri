import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'l10n/strings.dart';

/// Uygulama geneli ayarlar: tema (açık/koyu/sistem) ve dil.
/// Dil seçilmemişse cihaz diline bakılır: Türkçe → TR, Arapça → AR, diğer → EN.
class AppSettings extends ChangeNotifier {
  AppSettings._();
  static final AppSettings instance = AppSettings._();

  static const _kTheme = 'theme_mode';
  static const _kLang = 'app_lang';

  ThemeMode themeMode = ThemeMode.system;

  /// null = cihaz diline göre otomatik.
  AppLang? langOverride;

  AppLang get lang {
    if (langOverride != null) return langOverride!;
    return switch (ui.PlatformDispatcher.instance.locale.languageCode) {
      'tr' => AppLang.tr,
      'ar' => AppLang.ar,
      _ => AppLang.en,
    };
  }

  Strings get strings => stringsFor(lang);
  Locale get locale => Locale(lang.name);

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    themeMode = switch (prefs.getString(_kTheme)) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
    langOverride = switch (prefs.getString(_kLang)) {
      'tr' => AppLang.tr,
      'ar' => AppLang.ar,
      'en' => AppLang.en,
      _ => null,
    };
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    themeMode = mode;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _kTheme,
      switch (mode) {
        ThemeMode.light => 'light',
        ThemeMode.dark => 'dark',
        ThemeMode.system => 'system',
      },
    );
  }

  Future<void> setLang(AppLang? newLang) async {
    langOverride = newLang;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kLang, newLang?.name ?? 'system');
  }
}

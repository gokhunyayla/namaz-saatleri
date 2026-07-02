import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_settings.dart';
import 'data/prayer_guide.dart';
import 'screens/guide_screen.dart';
import 'screens/home_screen.dart';
import 'screens/qibla_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/verse_screen.dart';
import 'services/location_service.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Tüm desteklenen diller için tarih biçimlendirme verilerini yükle.
  await initializeDateFormatting();
  await AppSettings.instance.load();
  await NotificationService.instance.init();
  // Mağaza ekran görüntüsü alırken sekme seçmek için gizli ayar (vars. 0).
  final prefs = await SharedPreferences.getInstance();
  final initialTab = prefs.getInt('debug_initial_tab') ?? 0;
  runApp(NamazSaatleriApp(initialTab: initialTab));
}

class NamazSaatleriApp extends StatelessWidget {
  final int initialTab;

  const NamazSaatleriApp({super.key, this.initialTab = 0});

  @override
  Widget build(BuildContext context) {
    // Tema veya dil değişince tüm uygulama yeniden kurulur.
    return ListenableBuilder(
      listenable: AppSettings.instance,
      builder: (context, _) {
        final settings = AppSettings.instance;
        return MaterialApp(
          title: settings.strings.appTitle,
          debugShowCheckedModeBanner: false,
          themeMode: settings.themeMode,
          locale: settings.locale,
          supportedLocales: const [Locale('tr'), Locale('ar'), Locale('en')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          theme: ThemeData(
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xFF00695C)),
            useMaterial3: true,
          ),
          darkTheme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xFF00695C),
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
          ),
          home: RootShell(initialTab: initialTab),
        );
      },
    );
  }
}

class RootShell extends StatefulWidget {
  final int initialTab;

  const RootShell({super.key, this.initialTab = 0});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  late int _index = widget.initialTab.clamp(0, 4);

  /// Konum ekranlar arasında paylaşılır: Vakitler ekranı alır, Kıble kullanır.
  final ValueNotifier<LocationInfo?> _location = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    final s = AppSettings.instance.strings;
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: [
          HomeScreen(location: _location),
          QiblaScreen(location: _location),
          VerseScreen(location: _location),
          const GuideScreen(),
          const SettingsScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.schedule),
            label: s.tabTimes,
          ),
          NavigationDestination(
            icon: const Icon(Icons.explore_outlined),
            selectedIcon: const Icon(Icons.explore),
            label: s.tabQibla,
          ),
          NavigationDestination(
            icon: const Icon(Icons.auto_stories_outlined),
            selectedIcon: const Icon(Icons.auto_stories),
            label: s.tabVerse,
          ),
          NavigationDestination(
            icon: const FaIcon(FontAwesomeIcons.personPraying, size: 22),
            label: guideL10nFor(AppSettings.instance.lang).tabGuide,
          ),
          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: s.tabSettings,
          ),
        ],
      ),
    );
  }
}

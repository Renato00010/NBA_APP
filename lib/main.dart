import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';
import 'db/app_database.dart';
import 'screens/home/home_screen.dart';
import 'screens/games/games_screen.dart';
import 'screens/news/news_screen.dart';
import 'screens/store/store_screen.dart';
import 'screens/auth/login_screen.dart';
import 'services/theme_service.dart';
import 'services/nba_api_service.dart';
import 'services/repository.dart';
import 'services/data_seed_service.dart';
import 'services/player_stats_web_sync.dart';
import 'services/player_stats_seed.dart';
import 'services/cart_service.dart';
import 'services/connectivity_service.dart';
import 'services/notification_service.dart';
import 'screens/standings/standings_screen.dart';
import 'widgets/offline_status_banner.dart';

late AppDatabase database;
late NbaRepository repository;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PlayerStatsSeed.init();
  database = AppDatabase();
  final apiService = NbaApiService();
  await DataSeedService(
    apiService,
    database.playersDao,
    database.teamsDao,
  ).seedDatabase();
  repository = NbaRepository(database, apiService);
  await CartService.instance.init(database);
  await ConnectivityService.instance.init();
  await NotificationService.instance.init();
  unawaited(NotificationService.instance.rescheduleFromPreferences());
  unawaited(
    PlayerStatsWebSync(
      database.playersDao,
    ).syncFromBasketballReference(passes: 3, perPlayerRetries: 2),
  );
  runApp(const NbaApp());
}

class NbaApp extends StatefulWidget {
  const NbaApp({super.key});

  static NbaAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<NbaAppState>();

  @override
  State<NbaApp> createState() => NbaAppState();
}

class NbaAppState extends State<NbaApp> {
  String? _favoriteTeamId;
  String? _userEmail;
  bool _loadingPrefs = true;
  Locale _locale = const Locale('pt');

  String? get userEmail => _userEmail;
  Locale get locale => _locale;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    try {
      final prefs = await database.preferencesDao.getPreferences();
      setState(() {
        _favoriteTeamId = prefs?.favoriteTeamId;
        _userEmail = prefs?.email;
        _loadingPrefs = false;
      });
      if (prefs?.language != null) {
        setState(() => _locale = Locale(prefs!.language));
      }
    } catch (e) {
      setState(() => _loadingPrefs = false);
    }
  }

  Future<void> updateTeam(String? teamId) async {
    setState(() => _favoriteTeamId = teamId);
    try {
      await database.preferencesDao.updateFavoriteTeam(teamId ?? '');
      unawaited(NotificationService.instance.rescheduleFromPreferences());
    } catch (e) {
      debugPrint('Erro ao guardar equipa: $e');
    }
  }

  Future<void> login(String email) async {
    try {
      await database.preferencesDao.setLoggedIn(email);
      final prefs = await database.preferencesDao.getPreferences();
      setState(() {
        _userEmail = prefs?.email ?? email;
        _favoriteTeamId = prefs?.favoriteTeamId;
        _locale = Locale(prefs?.language ?? 'pt');
      });
    } catch (e) {
      debugPrint('Erro ao guardar login: $e');
    }
  }

  Future<void> logout() async {
    try {
      await database.preferencesDao.setLoggedOut();
      setState(() {
        _userEmail = null;
        _favoriteTeamId = null;
      });
    } catch (e) {
      debugPrint('Erro ao fazer logout: $e');
    }
  }

  Future<void> setLocale(String languageCode) async {
    setState(() => _locale = Locale(languageCode));
    try {
      await database.preferencesDao.updateLanguageCode(languageCode);
    } catch (e) {
      debugPrint('Erro ao guardar idioma: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loadingPrefs) {
      return const MaterialApp(
        home: Scaffold(
          backgroundColor: Color(0xFF0A0A0A),
          body: Center(
            child: CircularProgressIndicator(color: Color(0xFF17408B)),
          ),
        ),
      );
    }

    final teamTheme = ThemeService.getTheme(_favoriteTeamId);
    return MaterialApp(
      title: 'NBA App',
      debugShowCheckedModeBanner: false,
      theme: ThemeService.buildTheme(teamTheme),
      locale: _locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt'), Locale('en')],
      home: (_userEmail == null || _userEmail!.isEmpty)
          ? const LoginScreen()
          : MainNavigation(teamTheme: teamTheme),
    );
  }
}

class MainNavigation extends StatefulWidget {
  final NbaTeamTheme teamTheme;
  const MainNavigation({super.key, required this.teamTheme});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    GamesScreen(),
    StandingsScreen(),
    NewsScreen(),
    StoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      body: Column(
        children: [
          const OfflineStatusBanner(),
          Expanded(child: _screens[_currentIndex]),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: widget.teamTheme.primaryColor,
        indicatorColor: widget.teamTheme.secondaryColor,
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined, color: Colors.white70),
            selectedIcon: const Icon(Icons.home, color: Colors.white),
            label: l10n.home,
          ),
          NavigationDestination(
            icon: const Icon(
              Icons.sports_basketball_outlined,
              color: Colors.white70,
            ),
            selectedIcon: const Icon(
              Icons.sports_basketball,
              color: Colors.white,
            ),
            label: l10n.games,
          ),
          NavigationDestination(
            icon: const Icon(Icons.table_chart_outlined, color: Colors.white70),
            selectedIcon: const Icon(Icons.table_chart, color: Colors.white),
            label: l10n.standings,
          ),
          NavigationDestination(
            icon: const Icon(Icons.newspaper_outlined, color: Colors.white70),
            selectedIcon: const Icon(Icons.newspaper, color: Colors.white),
            label: l10n.news,
          ),
          NavigationDestination(
            icon: const Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white70,
            ),
            selectedIcon: const Icon(Icons.shopping_bag, color: Colors.white),
            label: l10n.store,
          ),
        ],
      ),
    );
  }
}

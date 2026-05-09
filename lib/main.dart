import 'package:flutter/material.dart';
import 'db/app_database.dart';
import 'screens/home/home_screen.dart';
import 'screens/games/games_screen.dart';
import 'screens/news/news_screen.dart';
import 'screens/store/store_screen.dart';
import 'screens/profile/profile_screen.dart';
import 'services/theme_service.dart';
import 'services/nba_api_service.dart';
import 'services/repository.dart';

late AppDatabase database;
late NbaRepository repository;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  database = AppDatabase();
  repository = NbaRepository(database, NbaApiService());
  runApp(const NbaApp());
}

class NbaApp extends StatefulWidget {
  const NbaApp({super.key});

  static _NbaAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_NbaAppState>();

  @override
  State<NbaApp> createState() => _NbaAppState();
}

class _NbaAppState extends State<NbaApp> {
  String? _favoriteTeamId;
  bool _loadingPrefs = true;

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
        _loadingPrefs = false;
      });
    } catch (e) {
      setState(() => _loadingPrefs = false);
    }
  }

  Future<void> updateTeam(String? teamId) async {
    setState(() => _favoriteTeamId = teamId);
    try {
      await database.preferencesDao.updateFavoriteTeam(teamId ?? '');
    } catch (e) {
      print('Erro ao guardar equipa: $e');
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
      home: MainNavigation(teamTheme: teamTheme),
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
    NewsScreen(),
    StoreScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: widget.teamTheme.primaryColor,
        indicatorColor: widget.teamTheme.secondaryColor,
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined, color: Colors.white70),
            selectedIcon: Icon(Icons.home, color: Colors.white),
            label: 'Início',
          ),
          NavigationDestination(
            icon: Icon(Icons.sports_basketball_outlined, color: Colors.white70),
            selectedIcon: Icon(Icons.sports_basketball, color: Colors.white),
            label: 'Jogos',
          ),
          NavigationDestination(
            icon: Icon(Icons.newspaper_outlined, color: Colors.white70),
            selectedIcon: Icon(Icons.newspaper, color: Colors.white),
            label: 'Notícias',
          ),
          NavigationDestination(
            icon: Icon(Icons.store_outlined, color: Colors.white70),
            selectedIcon: Icon(Icons.store, color: Colors.white),
            label: 'Loja',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline, color: Colors.white70),
            selectedIcon: Icon(Icons.person, color: Colors.white),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class NbaTeamTheme {
  final String teamId;
  final String teamName;
  final Color primaryColor;
  final Color secondaryColor;

  const NbaTeamTheme({
    required this.teamId,
    required this.teamName,
    required this.primaryColor,
    required this.secondaryColor,
  });
}

class ThemeService {
  // Temas de todas as equipas NBA
  static const Map<String, NbaTeamTheme> teamThemes = {
    '1': NbaTeamTheme(
      teamId: '1',
      teamName: 'Atlanta Hawks',
      primaryColor: Color(0xFFC1D32F),
      secondaryColor: Color(0xFFE03A3E),
    ),
    '2': NbaTeamTheme(
      teamId: '2',
      teamName: 'Boston Celtics',
      primaryColor: Color(0xFF007A33),
      secondaryColor: Color(0xFFBA9653),
    ),
    '3': NbaTeamTheme(
      teamId: '3',
      teamName: 'Brooklyn Nets',
      primaryColor: Color(0xFF000000),
      secondaryColor: Color(0xFFFFFFFF),
    ),
    '4': NbaTeamTheme(
      teamId: '4',
      teamName: 'Charlotte Hornets',
      primaryColor: Color(0xFF1D1160),
      secondaryColor: Color(0xFF00788C),
    ),
    '5': NbaTeamTheme(
      teamId: '5',
      teamName: 'Chicago Bulls',
      primaryColor: Color(0xFFCE1141),
      secondaryColor: Color(0xFF000000),
    ),
    '6': NbaTeamTheme(
      teamId: '6',
      teamName: 'Cleveland Cavaliers',
      primaryColor: Color(0xFF860038),
      secondaryColor: Color(0xFFFFB81C),
    ),
    '7': NbaTeamTheme(
      teamId: '7',
      teamName: 'Dallas Mavericks',
      primaryColor: Color(0xFF00538C),
      secondaryColor: Color(0xFF002B5E),
    ),
    '8': NbaTeamTheme(
      teamId: '8',
      teamName: 'Denver Nuggets',
      primaryColor: Color(0xFF0E2240),
      secondaryColor: Color(0xFFFEC524),
    ),
    '9': NbaTeamTheme(
      teamId: '9',
      teamName: 'Detroit Pistons',
      primaryColor: Color(0xFFC8102E),
      secondaryColor: Color(0xFF006BB6),
    ),
    '10': NbaTeamTheme(
      teamId: '10',
      teamName: 'Golden State Warriors',
      primaryColor: Color(0xFF1D42BA),
      secondaryColor: Color(0xFFFFC72C),
    ),
    '11': NbaTeamTheme(
      teamId: '11',
      teamName: 'Houston Rockets',
      primaryColor: Color(0xFFCE1141),
      secondaryColor: Color(0xFF000000),
    ),
    '12': NbaTeamTheme(
      teamId: '12',
      teamName: 'Indiana Pacers',
      primaryColor: Color(0xFF002D62),
      secondaryColor: Color(0xFFFFB200),
    ),
    '13': NbaTeamTheme(
      teamId: '13',
      teamName: 'LA Clippers',
      primaryColor: Color(0xFFC8102E),
      secondaryColor: Color(0xFF1D42BA),
    ),
    '14': NbaTeamTheme(
      teamId: '14',
      teamName: 'Los Angeles Lakers',
      primaryColor: Color(0xFF552583),
      secondaryColor: Color(0xFFFDB927),
    ),
    '15': NbaTeamTheme(
      teamId: '15',
      teamName: 'Memphis Grizzlies',
      primaryColor: Color(0xFF5D76A9),
      secondaryColor: Color(0xFF12173F),
    ),
    '16': NbaTeamTheme(
      teamId: '16',
      teamName: 'Miami Heat',
      primaryColor: Color(0xFF98002E),
      secondaryColor: Color(0xFFF9A01B),
    ),
    '17': NbaTeamTheme(
      teamId: '17',
      teamName: 'Milwaukee Bucks',
      primaryColor: Color(0xFF00471B),
      secondaryColor: Color(0xFFEEE1C6),
    ),
    '18': NbaTeamTheme(
      teamId: '18',
      teamName: 'Minnesota Timberwolves',
      primaryColor: Color(0xFF0C2340),
      secondaryColor: Color(0xFF236192),
    ),
    '19': NbaTeamTheme(
      teamId: '19',
      teamName: 'New Orleans Pelicans',
      primaryColor: Color(0xFF0C2340),
      secondaryColor: Color(0xFFC8102E),
    ),
    '20': NbaTeamTheme(
      teamId: '20',
      teamName: 'New York Knicks',
      primaryColor: Color(0xFF006BB6),
      secondaryColor: Color(0xFFF58426),
    ),
    '21': NbaTeamTheme(
      teamId: '21',
      teamName: 'Oklahoma City Thunder',
      primaryColor: Color(0xFF007AC1),
      secondaryColor: Color(0xFFEF3B24),
    ),
    '22': NbaTeamTheme(
      teamId: '22',
      teamName: 'Orlando Magic',
      primaryColor: Color(0xFF0077C0),
      secondaryColor: Color(0xFFC4CED4),
    ),
    '23': NbaTeamTheme(
      teamId: '23',
      teamName: 'Philadelphia 76ers',
      primaryColor: Color(0xFF006BB6),
      secondaryColor: Color(0xFFED174C),
    ),
    '24': NbaTeamTheme(
      teamId: '24',
      teamName: 'Phoenix Suns',
      primaryColor: Color(0xFF1D1160),
      secondaryColor: Color(0xFFE56020),
    ),
    '25': NbaTeamTheme(
      teamId: '25',
      teamName: 'Portland Trail Blazers',
      primaryColor: Color(0xFFE03A3E),
      secondaryColor: Color(0xFF000000),
    ),
    '26': NbaTeamTheme(
      teamId: '26',
      teamName: 'Sacramento Kings',
      primaryColor: Color(0xFF5A2D81),
      secondaryColor: Color(0xFF63727A),
    ),
    '27': NbaTeamTheme(
      teamId: '27',
      teamName: 'San Antonio Spurs',
      primaryColor: Color(0xFFC4CED4),
      secondaryColor: Color(0xFF000000),
    ),
    '28': NbaTeamTheme(
      teamId: '28',
      teamName: 'Toronto Raptors',
      primaryColor: Color(0xFFCE1141),
      secondaryColor: Color(0xFF000000),
    ),
    '29': NbaTeamTheme(
      teamId: '29',
      teamName: 'Utah Jazz',
      primaryColor: Color(0xFF002B5C),
      secondaryColor: Color(0xFF00471B),
    ),
    '30': NbaTeamTheme(
      teamId: '30',
      teamName: 'Washington Wizards',
      primaryColor: Color(0xFF002B5C),
      secondaryColor: Color(0xFFE31837),
    ),
  };

  // Tema padrão NBA (sem equipa favorita)
  static const NbaTeamTheme defaultTheme = NbaTeamTheme(
    teamId: '0',
    teamName: 'NBA',
    primaryColor: Color(0xFF17408B),
    secondaryColor: Color(0xFFC9082A),
  );

  // Obter tema por ID da equipa
  static NbaTeamTheme getTheme(String? teamId) {
    if (teamId == null) return defaultTheme;
    return teamThemes[teamId] ?? defaultTheme;
  }

  // Gerar ThemeData completo para a app
  static ThemeData buildTheme(NbaTeamTheme teamTheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.dark(
        primary: teamTheme.primaryColor,
        secondary: teamTheme.secondaryColor,
        tertiary: const Color(0xFFFFC72C),
        surface: const Color(0xFF121212),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: teamTheme.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: teamTheme.primaryColor,
        indicatorColor: teamTheme.secondaryColor,
      ),
      scaffoldBackgroundColor: const Color(0xFF0A0A0A),
    );
  }
}

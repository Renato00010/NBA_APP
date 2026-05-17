class Standing {
  final int teamId;
  final String teamName;
  final String abbreviation;
  final String conference;
  final int wins;
  final int losses;
  final double winPercentage;
  final double gamesBack;
  final String streak;
  final String last10;
  final String conferenceRecord;
  final String homeRecord;
  final String roadRecord;

  Standing({
    required this.teamId,
    required this.teamName,
    required this.abbreviation,
    required this.conference,
    required this.wins,
    required this.losses,
    required this.winPercentage,
    required this.gamesBack,
    required this.streak,
    required this.last10,
    required this.conferenceRecord,
    required this.homeRecord,
    required this.roadRecord,
  });

  factory Standing.fromEspnEntry(
    Map<String, dynamic> entry,
    String conference,
  ) {
    final team = entry['team'] as Map<String, dynamic>;
    final stats = entry['stats'] as List<dynamic>? ?? [];

    double statNum(String name) {
      for (final s in stats) {
        if (s['name'] == name) {
          final v = s['value'];
          if (v is num) return v.toDouble();
          return double.tryParse(v.toString()) ?? 0;
        }
      }
      return 0;
    }

    String statStr(String name) {
      for (final s in stats) {
        if (s['name'] == name) {
          return s['displayValue']?.toString() ?? '-';
        }
      }
      return '-';
    }

    final wins = statNum('wins').toInt();
    final losses = statNum('losses').toInt();
    final winPct = statNum('winPercent');
    final normalizedConference = conference.toLowerCase().contains('west')
        ? 'West'
        : 'East';

    return Standing(
      teamId: int.tryParse(team['id']?.toString() ?? '') ?? 0,
      teamName: team['displayName'] as String? ?? team['name'] as String? ?? '',
      abbreviation: team['abbreviation'] as String? ?? '',
      conference: normalizedConference,
      wins: wins,
      losses: losses,
      winPercentage: winPct > 1 ? winPct / 100 : winPct,
      gamesBack: statNum('gamesBehind'),
      streak: statStr('streak'),
      last10: statStr('Last Ten Games'),
      conferenceRecord: statStr('vs. Conf.'),
      homeRecord: statStr('Home'),
      roadRecord: statStr('Road'),
    );
  }

  factory Standing.fromJson(Map<String, dynamic> json) {
    final team = json['team'] as Map<String, dynamic>;
    return Standing(
      teamId: team['id'] as int,
      teamName: team['full_name'] as String,
      abbreviation: team['abbreviation'] as String,
      conference: team['conference'] as String,
      wins: json['wins'] as int,
      losses: json['losses'] as int,
      winPercentage: double.tryParse(json['win_percentage'].toString()) ?? 0.0,
      gamesBack: double.tryParse(json['games_back'].toString()) ?? 0.0,
      streak: json['streak'] as String? ?? '-',
      last10: json['last_10'] as String? ?? '-',
      conferenceRecord: json['conference_record'] as String? ?? '-',
      homeRecord: json['home_record'] as String? ?? '-',
      roadRecord: json['road_record'] as String? ?? '-',
    );
  }
}

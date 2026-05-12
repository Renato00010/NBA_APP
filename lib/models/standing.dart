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

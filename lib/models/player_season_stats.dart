class PlayerSeasonStats {
  final String season;
  final double ppg;
  final double rpg;
  final double apg;
  final double per;
  final double tsPct;

  PlayerSeasonStats({
    required this.season,
    required this.ppg,
    required this.rpg,
    required this.apg,
    required this.per,
    required this.tsPct,
  });

  factory PlayerSeasonStats.fromMap(Map<String, dynamic> map) {
    return PlayerSeasonStats(
      season: map['season'] as String,
      ppg: (map['ppg'] as num).toDouble(),
      rpg: (map['rpg'] as num).toDouble(),
      apg: (map['apg'] as num).toDouble(),
      per: (map['per'] as num).toDouble(),
      tsPct: (map['tsPct'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() => {
        'season': season,
        'ppg': ppg,
        'rpg': rpg,
        'apg': apg,
        'per': per,
        'tsPct': tsPct,
      };
}

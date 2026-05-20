import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Medias estimadas (so para roster local sem dados BR/manual).
class FallbackPerGameLine {
  final double ppg;
  final double rpg;
  final double apg;
  final double spg;
  final double bpg;
  final double mpg;
  final double topg;
  final double fgPct;
  final double fg3Pct;
  final double ftPct;

  const FallbackPerGameLine({
    required this.ppg,
    required this.rpg,
    required this.apg,
    required this.spg,
    required this.bpg,
    required this.mpg,
    required this.topg,
    required this.fgPct,
    required this.fg3Pct,
    required this.ftPct,
  });
}

class PlayerStatsSeed {
  static Map<String, PlayerStatsProfile> _profiles = {};

  static Future<void> init() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/nba_players.json',
      );
      final Map<String, dynamic> jsonData = json.decode(jsonString);

      _profiles = jsonData.map((key, value) {
        return MapEntry(key, PlayerStatsProfile.fromJson(value));
      });
    } catch (e) {
      debugPrint('Erro ao carregar PlayerStatsSeed: $e');
    }
  }

  static PlayerStatsProfile? forName(String name) {
    return _profiles[_normalize(name)];
  }

  /// Cria um perfil completo estimado para jogadores sem seed manual.
  static PlayerStatsProfile estimatedProfileForRosterGap({
    required String fullName,
    String? position,
    String? teamName,
  }) {
    final perGame = estimatedPerGameForRosterGap(fullName, position);
    final seed = _stableSeed(fullName, position);
    int i(int min, int max, int salt) {
      final span = max - min + 1;
      return min + ((seed + salt * 7919) % span);
    }

    double d(double min, double max, int salt) {
      final base = ((seed + salt * 104729) % 10000) / 10000.0;
      return min + (max - min) * base;
    }

    final gp = i(60, 82, 1);
    final gs = (gp - i(0, 8, 2)).clamp(0, 82);
    final expYears = i(1, 12, 3);
    final careerGames = i(82, 82 * expYears, 4);
    final starts = (careerGames - i(0, (careerGames * 0.25).round(), 5)).clamp(
      0,
      careerGames,
    );
    final orb = d(0.3, 2.8, 6);
    final drb = (perGame.rpg - orb).clamp(0.8, 12.0);
    final pf = d(1.4, 3.3, 7);
    final tsPct = ((perGame.fgPct + perGame.ftPct * 0.35) / 1.35).clamp(
      48.0,
      68.0,
    );
    final per =
        (10.0 + perGame.ppg * 0.45 + perGame.apg * 0.25 + perGame.rpg * 0.2)
            .clamp(10.0, 31.0);
    final usg = (18.0 + perGame.ppg * 0.55 + perGame.topg * 0.9).clamp(
      16.0,
      37.0,
    );
    final impact = ((per - 15) / 2.2).clamp(-2.5, 11.5);
    final offRtg = (102.0 + perGame.ppg * 0.7 + perGame.apg * 0.45).clamp(
      103.0,
      127.0,
    );
    final defRtg = (121.0 - perGame.spg * 2.1 - perGame.bpg * 1.8).clamp(
      105.0,
      122.0,
    );

    int pointsTotal() => (perGame.ppg * careerGames).round();
    int reboundsTotal() => (perGame.rpg * careerGames).round();
    int assistsTotal() => (perGame.apg * careerGames).round();
    int stealsTotal() => (perGame.spg * careerGames).round();
    int blocksTotal() => (perGame.bpg * careerGames).round();
    int turnoversTotal() => (perGame.topg * careerGames).round();

    final current = SeasonStats(
      season: '2024-25',
      team: teamName ?? 'NBA',
      gp: gp,
      gs: gs,
      mpg: perGame.mpg,
      ppg: perGame.ppg,
      rpg: perGame.rpg,
      apg: perGame.apg,
      spg: perGame.spg,
      bpg: perGame.bpg,
      topg: perGame.topg,
      fgPct: perGame.fgPct,
      fg3Pct: perGame.fg3Pct,
      ftPct: perGame.ftPct,
      per: per,
      tsPct: tsPct,
      usgPct: usg,
      impactMetric: impact,
      impactMetricLabel: 'BPM',
      offensiveRating: offRtg,
      defensiveRating: defRtg,
      orb: orb,
      drb: drb,
      pf: pf,
    );

    final historicalSeasons = <SeasonStats>[];
    final numHistorical = i(
      2,
      9,
      8,
    ); // Entre 3 e 10 anos de carreira (contando a atual)

    final possibleTeams = [
      'LAL',
      'BOS',
      'GSW',
      'CHI',
      'MIA',
      'MIL',
      'PHX',
      'DEN',
      'PHI',
      'BKN',
      'DAL',
      'LAC',
      'ATL',
      'TOR',
      'MEM',
      'NYK',
      'CLE',
      'UTA',
      'POR',
      'SAC',
    ];

    var lastTeam = teamName ?? 'NBA';

    for (var yearOffset = 1; yearOffset <= numHistorical; yearOffset++) {
      final yearStart = 2024 - yearOffset;
      final yearEnd = (yearStart + 1) % 100;
      final seasonStr = '$yearStart-${yearEnd.toString().padLeft(2, '0')}';

      // 20% de chance de ter mudado de time no passado
      if (i(1, 100, 100 + yearOffset) < 20) {
        lastTeam =
            possibleTeams[i(0, possibleTeams.length - 1, 200 + yearOffset)];
      }

      historicalSeasons.add(
        SeasonStats(
          season: seasonStr,
          team: lastTeam,
          gp: (gp - i(0, 15, 8 + yearOffset)).clamp(30, 82),
          gs: (gs - i(0, 20, 9 + yearOffset)).clamp(0, 82),
          mpg: (perGame.mpg - d(-2.0, 4.0, 10 + yearOffset)).clamp(10.0, 40.0),
          ppg: (perGame.ppg - d(-3.0, 5.0, 11 + yearOffset)).clamp(2.0, 38.0),
          rpg: (perGame.rpg - d(-1.0, 2.0, 12 + yearOffset)).clamp(0.5, 16.0),
          apg: (perGame.apg - d(-1.0, 2.0, 13 + yearOffset)).clamp(0.2, 13.0),
          spg: (perGame.spg - d(-0.2, 0.5, 14 + yearOffset)).clamp(0.1, 3.2),
          bpg: (perGame.bpg - d(-0.2, 0.5, 15 + yearOffset)).clamp(0.0, 4.0),
          topg: (perGame.topg - d(-0.5, 0.8, 16 + yearOffset)).clamp(0.4, 5.8),
          fgPct: (perGame.fgPct - d(-2.0, 3.0, 17 + yearOffset)).clamp(
            34.0,
            68.0,
          ),
          fg3Pct: (perGame.fg3Pct - d(-3.0, 5.0, 18 + yearOffset)).clamp(
            20.0,
            52.0,
          ),
          ftPct: (perGame.ftPct - d(-2.0, 4.0, 19 + yearOffset)).clamp(
            50.0,
            98.0,
          ),
          per: (per - d(-1.0, 3.0, 20 + yearOffset)).clamp(6.0, 32.0),
          tsPct: (tsPct - d(-1.0, 3.0, 21 + yearOffset)).clamp(40.0, 72.0),
          usgPct: (usg - d(-2.0, 4.0, 22 + yearOffset)).clamp(12.0, 40.0),
          impactMetric: (impact - d(-0.5, 1.5, 23 + yearOffset)).clamp(
            -6.0,
            13.0,
          ),
          impactMetricLabel: 'BPM',
          offensiveRating: (offRtg - d(-2.0, 5.0, 24 + yearOffset)).clamp(
            90.0,
            130.0,
          ),
          defensiveRating: (defRtg + d(-2.0, 3.0, 25 + yearOffset)).clamp(
            100.0,
            126.0,
          ),
          orb: (orb - d(-0.1, 0.5, 26 + yearOffset)).clamp(0.1, 5.0),
          drb: (drb - d(-0.2, 1.0, 27 + yearOffset)).clamp(0.4, 14.0),
          pf: (pf + d(-0.5, 0.6, 28 + yearOffset)).clamp(0.8, 4.5),
        ),
      );
    }

    return PlayerStatsProfile(
      currentSeason: current,
      seasons: historicalSeasons,
      career: CareerTotals(
        games: careerGames,
        starts: starts,
        points: pointsTotal(),
        rebounds: reboundsTotal(),
        assists: assistsTotal(),
        steals: stealsTotal(),
        blocks: blocksTotal(),
        turnovers: turnoversTotal(),
      ),
      careerHighs: CareerHighs(
        points: (perGame.ppg * 1.9).round().clamp(15, 75),
        rebounds: (perGame.rpg * 2.0).round().clamp(7, 30),
        assists: (perGame.apg * 2.2).round().clamp(6, 25),
        steals: (perGame.spg * 3.0).round().clamp(2, 10),
        blocks: (perGame.bpg * 3.2).round().clamp(1, 11),
      ),
      recentGames: [
        GameLog(
          opponent: 'BOS',
          result: i(0, 1, 29) == 0 ? 'W' : 'L',
          minutes: (perGame.mpg + d(-3.5, 2.8, 30)).round().clamp(12, 44),
          pts: (perGame.ppg + d(-6.0, 7.0, 31)).round().clamp(2, 62),
          reb: (perGame.rpg + d(-2.4, 3.1, 32)).round().clamp(0, 24),
          ast: (perGame.apg + d(-2.8, 3.3, 33)).round().clamp(0, 20),
          stl: (perGame.spg + d(-0.8, 1.3, 34)).round().clamp(0, 7),
          blk: (perGame.bpg + d(-0.7, 1.4, 35)).round().clamp(0, 8),
          tov: (perGame.topg + d(-1.2, 1.6, 36)).round().clamp(0, 9),
        ),
        GameLog(
          opponent: 'DEN',
          result: i(0, 1, 37) == 0 ? 'W' : 'L',
          minutes: (perGame.mpg + d(-3.2, 2.5, 38)).round().clamp(12, 44),
          pts: (perGame.ppg + d(-5.8, 6.8, 39)).round().clamp(2, 62),
          reb: (perGame.rpg + d(-2.2, 2.8, 40)).round().clamp(0, 24),
          ast: (perGame.apg + d(-2.6, 3.0, 41)).round().clamp(0, 20),
          stl: (perGame.spg + d(-0.8, 1.2, 42)).round().clamp(0, 7),
          blk: (perGame.bpg + d(-0.7, 1.3, 43)).round().clamp(0, 8),
          tov: (perGame.topg + d(-1.1, 1.5, 44)).round().clamp(0, 9),
        ),
        GameLog(
          opponent: 'MIL',
          result: i(0, 1, 45) == 0 ? 'W' : 'L',
          minutes: (perGame.mpg + d(-3.0, 2.3, 46)).round().clamp(12, 44),
          pts: (perGame.ppg + d(-5.5, 6.5, 47)).round().clamp(2, 62),
          reb: (perGame.rpg + d(-2.0, 2.7, 48)).round().clamp(0, 24),
          ast: (perGame.apg + d(-2.4, 2.8, 49)).round().clamp(0, 20),
          stl: (perGame.spg + d(-0.7, 1.1, 50)).round().clamp(0, 7),
          blk: (perGame.bpg + d(-0.6, 1.2, 51)).round().clamp(0, 8),
          tov: (perGame.topg + d(-1.0, 1.4, 52)).round().clamp(0, 9),
        ),
      ],
      awards: const [AwardItem('Sem premios manuais cadastrados')],
      health: const HealthStatus(
        status: 'Ativo',
        injuryDescription: '-',
        expectedReturn: '-',
      ),
    );
  }

  /// Valores plausiveis e estaveis por nome+posicao quando nao ha fonte real.
  static FallbackPerGameLine estimatedPerGameForRosterGap(
    String fullName,
    String? position,
  ) {
    var seed = fullName.hashCode ^ (position ?? 'F').hashCode * 0x9e3779b9;
    if (seed < 0) seed = -seed;
    double u(int salt) {
      seed = (seed * 1103515245 + salt + fullName.length) & 0x7fffffff;
      return seed / 0x7fffffff;
    }

    double range(int salt, double lo, double hi) => lo + u(salt) * (hi - lo);

    double r1(double x) => (x * 10).round() / 10.0;

    final p = (position ?? 'F').toUpperCase().trim();
    late double ppgv;
    late double rpgv;
    late double apgv;
    late double spgv;
    late double bpgv;

    if (p.contains('PG')) {
      ppgv = range(1, 10.5, 26.5);
      rpgv = range(2, 3.0, 7.0);
      apgv = range(3, 4.0, 11.0);
      spgv = range(4, 0.5, 2.0);
      bpgv = range(5, 0.0, 0.6);
    } else if (p.contains('SG')) {
      ppgv = range(1, 9.0, 28.0);
      rpgv = range(2, 2.5, 6.5);
      apgv = range(3, 2.0, 7.5);
      spgv = range(4, 0.5, 1.8);
      bpgv = range(5, 0.1, 0.9);
    } else if (p.contains('SF')) {
      ppgv = range(1, 8.0, 26.0);
      rpgv = range(2, 3.5, 8.5);
      apgv = range(3, 1.5, 6.0);
      spgv = range(4, 0.6, 1.7);
      bpgv = range(5, 0.2, 1.2);
    } else if (p.contains('PF')) {
      ppgv = range(1, 7.0, 24.0);
      rpgv = range(2, 4.5, 11.5);
      apgv = range(3, 1.0, 5.0);
      spgv = range(4, 0.4, 1.4);
      bpgv = range(5, 0.3, 1.8);
    } else if (p == 'C') {
      ppgv = range(1, 6.0, 22.0);
      rpgv = range(2, 5.5, 13.5);
      apgv = range(3, 0.8, 4.5);
      spgv = range(4, 0.3, 1.2);
      bpgv = range(5, 0.5, 3.2);
    } else if (p == 'G') {
      ppgv = range(1, 8.0, 22.0);
      rpgv = range(2, 2.5, 5.5);
      apgv = range(3, 2.5, 8.0);
      spgv = range(4, 0.5, 1.6);
      bpgv = range(5, 0.0, 0.7);
    } else if (p == 'F') {
      ppgv = range(1, 7.0, 22.0);
      rpgv = range(2, 3.5, 9.5);
      apgv = range(3, 1.2, 5.5);
      spgv = range(4, 0.5, 1.5);
      bpgv = range(5, 0.2, 1.5);
    } else {
      ppgv = range(1, 7.0, 20.0);
      rpgv = range(2, 3.0, 8.0);
      apgv = range(3, 1.5, 6.0);
      spgv = range(4, 0.5, 1.5);
      bpgv = range(5, 0.1, 1.2);
    }

    final mpgv = range(20, 14.0, 36.0);
    final topgv = range(21, 1.2, 4.5);
    final fgp = range(22, 41.0, 51.0);
    final fg3p = range(23, 30.0, 42.0);
    final ftp = range(24, 68.0, 90.0);

    return FallbackPerGameLine(
      ppg: r1(ppgv),
      rpg: r1(rpgv),
      apg: r1(apgv),
      spg: r1(spgv),
      bpg: r1(bpgv),
      mpg: r1(mpgv),
      topg: r1(topgv),
      fgPct: r1(fgp),
      fg3Pct: r1(fg3p),
      ftPct: r1(ftp),
    );
  }

  static String _normalize(String value) {
    var str = value.toLowerCase();
    // Mapa simples para remover acentos comuns
    const accents = {
      'á': 'a',
      'à': 'a',
      'ã': 'a',
      'â': 'a',
      'é': 'e',
      'ê': 'e',
      'í': 'i',
      'ó': 'o',
      'ô': 'o',
      'õ': 'o',
      'ú': 'u',
      'ç': 'c',
      'ć': 'c',
      'č': 'c',
      'š': 's',
      'ž': 'z',
      'đ': 'd',
      'ý': 'y',
    };
    accents.forEach((key, val) => str = str.replaceAll(key, val));

    return str
        .replaceAll(RegExp(r'[^a-z0-9]+'), '_')
        .replaceAll(RegExp(r'_+'), '_')
        .trim()
        .replaceAll(RegExp(r'^_+|_+$'), '');
  }

  static int _stableSeed(String fullName, String? position) {
    final normalized = _normalize(fullName);
    var hash = 5381;
    for (final unit in normalized.codeUnits) {
      hash = ((hash << 5) + hash) ^ unit;
      hash &= 0x7fffffff;
    }
    final pos = (position ?? 'F').toUpperCase().trim();
    for (final unit in pos.codeUnits) {
      hash = ((hash << 5) + hash) ^ unit;
      hash &= 0x7fffffff;
    }
    return hash;
  }
}

class PlayerStatsProfile {
  final SeasonStats currentSeason;
  final List<SeasonStats> seasons;
  final CareerTotals career;
  final CareerHighs careerHighs;
  final List<GameLog> recentGames;
  final List<AwardItem> awards;
  final HealthStatus health;

  const PlayerStatsProfile({
    required this.currentSeason,
    required this.seasons,
    required this.career,
    required this.careerHighs,
    required this.recentGames,
    required this.awards,
    required this.health,
  });

  factory PlayerStatsProfile.fromJson(Map<String, dynamic> json) {
    return PlayerStatsProfile(
      currentSeason: SeasonStats.fromJson(json['currentSeason']),
      seasons: (json['seasons'] as List)
          .map((s) => SeasonStats.fromJson(s))
          .toList(),
      career: CareerTotals.fromJson(json['career']),
      careerHighs: CareerHighs.fromJson(json['careerHighs']),
      recentGames: [],
      awards: (json['awards'] as List)
          .map((a) => AwardItem(a.toString()))
          .toList(),
      health: HealthStatus.fromJson(json['health']),
    );
  }
}

class SeasonStats {
  final String season;
  final String team;
  final int gp;
  final int gs;
  final double mpg;
  final double ppg;
  final double rpg;
  final double apg;
  final double spg;
  final double bpg;
  final double topg;
  final double fgPct;
  final double fg3Pct;
  final double ftPct;
  final double per;
  final double tsPct;
  final double usgPct;
  final double impactMetric;
  final String impactMetricLabel;
  final double offensiveRating;
  final double defensiveRating;
  final double orb;
  final double drb;
  final double pf;

  const SeasonStats({
    required this.season,
    required this.team,
    required this.gp,
    required this.gs,
    required this.mpg,
    required this.ppg,
    required this.rpg,
    required this.apg,
    required this.spg,
    required this.bpg,
    required this.topg,
    required this.fgPct,
    required this.fg3Pct,
    required this.ftPct,
    required this.per,
    required this.tsPct,
    required this.usgPct,
    required this.impactMetric,
    required this.impactMetricLabel,
    required this.offensiveRating,
    required this.defensiveRating,
    this.orb = 0,
    this.drb = 0,
    this.pf = 0,
  });

  factory SeasonStats.fromJson(Map<String, dynamic> json) {
    final ppg = (json['ppg'] ?? 0).toDouble();
    final rpg = (json['rpg'] ?? 0).toDouble();
    // Se orb/drb nao existirem, estima-se com base no total de ressaltos
    final orb = (json['orb'] ?? (rpg * 0.25)).toDouble();
    final drb = (json['drb'] ?? (rpg * 0.75)).toDouble();
    final pf = (json['pf'] ?? 2.1).toDouble();

    return SeasonStats(
      season: json['season'] ?? '',
      team: json['team'] ?? '',
      gp: json['gp'] ?? 0,
      gs: json['gs'] ?? 0,
      mpg: (json['mpg'] ?? 0).toDouble(),
      ppg: ppg,
      rpg: rpg,
      apg: (json['apg'] ?? 0).toDouble(),
      spg: (json['spg'] ?? 0).toDouble(),
      bpg: (json['bpg'] ?? 0).toDouble(),
      topg: (json['topg'] ?? 0).toDouble(),
      fgPct: (json['fgPct'] ?? 0).toDouble(),
      fg3Pct: (json['fg3Pct'] ?? 0).toDouble(),
      ftPct: (json['ftPct'] ?? 0).toDouble(),
      per: (json['per'] ?? 0).toDouble(),
      tsPct: (json['tsPct'] ?? 0).toDouble(),
      usgPct: (json['usgPct'] ?? 0).toDouble(),
      impactMetric: (json['impactMetric'] ?? 0).toDouble(),
      impactMetricLabel: json['impactMetricLabel'] ?? 'BPM',
      offensiveRating: (json['offensiveRating'] ?? 0).toDouble(),
      defensiveRating: (json['defensiveRating'] ?? 0).toDouble(),
      orb: orb,
      drb: drb,
      pf: pf,
    );
  }
}

class CareerTotals {
  final int games;
  final int starts;
  final int points;
  final int rebounds;
  final int assists;
  final int steals;
  final int blocks;
  final int turnovers;

  const CareerTotals({
    required this.games,
    required this.starts,
    required this.points,
    required this.rebounds,
    required this.assists,
    required this.steals,
    required this.blocks,
    required this.turnovers,
  });

  factory CareerTotals.fromJson(Map<String, dynamic> json) {
    return CareerTotals(
      games: json['games'] ?? 0,
      starts: json['starts'] ?? 0,
      points: json['points'] ?? 0,
      rebounds: json['rebounds'] ?? 0,
      assists: json['assists'] ?? 0,
      steals: json['steals'] ?? 0,
      blocks: json['blocks'] ?? 0,
      turnovers: json['turnovers'] ?? 0,
    );
  }
}

class CareerHighs {
  final int points;
  final int rebounds;
  final int assists;
  final int steals;
  final int blocks;

  const CareerHighs({
    required this.points,
    required this.rebounds,
    required this.assists,
    required this.steals,
    required this.blocks,
  });

  factory CareerHighs.fromJson(Map<String, dynamic> json) {
    return CareerHighs(
      points: json['points'] ?? 0,
      rebounds: json['rebounds'] ?? 0,
      assists: json['assists'] ?? 0,
      steals: json['steals'] ?? 0,
      blocks: json['blocks'] ?? 0,
    );
  }
}

class GameLog {
  final String opponent;
  final String result;
  final int minutes;
  final int pts;
  final int reb;
  final int ast;
  final int stl;
  final int blk;
  final int tov;

  const GameLog({
    required this.opponent,
    required this.result,
    required this.minutes,
    required this.pts,
    required this.reb,
    required this.ast,
    required this.stl,
    required this.blk,
    required this.tov,
  });
}

class AwardItem {
  final String label;

  const AwardItem(this.label);
}

class HealthStatus {
  final String status;
  final String injuryDescription;
  final String expectedReturn;

  const HealthStatus({
    required this.status,
    required this.injuryDescription,
    required this.expectedReturn,
  });

  factory HealthStatus.fromJson(Map<String, dynamic> json) {
    return HealthStatus(
      status: json['status'] ?? '',
      injuryDescription: json['injuryDescription'] ?? '',
      expectedReturn: json['expectedReturn'] ?? '',
    );
  }
}

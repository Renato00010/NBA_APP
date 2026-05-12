import 'package:dio/dio.dart';

import 'player_stats_seed.dart';

class BasketballReferenceService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://www.basketball-reference.com',
      connectTimeout: const Duration(seconds: 8),
      receiveTimeout: const Duration(seconds: 8),
      headers: const {
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
      },
    ),
  );

  final Map<String, PlayerStatsProfile?> _cache = {};
  final Map<String, String?> _slugCache = {};
  final Map<String, List<_IndexEntry>> _letterIndexCache = {};

  Future<PlayerStatsProfile?> getPlayerProfile(String fullName) async {
    final key = _normalize(fullName);
    if (_cache.containsKey(key)) return _cache[key];
    final slugs = <String>{};
    final indexedSlug = await _resolveSlugFromIndex(fullName);
    if (indexedSlug != null) slugs.add(indexedSlug);
    slugs.addAll(_slugCandidates(fullName));

    for (final slug in slugs) {
      try {
        final letter = slug[0];
        // Busca perfil e logs em paralelo para performance
        final responses = await Future.wait([
          _dio.get<String>('/players/$letter/$slug.html'),
          _dio.get<String>('/players/$letter/$slug/gamelog/2025/'),
        ]).catchError((e) async {
          // Se falhar o log de 2025, tenta apenas o perfil
          final r = await _dio.get<String>('/players/$letter/$slug.html');
          return <Response<String>>[r, Response<String>(requestOptions: RequestOptions(), data: '')];
        });

        final html = responses[0].data;
        final logsHtml = responses[1].data;

        if (html == null || !html.contains('id="per_game"')) continue;

        final profile = _parseProfile(html, logsHtml);
        if (profile != null) {
          _cache[key] = profile;
          return profile;
        }
      } catch (_) {
        continue;
      }
    }

    _cache[key] = null;
    return null;
  }

  PlayerStatsProfile? _parseProfile(String html, String? logsHtml) {
    final perGameRows = _parseTableRows(html, 'per_game');
    if (perGameRows.isEmpty) return null;

    final advancedRows = _parseTableRows(html, 'advanced');
    final totalsRows = _parseTableRows(html, 'totals');

    final advancedBySeason = {
      for (final row in advancedRows)
        if ((row['season'] ?? '').isNotEmpty) row['season']!: row,
    };

    final seasons = <SeasonStats>[];
    for (final row in perGameRows) {
      final season = row['season'] ?? '';
      if (season.isEmpty || season == 'Career') continue;
      final advanced = advancedBySeason[season] ?? const <String, String>{};
      seasons.add(
        SeasonStats(
          season: season,
          team: row['team_id'] ?? '-',
          gp: _int(row['g']),
          gs: _int(row['gs']),
          mpg: _double(row['mp_per_g']),
          ppg: _double(row['pts_per_g']),
          rpg: _double(row['trb_per_g']),
          apg: _double(row['ast_per_g']),
          spg: _double(row['stl_per_g']),
          bpg: _double(row['blk_per_g']),
          topg: _double(row['tov_per_g']),
          fgPct: _percent(row['fg_pct']),
          fg3Pct: _percent(row['fg3_pct']),
          ftPct: _percent(row['ft_pct']),
          per: _double(advanced['per']),
          tsPct: _percent(advanced['ts_pct']),
          usgPct: _percent(advanced['usg_pct']),
          impactMetric: _double(advanced['bpm']),
          impactMetricLabel: 'BPM',
          offensiveRating: _double(advanced['off_rtg']),
          defensiveRating: _double(advanced['def_rtg']),
          orb: _double(row['orb_per_g']),
          drb: _double(row['drb_per_g']),
          pf: _double(row['pf_per_g']),
        ),
      );
    }

    if (seasons.isEmpty) return null;

    final totalCareer = totalsRows.firstWhere(
      (row) => row['season'] == 'Career',
      orElse: () => const <String, String>{},
    );
    final perGameCareer = perGameRows.firstWhere(
      (row) => row['season'] == 'Career',
      orElse: () => const <String, String>{},
    );
    final latestSeasonKey = seasons
        .map((s) => s.season)
        .reduce((a, b) => a.compareTo(b) >= 0 ? a : b);
    final latest = seasons.firstWhere(
      (s) => s.season == latestSeasonKey && s.team == 'TOT',
      orElse: () => seasons.firstWhere(
        (s) => s.season == latestSeasonKey,
        orElse: () => seasons.first,
      ),
    );

    return PlayerStatsProfile(
      currentSeason: latest,
      seasons: seasons,
      career: CareerTotals(
        games: _int(totalCareer['g'] ?? perGameCareer['g']),
        starts: _int(totalCareer['gs'] ?? perGameCareer['gs']),
        points: _int(totalCareer['pts']),
        rebounds: _int(totalCareer['trb']),
        assists: _int(totalCareer['ast']),
        steals: _int(totalCareer['stl']),
        blocks: _int(totalCareer['blk']),
        turnovers: _int(totalCareer['tov']),
      ),
      careerHighs: _parseCareerHighs(html),
      recentGames: _parseRecentGames(logsHtml ?? html),
      awards: _awardItems(perGameRows),
      health: const HealthStatus(
        status: 'Ativo',
        injuryDescription: '-',
        expectedReturn: '-',
      ),
    );
  }

  List<GameLog> _parseRecentGames(String html) {
    // Tenta primeiro a tabela de gamelog (mais completa)
    var rows = _parseTableRows(html, 'pgl_basic');
    if (rows.isEmpty) {
      // Fallback para last5 na pagina principal
      rows = _parseTableRows(html, 'last5');
    }

    final logs = <GameLog>[];
    // Pega os ultimos 10 jogos (as linhas estao em ordem cronologica, pegamos as ultimas)
    final recentRows = rows.length > 10 ? rows.sublist(rows.length - 10) : rows;

    for (final row in recentRows.reversed) {
      final opp = row['opp_id'] ?? '';
      final res = row['game_result'] ?? '';

      logs.add(
        GameLog(
          opponent: opp,
          result: res.contains('W') ? 'W' : 'L',
          minutes: _int(row['mp']),
          pts: _int(row['pts']),
          reb: _int(row['trb']),
          ast: _int(row['ast']),
          stl: _int(row['stl']),
          blk: _int(row['blk']),
          tov: _int(row['tov']),
        ),
      );
    }
    return logs;
  }

  List<Map<String, String>> _parseTableRows(String html, String tableId) {
    final tableMatch = RegExp(
      '<table[^>]*id="$tableId"[\\s\\S]*?</table>',
    ).firstMatch(html);
    if (tableMatch == null) return const [];

    final table = tableMatch.group(0)!;
    final rowMatches = RegExp('<tr[\\s\\S]*?</tr>').allMatches(table);
    final rows = <Map<String, String>>[];

    for (final rowMatch in rowMatches) {
      final rowHtml = rowMatch.group(0)!;
      if (rowHtml.contains('class="thead"')) continue;
      final cells = RegExp(
        '<(?:th|td)[^>]*data-stat="([^"]+)"[^>]*>([\\s\\S]*?)</(?:th|td)>',
      ).allMatches(rowHtml);
      final row = <String, String>{};
      for (final cell in cells) {
        row[cell.group(1)!] = _clean(cell.group(2)!);
      }
      // Aceita linhas se tiverem temporada (stats anuais) ou data (gamelog)
      if ((row['season'] ?? '').isNotEmpty || (row['date_game'] ?? '').isNotEmpty) {
        rows.add(row);
      }
    }
    return rows;
  }

  CareerHighs _parseCareerHighs(String html) {
    final tableMatch = RegExp(
      '<table[^>]*id="highs"[\\s\\S]*?</table>',
    ).firstMatch(html);
    if (tableMatch == null) {
      return const CareerHighs(
        points: 0,
        rebounds: 0,
        assists: 0,
        steals: 0,
        blocks: 0,
      );
    }
    final table = tableMatch.group(0)!;
    final rowMatches = RegExp('<tr[\\s\\S]*?</tr>').allMatches(table);
    for (final rowMatch in rowMatches) {
      final rowHtml = rowMatch.group(0)!;
      if (rowHtml.contains('class="thead"')) continue;
      final cells = RegExp(
        '<(?:th|td)[^>]*data-stat="([^"]+)"[^>]*>([\\s\\S]*?)</(?:th|td)>',
      ).allMatches(rowHtml);
      final row = <String, String>{};
      for (final cell in cells) {
        row[cell.group(1)!] = _clean(cell.group(2)!);
      }
      if (row.isEmpty) continue;
      return CareerHighs(
        points: _int(row['pts']),
        rebounds: _int(row['trb']),
        assists: _int(row['ast']),
        steals: _int(row['stl']),
        blocks: _int(row['blk']),
      );
    }
    return const CareerHighs(
      points: 0,
      rebounds: 0,
      assists: 0,
      steals: 0,
      blocks: 0,
    );
  }

  List<AwardItem> _awardItems(List<Map<String, String>> rows) {
    final awards = <String>{};
    for (final row in rows) {
      final value = row['award_summary'];
      if (value == null || value.isEmpty) continue;
      for (final award in value.split(',')) {
        final trimmed = award.trim();
        if (trimmed.isNotEmpty) awards.add(trimmed);
      }
    }
    return awards.map(AwardItem.new).toList();
  }

  Iterable<String> _slugCandidates(String fullName) sync* {
    final parts = _nameParts(fullName);
    if (parts.length < 2) return;
    final first = parts.first;
    final last = parts.last;
    final lastPart = last.length >= 5 ? last.substring(0, 5) : last;
    final firstPart = first.length >= 2 ? first.substring(0, 2) : first;
    for (var i = 1; i <= 12; i++) {
      yield '$lastPart$firstPart${i.toString().padLeft(2, '0')}';
    }
  }

  Future<String?> _resolveSlugFromIndex(String fullName) async {
    final key = _normalize(fullName);
    if (_slugCache.containsKey(key)) return _slugCache[key];

    final parts = _nameParts(fullName);
    if (parts.length < 2) {
      _slugCache[key] = null;
      return null;
    }
    final letter = parts.last[0];
    final entries = await _loadLetterIndex(letter);
    if (entries.isEmpty) {
      _slugCache[key] = null;
      return null;
    }

    for (final entry in entries) {
      if (entry.normalizedName == key) {
        _slugCache[key] = entry.slug;
        return entry.slug;
      }
    }

    // Fallback por aproximacao para casos de nomes com sufixo/variante.
    for (final entry in entries) {
      if (entry.normalizedName.contains(key) || key.contains(entry.normalizedName)) {
        _slugCache[key] = entry.slug;
        return entry.slug;
      }
    }

    _slugCache[key] = null;
    return null;
  }

  Future<List<_IndexEntry>> _loadLetterIndex(String letter) async {
    final normalizedLetter = letter.toLowerCase();
    if (_letterIndexCache.containsKey(normalizedLetter)) {
      return _letterIndexCache[normalizedLetter]!;
    }
    try {
      final response = await _dio.get<String>('/players/$normalizedLetter/');
      final html = response.data ?? '';
      final entries = <_IndexEntry>[];
      final linkRe = RegExp(
        r'<th[^>]*data-stat="player"[^>]*>[\s\S]*?<a href="/players/[a-z]/([a-z0-9]{9})\.html">([\s\S]*?)</a>',
      );
      for (final m in linkRe.allMatches(html)) {
        final slug = m.group(1);
        final name = _clean(m.group(2) ?? '');
        if (slug == null || name.isEmpty) continue;
        entries.add(_IndexEntry(slug: slug, normalizedName: _normalize(name)));
      }
      _letterIndexCache[normalizedLetter] = entries;
      return entries;
    } catch (_) {
      _letterIndexCache[normalizedLetter] = const [];
      return const [];
    }
  }

  List<String> _nameParts(String fullName) {
    const suffixes = {'jr', 'sr', 'ii', 'iii', 'iv'};
    final normalized = _normalize(fullName)
        .split(' ')
        .where((part) => part.isNotEmpty && !suffixes.contains(part))
        .toList();
    return normalized;
  }

  String _normalize(String value) {
    const replacements = {
      'á': 'a',
      'à': 'a',
      'â': 'a',
      'ã': 'a',
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
      'ž': 'z',
      'š': 's',
      'ñ': 'n',
    };
    var text = value.toLowerCase();
    replacements.forEach((from, to) => text = text.replaceAll(from, to));
    return text
        .replaceAll(RegExp(r'[^a-z0-9]+'), ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  String _clean(String html) {
    return html
        .replaceAll(RegExp(r'<[^>]+>'), '')
        .replaceAll('&nbsp;', ' ')
        .replaceAll('&amp;', '&')
        .replaceAll('&#x2a;', '')
        .trim();
  }

  int _int(String? value) =>
      int.tryParse((value ?? '').replaceAll(',', '')) ?? 0;

  double _double(String? value) => double.tryParse(value ?? '') ?? 0;

  double _percent(String? value) {
    final parsed = _double(value);
    if (parsed <= 1) return parsed * 100;
    return parsed;
  }
}

class _IndexEntry {
  final String slug;
  final String normalizedName;

  const _IndexEntry({required this.slug, required this.normalizedName});
}

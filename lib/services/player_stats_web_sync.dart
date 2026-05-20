import 'package:connectivity_plus/connectivity_plus.dart';

import '../db/app_database.dart';
import 'basketball_reference_service.dart';

/// Sincroniza medias na BD a partir de sites (Basketball-Reference.com, HTML).
class PlayerStatsWebSync {
  PlayerStatsWebSync(
    this._playersDao, {
    BasketballReferenceService? basketballReference,
  }) : _br = basketballReference ?? BasketballReferenceService();

  final PlayersDao _playersDao;
  final BasketballReferenceService _br;

  Future<bool> _hasInternet() async {
    final results = await Connectivity().checkConnectivity();
    return !results.contains(ConnectivityResult.none);
  }

  /// Para cada jogador sem medias na BD, tenta carregar a ficha em basketball-reference.com.
  Future<void> syncFromBasketballReference({
    int passes = 3,
    int perPlayerRetries = 2,
  }) async {
    if (!await _hasInternet()) return;
    final all = await _playersDao.getAllPlayers();
    if (all.isEmpty) return;

    final totalPasses = passes < 1 ? 1 : passes;
    final retries = perPlayerRetries < 1 ? 1 : perPlayerRetries;

    for (var pass = 0; pass < totalPasses; pass++) {
      for (final player in all) {
        var synced = false;
        for (var attempt = 0; attempt < retries; attempt++) {
          try {
            final profile = await _br.getPlayerProfile(player.fullName);
            if (profile == null) {
              await Future.delayed(const Duration(milliseconds: 220));
              continue;
            }
            final s = profile.currentSeason;
            await _playersDao.updatePlayerSeasonStats(
              player.playerId,
              ppg: s.ppg,
              rpg: s.rpg,
              apg: s.apg,
              spg: s.spg,
              bpg: s.bpg,
              mpg: s.mpg,
              topg: s.topg,
              fgPct: s.fgPct,
              fg3Pct: s.fg3Pct,
              ftPct: s.ftPct,
            );

            final c = profile.career;

            // Salva todas as temporadas historicas para offline real
            final seasonsToSave = profile.seasons
                .map(
                  (s) => PlayerSeasonsCompanion(
                    playerId: Value(player.playerId),
                    season: Value(s.season),
                    team: Value(s.team),
                    gp: Value(s.gp),
                    gs: Value(s.gs),
                    mpg: Value(s.mpg),
                    ppg: Value(s.ppg),
                    rpg: Value(s.rpg),
                    apg: Value(s.apg),
                    spg: Value(s.spg),
                    bpg: Value(s.bpg),
                    topg: Value(s.topg),
                    fgPct: Value(s.fgPct),
                    fg3Pct: Value(s.fg3Pct),
                    ftPct: Value(s.ftPct),
                    per: Value(s.per),
                    tsPct: Value(s.tsPct),
                    usgPct: Value(s.usgPct),
                  ),
                )
                .toList();

            await _playersDao.deletePlayerSeasons(player.playerId);
            await _playersDao.upsertPlayerSeasons(seasonsToSave);

            final teamList = profile.seasons
                .map((e) => e.team)
                .where((t) => t.isNotEmpty && t != 'TOT')
                .toList(); // Mantem ordem cronologica

            final uniqueTeams = <String>[];
            for (final t in teamList) {
              if (uniqueTeams.isEmpty || uniqueTeams.last != t) {
                uniqueTeams.add(t);
              }
            }

            await _playersDao.updatePlayerCareerStats(
              player.playerId,
              points: c.points,
              rebounds: c.rebounds,
              assists: c.assists,
              steals: c.steals,
              blocks: c.blocks,
              games: c.games,
              starts: c.starts,
              turnovers: c.turnovers,
              careerTeams: uniqueTeams.join(','),
            );

            synced = true;
            break;
          } catch (_) {
            await Future.delayed(const Duration(milliseconds: 220));
          }
        }
        if (!synced) {
          // Proxima passagem pode resolver erros temporarios de rede/site.
        }
        await Future.delayed(const Duration(milliseconds: 320));
      }
    }
  }

  /// Sincroniza um único jogador especificamente (útil para botão manual).
  Future<bool> syncSinglePlayer(Player player) async {
    if (!await _hasInternet()) return false;
    try {
      final profile = await _br.getPlayerProfile(player.fullName);
      if (profile == null) return false;

      final s = profile.currentSeason;
      await _playersDao.updatePlayerSeasonStats(
        player.playerId,
        ppg: s.ppg,
        rpg: s.rpg,
        apg: s.apg,
        spg: s.spg,
        bpg: s.bpg,
        mpg: s.mpg,
        topg: s.topg,
        fgPct: s.fgPct,
        fg3Pct: s.fg3Pct,
        ftPct: s.ftPct,
      );

      final seasonsToSave = profile.seasons
          .map(
            (s) => PlayerSeasonsCompanion(
              playerId: Value(player.playerId),
              season: Value(s.season),
              team: Value(s.team),
              gp: Value(s.gp),
              gs: Value(s.gs),
              mpg: Value(s.mpg),
              ppg: Value(s.ppg),
              rpg: Value(s.rpg),
              apg: Value(s.apg),
              spg: Value(s.spg),
              bpg: Value(s.bpg),
              topg: Value(s.topg),
              fgPct: Value(s.fgPct),
              fg3Pct: Value(s.fg3Pct),
              ftPct: Value(s.ftPct),
              per: Value(s.per),
              tsPct: Value(s.tsPct),
              usgPct: Value(s.usgPct),
            ),
          )
          .toList();

      await _playersDao.deletePlayerSeasons(player.playerId);
      await _playersDao.upsertPlayerSeasons(seasonsToSave);

      final teamList = profile.seasons
          .map((e) => e.team)
          .where((t) => t.isNotEmpty && t != 'TOT')
          .toList();

      final uniqueTeams = <String>[];
      for (final t in teamList) {
        if (uniqueTeams.isEmpty || uniqueTeams.last != t) {
          uniqueTeams.add(t);
        }
      }

      final c = profile.career;
      await _playersDao.updatePlayerCareerStats(
        player.playerId,
        points: c.points,
        rebounds: c.rebounds,
        assists: c.assists,
        steals: c.steals,
        blocks: c.blocks,
        games: c.games,
        starts: c.starts,
        turnovers: c.turnovers,
        careerTeams: uniqueTeams.join(','),
      );

      return true;
    } catch (_) {
      return false;
    }
  }
}

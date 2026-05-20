import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:nba_app/db/app_database.dart';
import 'package:nba_app/services/repository.dart';
import 'package:nba_app/services/nba_api_service.dart';

void main() {
  late AppDatabase db;
  late NbaRepository repo;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repo = NbaRepository(db, NbaApiService());
  });

  tearDown(() async {
    await db.close();
  });

  test('getPlayerCareer returns player if exists', () async {
    await db.playersDao.upsertPlayer(
      const PlayersCompanion(
        playerId: Value('1'),
        fullName: Value('LeBron James'),
        teamId: Value('14'),
        careerGames: Value(1000),
      ),
    );

    final player = await repo.getPlayerCareer('1');
    expect(player, isNot(null));
    expect(player?.fullName, 'LeBron James');
  });

  test('getPlayerSeasonStats returns stats', () async {
    await db.playersDao.upsertPlayerSeasons([
      const PlayerSeasonsCompanion(
        playerId: Value('1'),
        season: Value('2023-24'),
        team: Value('LAL'),
        ppg: Value(25.0),
        rpg: Value(7.0),
        apg: Value(8.0),
        gp: Value(71),
        gs: Value(71),
        mpg: Value(35.3),
        spg: Value(1.2),
        bpg: Value(0.5),
        topg: Value(3.4),
        fgPct: Value(54.0),
        fg3Pct: Value(41.0),
        ftPct: Value(75.0),
        per: Value(23.0),
        tsPct: Value(63.0),
        usgPct: Value(28.0),
      ),
    ]);

    final stats = await repo.getPlayerSeasonStats('1');
    expect(stats.length, 1);
    expect(stats.first.ppg, 25.0);
    expect(stats.first.season, '2023-24');
  });
}

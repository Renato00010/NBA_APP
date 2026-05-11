import 'package:drift/drift.dart';
import '../db/app_database.dart';
import '../db/daos/players_dao.dart';
import '../db/daos/teams_dao.dart';
import 'nba_api_service.dart';
import 'player_bio_seed.dart';
import 'player_photo_seed.dart';

class DataSeedService {
  final NbaApiService _apiService;
  final PlayersDao _playersDao;
  final TeamsDao _teamsDao;

  DataSeedService(this._apiService, this._playersDao, this._teamsDao);

  static const List<_SeedTeam> _teams = [
    _SeedTeam('1', 'Atlanta Hawks', 'Atlanta', 'East', 'Southeast'),
    _SeedTeam('2', 'Boston Celtics', 'Boston', 'East', 'Atlantic'),
    _SeedTeam('3', 'Brooklyn Nets', 'Brooklyn', 'East', 'Atlantic'),
    _SeedTeam('4', 'Charlotte Hornets', 'Charlotte', 'East', 'Southeast'),
    _SeedTeam('5', 'Chicago Bulls', 'Chicago', 'East', 'Central'),
    _SeedTeam('6', 'Cleveland Cavaliers', 'Cleveland', 'East', 'Central'),
    _SeedTeam('7', 'Dallas Mavericks', 'Dallas', 'West', 'Southwest'),
    _SeedTeam('8', 'Denver Nuggets', 'Denver', 'West', 'Northwest'),
    _SeedTeam('9', 'Detroit Pistons', 'Detroit', 'East', 'Central'),
    _SeedTeam('10', 'Golden State Warriors', 'Golden State', 'West', 'Pacific'),
    _SeedTeam('11', 'Houston Rockets', 'Houston', 'West', 'Southwest'),
    _SeedTeam('12', 'Indiana Pacers', 'Indiana', 'East', 'Central'),
    _SeedTeam('13', 'LA Clippers', 'LA', 'West', 'Pacific'),
    _SeedTeam('14', 'Los Angeles Lakers', 'Los Angeles', 'West', 'Pacific'),
    _SeedTeam('15', 'Memphis Grizzlies', 'Memphis', 'West', 'Southwest'),
    _SeedTeam('16', 'Miami Heat', 'Miami', 'East', 'Southeast'),
    _SeedTeam('17', 'Milwaukee Bucks', 'Milwaukee', 'East', 'Central'),
    _SeedTeam('18', 'Minnesota Timberwolves', 'Minnesota', 'West', 'Northwest'),
    _SeedTeam('19', 'New Orleans Pelicans', 'New Orleans', 'West', 'Southwest'),
    _SeedTeam('20', 'New York Knicks', 'New York', 'East', 'Atlantic'),
    _SeedTeam(
      '21',
      'Oklahoma City Thunder',
      'Oklahoma City',
      'West',
      'Northwest',
    ),
    _SeedTeam('22', 'Orlando Magic', 'Orlando', 'East', 'Southeast'),
    _SeedTeam('23', 'Philadelphia 76ers', 'Philadelphia', 'East', 'Atlantic'),
    _SeedTeam('24', 'Phoenix Suns', 'Phoenix', 'West', 'Pacific'),
    _SeedTeam('25', 'Portland Trail Blazers', 'Portland', 'West', 'Northwest'),
    _SeedTeam('26', 'Sacramento Kings', 'Sacramento', 'West', 'Pacific'),
    _SeedTeam('27', 'San Antonio Spurs', 'San Antonio', 'West', 'Southwest'),
    _SeedTeam('28', 'Toronto Raptors', 'Toronto', 'East', 'Atlantic'),
    _SeedTeam('29', 'Utah Jazz', 'Utah', 'West', 'Northwest'),
    _SeedTeam('30', 'Washington Wizards', 'Washington', 'East', 'Southeast'),
  ];

  static const Map<String, List<_SeedPlayer>> _playersByTeam = {
    '1': [
      _SeedPlayer('Buddy Hield', 'SF'),
      _SeedPlayer('CJ McCollum', 'SG'),
      _SeedPlayer('Corey Kispert', 'F'),
      _SeedPlayer('Dyson Daniels', 'SG'),
      _SeedPlayer('Gabe Vincent', 'G'),
      _SeedPlayer('Jalen Johnson', 'SF'),
      _SeedPlayer('Jonathan Kuminga', 'F'),
      _SeedPlayer('Nickeil Alexander-Walker', 'G'),
      _SeedPlayer('Onyeka Okongwu', 'C'),
      _SeedPlayer('Zaccharie Risacher', 'F'),
    ],
    '2': [
      _SeedPlayer('Derrick White', 'PG'),
      _SeedPlayer('Jaylen Brown', 'SG'),
      _SeedPlayer('Jayson Tatum', 'PF'),
      _SeedPlayer('Neemias Queta', 'C'),
      _SeedPlayer('Nikola Vucevic', 'C'),
      _SeedPlayer('Payton Pritchard', 'G'),
      _SeedPlayer('Sam Hauser', 'SF'),
    ],
    '3': [
      _SeedPlayer('Dariq Whitehead', 'F'),
      _SeedPlayer('DayRon Sharpe', 'C'),
      _SeedPlayer('Egor Demin', 'PG'),
      _SeedPlayer('Michael Porter Jr.', 'SF'),
      _SeedPlayer('Nic Claxton', 'C'),
      _SeedPlayer('Noah Clowney', 'PF'),
      _SeedPlayer('Ochai Agbaji', 'G'),
      _SeedPlayer('Terance Mann', 'G'),
    ],
    '4': [
      _SeedPlayer('Brandon Miller', 'SF'),
      _SeedPlayer('Coby White', 'SG'),
      _SeedPlayer('Grant Williams', 'F'),
      _SeedPlayer('Kon Knueppel', 'SG'),
      _SeedPlayer('LaMelo Ball', 'PG'),
      _SeedPlayer('Miles Bridges', 'PF'),
      _SeedPlayer('Moussa Diabate', 'C'),
      _SeedPlayer('Tre Mann', 'G'),
      _SeedPlayer('Xavier Tillman', 'F'),
    ],
    '5': [
      _SeedPlayer('Anfernee Simons', 'G'),
      _SeedPlayer('Isaac Okoro', 'F'),
      _SeedPlayer('Jaden Ivey', 'SG'),
      _SeedPlayer('Josh Giddey', 'PG'),
      _SeedPlayer('Matas Buzelis', 'PF'),
      _SeedPlayer('Nick Richards', 'C'),
      _SeedPlayer('Patrick Williams', 'F'),
      _SeedPlayer('Rob Dillingham', 'G'),
      _SeedPlayer('Tre Jones', 'G'),
    ],
    '6': [
      _SeedPlayer('Dean Wade', 'F'),
      _SeedPlayer('Donovan Mitchell', 'SG'),
      _SeedPlayer('Evan Mobley', 'PF'),
      _SeedPlayer('James Harden', 'PG'),
      _SeedPlayer('Jarrett Allen', 'C'),
      _SeedPlayer('Max Strus', 'G'),
      _SeedPlayer('Sam Merrill', 'G'),
    ],
    '7': [
      _SeedPlayer('Cooper Flagg', 'SF'),
      _SeedPlayer('Daniel Gafford', 'C'),
      _SeedPlayer('Dereck Lively II', 'C'),
      _SeedPlayer('Khris Middleton', 'PF'),
      _SeedPlayer('Klay Thompson', 'SG'),
      _SeedPlayer('Kyrie Irving', 'PG'),
      _SeedPlayer('Max Christie', 'G'),
      _SeedPlayer('PJ Washington', 'F'),
    ],
    '8': [
      _SeedPlayer('Aaron Gordon', 'PF'),
      _SeedPlayer('Cam Johnson', 'SF'),
      _SeedPlayer('Christian Braun', 'SG'),
      _SeedPlayer('Jamal Murray', 'PG'),
      _SeedPlayer('Nikola Jokic', 'C'),
      _SeedPlayer('Peyton Watson', 'F'),
    ],
    '9': [
      _SeedPlayer('Ausar Thompson', 'SF'),
      _SeedPlayer('Cade Cunningham', 'PG'),
      _SeedPlayer('Duncan Robinson', 'G'),
      _SeedPlayer('Isaiah Stewart', 'C'),
      _SeedPlayer('Jalen Duren', 'C'),
      _SeedPlayer('Ron Holland', 'F'),
      _SeedPlayer('Tobias Harris', 'PF'),
    ],
    '10': [
      _SeedPlayer('Al Horford', 'C'),
      _SeedPlayer('Brandin Podziemski', 'SG'),
      _SeedPlayer('Draymond Green', 'PF'),
      _SeedPlayer('Jimmy Butler', 'F'),
      _SeedPlayer('Kristaps Porzingis', 'C'),
      _SeedPlayer('Stephen Curry', 'PG'),
    ],
    '11': [
      _SeedPlayer('Alperen Sengun', 'C'),
      _SeedPlayer('Amen Thompson', 'SG'),
      _SeedPlayer('Fred VanVleet', 'PG'),
      _SeedPlayer('Jabari Smith Jr.', 'PF'),
      _SeedPlayer('Kevin Durant', 'SF'),
      _SeedPlayer('Reed Sheppard', 'G'),
      _SeedPlayer('Tari Eason', 'F'),
    ],
    '12': [
      _SeedPlayer('Aaron Nesmith', 'SF'),
      _SeedPlayer('Andrew Nembhard', 'SG'),
      _SeedPlayer('Ivica Zubac', 'C'),
      _SeedPlayer('Obi Toppin', 'F'),
      _SeedPlayer('Pascal Siakam', 'PF'),
      _SeedPlayer('TJ McConnell', 'G'),
      _SeedPlayer('Tyrese Haliburton', 'PG'),
    ],
    '13': [
      _SeedPlayer('Bennedict Mathurin', 'G'),
      _SeedPlayer('Bogdan Bogdanovic', 'G'),
      _SeedPlayer('Bradley Beal', 'SG'),
      _SeedPlayer('Brook Lopez', 'C'),
      _SeedPlayer('Darius Garland', 'PG'),
      _SeedPlayer('Derrick Jones Jr.', 'F'),
      _SeedPlayer('Isaiah Jackson', 'C'),
      _SeedPlayer('John Collins', 'PF'),
      _SeedPlayer('Kawhi Leonard', 'SF'),
    ],
    '14': [
      _SeedPlayer('Austin Reaves', 'SG'),
      _SeedPlayer('Deandre Ayton', 'C'),
      _SeedPlayer('Jarred Vanderbilt', 'F'),
      _SeedPlayer('LeBron James', 'PF'),
      _SeedPlayer('Luka Doncic', 'PG'),
      _SeedPlayer('Luke Kennard', 'G'),
      _SeedPlayer('Marcus Smart', 'G'),
      _SeedPlayer('Rui Hachimura', 'SF'),
    ],
    '15': [
      _SeedPlayer('Brandon Clarke', 'F'),
      _SeedPlayer('Ja Morant', 'PG'),
      _SeedPlayer('Jaylen Wells', 'SF'),
      _SeedPlayer('Kentavious Caldwell-Pope', 'SG'),
      _SeedPlayer('Santi Aldama', 'F'),
      _SeedPlayer('Taylor Hendricks', 'F'),
      _SeedPlayer('Zach Edey', 'C'),
    ],
    '16': [
      _SeedPlayer('Andrew Wiggins', 'PF'),
      _SeedPlayer('Bam Adebayo', 'C'),
      _SeedPlayer('Davion Mitchell', 'PG'),
      _SeedPlayer('Jaime Jaquez Jr.', 'F'),
      _SeedPlayer('Kel el Ware', 'C'),
      _SeedPlayer('Norman Powell', 'SF'),
      _SeedPlayer('Terry Rozier', 'G'),
      _SeedPlayer('Tyler Herro', 'SG'),
    ],
    '17': [
      _SeedPlayer('AJ Green', 'G'),
      _SeedPlayer('Bobby Portis', 'F'),
      _SeedPlayer('Cam Thomas', 'SG'),
      _SeedPlayer('Gary Trent Jr.', 'SG'),
      _SeedPlayer('Giannis Antetokounmpo', 'PF'),
      _SeedPlayer('Kevin Porter Jr.', 'PG'),
      _SeedPlayer('Kyle Kuzma', 'SF'),
      _SeedPlayer('Myles Turner', 'C'),
      _SeedPlayer('Taurean Prince', 'F'),
    ],
    '18': [
      _SeedPlayer('Anthony Edwards', 'SG'),
      _SeedPlayer('Ayo Dosunmu', 'SF'),
      _SeedPlayer('Donte DiVincenzo', 'G'),
      _SeedPlayer('Jaden McDaniels', 'SF'),
      _SeedPlayer('Julius Randle', 'PF'),
      _SeedPlayer('Mike Conley', 'PG'),
      _SeedPlayer('Naz Reid', 'C'),
      _SeedPlayer('Rudy Gobert', 'C'),
    ],
    '19': [
      _SeedPlayer('Dejounte Murray', 'PG'),
      _SeedPlayer('Herbert Jones', 'F'),
      _SeedPlayer('Jordan Poole', 'SG'),
      _SeedPlayer('Saddiq Bey', 'F'),
      _SeedPlayer('Trey Murphy III', 'SF'),
      _SeedPlayer('Yves Missi', 'C'),
      _SeedPlayer('Zion Williamson', 'PF'),
    ],
    '20': [
      _SeedPlayer('Jalen Brunson', 'PG'),
      _SeedPlayer('Jeremy Sochan', 'F'),
      _SeedPlayer('Jordan Clarkson', 'G'),
      _SeedPlayer('Jose Alvarado', 'G'),
      _SeedPlayer('Josh Hart', 'SG'),
      _SeedPlayer('Karl-Anthony Towns', 'C'),
      _SeedPlayer('Mikal Bridges', 'SF'),
      _SeedPlayer('Miles McBride', 'G'),
      _SeedPlayer('Mitchell Robinson', 'C'),
      _SeedPlayer('OG Anunoby', 'PF'),
    ],
    '21': [
      _SeedPlayer('Aaron Wiggins', 'G'),
      _SeedPlayer('Alex Caruso', 'G'),
      _SeedPlayer('Cason Wallace', 'G'),
      _SeedPlayer('Chet Holmgren', 'PF'),
      _SeedPlayer('Isaiah Hartenstein', 'C'),
      _SeedPlayer('Jalen Williams', 'SF'),
      _SeedPlayer('Jared McCain', 'G'),
      _SeedPlayer('Luguentz Dort', 'SG'),
      _SeedPlayer('Shai Gilgeous-Alexander', 'PG'),
    ],
    '22': [
      _SeedPlayer('Anthony Black', 'G'),
      _SeedPlayer('Desmond Bane', 'G'),
      _SeedPlayer('Franz Wagner', 'SF'),
      _SeedPlayer('Jalen Suggs', 'PG'),
      _SeedPlayer('Jonathan Isaac', 'F'),
      _SeedPlayer('Paolo Banchero', 'PF'),
      _SeedPlayer('Wendell Carter Jr.', 'C'),
    ],
    '23': [
      _SeedPlayer('Andre Drummond', 'C'),
      _SeedPlayer('Joel Embiid', 'C'),
      _SeedPlayer('Kelly Oubre Jr.', 'SF'),
      _SeedPlayer('Paul George', 'PF'),
      _SeedPlayer('Quentin Grimes', 'SG'),
      _SeedPlayer('Tyrese Maxey', 'PG'),
      _SeedPlayer('VJ Edgecombe', 'G'),
    ],
    '24': [
      _SeedPlayer('Cole Anthony', 'G'),
      _SeedPlayer('Devin Booker', 'PG'),
      _SeedPlayer('Dillon Brooks', 'PF'),
      _SeedPlayer('Grayson Allen', 'G'),
      _SeedPlayer('Jalen Green', 'G'),
      _SeedPlayer('Mark Williams', 'C'),
      _SeedPlayer('Royce ONeale', 'SF'),
      _SeedPlayer('Ryan Dunn', 'F'),
    ],
    '25': [
      _SeedPlayer('Deni Avdija', 'SF'),
      _SeedPlayer('Donovan Clingan', 'C'),
      _SeedPlayer('Jerami Grant', 'PF'),
      _SeedPlayer('Jrue Holiday', 'PG'),
      _SeedPlayer('Robert Williams III', 'C'),
      _SeedPlayer('Scoot Henderson', 'G'),
      _SeedPlayer('Shaedon Sharpe', 'SG'),
      _SeedPlayer('Toumani Camara', 'F'),
    ],
    '26': [
      _SeedPlayer('DeAndre Hunter', 'SF'),
      _SeedPlayer('DeMar DeRozan', 'SF'),
      _SeedPlayer('Domantas Sabonis', 'C'),
      _SeedPlayer('Keegan Murray', 'PF'),
      _SeedPlayer('Malik Monk', 'G'),
      _SeedPlayer('Precious Achiuwa', 'F'),
      _SeedPlayer('Russell Westbrook', 'G'),
      _SeedPlayer('Zach LaVine', 'SG'),
    ],
    '27': [
      _SeedPlayer('DeAaron Fox', 'PG'),
      _SeedPlayer('Devin Vassell', 'SF'),
      _SeedPlayer('Harrison Barnes', 'PF'),
      _SeedPlayer('Keldon Johnson', 'F'),
      _SeedPlayer('Stephon Castle', 'SG'),
      _SeedPlayer('Victor Wembanyama', 'C'),
    ],
    '28': [
      _SeedPlayer('Brandon Ingram', 'SF'),
      _SeedPlayer('Gradey Dick', 'G'),
      _SeedPlayer('Immanuel Quickley', 'PG'),
      _SeedPlayer('Jakob Poeltl', 'C'),
      _SeedPlayer('Jonathan Mogbo', 'F'),
      _SeedPlayer('RJ Barrett', 'SG'),
      _SeedPlayer('Scottie Barnes', 'PF'),
    ],
    '29': [
      _SeedPlayer('Ace Bailey', 'SF'),
      _SeedPlayer('Brice Sensabaugh', 'SG'),
      _SeedPlayer('Isaiah Collier', 'G'),
      _SeedPlayer('Jaren Jackson Jr.', 'PF'),
      _SeedPlayer('Keyonte George', 'PG'),
      _SeedPlayer('Lauri Markkanen', 'PF'),
      _SeedPlayer('Walker Kessler', 'C'),
    ],
    '30': [
      _SeedPlayer('Alex Sarr', 'C'),
      _SeedPlayer('Anthony Davis', 'PF'),
      _SeedPlayer('Bilal Coulibaly', 'SF'),
      _SeedPlayer('Bub Carrington', 'PG'),
      _SeedPlayer('Kyshawn George', 'F'),
      _SeedPlayer('Trae Young', 'PG'),
      _SeedPlayer('Tre Johnson', 'G'),
    ],
  };

  Future<void> seedDatabase() async {
    await _seedTeams();
    await _seedPlayers();
  }

  Future<void> _seedTeams() async {
    final companions = _teams
        .map(
          (team) => NbaTeamsCompanion(
            teamId: Value(team.id),
            name: Value(team.name),
            city: Value(team.city),
            conference: Value(team.conference),
            division: Value(team.division),
            colorPrimary: const Value('#17408B'),
            colorSecondary: const Value('#C9082A'),
          ),
        )
        .toList();
    await _teamsDao.upsertAllTeams(companions);
  }

  Future<void> _seedPlayers() async {
    final existingPlayers = await _playersDao.getAllPlayers();
    final existingPlayerByName = <String, Player>{};
    for (final player in existingPlayers) {
      final normalizedName = _normalize(player.fullName);
      if (existingPlayerByName.containsKey(normalizedName)) {
        await _playersDao.deletePlayer(player.playerId);
      } else {
        existingPlayerByName[normalizedName] = player;
      }
    }
    final seedAssetPhotoByName = {
      for (final entry in _playersByTeam.entries)
        for (final player in entry.value)
          _normalize(player.fullName): PlayerPhotoSeed.assetPhotoPathForName(
            player.fullName,
          ),
    };

    var seedId = -100000;
    final companions = <PlayersCompanion>[];
    for (final entry in _playersByTeam.entries) {
      final teamId = entry.key;
      for (final player in entry.value) {
        final normalizedName = _normalize(player.fullName);
        final assetPhotoPath = PlayerPhotoSeed.assetPhotoPathForName(
          player.fullName,
        );
        final bio = PlayerBioSeed.forName(player.fullName);
        final existingPlayer = existingPlayerByName[normalizedName];

        if (existingPlayer != null) {
          if (existingPlayer.teamId != teamId ||
              existingPlayer.position != player.position ||
              existingPlayer.photoWebpPath != assetPhotoPath ||
              existingPlayer.displayName != bio?.displayName ||
              existingPlayer.jerseyNumber != bio?.jerseyNumber ||
              existingPlayer.heightCm != bio?.heightCm ||
              existingPlayer.weightKg != bio?.weightKg ||
              existingPlayer.birthDate != bio?.birthDate ||
              existingPlayer.country != bio?.country ||
              existingPlayer.previousTeam != bio?.previousTeam ||
              existingPlayer.experienceYears != bio?.experienceYears) {
            await _playersDao.updatePlayerSeedData(
              existingPlayer.playerId,
              teamId: teamId,
              position: player.position,
              photoWebpPath: assetPhotoPath,
              displayName: bio?.displayName,
              jerseyNumber: bio?.jerseyNumber,
              heightCm: bio?.heightCm,
              weightKg: bio?.weightKg,
              birthDate: bio?.birthDate,
              country: bio?.country,
              previousTeam: bio?.previousTeam,
              experienceYears: bio?.experienceYears,
            );
          }
          continue;
        }

        companions.add(
          PlayersCompanion(
            playerId: Value((seedId--).toString()),
            teamId: Value(teamId),
            fullName: Value(player.fullName),
            displayName: Value(bio?.displayName),
            position: Value(player.position),
            jerseyNumber: Value(bio?.jerseyNumber),
            heightCm: Value(bio?.heightCm),
            weightKg: Value(bio?.weightKg),
            birthDate: Value(bio?.birthDate),
            country: Value(bio?.country),
            previousTeam: Value(bio?.previousTeam),
            experienceYears: Value(bio?.experienceYears),
            photoWebpPath: Value(assetPhotoPath),
          ),
        );
      }
    }

    if (companions.isNotEmpty) {
      await _playersDao.upsertAllPlayers(companions);
    }

    final allPlayers = await _playersDao.getAllPlayers();
    for (final player in allPlayers) {
      final assetPhotoPath = seedAssetPhotoByName[_normalize(player.fullName)];
      if (assetPhotoPath == null || player.photoWebpPath == assetPhotoPath) {
        continue;
      }
      await _playersDao.updatePlayerPhotoPath(player.playerId, assetPhotoPath);
    }
  }

  String _normalize(String value) => value
      .toLowerCase()
      .replaceAll(RegExp(r'[^a-z0-9]+'), ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();

  // Kept so existing constructors do not break while the seed remains local.
  NbaApiService get apiService => _apiService;
}

class _SeedTeam {
  final String id;
  final String name;
  final String city;
  final String conference;
  final String division;

  const _SeedTeam(
    this.id,
    this.name,
    this.city,
    this.conference,
    this.division,
  );
}

class _SeedPlayer {
  final String fullName;
  final String position;

  const _SeedPlayer(this.fullName, this.position);
}

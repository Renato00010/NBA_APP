import '../db/app_database.dart';
import 'nba_api_service.dart';
import 'player_bio_seed.dart';
import 'player_photo_seed.dart';
import 'player_stats_seed.dart';

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
    await _seedRetiredPlayers();
  }

  // Seed retired players
  Future<void> _seedRetiredPlayers() async {
    final retiredLegends = [
      RetiredPlayersCompanion(
        playerId: const Value('R1'),
        fullName: const Value('Michael Jordan'),
        displayName: const Value('Michael Jordan'),
        position: const Value('SG'),
        jerseyNumber: const Value('23'),
        heightCm: const Value(198.12),
        weightKg: const Value(98.0),
        birthDate: Value(DateTime(1963, 2, 17)),
        country: const Value('USA'),
        previousTeam: const Value('North Carolina'),
        experienceYears: const Value(15),
        careerTeams: const Value('CHI,WAS'),
        photoWebpPath: const Value(null),
      ),
      RetiredPlayersCompanion(
        playerId: const Value('R2'),
        fullName: const Value('Kobe Bryant'),
        displayName: const Value('Kobe Bryant'),
        position: const Value('SG'),
        jerseyNumber: const Value('24'),
        heightCm: const Value(198.12),
        weightKg: const Value(96.0),
        birthDate: Value(DateTime(1978, 8, 23)),
        country: const Value('USA'),
        previousTeam: const Value('Lower Merion HS'),
        experienceYears: const Value(20),
        careerTeams: const Value('LAL'),
        photoWebpPath: const Value(null),
      ),
      RetiredPlayersCompanion(
        playerId: const Value('R3'),
        fullName: const Value('Shaquille O\'Neal'),
        displayName: const Value('Shaquille O\'Neal'),
        position: const Value('C'),
        jerseyNumber: const Value('32'),
        heightCm: const Value(215.90),
        weightKg: const Value(147.4),
        birthDate: Value(DateTime(1972, 3, 6)),
        country: const Value('USA'),
        previousTeam: const Value('LSU'),
        experienceYears: const Value(19),
        careerTeams: const Value('ORL,LAL,MIA,PHX,CLE,BOS'),
        photoWebpPath: const Value(null),
      ),
      RetiredPlayersCompanion(
        playerId: const Value('R4'),
        fullName: const Value('Magic Johnson'),
        displayName: const Value('Magic Johnson'),
        position: const Value('PG'),
        jerseyNumber: const Value('32'),
        heightCm: const Value(205.74),
        weightKg: const Value(99.8),
        birthDate: Value(DateTime(1959, 8, 14)),
        country: const Value('USA'),
        previousTeam: const Value('Michigan State'),
        experienceYears: const Value(13),
        careerTeams: const Value('LAL'),
        photoWebpPath: const Value(null),
      ),
      RetiredPlayersCompanion(
        playerId: const Value('R5'),
        fullName: const Value('Larry Bird'),
        displayName: const Value('Larry Bird'),
        position: const Value('SF'),
        jerseyNumber: const Value('33'),
        heightCm: const Value(205.74),
        weightKg: const Value(99.8),
        birthDate: Value(DateTime(1956, 12, 07)),
        country: const Value('USA'),
        previousTeam: const Value('Indiana State'),
        experienceYears: const Value(13),
        careerTeams: const Value('BOS'),
        photoWebpPath: const Value(null),
      ),
      RetiredPlayersCompanion(
        playerId: const Value('R6'),
        fullName: const Value('Allen Iverson'),
        displayName: const Value('Allen Iverson'),
        position: const Value('SG'),
        jerseyNumber: const Value('3'),
        heightCm: const Value(182.88),
        weightKg: const Value(74.8),
        birthDate: Value(DateTime(1975, 6, 7)),
        country: const Value('USA'),
        previousTeam: const Value('Georgetown'),
        experienceYears: const Value(14),
        careerTeams: const Value('PHI,DEN,DET,MEM'),
        photoWebpPath: const Value(null),
      ),
      RetiredPlayersCompanion(
        playerId: const Value('R7'),
        fullName: const Value('Dwyane Wade'),
        displayName: const Value('Dwyane Wade'),
        position: const Value('SG'),
        jerseyNumber: const Value('3'),
        heightCm: const Value(193.04),
        weightKg: const Value(99.8),
        birthDate: Value(DateTime(1982, 1, 17)),
        country: const Value('USA'),
        previousTeam: const Value('Marquette'),
        experienceYears: const Value(16),
        careerTeams: const Value('MIA,CHI,CLE'),
        photoWebpPath: const Value(null),
      ),
      RetiredPlayersCompanion(
        playerId: const Value('R8'),
        fullName: const Value('Dirk Nowitzki'),
        displayName: const Value('Dirk Nowitzki'),
        position: const Value('PF'),
        jerseyNumber: const Value('41'),
        heightCm: const Value(213.36),
        weightKg: const Value(111.1),
        birthDate: Value(DateTime(1978, 6, 19)),
        country: const Value('Germany'),
        previousTeam: const Value('Germany'),
        experienceYears: const Value(21),
        careerTeams: const Value('DAL'),
        photoWebpPath: const Value(null),
      ),
      RetiredPlayersCompanion(
        playerId: const Value('R9'),
        fullName: const Value('Tim Duncan'),
        displayName: const Value('Tim Duncan'),
        position: const Value('PF'),
        jerseyNumber: const Value('21'),
        heightCm: const Value(210.82),
        weightKg: const Value(113.4),
        birthDate: Value(DateTime(1976, 4, 25)),
        country: const Value('USA'),
        previousTeam: const Value('Wake Forest'),
        experienceYears: const Value(19),
        careerTeams: const Value('SAS'),
        photoWebpPath: const Value(null),
      ),
      RetiredPlayersCompanion(
        playerId: const Value('R10'),
        fullName: const Value('Kevin Garnett'),
        displayName: const Value('Kevin Garnett'),
        position: const Value('PF'),
        jerseyNumber: const Value('5'),
        heightCm: const Value(210.82),
        weightKg: const Value(108.9),
        birthDate: Value(DateTime(1976, 5, 19)),
        country: const Value('USA'),
        previousTeam: const Value('Farragut Academy HS'),
        experienceYears: const Value(21),
        careerTeams: const Value('MIN,BOS,BKN'),
        photoWebpPath: const Value(null),
      ),
      RetiredPlayersCompanion(
        playerId: const Value('R11'),
        fullName: const Value('Reggie Miller'),
        displayName: const Value('Reggie Miller'),
        position: const Value('SG'),
        jerseyNumber: const Value('31'),
        heightCm: const Value(200.66),
        weightKg: const Value(83.9),
        birthDate: Value(DateTime(1965, 8, 24)),
        country: const Value('USA'),
        previousTeam: const Value('UCLA'),
        experienceYears: const Value(18),
        careerTeams: const Value('IND'),
        photoWebpPath: const Value(null),
      ),
      RetiredPlayersCompanion(
        playerId: const Value('R12'),
        fullName: const Value('Charles Barkley'),
        displayName: const Value('Charles Barkley'),
        position: const Value('PF'),
        jerseyNumber: const Value('34'),
        heightCm: const Value(198.12),
        weightKg: const Value(114.3),
        birthDate: Value(DateTime(1963, 2, 20)),
        country: const Value('USA'),
        previousTeam: const Value('Auburn'),
        experienceYears: const Value(16),
        careerTeams: const Value('PHI,PHX,HOU'),
        photoWebpPath: const Value(null),
      ),
      RetiredPlayersCompanion(
        playerId: const Value('R13'),
        fullName: const Value('Hakeem Olajuwon'),
        displayName: const Value('Hakeem Olajuwon'),
        position: const Value('C'),
        jerseyNumber: const Value('34'),
        heightCm: const Value(213.36),
        weightKg: const Value(115.7),
        birthDate: Value(DateTime(1963, 1, 21)),
        country: const Value('Nigeria'),
        previousTeam: const Value('Houston'),
        experienceYears: const Value(18),
        careerTeams: const Value('HOU,TOR'),
        photoWebpPath: const Value(null),
      ),
      RetiredPlayersCompanion(
        playerId: const Value('R14'),
        fullName: const Value('Steve Nash'),
        displayName: const Value('Steve Nash'),
        position: const Value('PG'),
        jerseyNumber: const Value('13'),
        heightCm: const Value(190.50),
        weightKg: const Value(88.5),
        birthDate: Value(DateTime(1974, 2, 7)),
        country: const Value('Canada'),
        previousTeam: const Value('Santa Clara'),
        experienceYears: const Value(18),
        careerTeams: const Value('PHX,DAL,LAL'),
        photoWebpPath: const Value(null),
      ),
      RetiredPlayersCompanion(
        playerId: const Value('R15'),
        fullName: const Value('Paul Pierce'),
        displayName: const Value('Paul Pierce'),
        position: const Value('SF'),
        jerseyNumber: const Value('34'),
        heightCm: const Value(200.66),
        weightKg: const Value(106.6),
        birthDate: Value(DateTime(1977, 10, 13)),
        country: const Value('USA'),
        previousTeam: const Value('Kansas'),
        experienceYears: const Value(19),
        careerTeams: const Value('BOS,BKN,WAS,LAC'),
        photoWebpPath: const Value(null),
      ),
      RetiredPlayersCompanion(
        playerId: const Value('R16'),
        fullName: const Value('Ray Allen'),
        displayName: const Value('Ray Allen'),
        position: const Value('SG'),
        jerseyNumber: const Value('34'),
        heightCm: const Value(195.58),
        weightKg: const Value(93.0),
        birthDate: Value(DateTime(1975, 7, 20)),
        country: const Value('USA'),
        previousTeam: const Value('UConn'),
        experienceYears: const Value(18),
        careerTeams: const Value('MIL,OKC,BOS,MIA'),
        photoWebpPath: const Value(null),
      ),
      RetiredPlayersCompanion(
        playerId: const Value('R17'),
        fullName: const Value('Vince Carter'),
        displayName: const Value('Vince Carter'),
        position: const Value('SG'),
        jerseyNumber: const Value('15'),
        heightCm: const Value(198.12),
        weightKg: const Value(99.8),
        birthDate: Value(DateTime(1977, 1, 26)),
        country: const Value('USA'),
        previousTeam: const Value('North Carolina'),
        experienceYears: const Value(22),
        careerTeams: const Value('TOR,BKN,ORL,PHX,DAL,MEM,SAC,ATL'),
        photoWebpPath: const Value(null),
      ),
      RetiredPlayersCompanion(
        playerId: const Value('R18'),
        fullName: const Value('Tracy McGrady'),
        displayName: const Value('Tracy McGrady'),
        position: const Value('SG'),
        jerseyNumber: const Value('1'),
        heightCm: const Value(203.20),
        weightKg: const Value(95.3),
        birthDate: Value(DateTime(1979, 5, 24)),
        country: const Value('USA'),
        previousTeam: const Value('Mt. Zion Christian Acad.'),
        experienceYears: const Value(15),
        careerTeams: const Value('TOR,ORL,HOU,NYK,DET,ATL,SAS'),
        photoWebpPath: const Value(null),
      ),
      RetiredPlayersCompanion(
        playerId: const Value('R19'),
        fullName: const Value('Yao Ming'),
        displayName: const Value('Yao Ming'),
        position: const Value('C'),
        jerseyNumber: const Value('11'),
        heightCm: const Value(228.60),
        weightKg: const Value(140.6),
        birthDate: Value(DateTime(1980, 9, 12)),
        country: const Value('China'),
        previousTeam: const Value('China'),
        experienceYears: const Value(8),
        careerTeams: const Value('HOU'),
        photoWebpPath: const Value(null),
      ),
      RetiredPlayersCompanion(
        playerId: const Value('R20'),
        fullName: const Value('Scottie Pippen'),
        displayName: const Value('Scottie Pippen'),
        position: const Value('SF'),
        jerseyNumber: const Value('33'),
        heightCm: const Value(203.20),
        weightKg: const Value(95.3),
        birthDate: Value(DateTime(1965, 9, 25)),
        country: const Value('USA'),
        previousTeam: const Value('Central Arkansas'),
        experienceYears: const Value(17),
        careerTeams: const Value('CHI,HOU,POR'),
        photoWebpPath: const Value(null),
      ),
    ];
    await _playersDao.upsertAllRetiredPlayers(retiredLegends);
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

    String cleanTeamCode(String name) {
      final n = name.toLowerCase();
      if (n.contains('lakers')) return 'LAL';
      if (n.contains('celtics')) return 'BOS';
      if (n.contains('warriors') || n == 'gs') return 'GSW';
      if (n.contains('heat')) return 'MIA';
      if (n.contains('nets')) return 'BKN';
      if (n.contains('clippers')) return 'LAC';
      if (n.contains('hawks')) return 'ATL';
      if (n.contains('hornets')) return 'CHA';
      if (n.contains('bulls')) return 'CHI';
      if (n.contains('cavaliers')) return 'CLE';
      if (n.contains('mavericks')) return 'DAL';
      if (n.contains('nuggets')) return 'DEN';
      if (n.contains('pistons')) return 'DET';
      if (n.contains('rockets')) return 'HOU';
      if (n.contains('pacers')) return 'IND';
      if (n.contains('grizzlies')) return 'MEM';
      if (n.contains('bucks')) return 'MIL';
      if (n.contains('timberwolves')) return 'MIN';
      if (n.contains('pelicans')) return 'NOP';
      if (n.contains('knicks')) return 'NYK';
      if (n.contains('thunder') || n == 'okc') return 'OKC';
      if (n.contains('magic')) return 'ORL';
      if (n.contains('76ers') || n == 'phi') return 'PHI';
      if (n.contains('suns') || n == 'phx') return 'PHX';
      if (n.contains('trail blazers') || n == 'por') return 'POR';
      if (n.contains('kings')) return 'SAC';
      if (n.contains('spurs') || n == 'sas') return 'SAS';
      if (n.contains('raptors')) return 'TOR';
      if (n.contains('jazz')) return 'UTA';
      if (n.contains('wizards') || n == 'was') return 'WAS';
      return name.toUpperCase();
    }

    String getCareerTeamsString(String fullName, String teamId) {
      final statsProfile = PlayerStatsSeed.forName(fullName) ??
          PlayerStatsSeed.estimatedProfileForRosterGap(
            fullName: fullName,
            position: 'SF',
            teamName: _teams.firstWhere((t) => t.id == teamId, orElse: () => _teams.first).name,
          );

      final teamCodes = <String>{};
      
      // Add current team code
      final activeTeamName = _teams.firstWhere((t) => t.id == teamId, orElse: () => _teams.first).name;
      teamCodes.add(cleanTeamCode(activeTeamName));

      // Add career seasons teams
      for (final s in statsProfile.seasons) {
        if (s.team.isNotEmpty && s.team != 'TOT') {
          teamCodes.add(cleanTeamCode(s.team));
        }
      }
      
      return teamCodes.join(',');
    }

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
        final careerTeamsString = getCareerTeamsString(player.fullName, teamId);

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
              existingPlayer.experienceYears != bio?.experienceYears ||
              existingPlayer.careerTeams != careerTeamsString) {
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
              careerTeams: careerTeamsString,
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
            careerTeams: Value(careerTeamsString),
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

    await _clearSeedStatsToRequireRealSource();
  }

  /// Limpa medias seeded para garantir que so dados reais sejam exibidos.
  Future<void> _clearSeedStatsToRequireRealSource() async {
    final all = await _playersDao.getAllPlayers();
    for (final p in all) {
      await _playersDao.updatePlayerSeasonStats(
        p.playerId,
        ppg: 0,
        rpg: 0,
        apg: 0,
        spg: 0,
        bpg: 0,
        mpg: 0,
        topg: 0,
        fgPct: 0,
        fg3Pct: 0,
        ftPct: 0,
      );
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

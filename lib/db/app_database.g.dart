// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $NbaTeamsTable extends NbaTeams with TableInfo<$NbaTeamsTable, NbaTeam> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NbaTeamsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  @override
  late final GeneratedColumn<String> teamId = GeneratedColumn<String>(
    'team_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cityMeta = const VerificationMeta('city');
  @override
  late final GeneratedColumn<String> city = GeneratedColumn<String>(
    'city',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _conferenceMeta = const VerificationMeta(
    'conference',
  );
  @override
  late final GeneratedColumn<String> conference = GeneratedColumn<String>(
    'conference',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _divisionMeta = const VerificationMeta(
    'division',
  );
  @override
  late final GeneratedColumn<String> division = GeneratedColumn<String>(
    'division',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorPrimaryMeta = const VerificationMeta(
    'colorPrimary',
  );
  @override
  late final GeneratedColumn<String> colorPrimary = GeneratedColumn<String>(
    'color_primary',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _colorSecondaryMeta = const VerificationMeta(
    'colorSecondary',
  );
  @override
  late final GeneratedColumn<String> colorSecondary = GeneratedColumn<String>(
    'color_secondary',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _logoWebpPathMeta = const VerificationMeta(
    'logoWebpPath',
  );
  @override
  late final GeneratedColumn<String> logoWebpPath = GeneratedColumn<String>(
    'logo_webp_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    teamId,
    name,
    city,
    conference,
    division,
    colorPrimary,
    colorSecondary,
    logoWebpPath,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'nba_teams';
  @override
  VerificationContext validateIntegrity(
    Insertable<NbaTeam> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('team_id')) {
      context.handle(
        _teamIdMeta,
        teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teamIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('city')) {
      context.handle(
        _cityMeta,
        city.isAcceptableOrUnknown(data['city']!, _cityMeta),
      );
    } else if (isInserting) {
      context.missing(_cityMeta);
    }
    if (data.containsKey('conference')) {
      context.handle(
        _conferenceMeta,
        conference.isAcceptableOrUnknown(data['conference']!, _conferenceMeta),
      );
    } else if (isInserting) {
      context.missing(_conferenceMeta);
    }
    if (data.containsKey('division')) {
      context.handle(
        _divisionMeta,
        division.isAcceptableOrUnknown(data['division']!, _divisionMeta),
      );
    } else if (isInserting) {
      context.missing(_divisionMeta);
    }
    if (data.containsKey('color_primary')) {
      context.handle(
        _colorPrimaryMeta,
        colorPrimary.isAcceptableOrUnknown(
          data['color_primary']!,
          _colorPrimaryMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_colorPrimaryMeta);
    }
    if (data.containsKey('color_secondary')) {
      context.handle(
        _colorSecondaryMeta,
        colorSecondary.isAcceptableOrUnknown(
          data['color_secondary']!,
          _colorSecondaryMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_colorSecondaryMeta);
    }
    if (data.containsKey('logo_webp_path')) {
      context.handle(
        _logoWebpPathMeta,
        logoWebpPath.isAcceptableOrUnknown(
          data['logo_webp_path']!,
          _logoWebpPathMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {teamId};
  @override
  NbaTeam map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NbaTeam(
      teamId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}team_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      city: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}city'],
      )!,
      conference: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}conference'],
      )!,
      division: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}division'],
      )!,
      colorPrimary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color_primary'],
      )!,
      colorSecondary: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}color_secondary'],
      )!,
      logoWebpPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logo_webp_path'],
      ),
    );
  }

  @override
  $NbaTeamsTable createAlias(String alias) {
    return $NbaTeamsTable(attachedDatabase, alias);
  }
}

class NbaTeam extends DataClass implements Insertable<NbaTeam> {
  final String teamId;
  final String name;
  final String city;
  final String conference;
  final String division;
  final String colorPrimary;
  final String colorSecondary;
  final String? logoWebpPath;
  const NbaTeam({
    required this.teamId,
    required this.name,
    required this.city,
    required this.conference,
    required this.division,
    required this.colorPrimary,
    required this.colorSecondary,
    this.logoWebpPath,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['team_id'] = Variable<String>(teamId);
    map['name'] = Variable<String>(name);
    map['city'] = Variable<String>(city);
    map['conference'] = Variable<String>(conference);
    map['division'] = Variable<String>(division);
    map['color_primary'] = Variable<String>(colorPrimary);
    map['color_secondary'] = Variable<String>(colorSecondary);
    if (!nullToAbsent || logoWebpPath != null) {
      map['logo_webp_path'] = Variable<String>(logoWebpPath);
    }
    return map;
  }

  NbaTeamsCompanion toCompanion(bool nullToAbsent) {
    return NbaTeamsCompanion(
      teamId: Value(teamId),
      name: Value(name),
      city: Value(city),
      conference: Value(conference),
      division: Value(division),
      colorPrimary: Value(colorPrimary),
      colorSecondary: Value(colorSecondary),
      logoWebpPath: logoWebpPath == null && nullToAbsent
          ? const Value.absent()
          : Value(logoWebpPath),
    );
  }

  factory NbaTeam.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NbaTeam(
      teamId: serializer.fromJson<String>(json['teamId']),
      name: serializer.fromJson<String>(json['name']),
      city: serializer.fromJson<String>(json['city']),
      conference: serializer.fromJson<String>(json['conference']),
      division: serializer.fromJson<String>(json['division']),
      colorPrimary: serializer.fromJson<String>(json['colorPrimary']),
      colorSecondary: serializer.fromJson<String>(json['colorSecondary']),
      logoWebpPath: serializer.fromJson<String?>(json['logoWebpPath']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'teamId': serializer.toJson<String>(teamId),
      'name': serializer.toJson<String>(name),
      'city': serializer.toJson<String>(city),
      'conference': serializer.toJson<String>(conference),
      'division': serializer.toJson<String>(division),
      'colorPrimary': serializer.toJson<String>(colorPrimary),
      'colorSecondary': serializer.toJson<String>(colorSecondary),
      'logoWebpPath': serializer.toJson<String?>(logoWebpPath),
    };
  }

  NbaTeam copyWith({
    String? teamId,
    String? name,
    String? city,
    String? conference,
    String? division,
    String? colorPrimary,
    String? colorSecondary,
    Value<String?> logoWebpPath = const Value.absent(),
  }) => NbaTeam(
    teamId: teamId ?? this.teamId,
    name: name ?? this.name,
    city: city ?? this.city,
    conference: conference ?? this.conference,
    division: division ?? this.division,
    colorPrimary: colorPrimary ?? this.colorPrimary,
    colorSecondary: colorSecondary ?? this.colorSecondary,
    logoWebpPath: logoWebpPath.present ? logoWebpPath.value : this.logoWebpPath,
  );
  NbaTeam copyWithCompanion(NbaTeamsCompanion data) {
    return NbaTeam(
      teamId: data.teamId.present ? data.teamId.value : this.teamId,
      name: data.name.present ? data.name.value : this.name,
      city: data.city.present ? data.city.value : this.city,
      conference: data.conference.present
          ? data.conference.value
          : this.conference,
      division: data.division.present ? data.division.value : this.division,
      colorPrimary: data.colorPrimary.present
          ? data.colorPrimary.value
          : this.colorPrimary,
      colorSecondary: data.colorSecondary.present
          ? data.colorSecondary.value
          : this.colorSecondary,
      logoWebpPath: data.logoWebpPath.present
          ? data.logoWebpPath.value
          : this.logoWebpPath,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NbaTeam(')
          ..write('teamId: $teamId, ')
          ..write('name: $name, ')
          ..write('city: $city, ')
          ..write('conference: $conference, ')
          ..write('division: $division, ')
          ..write('colorPrimary: $colorPrimary, ')
          ..write('colorSecondary: $colorSecondary, ')
          ..write('logoWebpPath: $logoWebpPath')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    teamId,
    name,
    city,
    conference,
    division,
    colorPrimary,
    colorSecondary,
    logoWebpPath,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NbaTeam &&
          other.teamId == this.teamId &&
          other.name == this.name &&
          other.city == this.city &&
          other.conference == this.conference &&
          other.division == this.division &&
          other.colorPrimary == this.colorPrimary &&
          other.colorSecondary == this.colorSecondary &&
          other.logoWebpPath == this.logoWebpPath);
}

class NbaTeamsCompanion extends UpdateCompanion<NbaTeam> {
  final Value<String> teamId;
  final Value<String> name;
  final Value<String> city;
  final Value<String> conference;
  final Value<String> division;
  final Value<String> colorPrimary;
  final Value<String> colorSecondary;
  final Value<String?> logoWebpPath;
  final Value<int> rowid;
  const NbaTeamsCompanion({
    this.teamId = const Value.absent(),
    this.name = const Value.absent(),
    this.city = const Value.absent(),
    this.conference = const Value.absent(),
    this.division = const Value.absent(),
    this.colorPrimary = const Value.absent(),
    this.colorSecondary = const Value.absent(),
    this.logoWebpPath = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NbaTeamsCompanion.insert({
    required String teamId,
    required String name,
    required String city,
    required String conference,
    required String division,
    required String colorPrimary,
    required String colorSecondary,
    this.logoWebpPath = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : teamId = Value(teamId),
       name = Value(name),
       city = Value(city),
       conference = Value(conference),
       division = Value(division),
       colorPrimary = Value(colorPrimary),
       colorSecondary = Value(colorSecondary);
  static Insertable<NbaTeam> custom({
    Expression<String>? teamId,
    Expression<String>? name,
    Expression<String>? city,
    Expression<String>? conference,
    Expression<String>? division,
    Expression<String>? colorPrimary,
    Expression<String>? colorSecondary,
    Expression<String>? logoWebpPath,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (teamId != null) 'team_id': teamId,
      if (name != null) 'name': name,
      if (city != null) 'city': city,
      if (conference != null) 'conference': conference,
      if (division != null) 'division': division,
      if (colorPrimary != null) 'color_primary': colorPrimary,
      if (colorSecondary != null) 'color_secondary': colorSecondary,
      if (logoWebpPath != null) 'logo_webp_path': logoWebpPath,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NbaTeamsCompanion copyWith({
    Value<String>? teamId,
    Value<String>? name,
    Value<String>? city,
    Value<String>? conference,
    Value<String>? division,
    Value<String>? colorPrimary,
    Value<String>? colorSecondary,
    Value<String?>? logoWebpPath,
    Value<int>? rowid,
  }) {
    return NbaTeamsCompanion(
      teamId: teamId ?? this.teamId,
      name: name ?? this.name,
      city: city ?? this.city,
      conference: conference ?? this.conference,
      division: division ?? this.division,
      colorPrimary: colorPrimary ?? this.colorPrimary,
      colorSecondary: colorSecondary ?? this.colorSecondary,
      logoWebpPath: logoWebpPath ?? this.logoWebpPath,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (teamId.present) {
      map['team_id'] = Variable<String>(teamId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (city.present) {
      map['city'] = Variable<String>(city.value);
    }
    if (conference.present) {
      map['conference'] = Variable<String>(conference.value);
    }
    if (division.present) {
      map['division'] = Variable<String>(division.value);
    }
    if (colorPrimary.present) {
      map['color_primary'] = Variable<String>(colorPrimary.value);
    }
    if (colorSecondary.present) {
      map['color_secondary'] = Variable<String>(colorSecondary.value);
    }
    if (logoWebpPath.present) {
      map['logo_webp_path'] = Variable<String>(logoWebpPath.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NbaTeamsCompanion(')
          ..write('teamId: $teamId, ')
          ..write('name: $name, ')
          ..write('city: $city, ')
          ..write('conference: $conference, ')
          ..write('division: $division, ')
          ..write('colorPrimary: $colorPrimary, ')
          ..write('colorSecondary: $colorSecondary, ')
          ..write('logoWebpPath: $logoWebpPath, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PlayersTable extends Players with TableInfo<$PlayersTable, Player> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<String> playerId = GeneratedColumn<String>(
    'player_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teamIdMeta = const VerificationMeta('teamId');
  @override
  late final GeneratedColumn<String> teamId = GeneratedColumn<String>(
    'team_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES nba_teams (team_id)',
    ),
  );
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _positionMeta = const VerificationMeta(
    'position',
  );
  @override
  late final GeneratedColumn<String> position = GeneratedColumn<String>(
    'position',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _jerseyNumberMeta = const VerificationMeta(
    'jerseyNumber',
  );
  @override
  late final GeneratedColumn<String> jerseyNumber = GeneratedColumn<String>(
    'jersey_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heightCmMeta = const VerificationMeta(
    'heightCm',
  );
  @override
  late final GeneratedColumn<double> heightCm = GeneratedColumn<double>(
    'height_cm',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _weightKgMeta = const VerificationMeta(
    'weightKg',
  );
  @override
  late final GeneratedColumn<double> weightKg = GeneratedColumn<double>(
    'weight_kg',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _birthDateMeta = const VerificationMeta(
    'birthDate',
  );
  @override
  late final GeneratedColumn<DateTime> birthDate = GeneratedColumn<DateTime>(
    'birth_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _countryMeta = const VerificationMeta(
    'country',
  );
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
    'country',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _previousTeamMeta = const VerificationMeta(
    'previousTeam',
  );
  @override
  late final GeneratedColumn<String> previousTeam = GeneratedColumn<String>(
    'previous_team',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _experienceYearsMeta = const VerificationMeta(
    'experienceYears',
  );
  @override
  late final GeneratedColumn<int> experienceYears = GeneratedColumn<int>(
    'experience_years',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ppgMeta = const VerificationMeta('ppg');
  @override
  late final GeneratedColumn<double> ppg = GeneratedColumn<double>(
    'ppg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _rpgMeta = const VerificationMeta('rpg');
  @override
  late final GeneratedColumn<double> rpg = GeneratedColumn<double>(
    'rpg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _apgMeta = const VerificationMeta('apg');
  @override
  late final GeneratedColumn<double> apg = GeneratedColumn<double>(
    'apg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _spgMeta = const VerificationMeta('spg');
  @override
  late final GeneratedColumn<double> spg = GeneratedColumn<double>(
    'spg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _bpgMeta = const VerificationMeta('bpg');
  @override
  late final GeneratedColumn<double> bpg = GeneratedColumn<double>(
    'bpg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _mpgMeta = const VerificationMeta('mpg');
  @override
  late final GeneratedColumn<double> mpg = GeneratedColumn<double>(
    'mpg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _topgMeta = const VerificationMeta('topg');
  @override
  late final GeneratedColumn<double> topg = GeneratedColumn<double>(
    'topg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _fgPctMeta = const VerificationMeta('fgPct');
  @override
  late final GeneratedColumn<double> fgPct = GeneratedColumn<double>(
    'fg_pct',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _fg3PctMeta = const VerificationMeta('fg3Pct');
  @override
  late final GeneratedColumn<double> fg3Pct = GeneratedColumn<double>(
    'fg3_pct',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _ftPctMeta = const VerificationMeta('ftPct');
  @override
  late final GeneratedColumn<double> ftPct = GeneratedColumn<double>(
    'ft_pct',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _photoWebpPathMeta = const VerificationMeta(
    'photoWebpPath',
  );
  @override
  late final GeneratedColumn<String> photoWebpPath = GeneratedColumn<String>(
    'photo_webp_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _careerPointsMeta = const VerificationMeta(
    'careerPoints',
  );
  @override
  late final GeneratedColumn<int> careerPoints = GeneratedColumn<int>(
    'career_points',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _careerReboundsMeta = const VerificationMeta(
    'careerRebounds',
  );
  @override
  late final GeneratedColumn<int> careerRebounds = GeneratedColumn<int>(
    'career_rebounds',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _careerAssistsMeta = const VerificationMeta(
    'careerAssists',
  );
  @override
  late final GeneratedColumn<int> careerAssists = GeneratedColumn<int>(
    'career_assists',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _careerStealsMeta = const VerificationMeta(
    'careerSteals',
  );
  @override
  late final GeneratedColumn<int> careerSteals = GeneratedColumn<int>(
    'career_steals',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _careerBlocksMeta = const VerificationMeta(
    'careerBlocks',
  );
  @override
  late final GeneratedColumn<int> careerBlocks = GeneratedColumn<int>(
    'career_blocks',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _careerGamesMeta = const VerificationMeta(
    'careerGames',
  );
  @override
  late final GeneratedColumn<int> careerGames = GeneratedColumn<int>(
    'career_games',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _careerStartsMeta = const VerificationMeta(
    'careerStarts',
  );
  @override
  late final GeneratedColumn<int> careerStarts = GeneratedColumn<int>(
    'career_starts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _careerTurnoversMeta = const VerificationMeta(
    'careerTurnovers',
  );
  @override
  late final GeneratedColumn<int> careerTurnovers = GeneratedColumn<int>(
    'career_turnovers',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _careerTeamsMeta = const VerificationMeta(
    'careerTeams',
  );
  @override
  late final GeneratedColumn<String> careerTeams = GeneratedColumn<String>(
    'career_teams',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    playerId,
    teamId,
    fullName,
    displayName,
    position,
    jerseyNumber,
    heightCm,
    weightKg,
    birthDate,
    country,
    previousTeam,
    experienceYears,
    ppg,
    rpg,
    apg,
    spg,
    bpg,
    mpg,
    topg,
    fgPct,
    fg3Pct,
    ftPct,
    photoWebpPath,
    careerPoints,
    careerRebounds,
    careerAssists,
    careerSteals,
    careerBlocks,
    careerGames,
    careerStarts,
    careerTurnovers,
    careerTeams,
    cachedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'players';
  @override
  VerificationContext validateIntegrity(
    Insertable<Player> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('team_id')) {
      context.handle(
        _teamIdMeta,
        teamId.isAcceptableOrUnknown(data['team_id']!, _teamIdMeta),
      );
    } else if (isInserting) {
      context.missing(_teamIdMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    }
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
      );
    }
    if (data.containsKey('jersey_number')) {
      context.handle(
        _jerseyNumberMeta,
        jerseyNumber.isAcceptableOrUnknown(
          data['jersey_number']!,
          _jerseyNumberMeta,
        ),
      );
    }
    if (data.containsKey('height_cm')) {
      context.handle(
        _heightCmMeta,
        heightCm.isAcceptableOrUnknown(data['height_cm']!, _heightCmMeta),
      );
    }
    if (data.containsKey('weight_kg')) {
      context.handle(
        _weightKgMeta,
        weightKg.isAcceptableOrUnknown(data['weight_kg']!, _weightKgMeta),
      );
    }
    if (data.containsKey('birth_date')) {
      context.handle(
        _birthDateMeta,
        birthDate.isAcceptableOrUnknown(data['birth_date']!, _birthDateMeta),
      );
    }
    if (data.containsKey('country')) {
      context.handle(
        _countryMeta,
        country.isAcceptableOrUnknown(data['country']!, _countryMeta),
      );
    }
    if (data.containsKey('previous_team')) {
      context.handle(
        _previousTeamMeta,
        previousTeam.isAcceptableOrUnknown(
          data['previous_team']!,
          _previousTeamMeta,
        ),
      );
    }
    if (data.containsKey('experience_years')) {
      context.handle(
        _experienceYearsMeta,
        experienceYears.isAcceptableOrUnknown(
          data['experience_years']!,
          _experienceYearsMeta,
        ),
      );
    }
    if (data.containsKey('ppg')) {
      context.handle(
        _ppgMeta,
        ppg.isAcceptableOrUnknown(data['ppg']!, _ppgMeta),
      );
    }
    if (data.containsKey('rpg')) {
      context.handle(
        _rpgMeta,
        rpg.isAcceptableOrUnknown(data['rpg']!, _rpgMeta),
      );
    }
    if (data.containsKey('apg')) {
      context.handle(
        _apgMeta,
        apg.isAcceptableOrUnknown(data['apg']!, _apgMeta),
      );
    }
    if (data.containsKey('spg')) {
      context.handle(
        _spgMeta,
        spg.isAcceptableOrUnknown(data['spg']!, _spgMeta),
      );
    }
    if (data.containsKey('bpg')) {
      context.handle(
        _bpgMeta,
        bpg.isAcceptableOrUnknown(data['bpg']!, _bpgMeta),
      );
    }
    if (data.containsKey('mpg')) {
      context.handle(
        _mpgMeta,
        mpg.isAcceptableOrUnknown(data['mpg']!, _mpgMeta),
      );
    }
    if (data.containsKey('topg')) {
      context.handle(
        _topgMeta,
        topg.isAcceptableOrUnknown(data['topg']!, _topgMeta),
      );
    }
    if (data.containsKey('fg_pct')) {
      context.handle(
        _fgPctMeta,
        fgPct.isAcceptableOrUnknown(data['fg_pct']!, _fgPctMeta),
      );
    }
    if (data.containsKey('fg3_pct')) {
      context.handle(
        _fg3PctMeta,
        fg3Pct.isAcceptableOrUnknown(data['fg3_pct']!, _fg3PctMeta),
      );
    }
    if (data.containsKey('ft_pct')) {
      context.handle(
        _ftPctMeta,
        ftPct.isAcceptableOrUnknown(data['ft_pct']!, _ftPctMeta),
      );
    }
    if (data.containsKey('photo_webp_path')) {
      context.handle(
        _photoWebpPathMeta,
        photoWebpPath.isAcceptableOrUnknown(
          data['photo_webp_path']!,
          _photoWebpPathMeta,
        ),
      );
    }
    if (data.containsKey('career_points')) {
      context.handle(
        _careerPointsMeta,
        careerPoints.isAcceptableOrUnknown(
          data['career_points']!,
          _careerPointsMeta,
        ),
      );
    }
    if (data.containsKey('career_rebounds')) {
      context.handle(
        _careerReboundsMeta,
        careerRebounds.isAcceptableOrUnknown(
          data['career_rebounds']!,
          _careerReboundsMeta,
        ),
      );
    }
    if (data.containsKey('career_assists')) {
      context.handle(
        _careerAssistsMeta,
        careerAssists.isAcceptableOrUnknown(
          data['career_assists']!,
          _careerAssistsMeta,
        ),
      );
    }
    if (data.containsKey('career_steals')) {
      context.handle(
        _careerStealsMeta,
        careerSteals.isAcceptableOrUnknown(
          data['career_steals']!,
          _careerStealsMeta,
        ),
      );
    }
    if (data.containsKey('career_blocks')) {
      context.handle(
        _careerBlocksMeta,
        careerBlocks.isAcceptableOrUnknown(
          data['career_blocks']!,
          _careerBlocksMeta,
        ),
      );
    }
    if (data.containsKey('career_games')) {
      context.handle(
        _careerGamesMeta,
        careerGames.isAcceptableOrUnknown(
          data['career_games']!,
          _careerGamesMeta,
        ),
      );
    }
    if (data.containsKey('career_starts')) {
      context.handle(
        _careerStartsMeta,
        careerStarts.isAcceptableOrUnknown(
          data['career_starts']!,
          _careerStartsMeta,
        ),
      );
    }
    if (data.containsKey('career_turnovers')) {
      context.handle(
        _careerTurnoversMeta,
        careerTurnovers.isAcceptableOrUnknown(
          data['career_turnovers']!,
          _careerTurnoversMeta,
        ),
      );
    }
    if (data.containsKey('career_teams')) {
      context.handle(
        _careerTeamsMeta,
        careerTeams.isAcceptableOrUnknown(
          data['career_teams']!,
          _careerTeamsMeta,
        ),
      );
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {playerId};
  @override
  Player map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Player(
      playerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}player_id'],
      )!,
      teamId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}team_id'],
      )!,
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      )!,
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      ),
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}position'],
      ),
      jerseyNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}jersey_number'],
      ),
      heightCm: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}height_cm'],
      ),
      weightKg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}weight_kg'],
      ),
      birthDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}birth_date'],
      ),
      country: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country'],
      ),
      previousTeam: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}previous_team'],
      ),
      experienceYears: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}experience_years'],
      ),
      ppg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ppg'],
      )!,
      rpg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rpg'],
      )!,
      apg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}apg'],
      )!,
      spg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}spg'],
      )!,
      bpg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}bpg'],
      )!,
      mpg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}mpg'],
      )!,
      topg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}topg'],
      )!,
      fgPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fg_pct'],
      )!,
      fg3Pct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fg3_pct'],
      )!,
      ftPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ft_pct'],
      )!,
      photoWebpPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_webp_path'],
      ),
      careerPoints: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}career_points'],
      )!,
      careerRebounds: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}career_rebounds'],
      )!,
      careerAssists: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}career_assists'],
      )!,
      careerSteals: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}career_steals'],
      )!,
      careerBlocks: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}career_blocks'],
      )!,
      careerGames: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}career_games'],
      )!,
      careerStarts: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}career_starts'],
      )!,
      careerTurnovers: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}career_turnovers'],
      )!,
      careerTeams: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}career_teams'],
      ),
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $PlayersTable createAlias(String alias) {
    return $PlayersTable(attachedDatabase, alias);
  }
}

class Player extends DataClass implements Insertable<Player> {
  final String playerId;
  final String teamId;
  final String fullName;
  final String? displayName;
  final String? position;
  final String? jerseyNumber;
  final double? heightCm;
  final double? weightKg;
  final DateTime? birthDate;
  final String? country;
  final String? previousTeam;
  final int? experienceYears;
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
  final String? photoWebpPath;
  final int careerPoints;
  final int careerRebounds;
  final int careerAssists;
  final int careerSteals;
  final int careerBlocks;
  final int careerGames;
  final int careerStarts;
  final int careerTurnovers;
  final String? careerTeams;
  final DateTime cachedAt;
  const Player({
    required this.playerId,
    required this.teamId,
    required this.fullName,
    this.displayName,
    this.position,
    this.jerseyNumber,
    this.heightCm,
    this.weightKg,
    this.birthDate,
    this.country,
    this.previousTeam,
    this.experienceYears,
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
    this.photoWebpPath,
    required this.careerPoints,
    required this.careerRebounds,
    required this.careerAssists,
    required this.careerSteals,
    required this.careerBlocks,
    required this.careerGames,
    required this.careerStarts,
    required this.careerTurnovers,
    this.careerTeams,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['player_id'] = Variable<String>(playerId);
    map['team_id'] = Variable<String>(teamId);
    map['full_name'] = Variable<String>(fullName);
    if (!nullToAbsent || displayName != null) {
      map['display_name'] = Variable<String>(displayName);
    }
    if (!nullToAbsent || position != null) {
      map['position'] = Variable<String>(position);
    }
    if (!nullToAbsent || jerseyNumber != null) {
      map['jersey_number'] = Variable<String>(jerseyNumber);
    }
    if (!nullToAbsent || heightCm != null) {
      map['height_cm'] = Variable<double>(heightCm);
    }
    if (!nullToAbsent || weightKg != null) {
      map['weight_kg'] = Variable<double>(weightKg);
    }
    if (!nullToAbsent || birthDate != null) {
      map['birth_date'] = Variable<DateTime>(birthDate);
    }
    if (!nullToAbsent || country != null) {
      map['country'] = Variable<String>(country);
    }
    if (!nullToAbsent || previousTeam != null) {
      map['previous_team'] = Variable<String>(previousTeam);
    }
    if (!nullToAbsent || experienceYears != null) {
      map['experience_years'] = Variable<int>(experienceYears);
    }
    map['ppg'] = Variable<double>(ppg);
    map['rpg'] = Variable<double>(rpg);
    map['apg'] = Variable<double>(apg);
    map['spg'] = Variable<double>(spg);
    map['bpg'] = Variable<double>(bpg);
    map['mpg'] = Variable<double>(mpg);
    map['topg'] = Variable<double>(topg);
    map['fg_pct'] = Variable<double>(fgPct);
    map['fg3_pct'] = Variable<double>(fg3Pct);
    map['ft_pct'] = Variable<double>(ftPct);
    if (!nullToAbsent || photoWebpPath != null) {
      map['photo_webp_path'] = Variable<String>(photoWebpPath);
    }
    map['career_points'] = Variable<int>(careerPoints);
    map['career_rebounds'] = Variable<int>(careerRebounds);
    map['career_assists'] = Variable<int>(careerAssists);
    map['career_steals'] = Variable<int>(careerSteals);
    map['career_blocks'] = Variable<int>(careerBlocks);
    map['career_games'] = Variable<int>(careerGames);
    map['career_starts'] = Variable<int>(careerStarts);
    map['career_turnovers'] = Variable<int>(careerTurnovers);
    if (!nullToAbsent || careerTeams != null) {
      map['career_teams'] = Variable<String>(careerTeams);
    }
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  PlayersCompanion toCompanion(bool nullToAbsent) {
    return PlayersCompanion(
      playerId: Value(playerId),
      teamId: Value(teamId),
      fullName: Value(fullName),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      position: position == null && nullToAbsent
          ? const Value.absent()
          : Value(position),
      jerseyNumber: jerseyNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(jerseyNumber),
      heightCm: heightCm == null && nullToAbsent
          ? const Value.absent()
          : Value(heightCm),
      weightKg: weightKg == null && nullToAbsent
          ? const Value.absent()
          : Value(weightKg),
      birthDate: birthDate == null && nullToAbsent
          ? const Value.absent()
          : Value(birthDate),
      country: country == null && nullToAbsent
          ? const Value.absent()
          : Value(country),
      previousTeam: previousTeam == null && nullToAbsent
          ? const Value.absent()
          : Value(previousTeam),
      experienceYears: experienceYears == null && nullToAbsent
          ? const Value.absent()
          : Value(experienceYears),
      ppg: Value(ppg),
      rpg: Value(rpg),
      apg: Value(apg),
      spg: Value(spg),
      bpg: Value(bpg),
      mpg: Value(mpg),
      topg: Value(topg),
      fgPct: Value(fgPct),
      fg3Pct: Value(fg3Pct),
      ftPct: Value(ftPct),
      photoWebpPath: photoWebpPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoWebpPath),
      careerPoints: Value(careerPoints),
      careerRebounds: Value(careerRebounds),
      careerAssists: Value(careerAssists),
      careerSteals: Value(careerSteals),
      careerBlocks: Value(careerBlocks),
      careerGames: Value(careerGames),
      careerStarts: Value(careerStarts),
      careerTurnovers: Value(careerTurnovers),
      careerTeams: careerTeams == null && nullToAbsent
          ? const Value.absent()
          : Value(careerTeams),
      cachedAt: Value(cachedAt),
    );
  }

  factory Player.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Player(
      playerId: serializer.fromJson<String>(json['playerId']),
      teamId: serializer.fromJson<String>(json['teamId']),
      fullName: serializer.fromJson<String>(json['fullName']),
      displayName: serializer.fromJson<String?>(json['displayName']),
      position: serializer.fromJson<String?>(json['position']),
      jerseyNumber: serializer.fromJson<String?>(json['jerseyNumber']),
      heightCm: serializer.fromJson<double?>(json['heightCm']),
      weightKg: serializer.fromJson<double?>(json['weightKg']),
      birthDate: serializer.fromJson<DateTime?>(json['birthDate']),
      country: serializer.fromJson<String?>(json['country']),
      previousTeam: serializer.fromJson<String?>(json['previousTeam']),
      experienceYears: serializer.fromJson<int?>(json['experienceYears']),
      ppg: serializer.fromJson<double>(json['ppg']),
      rpg: serializer.fromJson<double>(json['rpg']),
      apg: serializer.fromJson<double>(json['apg']),
      spg: serializer.fromJson<double>(json['spg']),
      bpg: serializer.fromJson<double>(json['bpg']),
      mpg: serializer.fromJson<double>(json['mpg']),
      topg: serializer.fromJson<double>(json['topg']),
      fgPct: serializer.fromJson<double>(json['fgPct']),
      fg3Pct: serializer.fromJson<double>(json['fg3Pct']),
      ftPct: serializer.fromJson<double>(json['ftPct']),
      photoWebpPath: serializer.fromJson<String?>(json['photoWebpPath']),
      careerPoints: serializer.fromJson<int>(json['careerPoints']),
      careerRebounds: serializer.fromJson<int>(json['careerRebounds']),
      careerAssists: serializer.fromJson<int>(json['careerAssists']),
      careerSteals: serializer.fromJson<int>(json['careerSteals']),
      careerBlocks: serializer.fromJson<int>(json['careerBlocks']),
      careerGames: serializer.fromJson<int>(json['careerGames']),
      careerStarts: serializer.fromJson<int>(json['careerStarts']),
      careerTurnovers: serializer.fromJson<int>(json['careerTurnovers']),
      careerTeams: serializer.fromJson<String?>(json['careerTeams']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'playerId': serializer.toJson<String>(playerId),
      'teamId': serializer.toJson<String>(teamId),
      'fullName': serializer.toJson<String>(fullName),
      'displayName': serializer.toJson<String?>(displayName),
      'position': serializer.toJson<String?>(position),
      'jerseyNumber': serializer.toJson<String?>(jerseyNumber),
      'heightCm': serializer.toJson<double?>(heightCm),
      'weightKg': serializer.toJson<double?>(weightKg),
      'birthDate': serializer.toJson<DateTime?>(birthDate),
      'country': serializer.toJson<String?>(country),
      'previousTeam': serializer.toJson<String?>(previousTeam),
      'experienceYears': serializer.toJson<int?>(experienceYears),
      'ppg': serializer.toJson<double>(ppg),
      'rpg': serializer.toJson<double>(rpg),
      'apg': serializer.toJson<double>(apg),
      'spg': serializer.toJson<double>(spg),
      'bpg': serializer.toJson<double>(bpg),
      'mpg': serializer.toJson<double>(mpg),
      'topg': serializer.toJson<double>(topg),
      'fgPct': serializer.toJson<double>(fgPct),
      'fg3Pct': serializer.toJson<double>(fg3Pct),
      'ftPct': serializer.toJson<double>(ftPct),
      'photoWebpPath': serializer.toJson<String?>(photoWebpPath),
      'careerPoints': serializer.toJson<int>(careerPoints),
      'careerRebounds': serializer.toJson<int>(careerRebounds),
      'careerAssists': serializer.toJson<int>(careerAssists),
      'careerSteals': serializer.toJson<int>(careerSteals),
      'careerBlocks': serializer.toJson<int>(careerBlocks),
      'careerGames': serializer.toJson<int>(careerGames),
      'careerStarts': serializer.toJson<int>(careerStarts),
      'careerTurnovers': serializer.toJson<int>(careerTurnovers),
      'careerTeams': serializer.toJson<String?>(careerTeams),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  Player copyWith({
    String? playerId,
    String? teamId,
    String? fullName,
    Value<String?> displayName = const Value.absent(),
    Value<String?> position = const Value.absent(),
    Value<String?> jerseyNumber = const Value.absent(),
    Value<double?> heightCm = const Value.absent(),
    Value<double?> weightKg = const Value.absent(),
    Value<DateTime?> birthDate = const Value.absent(),
    Value<String?> country = const Value.absent(),
    Value<String?> previousTeam = const Value.absent(),
    Value<int?> experienceYears = const Value.absent(),
    double? ppg,
    double? rpg,
    double? apg,
    double? spg,
    double? bpg,
    double? mpg,
    double? topg,
    double? fgPct,
    double? fg3Pct,
    double? ftPct,
    Value<String?> photoWebpPath = const Value.absent(),
    int? careerPoints,
    int? careerRebounds,
    int? careerAssists,
    int? careerSteals,
    int? careerBlocks,
    int? careerGames,
    int? careerStarts,
    int? careerTurnovers,
    Value<String?> careerTeams = const Value.absent(),
    DateTime? cachedAt,
  }) => Player(
    playerId: playerId ?? this.playerId,
    teamId: teamId ?? this.teamId,
    fullName: fullName ?? this.fullName,
    displayName: displayName.present ? displayName.value : this.displayName,
    position: position.present ? position.value : this.position,
    jerseyNumber: jerseyNumber.present ? jerseyNumber.value : this.jerseyNumber,
    heightCm: heightCm.present ? heightCm.value : this.heightCm,
    weightKg: weightKg.present ? weightKg.value : this.weightKg,
    birthDate: birthDate.present ? birthDate.value : this.birthDate,
    country: country.present ? country.value : this.country,
    previousTeam: previousTeam.present ? previousTeam.value : this.previousTeam,
    experienceYears: experienceYears.present
        ? experienceYears.value
        : this.experienceYears,
    ppg: ppg ?? this.ppg,
    rpg: rpg ?? this.rpg,
    apg: apg ?? this.apg,
    spg: spg ?? this.spg,
    bpg: bpg ?? this.bpg,
    mpg: mpg ?? this.mpg,
    topg: topg ?? this.topg,
    fgPct: fgPct ?? this.fgPct,
    fg3Pct: fg3Pct ?? this.fg3Pct,
    ftPct: ftPct ?? this.ftPct,
    photoWebpPath: photoWebpPath.present
        ? photoWebpPath.value
        : this.photoWebpPath,
    careerPoints: careerPoints ?? this.careerPoints,
    careerRebounds: careerRebounds ?? this.careerRebounds,
    careerAssists: careerAssists ?? this.careerAssists,
    careerSteals: careerSteals ?? this.careerSteals,
    careerBlocks: careerBlocks ?? this.careerBlocks,
    careerGames: careerGames ?? this.careerGames,
    careerStarts: careerStarts ?? this.careerStarts,
    careerTurnovers: careerTurnovers ?? this.careerTurnovers,
    careerTeams: careerTeams.present ? careerTeams.value : this.careerTeams,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  Player copyWithCompanion(PlayersCompanion data) {
    return Player(
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      teamId: data.teamId.present ? data.teamId.value : this.teamId,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      position: data.position.present ? data.position.value : this.position,
      jerseyNumber: data.jerseyNumber.present
          ? data.jerseyNumber.value
          : this.jerseyNumber,
      heightCm: data.heightCm.present ? data.heightCm.value : this.heightCm,
      weightKg: data.weightKg.present ? data.weightKg.value : this.weightKg,
      birthDate: data.birthDate.present ? data.birthDate.value : this.birthDate,
      country: data.country.present ? data.country.value : this.country,
      previousTeam: data.previousTeam.present
          ? data.previousTeam.value
          : this.previousTeam,
      experienceYears: data.experienceYears.present
          ? data.experienceYears.value
          : this.experienceYears,
      ppg: data.ppg.present ? data.ppg.value : this.ppg,
      rpg: data.rpg.present ? data.rpg.value : this.rpg,
      apg: data.apg.present ? data.apg.value : this.apg,
      spg: data.spg.present ? data.spg.value : this.spg,
      bpg: data.bpg.present ? data.bpg.value : this.bpg,
      mpg: data.mpg.present ? data.mpg.value : this.mpg,
      topg: data.topg.present ? data.topg.value : this.topg,
      fgPct: data.fgPct.present ? data.fgPct.value : this.fgPct,
      fg3Pct: data.fg3Pct.present ? data.fg3Pct.value : this.fg3Pct,
      ftPct: data.ftPct.present ? data.ftPct.value : this.ftPct,
      photoWebpPath: data.photoWebpPath.present
          ? data.photoWebpPath.value
          : this.photoWebpPath,
      careerPoints: data.careerPoints.present
          ? data.careerPoints.value
          : this.careerPoints,
      careerRebounds: data.careerRebounds.present
          ? data.careerRebounds.value
          : this.careerRebounds,
      careerAssists: data.careerAssists.present
          ? data.careerAssists.value
          : this.careerAssists,
      careerSteals: data.careerSteals.present
          ? data.careerSteals.value
          : this.careerSteals,
      careerBlocks: data.careerBlocks.present
          ? data.careerBlocks.value
          : this.careerBlocks,
      careerGames: data.careerGames.present
          ? data.careerGames.value
          : this.careerGames,
      careerStarts: data.careerStarts.present
          ? data.careerStarts.value
          : this.careerStarts,
      careerTurnovers: data.careerTurnovers.present
          ? data.careerTurnovers.value
          : this.careerTurnovers,
      careerTeams: data.careerTeams.present
          ? data.careerTeams.value
          : this.careerTeams,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Player(')
          ..write('playerId: $playerId, ')
          ..write('teamId: $teamId, ')
          ..write('fullName: $fullName, ')
          ..write('displayName: $displayName, ')
          ..write('position: $position, ')
          ..write('jerseyNumber: $jerseyNumber, ')
          ..write('heightCm: $heightCm, ')
          ..write('weightKg: $weightKg, ')
          ..write('birthDate: $birthDate, ')
          ..write('country: $country, ')
          ..write('previousTeam: $previousTeam, ')
          ..write('experienceYears: $experienceYears, ')
          ..write('ppg: $ppg, ')
          ..write('rpg: $rpg, ')
          ..write('apg: $apg, ')
          ..write('spg: $spg, ')
          ..write('bpg: $bpg, ')
          ..write('mpg: $mpg, ')
          ..write('topg: $topg, ')
          ..write('fgPct: $fgPct, ')
          ..write('fg3Pct: $fg3Pct, ')
          ..write('ftPct: $ftPct, ')
          ..write('photoWebpPath: $photoWebpPath, ')
          ..write('careerPoints: $careerPoints, ')
          ..write('careerRebounds: $careerRebounds, ')
          ..write('careerAssists: $careerAssists, ')
          ..write('careerSteals: $careerSteals, ')
          ..write('careerBlocks: $careerBlocks, ')
          ..write('careerGames: $careerGames, ')
          ..write('careerStarts: $careerStarts, ')
          ..write('careerTurnovers: $careerTurnovers, ')
          ..write('careerTeams: $careerTeams, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    playerId,
    teamId,
    fullName,
    displayName,
    position,
    jerseyNumber,
    heightCm,
    weightKg,
    birthDate,
    country,
    previousTeam,
    experienceYears,
    ppg,
    rpg,
    apg,
    spg,
    bpg,
    mpg,
    topg,
    fgPct,
    fg3Pct,
    ftPct,
    photoWebpPath,
    careerPoints,
    careerRebounds,
    careerAssists,
    careerSteals,
    careerBlocks,
    careerGames,
    careerStarts,
    careerTurnovers,
    careerTeams,
    cachedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Player &&
          other.playerId == this.playerId &&
          other.teamId == this.teamId &&
          other.fullName == this.fullName &&
          other.displayName == this.displayName &&
          other.position == this.position &&
          other.jerseyNumber == this.jerseyNumber &&
          other.heightCm == this.heightCm &&
          other.weightKg == this.weightKg &&
          other.birthDate == this.birthDate &&
          other.country == this.country &&
          other.previousTeam == this.previousTeam &&
          other.experienceYears == this.experienceYears &&
          other.ppg == this.ppg &&
          other.rpg == this.rpg &&
          other.apg == this.apg &&
          other.spg == this.spg &&
          other.bpg == this.bpg &&
          other.mpg == this.mpg &&
          other.topg == this.topg &&
          other.fgPct == this.fgPct &&
          other.fg3Pct == this.fg3Pct &&
          other.ftPct == this.ftPct &&
          other.photoWebpPath == this.photoWebpPath &&
          other.careerPoints == this.careerPoints &&
          other.careerRebounds == this.careerRebounds &&
          other.careerAssists == this.careerAssists &&
          other.careerSteals == this.careerSteals &&
          other.careerBlocks == this.careerBlocks &&
          other.careerGames == this.careerGames &&
          other.careerStarts == this.careerStarts &&
          other.careerTurnovers == this.careerTurnovers &&
          other.careerTeams == this.careerTeams &&
          other.cachedAt == this.cachedAt);
}

class PlayersCompanion extends UpdateCompanion<Player> {
  final Value<String> playerId;
  final Value<String> teamId;
  final Value<String> fullName;
  final Value<String?> displayName;
  final Value<String?> position;
  final Value<String?> jerseyNumber;
  final Value<double?> heightCm;
  final Value<double?> weightKg;
  final Value<DateTime?> birthDate;
  final Value<String?> country;
  final Value<String?> previousTeam;
  final Value<int?> experienceYears;
  final Value<double> ppg;
  final Value<double> rpg;
  final Value<double> apg;
  final Value<double> spg;
  final Value<double> bpg;
  final Value<double> mpg;
  final Value<double> topg;
  final Value<double> fgPct;
  final Value<double> fg3Pct;
  final Value<double> ftPct;
  final Value<String?> photoWebpPath;
  final Value<int> careerPoints;
  final Value<int> careerRebounds;
  final Value<int> careerAssists;
  final Value<int> careerSteals;
  final Value<int> careerBlocks;
  final Value<int> careerGames;
  final Value<int> careerStarts;
  final Value<int> careerTurnovers;
  final Value<String?> careerTeams;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const PlayersCompanion({
    this.playerId = const Value.absent(),
    this.teamId = const Value.absent(),
    this.fullName = const Value.absent(),
    this.displayName = const Value.absent(),
    this.position = const Value.absent(),
    this.jerseyNumber = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.country = const Value.absent(),
    this.previousTeam = const Value.absent(),
    this.experienceYears = const Value.absent(),
    this.ppg = const Value.absent(),
    this.rpg = const Value.absent(),
    this.apg = const Value.absent(),
    this.spg = const Value.absent(),
    this.bpg = const Value.absent(),
    this.mpg = const Value.absent(),
    this.topg = const Value.absent(),
    this.fgPct = const Value.absent(),
    this.fg3Pct = const Value.absent(),
    this.ftPct = const Value.absent(),
    this.photoWebpPath = const Value.absent(),
    this.careerPoints = const Value.absent(),
    this.careerRebounds = const Value.absent(),
    this.careerAssists = const Value.absent(),
    this.careerSteals = const Value.absent(),
    this.careerBlocks = const Value.absent(),
    this.careerGames = const Value.absent(),
    this.careerStarts = const Value.absent(),
    this.careerTurnovers = const Value.absent(),
    this.careerTeams = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlayersCompanion.insert({
    required String playerId,
    required String teamId,
    required String fullName,
    this.displayName = const Value.absent(),
    this.position = const Value.absent(),
    this.jerseyNumber = const Value.absent(),
    this.heightCm = const Value.absent(),
    this.weightKg = const Value.absent(),
    this.birthDate = const Value.absent(),
    this.country = const Value.absent(),
    this.previousTeam = const Value.absent(),
    this.experienceYears = const Value.absent(),
    this.ppg = const Value.absent(),
    this.rpg = const Value.absent(),
    this.apg = const Value.absent(),
    this.spg = const Value.absent(),
    this.bpg = const Value.absent(),
    this.mpg = const Value.absent(),
    this.topg = const Value.absent(),
    this.fgPct = const Value.absent(),
    this.fg3Pct = const Value.absent(),
    this.ftPct = const Value.absent(),
    this.photoWebpPath = const Value.absent(),
    this.careerPoints = const Value.absent(),
    this.careerRebounds = const Value.absent(),
    this.careerAssists = const Value.absent(),
    this.careerSteals = const Value.absent(),
    this.careerBlocks = const Value.absent(),
    this.careerGames = const Value.absent(),
    this.careerStarts = const Value.absent(),
    this.careerTurnovers = const Value.absent(),
    this.careerTeams = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : playerId = Value(playerId),
       teamId = Value(teamId),
       fullName = Value(fullName);
  static Insertable<Player> custom({
    Expression<String>? playerId,
    Expression<String>? teamId,
    Expression<String>? fullName,
    Expression<String>? displayName,
    Expression<String>? position,
    Expression<String>? jerseyNumber,
    Expression<double>? heightCm,
    Expression<double>? weightKg,
    Expression<DateTime>? birthDate,
    Expression<String>? country,
    Expression<String>? previousTeam,
    Expression<int>? experienceYears,
    Expression<double>? ppg,
    Expression<double>? rpg,
    Expression<double>? apg,
    Expression<double>? spg,
    Expression<double>? bpg,
    Expression<double>? mpg,
    Expression<double>? topg,
    Expression<double>? fgPct,
    Expression<double>? fg3Pct,
    Expression<double>? ftPct,
    Expression<String>? photoWebpPath,
    Expression<int>? careerPoints,
    Expression<int>? careerRebounds,
    Expression<int>? careerAssists,
    Expression<int>? careerSteals,
    Expression<int>? careerBlocks,
    Expression<int>? careerGames,
    Expression<int>? careerStarts,
    Expression<int>? careerTurnovers,
    Expression<String>? careerTeams,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (playerId != null) 'player_id': playerId,
      if (teamId != null) 'team_id': teamId,
      if (fullName != null) 'full_name': fullName,
      if (displayName != null) 'display_name': displayName,
      if (position != null) 'position': position,
      if (jerseyNumber != null) 'jersey_number': jerseyNumber,
      if (heightCm != null) 'height_cm': heightCm,
      if (weightKg != null) 'weight_kg': weightKg,
      if (birthDate != null) 'birth_date': birthDate,
      if (country != null) 'country': country,
      if (previousTeam != null) 'previous_team': previousTeam,
      if (experienceYears != null) 'experience_years': experienceYears,
      if (ppg != null) 'ppg': ppg,
      if (rpg != null) 'rpg': rpg,
      if (apg != null) 'apg': apg,
      if (spg != null) 'spg': spg,
      if (bpg != null) 'bpg': bpg,
      if (mpg != null) 'mpg': mpg,
      if (topg != null) 'topg': topg,
      if (fgPct != null) 'fg_pct': fgPct,
      if (fg3Pct != null) 'fg3_pct': fg3Pct,
      if (ftPct != null) 'ft_pct': ftPct,
      if (photoWebpPath != null) 'photo_webp_path': photoWebpPath,
      if (careerPoints != null) 'career_points': careerPoints,
      if (careerRebounds != null) 'career_rebounds': careerRebounds,
      if (careerAssists != null) 'career_assists': careerAssists,
      if (careerSteals != null) 'career_steals': careerSteals,
      if (careerBlocks != null) 'career_blocks': careerBlocks,
      if (careerGames != null) 'career_games': careerGames,
      if (careerStarts != null) 'career_starts': careerStarts,
      if (careerTurnovers != null) 'career_turnovers': careerTurnovers,
      if (careerTeams != null) 'career_teams': careerTeams,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlayersCompanion copyWith({
    Value<String>? playerId,
    Value<String>? teamId,
    Value<String>? fullName,
    Value<String?>? displayName,
    Value<String?>? position,
    Value<String?>? jerseyNumber,
    Value<double?>? heightCm,
    Value<double?>? weightKg,
    Value<DateTime?>? birthDate,
    Value<String?>? country,
    Value<String?>? previousTeam,
    Value<int?>? experienceYears,
    Value<double>? ppg,
    Value<double>? rpg,
    Value<double>? apg,
    Value<double>? spg,
    Value<double>? bpg,
    Value<double>? mpg,
    Value<double>? topg,
    Value<double>? fgPct,
    Value<double>? fg3Pct,
    Value<double>? ftPct,
    Value<String?>? photoWebpPath,
    Value<int>? careerPoints,
    Value<int>? careerRebounds,
    Value<int>? careerAssists,
    Value<int>? careerSteals,
    Value<int>? careerBlocks,
    Value<int>? careerGames,
    Value<int>? careerStarts,
    Value<int>? careerTurnovers,
    Value<String?>? careerTeams,
    Value<DateTime>? cachedAt,
    Value<int>? rowid,
  }) {
    return PlayersCompanion(
      playerId: playerId ?? this.playerId,
      teamId: teamId ?? this.teamId,
      fullName: fullName ?? this.fullName,
      displayName: displayName ?? this.displayName,
      position: position ?? this.position,
      jerseyNumber: jerseyNumber ?? this.jerseyNumber,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      birthDate: birthDate ?? this.birthDate,
      country: country ?? this.country,
      previousTeam: previousTeam ?? this.previousTeam,
      experienceYears: experienceYears ?? this.experienceYears,
      ppg: ppg ?? this.ppg,
      rpg: rpg ?? this.rpg,
      apg: apg ?? this.apg,
      spg: spg ?? this.spg,
      bpg: bpg ?? this.bpg,
      mpg: mpg ?? this.mpg,
      topg: topg ?? this.topg,
      fgPct: fgPct ?? this.fgPct,
      fg3Pct: fg3Pct ?? this.fg3Pct,
      ftPct: ftPct ?? this.ftPct,
      photoWebpPath: photoWebpPath ?? this.photoWebpPath,
      careerPoints: careerPoints ?? this.careerPoints,
      careerRebounds: careerRebounds ?? this.careerRebounds,
      careerAssists: careerAssists ?? this.careerAssists,
      careerSteals: careerSteals ?? this.careerSteals,
      careerBlocks: careerBlocks ?? this.careerBlocks,
      careerGames: careerGames ?? this.careerGames,
      careerStarts: careerStarts ?? this.careerStarts,
      careerTurnovers: careerTurnovers ?? this.careerTurnovers,
      careerTeams: careerTeams ?? this.careerTeams,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (playerId.present) {
      map['player_id'] = Variable<String>(playerId.value);
    }
    if (teamId.present) {
      map['team_id'] = Variable<String>(teamId.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (position.present) {
      map['position'] = Variable<String>(position.value);
    }
    if (jerseyNumber.present) {
      map['jersey_number'] = Variable<String>(jerseyNumber.value);
    }
    if (heightCm.present) {
      map['height_cm'] = Variable<double>(heightCm.value);
    }
    if (weightKg.present) {
      map['weight_kg'] = Variable<double>(weightKg.value);
    }
    if (birthDate.present) {
      map['birth_date'] = Variable<DateTime>(birthDate.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (previousTeam.present) {
      map['previous_team'] = Variable<String>(previousTeam.value);
    }
    if (experienceYears.present) {
      map['experience_years'] = Variable<int>(experienceYears.value);
    }
    if (ppg.present) {
      map['ppg'] = Variable<double>(ppg.value);
    }
    if (rpg.present) {
      map['rpg'] = Variable<double>(rpg.value);
    }
    if (apg.present) {
      map['apg'] = Variable<double>(apg.value);
    }
    if (spg.present) {
      map['spg'] = Variable<double>(spg.value);
    }
    if (bpg.present) {
      map['bpg'] = Variable<double>(bpg.value);
    }
    if (mpg.present) {
      map['mpg'] = Variable<double>(mpg.value);
    }
    if (topg.present) {
      map['topg'] = Variable<double>(topg.value);
    }
    if (fgPct.present) {
      map['fg_pct'] = Variable<double>(fgPct.value);
    }
    if (fg3Pct.present) {
      map['fg3_pct'] = Variable<double>(fg3Pct.value);
    }
    if (ftPct.present) {
      map['ft_pct'] = Variable<double>(ftPct.value);
    }
    if (photoWebpPath.present) {
      map['photo_webp_path'] = Variable<String>(photoWebpPath.value);
    }
    if (careerPoints.present) {
      map['career_points'] = Variable<int>(careerPoints.value);
    }
    if (careerRebounds.present) {
      map['career_rebounds'] = Variable<int>(careerRebounds.value);
    }
    if (careerAssists.present) {
      map['career_assists'] = Variable<int>(careerAssists.value);
    }
    if (careerSteals.present) {
      map['career_steals'] = Variable<int>(careerSteals.value);
    }
    if (careerBlocks.present) {
      map['career_blocks'] = Variable<int>(careerBlocks.value);
    }
    if (careerGames.present) {
      map['career_games'] = Variable<int>(careerGames.value);
    }
    if (careerStarts.present) {
      map['career_starts'] = Variable<int>(careerStarts.value);
    }
    if (careerTurnovers.present) {
      map['career_turnovers'] = Variable<int>(careerTurnovers.value);
    }
    if (careerTeams.present) {
      map['career_teams'] = Variable<String>(careerTeams.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayersCompanion(')
          ..write('playerId: $playerId, ')
          ..write('teamId: $teamId, ')
          ..write('fullName: $fullName, ')
          ..write('displayName: $displayName, ')
          ..write('position: $position, ')
          ..write('jerseyNumber: $jerseyNumber, ')
          ..write('heightCm: $heightCm, ')
          ..write('weightKg: $weightKg, ')
          ..write('birthDate: $birthDate, ')
          ..write('country: $country, ')
          ..write('previousTeam: $previousTeam, ')
          ..write('experienceYears: $experienceYears, ')
          ..write('ppg: $ppg, ')
          ..write('rpg: $rpg, ')
          ..write('apg: $apg, ')
          ..write('spg: $spg, ')
          ..write('bpg: $bpg, ')
          ..write('mpg: $mpg, ')
          ..write('topg: $topg, ')
          ..write('fgPct: $fgPct, ')
          ..write('fg3Pct: $fg3Pct, ')
          ..write('ftPct: $ftPct, ')
          ..write('photoWebpPath: $photoWebpPath, ')
          ..write('careerPoints: $careerPoints, ')
          ..write('careerRebounds: $careerRebounds, ')
          ..write('careerAssists: $careerAssists, ')
          ..write('careerSteals: $careerSteals, ')
          ..write('careerBlocks: $careerBlocks, ')
          ..write('careerGames: $careerGames, ')
          ..write('careerStarts: $careerStarts, ')
          ..write('careerTurnovers: $careerTurnovers, ')
          ..write('careerTeams: $careerTeams, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CachedGamesTable extends CachedGames
    with TableInfo<$CachedGamesTable, CachedGame> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CachedGamesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _gameIdMeta = const VerificationMeta('gameId');
  @override
  late final GeneratedColumn<String> gameId = GeneratedColumn<String>(
    'game_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _homeTeamIdMeta = const VerificationMeta(
    'homeTeamId',
  );
  @override
  late final GeneratedColumn<String> homeTeamId = GeneratedColumn<String>(
    'home_team_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES nba_teams (team_id)',
    ),
  );
  static const VerificationMeta _awayTeamIdMeta = const VerificationMeta(
    'awayTeamId',
  );
  @override
  late final GeneratedColumn<String> awayTeamId = GeneratedColumn<String>(
    'away_team_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES nba_teams (team_id)',
    ),
  );
  static const VerificationMeta _scoreHomeMeta = const VerificationMeta(
    'scoreHome',
  );
  @override
  late final GeneratedColumn<int> scoreHome = GeneratedColumn<int>(
    'score_home',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _scoreAwayMeta = const VerificationMeta(
    'scoreAway',
  );
  @override
  late final GeneratedColumn<int> scoreAway = GeneratedColumn<int>(
    'score_away',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gameDateMeta = const VerificationMeta(
    'gameDate',
  );
  @override
  late final GeneratedColumn<DateTime> gameDate = GeneratedColumn<DateTime>(
    'game_date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cachedAtMeta = const VerificationMeta(
    'cachedAt',
  );
  @override
  late final GeneratedColumn<DateTime> cachedAt = GeneratedColumn<DateTime>(
    'cached_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    gameId,
    homeTeamId,
    awayTeamId,
    scoreHome,
    scoreAway,
    status,
    gameDate,
    cachedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cached_games';
  @override
  VerificationContext validateIntegrity(
    Insertable<CachedGame> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('game_id')) {
      context.handle(
        _gameIdMeta,
        gameId.isAcceptableOrUnknown(data['game_id']!, _gameIdMeta),
      );
    } else if (isInserting) {
      context.missing(_gameIdMeta);
    }
    if (data.containsKey('home_team_id')) {
      context.handle(
        _homeTeamIdMeta,
        homeTeamId.isAcceptableOrUnknown(
          data['home_team_id']!,
          _homeTeamIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_homeTeamIdMeta);
    }
    if (data.containsKey('away_team_id')) {
      context.handle(
        _awayTeamIdMeta,
        awayTeamId.isAcceptableOrUnknown(
          data['away_team_id']!,
          _awayTeamIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_awayTeamIdMeta);
    }
    if (data.containsKey('score_home')) {
      context.handle(
        _scoreHomeMeta,
        scoreHome.isAcceptableOrUnknown(data['score_home']!, _scoreHomeMeta),
      );
    }
    if (data.containsKey('score_away')) {
      context.handle(
        _scoreAwayMeta,
        scoreAway.isAcceptableOrUnknown(data['score_away']!, _scoreAwayMeta),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('game_date')) {
      context.handle(
        _gameDateMeta,
        gameDate.isAcceptableOrUnknown(data['game_date']!, _gameDateMeta),
      );
    } else if (isInserting) {
      context.missing(_gameDateMeta);
    }
    if (data.containsKey('cached_at')) {
      context.handle(
        _cachedAtMeta,
        cachedAt.isAcceptableOrUnknown(data['cached_at']!, _cachedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {gameId};
  @override
  CachedGame map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CachedGame(
      gameId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}game_id'],
      )!,
      homeTeamId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}home_team_id'],
      )!,
      awayTeamId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}away_team_id'],
      )!,
      scoreHome: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score_home'],
      )!,
      scoreAway: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score_away'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      gameDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}game_date'],
      )!,
      cachedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cached_at'],
      )!,
    );
  }

  @override
  $CachedGamesTable createAlias(String alias) {
    return $CachedGamesTable(attachedDatabase, alias);
  }
}

class CachedGame extends DataClass implements Insertable<CachedGame> {
  final String gameId;
  final String homeTeamId;
  final String awayTeamId;
  final int scoreHome;
  final int scoreAway;
  final String status;
  final DateTime gameDate;
  final DateTime cachedAt;
  const CachedGame({
    required this.gameId,
    required this.homeTeamId,
    required this.awayTeamId,
    required this.scoreHome,
    required this.scoreAway,
    required this.status,
    required this.gameDate,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['game_id'] = Variable<String>(gameId);
    map['home_team_id'] = Variable<String>(homeTeamId);
    map['away_team_id'] = Variable<String>(awayTeamId);
    map['score_home'] = Variable<int>(scoreHome);
    map['score_away'] = Variable<int>(scoreAway);
    map['status'] = Variable<String>(status);
    map['game_date'] = Variable<DateTime>(gameDate);
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  CachedGamesCompanion toCompanion(bool nullToAbsent) {
    return CachedGamesCompanion(
      gameId: Value(gameId),
      homeTeamId: Value(homeTeamId),
      awayTeamId: Value(awayTeamId),
      scoreHome: Value(scoreHome),
      scoreAway: Value(scoreAway),
      status: Value(status),
      gameDate: Value(gameDate),
      cachedAt: Value(cachedAt),
    );
  }

  factory CachedGame.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CachedGame(
      gameId: serializer.fromJson<String>(json['gameId']),
      homeTeamId: serializer.fromJson<String>(json['homeTeamId']),
      awayTeamId: serializer.fromJson<String>(json['awayTeamId']),
      scoreHome: serializer.fromJson<int>(json['scoreHome']),
      scoreAway: serializer.fromJson<int>(json['scoreAway']),
      status: serializer.fromJson<String>(json['status']),
      gameDate: serializer.fromJson<DateTime>(json['gameDate']),
      cachedAt: serializer.fromJson<DateTime>(json['cachedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'gameId': serializer.toJson<String>(gameId),
      'homeTeamId': serializer.toJson<String>(homeTeamId),
      'awayTeamId': serializer.toJson<String>(awayTeamId),
      'scoreHome': serializer.toJson<int>(scoreHome),
      'scoreAway': serializer.toJson<int>(scoreAway),
      'status': serializer.toJson<String>(status),
      'gameDate': serializer.toJson<DateTime>(gameDate),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  CachedGame copyWith({
    String? gameId,
    String? homeTeamId,
    String? awayTeamId,
    int? scoreHome,
    int? scoreAway,
    String? status,
    DateTime? gameDate,
    DateTime? cachedAt,
  }) => CachedGame(
    gameId: gameId ?? this.gameId,
    homeTeamId: homeTeamId ?? this.homeTeamId,
    awayTeamId: awayTeamId ?? this.awayTeamId,
    scoreHome: scoreHome ?? this.scoreHome,
    scoreAway: scoreAway ?? this.scoreAway,
    status: status ?? this.status,
    gameDate: gameDate ?? this.gameDate,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  CachedGame copyWithCompanion(CachedGamesCompanion data) {
    return CachedGame(
      gameId: data.gameId.present ? data.gameId.value : this.gameId,
      homeTeamId: data.homeTeamId.present
          ? data.homeTeamId.value
          : this.homeTeamId,
      awayTeamId: data.awayTeamId.present
          ? data.awayTeamId.value
          : this.awayTeamId,
      scoreHome: data.scoreHome.present ? data.scoreHome.value : this.scoreHome,
      scoreAway: data.scoreAway.present ? data.scoreAway.value : this.scoreAway,
      status: data.status.present ? data.status.value : this.status,
      gameDate: data.gameDate.present ? data.gameDate.value : this.gameDate,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CachedGame(')
          ..write('gameId: $gameId, ')
          ..write('homeTeamId: $homeTeamId, ')
          ..write('awayTeamId: $awayTeamId, ')
          ..write('scoreHome: $scoreHome, ')
          ..write('scoreAway: $scoreAway, ')
          ..write('status: $status, ')
          ..write('gameDate: $gameDate, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    gameId,
    homeTeamId,
    awayTeamId,
    scoreHome,
    scoreAway,
    status,
    gameDate,
    cachedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CachedGame &&
          other.gameId == this.gameId &&
          other.homeTeamId == this.homeTeamId &&
          other.awayTeamId == this.awayTeamId &&
          other.scoreHome == this.scoreHome &&
          other.scoreAway == this.scoreAway &&
          other.status == this.status &&
          other.gameDate == this.gameDate &&
          other.cachedAt == this.cachedAt);
}

class CachedGamesCompanion extends UpdateCompanion<CachedGame> {
  final Value<String> gameId;
  final Value<String> homeTeamId;
  final Value<String> awayTeamId;
  final Value<int> scoreHome;
  final Value<int> scoreAway;
  final Value<String> status;
  final Value<DateTime> gameDate;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const CachedGamesCompanion({
    this.gameId = const Value.absent(),
    this.homeTeamId = const Value.absent(),
    this.awayTeamId = const Value.absent(),
    this.scoreHome = const Value.absent(),
    this.scoreAway = const Value.absent(),
    this.status = const Value.absent(),
    this.gameDate = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CachedGamesCompanion.insert({
    required String gameId,
    required String homeTeamId,
    required String awayTeamId,
    this.scoreHome = const Value.absent(),
    this.scoreAway = const Value.absent(),
    required String status,
    required DateTime gameDate,
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : gameId = Value(gameId),
       homeTeamId = Value(homeTeamId),
       awayTeamId = Value(awayTeamId),
       status = Value(status),
       gameDate = Value(gameDate);
  static Insertable<CachedGame> custom({
    Expression<String>? gameId,
    Expression<String>? homeTeamId,
    Expression<String>? awayTeamId,
    Expression<int>? scoreHome,
    Expression<int>? scoreAway,
    Expression<String>? status,
    Expression<DateTime>? gameDate,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (gameId != null) 'game_id': gameId,
      if (homeTeamId != null) 'home_team_id': homeTeamId,
      if (awayTeamId != null) 'away_team_id': awayTeamId,
      if (scoreHome != null) 'score_home': scoreHome,
      if (scoreAway != null) 'score_away': scoreAway,
      if (status != null) 'status': status,
      if (gameDate != null) 'game_date': gameDate,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CachedGamesCompanion copyWith({
    Value<String>? gameId,
    Value<String>? homeTeamId,
    Value<String>? awayTeamId,
    Value<int>? scoreHome,
    Value<int>? scoreAway,
    Value<String>? status,
    Value<DateTime>? gameDate,
    Value<DateTime>? cachedAt,
    Value<int>? rowid,
  }) {
    return CachedGamesCompanion(
      gameId: gameId ?? this.gameId,
      homeTeamId: homeTeamId ?? this.homeTeamId,
      awayTeamId: awayTeamId ?? this.awayTeamId,
      scoreHome: scoreHome ?? this.scoreHome,
      scoreAway: scoreAway ?? this.scoreAway,
      status: status ?? this.status,
      gameDate: gameDate ?? this.gameDate,
      cachedAt: cachedAt ?? this.cachedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (gameId.present) {
      map['game_id'] = Variable<String>(gameId.value);
    }
    if (homeTeamId.present) {
      map['home_team_id'] = Variable<String>(homeTeamId.value);
    }
    if (awayTeamId.present) {
      map['away_team_id'] = Variable<String>(awayTeamId.value);
    }
    if (scoreHome.present) {
      map['score_home'] = Variable<int>(scoreHome.value);
    }
    if (scoreAway.present) {
      map['score_away'] = Variable<int>(scoreAway.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (gameDate.present) {
      map['game_date'] = Variable<DateTime>(gameDate.value);
    }
    if (cachedAt.present) {
      map['cached_at'] = Variable<DateTime>(cachedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CachedGamesCompanion(')
          ..write('gameId: $gameId, ')
          ..write('homeTeamId: $homeTeamId, ')
          ..write('awayTeamId: $awayTeamId, ')
          ..write('scoreHome: $scoreHome, ')
          ..write('scoreAway: $scoreAway, ')
          ..write('status: $status, ')
          ..write('gameDate: $gameDate, ')
          ..write('cachedAt: $cachedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $UserPreferencesTable extends UserPreferences
    with TableInfo<$UserPreferencesTable, UserPreference> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserPreferencesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _passwordHashMeta = const VerificationMeta(
    'passwordHash',
  );
  @override
  late final GeneratedColumn<String> passwordHash = GeneratedColumn<String>(
    'password_hash',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _displayNameMeta = const VerificationMeta(
    'displayName',
  );
  @override
  late final GeneratedColumn<String> displayName = GeneratedColumn<String>(
    'display_name',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _favoriteTeamIdMeta = const VerificationMeta(
    'favoriteTeamId',
  );
  @override
  late final GeneratedColumn<String> favoriteTeamId = GeneratedColumn<String>(
    'favorite_team_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES nba_teams (team_id)',
    ),
  );
  static const VerificationMeta _isLoggedInMeta = const VerificationMeta(
    'isLoggedIn',
  );
  @override
  late final GeneratedColumn<bool> isLoggedIn = GeneratedColumn<bool>(
    'is_logged_in',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_logged_in" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _themeModeMeta = const VerificationMeta(
    'themeMode',
  );
  @override
  late final GeneratedColumn<String> themeMode = GeneratedColumn<String>(
    'theme_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('system'),
  );
  static const VerificationMeta _notificationsOnMeta = const VerificationMeta(
    'notificationsOn',
  );
  @override
  late final GeneratedColumn<bool> notificationsOn = GeneratedColumn<bool>(
    'notifications_on',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("notifications_on" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _languageMeta = const VerificationMeta(
    'language',
  );
  @override
  late final GeneratedColumn<String> language = GeneratedColumn<String>(
    'language',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('pt'),
  );
  static const VerificationMeta _measurementUnitMeta = const VerificationMeta(
    'measurementUnit',
  );
  @override
  late final GeneratedColumn<String> measurementUnit = GeneratedColumn<String>(
    'measurement_unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('metric'),
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('EUR'),
  );
  static const VerificationMeta _favoriteTeamAlertsMeta =
      const VerificationMeta('favoriteTeamAlerts');
  @override
  late final GeneratedColumn<bool> favoriteTeamAlerts = GeneratedColumn<bool>(
    'favorite_team_alerts',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("favorite_team_alerts" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    email,
    passwordHash,
    displayName,
    favoriteTeamId,
    isLoggedIn,
    themeMode,
    notificationsOn,
    language,
    measurementUnit,
    currencyCode,
    favoriteTeamAlerts,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_preferences';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserPreference> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('password_hash')) {
      context.handle(
        _passwordHashMeta,
        passwordHash.isAcceptableOrUnknown(
          data['password_hash']!,
          _passwordHashMeta,
        ),
      );
    }
    if (data.containsKey('display_name')) {
      context.handle(
        _displayNameMeta,
        displayName.isAcceptableOrUnknown(
          data['display_name']!,
          _displayNameMeta,
        ),
      );
    }
    if (data.containsKey('favorite_team_id')) {
      context.handle(
        _favoriteTeamIdMeta,
        favoriteTeamId.isAcceptableOrUnknown(
          data['favorite_team_id']!,
          _favoriteTeamIdMeta,
        ),
      );
    }
    if (data.containsKey('is_logged_in')) {
      context.handle(
        _isLoggedInMeta,
        isLoggedIn.isAcceptableOrUnknown(
          data['is_logged_in']!,
          _isLoggedInMeta,
        ),
      );
    }
    if (data.containsKey('theme_mode')) {
      context.handle(
        _themeModeMeta,
        themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta),
      );
    }
    if (data.containsKey('notifications_on')) {
      context.handle(
        _notificationsOnMeta,
        notificationsOn.isAcceptableOrUnknown(
          data['notifications_on']!,
          _notificationsOnMeta,
        ),
      );
    }
    if (data.containsKey('language')) {
      context.handle(
        _languageMeta,
        language.isAcceptableOrUnknown(data['language']!, _languageMeta),
      );
    }
    if (data.containsKey('measurement_unit')) {
      context.handle(
        _measurementUnitMeta,
        measurementUnit.isAcceptableOrUnknown(
          data['measurement_unit']!,
          _measurementUnitMeta,
        ),
      );
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    }
    if (data.containsKey('favorite_team_alerts')) {
      context.handle(
        _favoriteTeamAlertsMeta,
        favoriteTeamAlerts.isAcceptableOrUnknown(
          data['favorite_team_alerts']!,
          _favoriteTeamAlertsMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserPreference map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserPreference(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      passwordHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}password_hash'],
      ),
      displayName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}display_name'],
      ),
      favoriteTeamId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}favorite_team_id'],
      ),
      isLoggedIn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_logged_in'],
      )!,
      themeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}theme_mode'],
      )!,
      notificationsOn: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}notifications_on'],
      )!,
      language: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}language'],
      )!,
      measurementUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}measurement_unit'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      favoriteTeamAlerts: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}favorite_team_alerts'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $UserPreferencesTable createAlias(String alias) {
    return $UserPreferencesTable(attachedDatabase, alias);
  }
}

class UserPreference extends DataClass implements Insertable<UserPreference> {
  final int id;
  final String? email;
  final String? passwordHash;
  final String? displayName;
  final String? favoriteTeamId;
  final bool isLoggedIn;
  final String themeMode;
  final bool notificationsOn;
  final String language;
  final String measurementUnit;
  final String currencyCode;
  final bool favoriteTeamAlerts;
  final DateTime updatedAt;
  const UserPreference({
    required this.id,
    this.email,
    this.passwordHash,
    this.displayName,
    this.favoriteTeamId,
    required this.isLoggedIn,
    required this.themeMode,
    required this.notificationsOn,
    required this.language,
    required this.measurementUnit,
    required this.currencyCode,
    required this.favoriteTeamAlerts,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || passwordHash != null) {
      map['password_hash'] = Variable<String>(passwordHash);
    }
    if (!nullToAbsent || displayName != null) {
      map['display_name'] = Variable<String>(displayName);
    }
    if (!nullToAbsent || favoriteTeamId != null) {
      map['favorite_team_id'] = Variable<String>(favoriteTeamId);
    }
    map['is_logged_in'] = Variable<bool>(isLoggedIn);
    map['theme_mode'] = Variable<String>(themeMode);
    map['notifications_on'] = Variable<bool>(notificationsOn);
    map['language'] = Variable<String>(language);
    map['measurement_unit'] = Variable<String>(measurementUnit);
    map['currency_code'] = Variable<String>(currencyCode);
    map['favorite_team_alerts'] = Variable<bool>(favoriteTeamAlerts);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  UserPreferencesCompanion toCompanion(bool nullToAbsent) {
    return UserPreferencesCompanion(
      id: Value(id),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      passwordHash: passwordHash == null && nullToAbsent
          ? const Value.absent()
          : Value(passwordHash),
      displayName: displayName == null && nullToAbsent
          ? const Value.absent()
          : Value(displayName),
      favoriteTeamId: favoriteTeamId == null && nullToAbsent
          ? const Value.absent()
          : Value(favoriteTeamId),
      isLoggedIn: Value(isLoggedIn),
      themeMode: Value(themeMode),
      notificationsOn: Value(notificationsOn),
      language: Value(language),
      measurementUnit: Value(measurementUnit),
      currencyCode: Value(currencyCode),
      favoriteTeamAlerts: Value(favoriteTeamAlerts),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserPreference.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserPreference(
      id: serializer.fromJson<int>(json['id']),
      email: serializer.fromJson<String?>(json['email']),
      passwordHash: serializer.fromJson<String?>(json['passwordHash']),
      displayName: serializer.fromJson<String?>(json['displayName']),
      favoriteTeamId: serializer.fromJson<String?>(json['favoriteTeamId']),
      isLoggedIn: serializer.fromJson<bool>(json['isLoggedIn']),
      themeMode: serializer.fromJson<String>(json['themeMode']),
      notificationsOn: serializer.fromJson<bool>(json['notificationsOn']),
      language: serializer.fromJson<String>(json['language']),
      measurementUnit: serializer.fromJson<String>(json['measurementUnit']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      favoriteTeamAlerts: serializer.fromJson<bool>(json['favoriteTeamAlerts']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'email': serializer.toJson<String?>(email),
      'passwordHash': serializer.toJson<String?>(passwordHash),
      'displayName': serializer.toJson<String?>(displayName),
      'favoriteTeamId': serializer.toJson<String?>(favoriteTeamId),
      'isLoggedIn': serializer.toJson<bool>(isLoggedIn),
      'themeMode': serializer.toJson<String>(themeMode),
      'notificationsOn': serializer.toJson<bool>(notificationsOn),
      'language': serializer.toJson<String>(language),
      'measurementUnit': serializer.toJson<String>(measurementUnit),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'favoriteTeamAlerts': serializer.toJson<bool>(favoriteTeamAlerts),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  UserPreference copyWith({
    int? id,
    Value<String?> email = const Value.absent(),
    Value<String?> passwordHash = const Value.absent(),
    Value<String?> displayName = const Value.absent(),
    Value<String?> favoriteTeamId = const Value.absent(),
    bool? isLoggedIn,
    String? themeMode,
    bool? notificationsOn,
    String? language,
    String? measurementUnit,
    String? currencyCode,
    bool? favoriteTeamAlerts,
    DateTime? updatedAt,
  }) => UserPreference(
    id: id ?? this.id,
    email: email.present ? email.value : this.email,
    passwordHash: passwordHash.present ? passwordHash.value : this.passwordHash,
    displayName: displayName.present ? displayName.value : this.displayName,
    favoriteTeamId: favoriteTeamId.present
        ? favoriteTeamId.value
        : this.favoriteTeamId,
    isLoggedIn: isLoggedIn ?? this.isLoggedIn,
    themeMode: themeMode ?? this.themeMode,
    notificationsOn: notificationsOn ?? this.notificationsOn,
    language: language ?? this.language,
    measurementUnit: measurementUnit ?? this.measurementUnit,
    currencyCode: currencyCode ?? this.currencyCode,
    favoriteTeamAlerts: favoriteTeamAlerts ?? this.favoriteTeamAlerts,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserPreference copyWithCompanion(UserPreferencesCompanion data) {
    return UserPreference(
      id: data.id.present ? data.id.value : this.id,
      email: data.email.present ? data.email.value : this.email,
      passwordHash: data.passwordHash.present
          ? data.passwordHash.value
          : this.passwordHash,
      displayName: data.displayName.present
          ? data.displayName.value
          : this.displayName,
      favoriteTeamId: data.favoriteTeamId.present
          ? data.favoriteTeamId.value
          : this.favoriteTeamId,
      isLoggedIn: data.isLoggedIn.present
          ? data.isLoggedIn.value
          : this.isLoggedIn,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      notificationsOn: data.notificationsOn.present
          ? data.notificationsOn.value
          : this.notificationsOn,
      language: data.language.present ? data.language.value : this.language,
      measurementUnit: data.measurementUnit.present
          ? data.measurementUnit.value
          : this.measurementUnit,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      favoriteTeamAlerts: data.favoriteTeamAlerts.present
          ? data.favoriteTeamAlerts.value
          : this.favoriteTeamAlerts,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserPreference(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('displayName: $displayName, ')
          ..write('favoriteTeamId: $favoriteTeamId, ')
          ..write('isLoggedIn: $isLoggedIn, ')
          ..write('themeMode: $themeMode, ')
          ..write('notificationsOn: $notificationsOn, ')
          ..write('language: $language, ')
          ..write('measurementUnit: $measurementUnit, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('favoriteTeamAlerts: $favoriteTeamAlerts, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    email,
    passwordHash,
    displayName,
    favoriteTeamId,
    isLoggedIn,
    themeMode,
    notificationsOn,
    language,
    measurementUnit,
    currencyCode,
    favoriteTeamAlerts,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserPreference &&
          other.id == this.id &&
          other.email == this.email &&
          other.passwordHash == this.passwordHash &&
          other.displayName == this.displayName &&
          other.favoriteTeamId == this.favoriteTeamId &&
          other.isLoggedIn == this.isLoggedIn &&
          other.themeMode == this.themeMode &&
          other.notificationsOn == this.notificationsOn &&
          other.language == this.language &&
          other.measurementUnit == this.measurementUnit &&
          other.currencyCode == this.currencyCode &&
          other.favoriteTeamAlerts == this.favoriteTeamAlerts &&
          other.updatedAt == this.updatedAt);
}

class UserPreferencesCompanion extends UpdateCompanion<UserPreference> {
  final Value<int> id;
  final Value<String?> email;
  final Value<String?> passwordHash;
  final Value<String?> displayName;
  final Value<String?> favoriteTeamId;
  final Value<bool> isLoggedIn;
  final Value<String> themeMode;
  final Value<bool> notificationsOn;
  final Value<String> language;
  final Value<String> measurementUnit;
  final Value<String> currencyCode;
  final Value<bool> favoriteTeamAlerts;
  final Value<DateTime> updatedAt;
  const UserPreferencesCompanion({
    this.id = const Value.absent(),
    this.email = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.displayName = const Value.absent(),
    this.favoriteTeamId = const Value.absent(),
    this.isLoggedIn = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.notificationsOn = const Value.absent(),
    this.language = const Value.absent(),
    this.measurementUnit = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.favoriteTeamAlerts = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  UserPreferencesCompanion.insert({
    this.id = const Value.absent(),
    this.email = const Value.absent(),
    this.passwordHash = const Value.absent(),
    this.displayName = const Value.absent(),
    this.favoriteTeamId = const Value.absent(),
    this.isLoggedIn = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.notificationsOn = const Value.absent(),
    this.language = const Value.absent(),
    this.measurementUnit = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.favoriteTeamAlerts = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  static Insertable<UserPreference> custom({
    Expression<int>? id,
    Expression<String>? email,
    Expression<String>? passwordHash,
    Expression<String>? displayName,
    Expression<String>? favoriteTeamId,
    Expression<bool>? isLoggedIn,
    Expression<String>? themeMode,
    Expression<bool>? notificationsOn,
    Expression<String>? language,
    Expression<String>? measurementUnit,
    Expression<String>? currencyCode,
    Expression<bool>? favoriteTeamAlerts,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (email != null) 'email': email,
      if (passwordHash != null) 'password_hash': passwordHash,
      if (displayName != null) 'display_name': displayName,
      if (favoriteTeamId != null) 'favorite_team_id': favoriteTeamId,
      if (isLoggedIn != null) 'is_logged_in': isLoggedIn,
      if (themeMode != null) 'theme_mode': themeMode,
      if (notificationsOn != null) 'notifications_on': notificationsOn,
      if (language != null) 'language': language,
      if (measurementUnit != null) 'measurement_unit': measurementUnit,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (favoriteTeamAlerts != null)
        'favorite_team_alerts': favoriteTeamAlerts,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  UserPreferencesCompanion copyWith({
    Value<int>? id,
    Value<String?>? email,
    Value<String?>? passwordHash,
    Value<String?>? displayName,
    Value<String?>? favoriteTeamId,
    Value<bool>? isLoggedIn,
    Value<String>? themeMode,
    Value<bool>? notificationsOn,
    Value<String>? language,
    Value<String>? measurementUnit,
    Value<String>? currencyCode,
    Value<bool>? favoriteTeamAlerts,
    Value<DateTime>? updatedAt,
  }) {
    return UserPreferencesCompanion(
      id: id ?? this.id,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      displayName: displayName ?? this.displayName,
      favoriteTeamId: favoriteTeamId ?? this.favoriteTeamId,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      themeMode: themeMode ?? this.themeMode,
      notificationsOn: notificationsOn ?? this.notificationsOn,
      language: language ?? this.language,
      measurementUnit: measurementUnit ?? this.measurementUnit,
      currencyCode: currencyCode ?? this.currencyCode,
      favoriteTeamAlerts: favoriteTeamAlerts ?? this.favoriteTeamAlerts,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (passwordHash.present) {
      map['password_hash'] = Variable<String>(passwordHash.value);
    }
    if (displayName.present) {
      map['display_name'] = Variable<String>(displayName.value);
    }
    if (favoriteTeamId.present) {
      map['favorite_team_id'] = Variable<String>(favoriteTeamId.value);
    }
    if (isLoggedIn.present) {
      map['is_logged_in'] = Variable<bool>(isLoggedIn.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<String>(themeMode.value);
    }
    if (notificationsOn.present) {
      map['notifications_on'] = Variable<bool>(notificationsOn.value);
    }
    if (language.present) {
      map['language'] = Variable<String>(language.value);
    }
    if (measurementUnit.present) {
      map['measurement_unit'] = Variable<String>(measurementUnit.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (favoriteTeamAlerts.present) {
      map['favorite_team_alerts'] = Variable<bool>(favoriteTeamAlerts.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserPreferencesCompanion(')
          ..write('id: $id, ')
          ..write('email: $email, ')
          ..write('passwordHash: $passwordHash, ')
          ..write('displayName: $displayName, ')
          ..write('favoriteTeamId: $favoriteTeamId, ')
          ..write('isLoggedIn: $isLoggedIn, ')
          ..write('themeMode: $themeMode, ')
          ..write('notificationsOn: $notificationsOn, ')
          ..write('language: $language, ')
          ..write('measurementUnit: $measurementUnit, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('favoriteTeamAlerts: $favoriteTeamAlerts, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $PlayerSeasonsTable extends PlayerSeasons
    with TableInfo<$PlayerSeasonsTable, PlayerSeason> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlayerSeasonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _playerIdMeta = const VerificationMeta(
    'playerId',
  );
  @override
  late final GeneratedColumn<String> playerId = GeneratedColumn<String>(
    'player_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES players (player_id)',
    ),
  );
  static const VerificationMeta _seasonMeta = const VerificationMeta('season');
  @override
  late final GeneratedColumn<String> season = GeneratedColumn<String>(
    'season',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _teamMeta = const VerificationMeta('team');
  @override
  late final GeneratedColumn<String> team = GeneratedColumn<String>(
    'team',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _gpMeta = const VerificationMeta('gp');
  @override
  late final GeneratedColumn<int> gp = GeneratedColumn<int>(
    'gp',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _gsMeta = const VerificationMeta('gs');
  @override
  late final GeneratedColumn<int> gs = GeneratedColumn<int>(
    'gs',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _mpgMeta = const VerificationMeta('mpg');
  @override
  late final GeneratedColumn<double> mpg = GeneratedColumn<double>(
    'mpg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _ppgMeta = const VerificationMeta('ppg');
  @override
  late final GeneratedColumn<double> ppg = GeneratedColumn<double>(
    'ppg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _rpgMeta = const VerificationMeta('rpg');
  @override
  late final GeneratedColumn<double> rpg = GeneratedColumn<double>(
    'rpg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _apgMeta = const VerificationMeta('apg');
  @override
  late final GeneratedColumn<double> apg = GeneratedColumn<double>(
    'apg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _spgMeta = const VerificationMeta('spg');
  @override
  late final GeneratedColumn<double> spg = GeneratedColumn<double>(
    'spg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _bpgMeta = const VerificationMeta('bpg');
  @override
  late final GeneratedColumn<double> bpg = GeneratedColumn<double>(
    'bpg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _topgMeta = const VerificationMeta('topg');
  @override
  late final GeneratedColumn<double> topg = GeneratedColumn<double>(
    'topg',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _fgPctMeta = const VerificationMeta('fgPct');
  @override
  late final GeneratedColumn<double> fgPct = GeneratedColumn<double>(
    'fg_pct',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _fg3PctMeta = const VerificationMeta('fg3Pct');
  @override
  late final GeneratedColumn<double> fg3Pct = GeneratedColumn<double>(
    'fg3_pct',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _ftPctMeta = const VerificationMeta('ftPct');
  @override
  late final GeneratedColumn<double> ftPct = GeneratedColumn<double>(
    'ft_pct',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _perMeta = const VerificationMeta('per');
  @override
  late final GeneratedColumn<double> per = GeneratedColumn<double>(
    'per',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _tsPctMeta = const VerificationMeta('tsPct');
  @override
  late final GeneratedColumn<double> tsPct = GeneratedColumn<double>(
    'ts_pct',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _usgPctMeta = const VerificationMeta('usgPct');
  @override
  late final GeneratedColumn<double> usgPct = GeneratedColumn<double>(
    'usg_pct',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    playerId,
    season,
    team,
    gp,
    gs,
    mpg,
    ppg,
    rpg,
    apg,
    spg,
    bpg,
    topg,
    fgPct,
    fg3Pct,
    ftPct,
    per,
    tsPct,
    usgPct,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'player_seasons';
  @override
  VerificationContext validateIntegrity(
    Insertable<PlayerSeason> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('player_id')) {
      context.handle(
        _playerIdMeta,
        playerId.isAcceptableOrUnknown(data['player_id']!, _playerIdMeta),
      );
    } else if (isInserting) {
      context.missing(_playerIdMeta);
    }
    if (data.containsKey('season')) {
      context.handle(
        _seasonMeta,
        season.isAcceptableOrUnknown(data['season']!, _seasonMeta),
      );
    } else if (isInserting) {
      context.missing(_seasonMeta);
    }
    if (data.containsKey('team')) {
      context.handle(
        _teamMeta,
        team.isAcceptableOrUnknown(data['team']!, _teamMeta),
      );
    } else if (isInserting) {
      context.missing(_teamMeta);
    }
    if (data.containsKey('gp')) {
      context.handle(_gpMeta, gp.isAcceptableOrUnknown(data['gp']!, _gpMeta));
    }
    if (data.containsKey('gs')) {
      context.handle(_gsMeta, gs.isAcceptableOrUnknown(data['gs']!, _gsMeta));
    }
    if (data.containsKey('mpg')) {
      context.handle(
        _mpgMeta,
        mpg.isAcceptableOrUnknown(data['mpg']!, _mpgMeta),
      );
    }
    if (data.containsKey('ppg')) {
      context.handle(
        _ppgMeta,
        ppg.isAcceptableOrUnknown(data['ppg']!, _ppgMeta),
      );
    }
    if (data.containsKey('rpg')) {
      context.handle(
        _rpgMeta,
        rpg.isAcceptableOrUnknown(data['rpg']!, _rpgMeta),
      );
    }
    if (data.containsKey('apg')) {
      context.handle(
        _apgMeta,
        apg.isAcceptableOrUnknown(data['apg']!, _apgMeta),
      );
    }
    if (data.containsKey('spg')) {
      context.handle(
        _spgMeta,
        spg.isAcceptableOrUnknown(data['spg']!, _spgMeta),
      );
    }
    if (data.containsKey('bpg')) {
      context.handle(
        _bpgMeta,
        bpg.isAcceptableOrUnknown(data['bpg']!, _bpgMeta),
      );
    }
    if (data.containsKey('topg')) {
      context.handle(
        _topgMeta,
        topg.isAcceptableOrUnknown(data['topg']!, _topgMeta),
      );
    }
    if (data.containsKey('fg_pct')) {
      context.handle(
        _fgPctMeta,
        fgPct.isAcceptableOrUnknown(data['fg_pct']!, _fgPctMeta),
      );
    }
    if (data.containsKey('fg3_pct')) {
      context.handle(
        _fg3PctMeta,
        fg3Pct.isAcceptableOrUnknown(data['fg3_pct']!, _fg3PctMeta),
      );
    }
    if (data.containsKey('ft_pct')) {
      context.handle(
        _ftPctMeta,
        ftPct.isAcceptableOrUnknown(data['ft_pct']!, _ftPctMeta),
      );
    }
    if (data.containsKey('per')) {
      context.handle(
        _perMeta,
        per.isAcceptableOrUnknown(data['per']!, _perMeta),
      );
    }
    if (data.containsKey('ts_pct')) {
      context.handle(
        _tsPctMeta,
        tsPct.isAcceptableOrUnknown(data['ts_pct']!, _tsPctMeta),
      );
    }
    if (data.containsKey('usg_pct')) {
      context.handle(
        _usgPctMeta,
        usgPct.isAcceptableOrUnknown(data['usg_pct']!, _usgPctMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PlayerSeason map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PlayerSeason(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      playerId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}player_id'],
      )!,
      season: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}season'],
      )!,
      team: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}team'],
      )!,
      gp: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gp'],
      )!,
      gs: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}gs'],
      )!,
      mpg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}mpg'],
      )!,
      ppg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ppg'],
      )!,
      rpg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}rpg'],
      )!,
      apg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}apg'],
      )!,
      spg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}spg'],
      )!,
      bpg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}bpg'],
      )!,
      topg: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}topg'],
      )!,
      fgPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fg_pct'],
      )!,
      fg3Pct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}fg3_pct'],
      )!,
      ftPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ft_pct'],
      )!,
      per: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}per'],
      )!,
      tsPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}ts_pct'],
      )!,
      usgPct: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}usg_pct'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $PlayerSeasonsTable createAlias(String alias) {
    return $PlayerSeasonsTable(attachedDatabase, alias);
  }
}

class PlayerSeason extends DataClass implements Insertable<PlayerSeason> {
  final int id;
  final String playerId;
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
  final DateTime createdAt;
  const PlayerSeason({
    required this.id,
    required this.playerId,
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
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['player_id'] = Variable<String>(playerId);
    map['season'] = Variable<String>(season);
    map['team'] = Variable<String>(team);
    map['gp'] = Variable<int>(gp);
    map['gs'] = Variable<int>(gs);
    map['mpg'] = Variable<double>(mpg);
    map['ppg'] = Variable<double>(ppg);
    map['rpg'] = Variable<double>(rpg);
    map['apg'] = Variable<double>(apg);
    map['spg'] = Variable<double>(spg);
    map['bpg'] = Variable<double>(bpg);
    map['topg'] = Variable<double>(topg);
    map['fg_pct'] = Variable<double>(fgPct);
    map['fg3_pct'] = Variable<double>(fg3Pct);
    map['ft_pct'] = Variable<double>(ftPct);
    map['per'] = Variable<double>(per);
    map['ts_pct'] = Variable<double>(tsPct);
    map['usg_pct'] = Variable<double>(usgPct);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  PlayerSeasonsCompanion toCompanion(bool nullToAbsent) {
    return PlayerSeasonsCompanion(
      id: Value(id),
      playerId: Value(playerId),
      season: Value(season),
      team: Value(team),
      gp: Value(gp),
      gs: Value(gs),
      mpg: Value(mpg),
      ppg: Value(ppg),
      rpg: Value(rpg),
      apg: Value(apg),
      spg: Value(spg),
      bpg: Value(bpg),
      topg: Value(topg),
      fgPct: Value(fgPct),
      fg3Pct: Value(fg3Pct),
      ftPct: Value(ftPct),
      per: Value(per),
      tsPct: Value(tsPct),
      usgPct: Value(usgPct),
      createdAt: Value(createdAt),
    );
  }

  factory PlayerSeason.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PlayerSeason(
      id: serializer.fromJson<int>(json['id']),
      playerId: serializer.fromJson<String>(json['playerId']),
      season: serializer.fromJson<String>(json['season']),
      team: serializer.fromJson<String>(json['team']),
      gp: serializer.fromJson<int>(json['gp']),
      gs: serializer.fromJson<int>(json['gs']),
      mpg: serializer.fromJson<double>(json['mpg']),
      ppg: serializer.fromJson<double>(json['ppg']),
      rpg: serializer.fromJson<double>(json['rpg']),
      apg: serializer.fromJson<double>(json['apg']),
      spg: serializer.fromJson<double>(json['spg']),
      bpg: serializer.fromJson<double>(json['bpg']),
      topg: serializer.fromJson<double>(json['topg']),
      fgPct: serializer.fromJson<double>(json['fgPct']),
      fg3Pct: serializer.fromJson<double>(json['fg3Pct']),
      ftPct: serializer.fromJson<double>(json['ftPct']),
      per: serializer.fromJson<double>(json['per']),
      tsPct: serializer.fromJson<double>(json['tsPct']),
      usgPct: serializer.fromJson<double>(json['usgPct']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'playerId': serializer.toJson<String>(playerId),
      'season': serializer.toJson<String>(season),
      'team': serializer.toJson<String>(team),
      'gp': serializer.toJson<int>(gp),
      'gs': serializer.toJson<int>(gs),
      'mpg': serializer.toJson<double>(mpg),
      'ppg': serializer.toJson<double>(ppg),
      'rpg': serializer.toJson<double>(rpg),
      'apg': serializer.toJson<double>(apg),
      'spg': serializer.toJson<double>(spg),
      'bpg': serializer.toJson<double>(bpg),
      'topg': serializer.toJson<double>(topg),
      'fgPct': serializer.toJson<double>(fgPct),
      'fg3Pct': serializer.toJson<double>(fg3Pct),
      'ftPct': serializer.toJson<double>(ftPct),
      'per': serializer.toJson<double>(per),
      'tsPct': serializer.toJson<double>(tsPct),
      'usgPct': serializer.toJson<double>(usgPct),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  PlayerSeason copyWith({
    int? id,
    String? playerId,
    String? season,
    String? team,
    int? gp,
    int? gs,
    double? mpg,
    double? ppg,
    double? rpg,
    double? apg,
    double? spg,
    double? bpg,
    double? topg,
    double? fgPct,
    double? fg3Pct,
    double? ftPct,
    double? per,
    double? tsPct,
    double? usgPct,
    DateTime? createdAt,
  }) => PlayerSeason(
    id: id ?? this.id,
    playerId: playerId ?? this.playerId,
    season: season ?? this.season,
    team: team ?? this.team,
    gp: gp ?? this.gp,
    gs: gs ?? this.gs,
    mpg: mpg ?? this.mpg,
    ppg: ppg ?? this.ppg,
    rpg: rpg ?? this.rpg,
    apg: apg ?? this.apg,
    spg: spg ?? this.spg,
    bpg: bpg ?? this.bpg,
    topg: topg ?? this.topg,
    fgPct: fgPct ?? this.fgPct,
    fg3Pct: fg3Pct ?? this.fg3Pct,
    ftPct: ftPct ?? this.ftPct,
    per: per ?? this.per,
    tsPct: tsPct ?? this.tsPct,
    usgPct: usgPct ?? this.usgPct,
    createdAt: createdAt ?? this.createdAt,
  );
  PlayerSeason copyWithCompanion(PlayerSeasonsCompanion data) {
    return PlayerSeason(
      id: data.id.present ? data.id.value : this.id,
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      season: data.season.present ? data.season.value : this.season,
      team: data.team.present ? data.team.value : this.team,
      gp: data.gp.present ? data.gp.value : this.gp,
      gs: data.gs.present ? data.gs.value : this.gs,
      mpg: data.mpg.present ? data.mpg.value : this.mpg,
      ppg: data.ppg.present ? data.ppg.value : this.ppg,
      rpg: data.rpg.present ? data.rpg.value : this.rpg,
      apg: data.apg.present ? data.apg.value : this.apg,
      spg: data.spg.present ? data.spg.value : this.spg,
      bpg: data.bpg.present ? data.bpg.value : this.bpg,
      topg: data.topg.present ? data.topg.value : this.topg,
      fgPct: data.fgPct.present ? data.fgPct.value : this.fgPct,
      fg3Pct: data.fg3Pct.present ? data.fg3Pct.value : this.fg3Pct,
      ftPct: data.ftPct.present ? data.ftPct.value : this.ftPct,
      per: data.per.present ? data.per.value : this.per,
      tsPct: data.tsPct.present ? data.tsPct.value : this.tsPct,
      usgPct: data.usgPct.present ? data.usgPct.value : this.usgPct,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PlayerSeason(')
          ..write('id: $id, ')
          ..write('playerId: $playerId, ')
          ..write('season: $season, ')
          ..write('team: $team, ')
          ..write('gp: $gp, ')
          ..write('gs: $gs, ')
          ..write('mpg: $mpg, ')
          ..write('ppg: $ppg, ')
          ..write('rpg: $rpg, ')
          ..write('apg: $apg, ')
          ..write('spg: $spg, ')
          ..write('bpg: $bpg, ')
          ..write('topg: $topg, ')
          ..write('fgPct: $fgPct, ')
          ..write('fg3Pct: $fg3Pct, ')
          ..write('ftPct: $ftPct, ')
          ..write('per: $per, ')
          ..write('tsPct: $tsPct, ')
          ..write('usgPct: $usgPct, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    playerId,
    season,
    team,
    gp,
    gs,
    mpg,
    ppg,
    rpg,
    apg,
    spg,
    bpg,
    topg,
    fgPct,
    fg3Pct,
    ftPct,
    per,
    tsPct,
    usgPct,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlayerSeason &&
          other.id == this.id &&
          other.playerId == this.playerId &&
          other.season == this.season &&
          other.team == this.team &&
          other.gp == this.gp &&
          other.gs == this.gs &&
          other.mpg == this.mpg &&
          other.ppg == this.ppg &&
          other.rpg == this.rpg &&
          other.apg == this.apg &&
          other.spg == this.spg &&
          other.bpg == this.bpg &&
          other.topg == this.topg &&
          other.fgPct == this.fgPct &&
          other.fg3Pct == this.fg3Pct &&
          other.ftPct == this.ftPct &&
          other.per == this.per &&
          other.tsPct == this.tsPct &&
          other.usgPct == this.usgPct &&
          other.createdAt == this.createdAt);
}

class PlayerSeasonsCompanion extends UpdateCompanion<PlayerSeason> {
  final Value<int> id;
  final Value<String> playerId;
  final Value<String> season;
  final Value<String> team;
  final Value<int> gp;
  final Value<int> gs;
  final Value<double> mpg;
  final Value<double> ppg;
  final Value<double> rpg;
  final Value<double> apg;
  final Value<double> spg;
  final Value<double> bpg;
  final Value<double> topg;
  final Value<double> fgPct;
  final Value<double> fg3Pct;
  final Value<double> ftPct;
  final Value<double> per;
  final Value<double> tsPct;
  final Value<double> usgPct;
  final Value<DateTime> createdAt;
  const PlayerSeasonsCompanion({
    this.id = const Value.absent(),
    this.playerId = const Value.absent(),
    this.season = const Value.absent(),
    this.team = const Value.absent(),
    this.gp = const Value.absent(),
    this.gs = const Value.absent(),
    this.mpg = const Value.absent(),
    this.ppg = const Value.absent(),
    this.rpg = const Value.absent(),
    this.apg = const Value.absent(),
    this.spg = const Value.absent(),
    this.bpg = const Value.absent(),
    this.topg = const Value.absent(),
    this.fgPct = const Value.absent(),
    this.fg3Pct = const Value.absent(),
    this.ftPct = const Value.absent(),
    this.per = const Value.absent(),
    this.tsPct = const Value.absent(),
    this.usgPct = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  PlayerSeasonsCompanion.insert({
    this.id = const Value.absent(),
    required String playerId,
    required String season,
    required String team,
    this.gp = const Value.absent(),
    this.gs = const Value.absent(),
    this.mpg = const Value.absent(),
    this.ppg = const Value.absent(),
    this.rpg = const Value.absent(),
    this.apg = const Value.absent(),
    this.spg = const Value.absent(),
    this.bpg = const Value.absent(),
    this.topg = const Value.absent(),
    this.fgPct = const Value.absent(),
    this.fg3Pct = const Value.absent(),
    this.ftPct = const Value.absent(),
    this.per = const Value.absent(),
    this.tsPct = const Value.absent(),
    this.usgPct = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : playerId = Value(playerId),
       season = Value(season),
       team = Value(team);
  static Insertable<PlayerSeason> custom({
    Expression<int>? id,
    Expression<String>? playerId,
    Expression<String>? season,
    Expression<String>? team,
    Expression<int>? gp,
    Expression<int>? gs,
    Expression<double>? mpg,
    Expression<double>? ppg,
    Expression<double>? rpg,
    Expression<double>? apg,
    Expression<double>? spg,
    Expression<double>? bpg,
    Expression<double>? topg,
    Expression<double>? fgPct,
    Expression<double>? fg3Pct,
    Expression<double>? ftPct,
    Expression<double>? per,
    Expression<double>? tsPct,
    Expression<double>? usgPct,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (playerId != null) 'player_id': playerId,
      if (season != null) 'season': season,
      if (team != null) 'team': team,
      if (gp != null) 'gp': gp,
      if (gs != null) 'gs': gs,
      if (mpg != null) 'mpg': mpg,
      if (ppg != null) 'ppg': ppg,
      if (rpg != null) 'rpg': rpg,
      if (apg != null) 'apg': apg,
      if (spg != null) 'spg': spg,
      if (bpg != null) 'bpg': bpg,
      if (topg != null) 'topg': topg,
      if (fgPct != null) 'fg_pct': fgPct,
      if (fg3Pct != null) 'fg3_pct': fg3Pct,
      if (ftPct != null) 'ft_pct': ftPct,
      if (per != null) 'per': per,
      if (tsPct != null) 'ts_pct': tsPct,
      if (usgPct != null) 'usg_pct': usgPct,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  PlayerSeasonsCompanion copyWith({
    Value<int>? id,
    Value<String>? playerId,
    Value<String>? season,
    Value<String>? team,
    Value<int>? gp,
    Value<int>? gs,
    Value<double>? mpg,
    Value<double>? ppg,
    Value<double>? rpg,
    Value<double>? apg,
    Value<double>? spg,
    Value<double>? bpg,
    Value<double>? topg,
    Value<double>? fgPct,
    Value<double>? fg3Pct,
    Value<double>? ftPct,
    Value<double>? per,
    Value<double>? tsPct,
    Value<double>? usgPct,
    Value<DateTime>? createdAt,
  }) {
    return PlayerSeasonsCompanion(
      id: id ?? this.id,
      playerId: playerId ?? this.playerId,
      season: season ?? this.season,
      team: team ?? this.team,
      gp: gp ?? this.gp,
      gs: gs ?? this.gs,
      mpg: mpg ?? this.mpg,
      ppg: ppg ?? this.ppg,
      rpg: rpg ?? this.rpg,
      apg: apg ?? this.apg,
      spg: spg ?? this.spg,
      bpg: bpg ?? this.bpg,
      topg: topg ?? this.topg,
      fgPct: fgPct ?? this.fgPct,
      fg3Pct: fg3Pct ?? this.fg3Pct,
      ftPct: ftPct ?? this.ftPct,
      per: per ?? this.per,
      tsPct: tsPct ?? this.tsPct,
      usgPct: usgPct ?? this.usgPct,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (playerId.present) {
      map['player_id'] = Variable<String>(playerId.value);
    }
    if (season.present) {
      map['season'] = Variable<String>(season.value);
    }
    if (team.present) {
      map['team'] = Variable<String>(team.value);
    }
    if (gp.present) {
      map['gp'] = Variable<int>(gp.value);
    }
    if (gs.present) {
      map['gs'] = Variable<int>(gs.value);
    }
    if (mpg.present) {
      map['mpg'] = Variable<double>(mpg.value);
    }
    if (ppg.present) {
      map['ppg'] = Variable<double>(ppg.value);
    }
    if (rpg.present) {
      map['rpg'] = Variable<double>(rpg.value);
    }
    if (apg.present) {
      map['apg'] = Variable<double>(apg.value);
    }
    if (spg.present) {
      map['spg'] = Variable<double>(spg.value);
    }
    if (bpg.present) {
      map['bpg'] = Variable<double>(bpg.value);
    }
    if (topg.present) {
      map['topg'] = Variable<double>(topg.value);
    }
    if (fgPct.present) {
      map['fg_pct'] = Variable<double>(fgPct.value);
    }
    if (fg3Pct.present) {
      map['fg3_pct'] = Variable<double>(fg3Pct.value);
    }
    if (ftPct.present) {
      map['ft_pct'] = Variable<double>(ftPct.value);
    }
    if (per.present) {
      map['per'] = Variable<double>(per.value);
    }
    if (tsPct.present) {
      map['ts_pct'] = Variable<double>(tsPct.value);
    }
    if (usgPct.present) {
      map['usg_pct'] = Variable<double>(usgPct.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlayerSeasonsCompanion(')
          ..write('id: $id, ')
          ..write('playerId: $playerId, ')
          ..write('season: $season, ')
          ..write('team: $team, ')
          ..write('gp: $gp, ')
          ..write('gs: $gs, ')
          ..write('mpg: $mpg, ')
          ..write('ppg: $ppg, ')
          ..write('rpg: $rpg, ')
          ..write('apg: $apg, ')
          ..write('spg: $spg, ')
          ..write('bpg: $bpg, ')
          ..write('topg: $topg, ')
          ..write('fgPct: $fgPct, ')
          ..write('fg3Pct: $fg3Pct, ')
          ..write('ftPct: $ftPct, ')
          ..write('per: $per, ')
          ..write('tsPct: $tsPct, ')
          ..write('usgPct: $usgPct, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $CartItemsTable extends CartItems
    with TableInfo<$CartItemsTable, CartItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CartItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _productIdMeta = const VerificationMeta(
    'productId',
  );
  @override
  late final GeneratedColumn<String> productId = GeneratedColumn<String>(
    'product_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _priceMeta = const VerificationMeta('price');
  @override
  late final GeneratedColumn<double> price = GeneratedColumn<double>(
    'price',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imageMeta = const VerificationMeta('image');
  @override
  late final GeneratedColumn<String> image = GeneratedColumn<String>(
    'image',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isNewMeta = const VerificationMeta('isNew');
  @override
  late final GeneratedColumn<bool> isNew = GeneratedColumn<bool>(
    'is_new',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_new" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _addedAtMeta = const VerificationMeta(
    'addedAt',
  );
  @override
  late final GeneratedColumn<DateTime> addedAt = GeneratedColumn<DateTime>(
    'added_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    productId,
    name,
    category,
    price,
    image,
    isNew,
    addedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cart_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<CartItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('product_id')) {
      context.handle(
        _productIdMeta,
        productId.isAcceptableOrUnknown(data['product_id']!, _productIdMeta),
      );
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('price')) {
      context.handle(
        _priceMeta,
        price.isAcceptableOrUnknown(data['price']!, _priceMeta),
      );
    } else if (isInserting) {
      context.missing(_priceMeta);
    }
    if (data.containsKey('image')) {
      context.handle(
        _imageMeta,
        image.isAcceptableOrUnknown(data['image']!, _imageMeta),
      );
    } else if (isInserting) {
      context.missing(_imageMeta);
    }
    if (data.containsKey('is_new')) {
      context.handle(
        _isNewMeta,
        isNew.isAcceptableOrUnknown(data['is_new']!, _isNewMeta),
      );
    }
    if (data.containsKey('added_at')) {
      context.handle(
        _addedAtMeta,
        addedAt.isAcceptableOrUnknown(data['added_at']!, _addedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CartItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CartItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      productId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}product_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      price: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}price'],
      )!,
      image: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}image'],
      )!,
      isNew: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_new'],
      )!,
      addedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}added_at'],
      )!,
    );
  }

  @override
  $CartItemsTable createAlias(String alias) {
    return $CartItemsTable(attachedDatabase, alias);
  }
}

class CartItem extends DataClass implements Insertable<CartItem> {
  final int id;
  final String productId;
  final String name;
  final String category;
  final double price;
  final String image;
  final bool isNew;
  final DateTime addedAt;
  const CartItem({
    required this.id,
    required this.productId,
    required this.name,
    required this.category,
    required this.price,
    required this.image,
    required this.isNew,
    required this.addedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['product_id'] = Variable<String>(productId);
    map['name'] = Variable<String>(name);
    map['category'] = Variable<String>(category);
    map['price'] = Variable<double>(price);
    map['image'] = Variable<String>(image);
    map['is_new'] = Variable<bool>(isNew);
    map['added_at'] = Variable<DateTime>(addedAt);
    return map;
  }

  CartItemsCompanion toCompanion(bool nullToAbsent) {
    return CartItemsCompanion(
      id: Value(id),
      productId: Value(productId),
      name: Value(name),
      category: Value(category),
      price: Value(price),
      image: Value(image),
      isNew: Value(isNew),
      addedAt: Value(addedAt),
    );
  }

  factory CartItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CartItem(
      id: serializer.fromJson<int>(json['id']),
      productId: serializer.fromJson<String>(json['productId']),
      name: serializer.fromJson<String>(json['name']),
      category: serializer.fromJson<String>(json['category']),
      price: serializer.fromJson<double>(json['price']),
      image: serializer.fromJson<String>(json['image']),
      isNew: serializer.fromJson<bool>(json['isNew']),
      addedAt: serializer.fromJson<DateTime>(json['addedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'productId': serializer.toJson<String>(productId),
      'name': serializer.toJson<String>(name),
      'category': serializer.toJson<String>(category),
      'price': serializer.toJson<double>(price),
      'image': serializer.toJson<String>(image),
      'isNew': serializer.toJson<bool>(isNew),
      'addedAt': serializer.toJson<DateTime>(addedAt),
    };
  }

  CartItem copyWith({
    int? id,
    String? productId,
    String? name,
    String? category,
    double? price,
    String? image,
    bool? isNew,
    DateTime? addedAt,
  }) => CartItem(
    id: id ?? this.id,
    productId: productId ?? this.productId,
    name: name ?? this.name,
    category: category ?? this.category,
    price: price ?? this.price,
    image: image ?? this.image,
    isNew: isNew ?? this.isNew,
    addedAt: addedAt ?? this.addedAt,
  );
  CartItem copyWithCompanion(CartItemsCompanion data) {
    return CartItem(
      id: data.id.present ? data.id.value : this.id,
      productId: data.productId.present ? data.productId.value : this.productId,
      name: data.name.present ? data.name.value : this.name,
      category: data.category.present ? data.category.value : this.category,
      price: data.price.present ? data.price.value : this.price,
      image: data.image.present ? data.image.value : this.image,
      isNew: data.isNew.present ? data.isNew.value : this.isNew,
      addedAt: data.addedAt.present ? data.addedAt.value : this.addedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CartItem(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('price: $price, ')
          ..write('image: $image, ')
          ..write('isNew: $isNew, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, productId, name, category, price, image, isNew, addedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CartItem &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.name == this.name &&
          other.category == this.category &&
          other.price == this.price &&
          other.image == this.image &&
          other.isNew == this.isNew &&
          other.addedAt == this.addedAt);
}

class CartItemsCompanion extends UpdateCompanion<CartItem> {
  final Value<int> id;
  final Value<String> productId;
  final Value<String> name;
  final Value<String> category;
  final Value<double> price;
  final Value<String> image;
  final Value<bool> isNew;
  final Value<DateTime> addedAt;
  const CartItemsCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.name = const Value.absent(),
    this.category = const Value.absent(),
    this.price = const Value.absent(),
    this.image = const Value.absent(),
    this.isNew = const Value.absent(),
    this.addedAt = const Value.absent(),
  });
  CartItemsCompanion.insert({
    this.id = const Value.absent(),
    required String productId,
    required String name,
    required String category,
    required double price,
    required String image,
    this.isNew = const Value.absent(),
    this.addedAt = const Value.absent(),
  }) : productId = Value(productId),
       name = Value(name),
       category = Value(category),
       price = Value(price),
       image = Value(image);
  static Insertable<CartItem> custom({
    Expression<int>? id,
    Expression<String>? productId,
    Expression<String>? name,
    Expression<String>? category,
    Expression<double>? price,
    Expression<String>? image,
    Expression<bool>? isNew,
    Expression<DateTime>? addedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'product_id': productId,
      if (name != null) 'name': name,
      if (category != null) 'category': category,
      if (price != null) 'price': price,
      if (image != null) 'image': image,
      if (isNew != null) 'is_new': isNew,
      if (addedAt != null) 'added_at': addedAt,
    });
  }

  CartItemsCompanion copyWith({
    Value<int>? id,
    Value<String>? productId,
    Value<String>? name,
    Value<String>? category,
    Value<double>? price,
    Value<String>? image,
    Value<bool>? isNew,
    Value<DateTime>? addedAt,
  }) {
    return CartItemsCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      image: image ?? this.image,
      isNew: isNew ?? this.isNew,
      addedAt: addedAt ?? this.addedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (productId.present) {
      map['product_id'] = Variable<String>(productId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (price.present) {
      map['price'] = Variable<double>(price.value);
    }
    if (image.present) {
      map['image'] = Variable<String>(image.value);
    }
    if (isNew.present) {
      map['is_new'] = Variable<bool>(isNew.value);
    }
    if (addedAt.present) {
      map['added_at'] = Variable<DateTime>(addedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CartItemsCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('name: $name, ')
          ..write('category: $category, ')
          ..write('price: $price, ')
          ..write('image: $image, ')
          ..write('isNew: $isNew, ')
          ..write('addedAt: $addedAt')
          ..write(')'))
        .toString();
  }
}

class $StoreOrdersTable extends StoreOrders
    with TableInfo<$StoreOrdersTable, StoreOrder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StoreOrdersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _itemsJsonMeta = const VerificationMeta(
    'itemsJson',
  );
  @override
  late final GeneratedColumn<String> itemsJson = GeneratedColumn<String>(
    'items_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalEurMeta = const VerificationMeta(
    'totalEur',
  );
  @override
  late final GeneratedColumn<double> totalEur = GeneratedColumn<double>(
    'total_eur',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currencyCodeMeta = const VerificationMeta(
    'currencyCode',
  );
  @override
  late final GeneratedColumn<String> currencyCode = GeneratedColumn<String>(
    'currency_code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _deliveryAddressMeta = const VerificationMeta(
    'deliveryAddress',
  );
  @override
  late final GeneratedColumn<String> deliveryAddress = GeneratedColumn<String>(
    'delivery_address',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _paymentMethodMeta = const VerificationMeta(
    'paymentMethod',
  );
  @override
  late final GeneratedColumn<String> paymentMethod = GeneratedColumn<String>(
    'payment_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    itemsJson,
    totalEur,
    currencyCode,
    deliveryAddress,
    paymentMethod,
    status,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'store_orders';
  @override
  VerificationContext validateIntegrity(
    Insertable<StoreOrder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('items_json')) {
      context.handle(
        _itemsJsonMeta,
        itemsJson.isAcceptableOrUnknown(data['items_json']!, _itemsJsonMeta),
      );
    } else if (isInserting) {
      context.missing(_itemsJsonMeta);
    }
    if (data.containsKey('total_eur')) {
      context.handle(
        _totalEurMeta,
        totalEur.isAcceptableOrUnknown(data['total_eur']!, _totalEurMeta),
      );
    } else if (isInserting) {
      context.missing(_totalEurMeta);
    }
    if (data.containsKey('currency_code')) {
      context.handle(
        _currencyCodeMeta,
        currencyCode.isAcceptableOrUnknown(
          data['currency_code']!,
          _currencyCodeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currencyCodeMeta);
    }
    if (data.containsKey('delivery_address')) {
      context.handle(
        _deliveryAddressMeta,
        deliveryAddress.isAcceptableOrUnknown(
          data['delivery_address']!,
          _deliveryAddressMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_deliveryAddressMeta);
    }
    if (data.containsKey('payment_method')) {
      context.handle(
        _paymentMethodMeta,
        paymentMethod.isAcceptableOrUnknown(
          data['payment_method']!,
          _paymentMethodMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_paymentMethodMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StoreOrder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoreOrder(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      itemsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}items_json'],
      )!,
      totalEur: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}total_eur'],
      )!,
      currencyCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}currency_code'],
      )!,
      deliveryAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}delivery_address'],
      )!,
      paymentMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}payment_method'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $StoreOrdersTable createAlias(String alias) {
    return $StoreOrdersTable(attachedDatabase, alias);
  }
}

class StoreOrder extends DataClass implements Insertable<StoreOrder> {
  final String id;
  final String itemsJson;
  final double totalEur;
  final String currencyCode;
  final String deliveryAddress;
  final String paymentMethod;
  final String status;
  final DateTime createdAt;
  const StoreOrder({
    required this.id,
    required this.itemsJson,
    required this.totalEur,
    required this.currencyCode,
    required this.deliveryAddress,
    required this.paymentMethod,
    required this.status,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['items_json'] = Variable<String>(itemsJson);
    map['total_eur'] = Variable<double>(totalEur);
    map['currency_code'] = Variable<String>(currencyCode);
    map['delivery_address'] = Variable<String>(deliveryAddress);
    map['payment_method'] = Variable<String>(paymentMethod);
    map['status'] = Variable<String>(status);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  StoreOrdersCompanion toCompanion(bool nullToAbsent) {
    return StoreOrdersCompanion(
      id: Value(id),
      itemsJson: Value(itemsJson),
      totalEur: Value(totalEur),
      currencyCode: Value(currencyCode),
      deliveryAddress: Value(deliveryAddress),
      paymentMethod: Value(paymentMethod),
      status: Value(status),
      createdAt: Value(createdAt),
    );
  }

  factory StoreOrder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoreOrder(
      id: serializer.fromJson<String>(json['id']),
      itemsJson: serializer.fromJson<String>(json['itemsJson']),
      totalEur: serializer.fromJson<double>(json['totalEur']),
      currencyCode: serializer.fromJson<String>(json['currencyCode']),
      deliveryAddress: serializer.fromJson<String>(json['deliveryAddress']),
      paymentMethod: serializer.fromJson<String>(json['paymentMethod']),
      status: serializer.fromJson<String>(json['status']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'itemsJson': serializer.toJson<String>(itemsJson),
      'totalEur': serializer.toJson<double>(totalEur),
      'currencyCode': serializer.toJson<String>(currencyCode),
      'deliveryAddress': serializer.toJson<String>(deliveryAddress),
      'paymentMethod': serializer.toJson<String>(paymentMethod),
      'status': serializer.toJson<String>(status),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  StoreOrder copyWith({
    String? id,
    String? itemsJson,
    double? totalEur,
    String? currencyCode,
    String? deliveryAddress,
    String? paymentMethod,
    String? status,
    DateTime? createdAt,
  }) => StoreOrder(
    id: id ?? this.id,
    itemsJson: itemsJson ?? this.itemsJson,
    totalEur: totalEur ?? this.totalEur,
    currencyCode: currencyCode ?? this.currencyCode,
    deliveryAddress: deliveryAddress ?? this.deliveryAddress,
    paymentMethod: paymentMethod ?? this.paymentMethod,
    status: status ?? this.status,
    createdAt: createdAt ?? this.createdAt,
  );
  StoreOrder copyWithCompanion(StoreOrdersCompanion data) {
    return StoreOrder(
      id: data.id.present ? data.id.value : this.id,
      itemsJson: data.itemsJson.present ? data.itemsJson.value : this.itemsJson,
      totalEur: data.totalEur.present ? data.totalEur.value : this.totalEur,
      currencyCode: data.currencyCode.present
          ? data.currencyCode.value
          : this.currencyCode,
      deliveryAddress: data.deliveryAddress.present
          ? data.deliveryAddress.value
          : this.deliveryAddress,
      paymentMethod: data.paymentMethod.present
          ? data.paymentMethod.value
          : this.paymentMethod,
      status: data.status.present ? data.status.value : this.status,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoreOrder(')
          ..write('id: $id, ')
          ..write('itemsJson: $itemsJson, ')
          ..write('totalEur: $totalEur, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('deliveryAddress: $deliveryAddress, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    itemsJson,
    totalEur,
    currencyCode,
    deliveryAddress,
    paymentMethod,
    status,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoreOrder &&
          other.id == this.id &&
          other.itemsJson == this.itemsJson &&
          other.totalEur == this.totalEur &&
          other.currencyCode == this.currencyCode &&
          other.deliveryAddress == this.deliveryAddress &&
          other.paymentMethod == this.paymentMethod &&
          other.status == this.status &&
          other.createdAt == this.createdAt);
}

class StoreOrdersCompanion extends UpdateCompanion<StoreOrder> {
  final Value<String> id;
  final Value<String> itemsJson;
  final Value<double> totalEur;
  final Value<String> currencyCode;
  final Value<String> deliveryAddress;
  final Value<String> paymentMethod;
  final Value<String> status;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const StoreOrdersCompanion({
    this.id = const Value.absent(),
    this.itemsJson = const Value.absent(),
    this.totalEur = const Value.absent(),
    this.currencyCode = const Value.absent(),
    this.deliveryAddress = const Value.absent(),
    this.paymentMethod = const Value.absent(),
    this.status = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  StoreOrdersCompanion.insert({
    required String id,
    required String itemsJson,
    required double totalEur,
    required String currencyCode,
    required String deliveryAddress,
    required String paymentMethod,
    required String status,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       itemsJson = Value(itemsJson),
       totalEur = Value(totalEur),
       currencyCode = Value(currencyCode),
       deliveryAddress = Value(deliveryAddress),
       paymentMethod = Value(paymentMethod),
       status = Value(status),
       createdAt = Value(createdAt);
  static Insertable<StoreOrder> custom({
    Expression<String>? id,
    Expression<String>? itemsJson,
    Expression<double>? totalEur,
    Expression<String>? currencyCode,
    Expression<String>? deliveryAddress,
    Expression<String>? paymentMethod,
    Expression<String>? status,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (itemsJson != null) 'items_json': itemsJson,
      if (totalEur != null) 'total_eur': totalEur,
      if (currencyCode != null) 'currency_code': currencyCode,
      if (deliveryAddress != null) 'delivery_address': deliveryAddress,
      if (paymentMethod != null) 'payment_method': paymentMethod,
      if (status != null) 'status': status,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  StoreOrdersCompanion copyWith({
    Value<String>? id,
    Value<String>? itemsJson,
    Value<double>? totalEur,
    Value<String>? currencyCode,
    Value<String>? deliveryAddress,
    Value<String>? paymentMethod,
    Value<String>? status,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return StoreOrdersCompanion(
      id: id ?? this.id,
      itemsJson: itemsJson ?? this.itemsJson,
      totalEur: totalEur ?? this.totalEur,
      currencyCode: currencyCode ?? this.currencyCode,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (itemsJson.present) {
      map['items_json'] = Variable<String>(itemsJson.value);
    }
    if (totalEur.present) {
      map['total_eur'] = Variable<double>(totalEur.value);
    }
    if (currencyCode.present) {
      map['currency_code'] = Variable<String>(currencyCode.value);
    }
    if (deliveryAddress.present) {
      map['delivery_address'] = Variable<String>(deliveryAddress.value);
    }
    if (paymentMethod.present) {
      map['payment_method'] = Variable<String>(paymentMethod.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StoreOrdersCompanion(')
          ..write('id: $id, ')
          ..write('itemsJson: $itemsJson, ')
          ..write('totalEur: $totalEur, ')
          ..write('currencyCode: $currencyCode, ')
          ..write('deliveryAddress: $deliveryAddress, ')
          ..write('paymentMethod: $paymentMethod, ')
          ..write('status: $status, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $NbaTeamsTable nbaTeams = $NbaTeamsTable(this);
  late final $PlayersTable players = $PlayersTable(this);
  late final $CachedGamesTable cachedGames = $CachedGamesTable(this);
  late final $UserPreferencesTable userPreferences = $UserPreferencesTable(
    this,
  );
  late final $PlayerSeasonsTable playerSeasons = $PlayerSeasonsTable(this);
  late final $CartItemsTable cartItems = $CartItemsTable(this);
  late final $StoreOrdersTable storeOrders = $StoreOrdersTable(this);
  late final TeamsDao teamsDao = TeamsDao(this as AppDatabase);
  late final PlayersDao playersDao = PlayersDao(this as AppDatabase);
  late final GamesDao gamesDao = GamesDao(this as AppDatabase);
  late final PreferencesDao preferencesDao = PreferencesDao(
    this as AppDatabase,
  );
  late final CommerceDao commerceDao = CommerceDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    nbaTeams,
    players,
    cachedGames,
    userPreferences,
    playerSeasons,
    cartItems,
    storeOrders,
  ];
}

typedef $$NbaTeamsTableCreateCompanionBuilder =
    NbaTeamsCompanion Function({
      required String teamId,
      required String name,
      required String city,
      required String conference,
      required String division,
      required String colorPrimary,
      required String colorSecondary,
      Value<String?> logoWebpPath,
      Value<int> rowid,
    });
typedef $$NbaTeamsTableUpdateCompanionBuilder =
    NbaTeamsCompanion Function({
      Value<String> teamId,
      Value<String> name,
      Value<String> city,
      Value<String> conference,
      Value<String> division,
      Value<String> colorPrimary,
      Value<String> colorSecondary,
      Value<String?> logoWebpPath,
      Value<int> rowid,
    });

final class $$NbaTeamsTableReferences
    extends BaseReferences<_$AppDatabase, $NbaTeamsTable, NbaTeam> {
  $$NbaTeamsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PlayersTable, List<Player>> _playersRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.players,
    aliasName: $_aliasNameGenerator(db.nbaTeams.teamId, db.players.teamId),
  );

  $$PlayersTableProcessedTableManager get playersRefs {
    final manager = $$PlayersTableTableManager($_db, $_db.players).filter(
      (f) => f.teamId.teamId.sqlEquals($_itemColumn<String>('team_id')!),
    );

    final cache = $_typedResult.readTableOrNull(_playersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$UserPreferencesTable, List<UserPreference>>
  _userPreferencesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.userPreferences,
    aliasName: $_aliasNameGenerator(
      db.nbaTeams.teamId,
      db.userPreferences.favoriteTeamId,
    ),
  );

  $$UserPreferencesTableProcessedTableManager get userPreferencesRefs {
    final manager =
        $$UserPreferencesTableTableManager($_db, $_db.userPreferences).filter(
          (f) => f.favoriteTeamId.teamId.sqlEquals(
            $_itemColumn<String>('team_id')!,
          ),
        );

    final cache = $_typedResult.readTableOrNull(
      _userPreferencesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$NbaTeamsTableFilterComposer
    extends Composer<_$AppDatabase, $NbaTeamsTable> {
  $$NbaTeamsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get conference => $composableBuilder(
    column: $table.conference,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get division => $composableBuilder(
    column: $table.division,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get colorPrimary => $composableBuilder(
    column: $table.colorPrimary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get colorSecondary => $composableBuilder(
    column: $table.colorSecondary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get logoWebpPath => $composableBuilder(
    column: $table.logoWebpPath,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> playersRefs(
    Expression<bool> Function($$PlayersTableFilterComposer f) f,
  ) {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.teamId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableFilterComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> userPreferencesRefs(
    Expression<bool> Function($$UserPreferencesTableFilterComposer f) f,
  ) {
    final $$UserPreferencesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamId,
      referencedTable: $db.userPreferences,
      getReferencedColumn: (t) => t.favoriteTeamId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserPreferencesTableFilterComposer(
            $db: $db,
            $table: $db.userPreferences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$NbaTeamsTableOrderingComposer
    extends Composer<_$AppDatabase, $NbaTeamsTable> {
  $$NbaTeamsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get teamId => $composableBuilder(
    column: $table.teamId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get city => $composableBuilder(
    column: $table.city,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get conference => $composableBuilder(
    column: $table.conference,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get division => $composableBuilder(
    column: $table.division,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colorPrimary => $composableBuilder(
    column: $table.colorPrimary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get colorSecondary => $composableBuilder(
    column: $table.colorSecondary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get logoWebpPath => $composableBuilder(
    column: $table.logoWebpPath,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NbaTeamsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NbaTeamsTable> {
  $$NbaTeamsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get teamId =>
      $composableBuilder(column: $table.teamId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get city =>
      $composableBuilder(column: $table.city, builder: (column) => column);

  GeneratedColumn<String> get conference => $composableBuilder(
    column: $table.conference,
    builder: (column) => column,
  );

  GeneratedColumn<String> get division =>
      $composableBuilder(column: $table.division, builder: (column) => column);

  GeneratedColumn<String> get colorPrimary => $composableBuilder(
    column: $table.colorPrimary,
    builder: (column) => column,
  );

  GeneratedColumn<String> get colorSecondary => $composableBuilder(
    column: $table.colorSecondary,
    builder: (column) => column,
  );

  GeneratedColumn<String> get logoWebpPath => $composableBuilder(
    column: $table.logoWebpPath,
    builder: (column) => column,
  );

  Expression<T> playersRefs<T extends Object>(
    Expression<T> Function($$PlayersTableAnnotationComposer a) f,
  ) {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.teamId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableAnnotationComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> userPreferencesRefs<T extends Object>(
    Expression<T> Function($$UserPreferencesTableAnnotationComposer a) f,
  ) {
    final $$UserPreferencesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamId,
      referencedTable: $db.userPreferences,
      getReferencedColumn: (t) => t.favoriteTeamId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UserPreferencesTableAnnotationComposer(
            $db: $db,
            $table: $db.userPreferences,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$NbaTeamsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NbaTeamsTable,
          NbaTeam,
          $$NbaTeamsTableFilterComposer,
          $$NbaTeamsTableOrderingComposer,
          $$NbaTeamsTableAnnotationComposer,
          $$NbaTeamsTableCreateCompanionBuilder,
          $$NbaTeamsTableUpdateCompanionBuilder,
          (NbaTeam, $$NbaTeamsTableReferences),
          NbaTeam,
          PrefetchHooks Function({bool playersRefs, bool userPreferencesRefs})
        > {
  $$NbaTeamsTableTableManager(_$AppDatabase db, $NbaTeamsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NbaTeamsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NbaTeamsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NbaTeamsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> teamId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> city = const Value.absent(),
                Value<String> conference = const Value.absent(),
                Value<String> division = const Value.absent(),
                Value<String> colorPrimary = const Value.absent(),
                Value<String> colorSecondary = const Value.absent(),
                Value<String?> logoWebpPath = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NbaTeamsCompanion(
                teamId: teamId,
                name: name,
                city: city,
                conference: conference,
                division: division,
                colorPrimary: colorPrimary,
                colorSecondary: colorSecondary,
                logoWebpPath: logoWebpPath,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String teamId,
                required String name,
                required String city,
                required String conference,
                required String division,
                required String colorPrimary,
                required String colorSecondary,
                Value<String?> logoWebpPath = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NbaTeamsCompanion.insert(
                teamId: teamId,
                name: name,
                city: city,
                conference: conference,
                division: division,
                colorPrimary: colorPrimary,
                colorSecondary: colorSecondary,
                logoWebpPath: logoWebpPath,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$NbaTeamsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({playersRefs = false, userPreferencesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (playersRefs) db.players,
                    if (userPreferencesRefs) db.userPreferences,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (playersRefs)
                        await $_getPrefetchedData<
                          NbaTeam,
                          $NbaTeamsTable,
                          Player
                        >(
                          currentTable: table,
                          referencedTable: $$NbaTeamsTableReferences
                              ._playersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$NbaTeamsTableReferences(
                                db,
                                table,
                                p0,
                              ).playersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.teamId == item.teamId,
                              ),
                          typedResults: items,
                        ),
                      if (userPreferencesRefs)
                        await $_getPrefetchedData<
                          NbaTeam,
                          $NbaTeamsTable,
                          UserPreference
                        >(
                          currentTable: table,
                          referencedTable: $$NbaTeamsTableReferences
                              ._userPreferencesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$NbaTeamsTableReferences(
                                db,
                                table,
                                p0,
                              ).userPreferencesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.favoriteTeamId == item.teamId,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$NbaTeamsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NbaTeamsTable,
      NbaTeam,
      $$NbaTeamsTableFilterComposer,
      $$NbaTeamsTableOrderingComposer,
      $$NbaTeamsTableAnnotationComposer,
      $$NbaTeamsTableCreateCompanionBuilder,
      $$NbaTeamsTableUpdateCompanionBuilder,
      (NbaTeam, $$NbaTeamsTableReferences),
      NbaTeam,
      PrefetchHooks Function({bool playersRefs, bool userPreferencesRefs})
    >;
typedef $$PlayersTableCreateCompanionBuilder =
    PlayersCompanion Function({
      required String playerId,
      required String teamId,
      required String fullName,
      Value<String?> displayName,
      Value<String?> position,
      Value<String?> jerseyNumber,
      Value<double?> heightCm,
      Value<double?> weightKg,
      Value<DateTime?> birthDate,
      Value<String?> country,
      Value<String?> previousTeam,
      Value<int?> experienceYears,
      Value<double> ppg,
      Value<double> rpg,
      Value<double> apg,
      Value<double> spg,
      Value<double> bpg,
      Value<double> mpg,
      Value<double> topg,
      Value<double> fgPct,
      Value<double> fg3Pct,
      Value<double> ftPct,
      Value<String?> photoWebpPath,
      Value<int> careerPoints,
      Value<int> careerRebounds,
      Value<int> careerAssists,
      Value<int> careerSteals,
      Value<int> careerBlocks,
      Value<int> careerGames,
      Value<int> careerStarts,
      Value<int> careerTurnovers,
      Value<String?> careerTeams,
      Value<DateTime> cachedAt,
      Value<int> rowid,
    });
typedef $$PlayersTableUpdateCompanionBuilder =
    PlayersCompanion Function({
      Value<String> playerId,
      Value<String> teamId,
      Value<String> fullName,
      Value<String?> displayName,
      Value<String?> position,
      Value<String?> jerseyNumber,
      Value<double?> heightCm,
      Value<double?> weightKg,
      Value<DateTime?> birthDate,
      Value<String?> country,
      Value<String?> previousTeam,
      Value<int?> experienceYears,
      Value<double> ppg,
      Value<double> rpg,
      Value<double> apg,
      Value<double> spg,
      Value<double> bpg,
      Value<double> mpg,
      Value<double> topg,
      Value<double> fgPct,
      Value<double> fg3Pct,
      Value<double> ftPct,
      Value<String?> photoWebpPath,
      Value<int> careerPoints,
      Value<int> careerRebounds,
      Value<int> careerAssists,
      Value<int> careerSteals,
      Value<int> careerBlocks,
      Value<int> careerGames,
      Value<int> careerStarts,
      Value<int> careerTurnovers,
      Value<String?> careerTeams,
      Value<DateTime> cachedAt,
      Value<int> rowid,
    });

final class $$PlayersTableReferences
    extends BaseReferences<_$AppDatabase, $PlayersTable, Player> {
  $$PlayersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $NbaTeamsTable _teamIdTable(_$AppDatabase db) => db.nbaTeams
      .createAlias($_aliasNameGenerator(db.players.teamId, db.nbaTeams.teamId));

  $$NbaTeamsTableProcessedTableManager get teamId {
    final $_column = $_itemColumn<String>('team_id')!;

    final manager = $$NbaTeamsTableTableManager(
      $_db,
      $_db.nbaTeams,
    ).filter((f) => f.teamId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_teamIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PlayerSeasonsTable, List<PlayerSeason>>
  _playerSeasonsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.playerSeasons,
    aliasName: $_aliasNameGenerator(
      db.players.playerId,
      db.playerSeasons.playerId,
    ),
  );

  $$PlayerSeasonsTableProcessedTableManager get playerSeasonsRefs {
    final manager = $$PlayerSeasonsTableTableManager($_db, $_db.playerSeasons)
        .filter(
          (f) =>
              f.playerId.playerId.sqlEquals($_itemColumn<String>('player_id')!),
        );

    final cache = $_typedResult.readTableOrNull(_playerSeasonsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PlayersTableFilterComposer
    extends Composer<_$AppDatabase, $PlayersTable> {
  $$PlayersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get playerId => $composableBuilder(
    column: $table.playerId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jerseyNumber => $composableBuilder(
    column: $table.jerseyNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get previousTeam => $composableBuilder(
    column: $table.previousTeam,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get experienceYears => $composableBuilder(
    column: $table.experienceYears,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get ppg => $composableBuilder(
    column: $table.ppg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rpg => $composableBuilder(
    column: $table.rpg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get apg => $composableBuilder(
    column: $table.apg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get spg => $composableBuilder(
    column: $table.spg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bpg => $composableBuilder(
    column: $table.bpg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get mpg => $composableBuilder(
    column: $table.mpg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get topg => $composableBuilder(
    column: $table.topg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fgPct => $composableBuilder(
    column: $table.fgPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fg3Pct => $composableBuilder(
    column: $table.fg3Pct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get ftPct => $composableBuilder(
    column: $table.ftPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoWebpPath => $composableBuilder(
    column: $table.photoWebpPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get careerPoints => $composableBuilder(
    column: $table.careerPoints,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get careerRebounds => $composableBuilder(
    column: $table.careerRebounds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get careerAssists => $composableBuilder(
    column: $table.careerAssists,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get careerSteals => $composableBuilder(
    column: $table.careerSteals,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get careerBlocks => $composableBuilder(
    column: $table.careerBlocks,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get careerGames => $composableBuilder(
    column: $table.careerGames,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get careerStarts => $composableBuilder(
    column: $table.careerStarts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get careerTurnovers => $composableBuilder(
    column: $table.careerTurnovers,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get careerTeams => $composableBuilder(
    column: $table.careerTeams,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$NbaTeamsTableFilterComposer get teamId {
    final $$NbaTeamsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamId,
      referencedTable: $db.nbaTeams,
      getReferencedColumn: (t) => t.teamId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NbaTeamsTableFilterComposer(
            $db: $db,
            $table: $db.nbaTeams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> playerSeasonsRefs(
    Expression<bool> Function($$PlayerSeasonsTableFilterComposer f) f,
  ) {
    final $$PlayerSeasonsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.playerSeasons,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerSeasonsTableFilterComposer(
            $db: $db,
            $table: $db.playerSeasons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlayersTableOrderingComposer
    extends Composer<_$AppDatabase, $PlayersTable> {
  $$PlayersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get playerId => $composableBuilder(
    column: $table.playerId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get position => $composableBuilder(
    column: $table.position,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jerseyNumber => $composableBuilder(
    column: $table.jerseyNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get heightCm => $composableBuilder(
    column: $table.heightCm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get weightKg => $composableBuilder(
    column: $table.weightKg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get birthDate => $composableBuilder(
    column: $table.birthDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get previousTeam => $composableBuilder(
    column: $table.previousTeam,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get experienceYears => $composableBuilder(
    column: $table.experienceYears,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get ppg => $composableBuilder(
    column: $table.ppg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rpg => $composableBuilder(
    column: $table.rpg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get apg => $composableBuilder(
    column: $table.apg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get spg => $composableBuilder(
    column: $table.spg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bpg => $composableBuilder(
    column: $table.bpg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get mpg => $composableBuilder(
    column: $table.mpg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get topg => $composableBuilder(
    column: $table.topg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fgPct => $composableBuilder(
    column: $table.fgPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fg3Pct => $composableBuilder(
    column: $table.fg3Pct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get ftPct => $composableBuilder(
    column: $table.ftPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoWebpPath => $composableBuilder(
    column: $table.photoWebpPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get careerPoints => $composableBuilder(
    column: $table.careerPoints,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get careerRebounds => $composableBuilder(
    column: $table.careerRebounds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get careerAssists => $composableBuilder(
    column: $table.careerAssists,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get careerSteals => $composableBuilder(
    column: $table.careerSteals,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get careerBlocks => $composableBuilder(
    column: $table.careerBlocks,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get careerGames => $composableBuilder(
    column: $table.careerGames,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get careerStarts => $composableBuilder(
    column: $table.careerStarts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get careerTurnovers => $composableBuilder(
    column: $table.careerTurnovers,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get careerTeams => $composableBuilder(
    column: $table.careerTeams,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$NbaTeamsTableOrderingComposer get teamId {
    final $$NbaTeamsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamId,
      referencedTable: $db.nbaTeams,
      getReferencedColumn: (t) => t.teamId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NbaTeamsTableOrderingComposer(
            $db: $db,
            $table: $db.nbaTeams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlayersTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlayersTable> {
  $$PlayersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get playerId =>
      $composableBuilder(column: $table.playerId, builder: (column) => column);

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

  GeneratedColumn<String> get jerseyNumber => $composableBuilder(
    column: $table.jerseyNumber,
    builder: (column) => column,
  );

  GeneratedColumn<double> get heightCm =>
      $composableBuilder(column: $table.heightCm, builder: (column) => column);

  GeneratedColumn<double> get weightKg =>
      $composableBuilder(column: $table.weightKg, builder: (column) => column);

  GeneratedColumn<DateTime> get birthDate =>
      $composableBuilder(column: $table.birthDate, builder: (column) => column);

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<String> get previousTeam => $composableBuilder(
    column: $table.previousTeam,
    builder: (column) => column,
  );

  GeneratedColumn<int> get experienceYears => $composableBuilder(
    column: $table.experienceYears,
    builder: (column) => column,
  );

  GeneratedColumn<double> get ppg =>
      $composableBuilder(column: $table.ppg, builder: (column) => column);

  GeneratedColumn<double> get rpg =>
      $composableBuilder(column: $table.rpg, builder: (column) => column);

  GeneratedColumn<double> get apg =>
      $composableBuilder(column: $table.apg, builder: (column) => column);

  GeneratedColumn<double> get spg =>
      $composableBuilder(column: $table.spg, builder: (column) => column);

  GeneratedColumn<double> get bpg =>
      $composableBuilder(column: $table.bpg, builder: (column) => column);

  GeneratedColumn<double> get mpg =>
      $composableBuilder(column: $table.mpg, builder: (column) => column);

  GeneratedColumn<double> get topg =>
      $composableBuilder(column: $table.topg, builder: (column) => column);

  GeneratedColumn<double> get fgPct =>
      $composableBuilder(column: $table.fgPct, builder: (column) => column);

  GeneratedColumn<double> get fg3Pct =>
      $composableBuilder(column: $table.fg3Pct, builder: (column) => column);

  GeneratedColumn<double> get ftPct =>
      $composableBuilder(column: $table.ftPct, builder: (column) => column);

  GeneratedColumn<String> get photoWebpPath => $composableBuilder(
    column: $table.photoWebpPath,
    builder: (column) => column,
  );

  GeneratedColumn<int> get careerPoints => $composableBuilder(
    column: $table.careerPoints,
    builder: (column) => column,
  );

  GeneratedColumn<int> get careerRebounds => $composableBuilder(
    column: $table.careerRebounds,
    builder: (column) => column,
  );

  GeneratedColumn<int> get careerAssists => $composableBuilder(
    column: $table.careerAssists,
    builder: (column) => column,
  );

  GeneratedColumn<int> get careerSteals => $composableBuilder(
    column: $table.careerSteals,
    builder: (column) => column,
  );

  GeneratedColumn<int> get careerBlocks => $composableBuilder(
    column: $table.careerBlocks,
    builder: (column) => column,
  );

  GeneratedColumn<int> get careerGames => $composableBuilder(
    column: $table.careerGames,
    builder: (column) => column,
  );

  GeneratedColumn<int> get careerStarts => $composableBuilder(
    column: $table.careerStarts,
    builder: (column) => column,
  );

  GeneratedColumn<int> get careerTurnovers => $composableBuilder(
    column: $table.careerTurnovers,
    builder: (column) => column,
  );

  GeneratedColumn<String> get careerTeams => $composableBuilder(
    column: $table.careerTeams,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);

  $$NbaTeamsTableAnnotationComposer get teamId {
    final $$NbaTeamsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.teamId,
      referencedTable: $db.nbaTeams,
      getReferencedColumn: (t) => t.teamId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NbaTeamsTableAnnotationComposer(
            $db: $db,
            $table: $db.nbaTeams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> playerSeasonsRefs<T extends Object>(
    Expression<T> Function($$PlayerSeasonsTableAnnotationComposer a) f,
  ) {
    final $$PlayerSeasonsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.playerSeasons,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayerSeasonsTableAnnotationComposer(
            $db: $db,
            $table: $db.playerSeasons,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PlayersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlayersTable,
          Player,
          $$PlayersTableFilterComposer,
          $$PlayersTableOrderingComposer,
          $$PlayersTableAnnotationComposer,
          $$PlayersTableCreateCompanionBuilder,
          $$PlayersTableUpdateCompanionBuilder,
          (Player, $$PlayersTableReferences),
          Player,
          PrefetchHooks Function({bool teamId, bool playerSeasonsRefs})
        > {
  $$PlayersTableTableManager(_$AppDatabase db, $PlayersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlayersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlayersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlayersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> playerId = const Value.absent(),
                Value<String> teamId = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<String?> displayName = const Value.absent(),
                Value<String?> position = const Value.absent(),
                Value<String?> jerseyNumber = const Value.absent(),
                Value<double?> heightCm = const Value.absent(),
                Value<double?> weightKg = const Value.absent(),
                Value<DateTime?> birthDate = const Value.absent(),
                Value<String?> country = const Value.absent(),
                Value<String?> previousTeam = const Value.absent(),
                Value<int?> experienceYears = const Value.absent(),
                Value<double> ppg = const Value.absent(),
                Value<double> rpg = const Value.absent(),
                Value<double> apg = const Value.absent(),
                Value<double> spg = const Value.absent(),
                Value<double> bpg = const Value.absent(),
                Value<double> mpg = const Value.absent(),
                Value<double> topg = const Value.absent(),
                Value<double> fgPct = const Value.absent(),
                Value<double> fg3Pct = const Value.absent(),
                Value<double> ftPct = const Value.absent(),
                Value<String?> photoWebpPath = const Value.absent(),
                Value<int> careerPoints = const Value.absent(),
                Value<int> careerRebounds = const Value.absent(),
                Value<int> careerAssists = const Value.absent(),
                Value<int> careerSteals = const Value.absent(),
                Value<int> careerBlocks = const Value.absent(),
                Value<int> careerGames = const Value.absent(),
                Value<int> careerStarts = const Value.absent(),
                Value<int> careerTurnovers = const Value.absent(),
                Value<String?> careerTeams = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlayersCompanion(
                playerId: playerId,
                teamId: teamId,
                fullName: fullName,
                displayName: displayName,
                position: position,
                jerseyNumber: jerseyNumber,
                heightCm: heightCm,
                weightKg: weightKg,
                birthDate: birthDate,
                country: country,
                previousTeam: previousTeam,
                experienceYears: experienceYears,
                ppg: ppg,
                rpg: rpg,
                apg: apg,
                spg: spg,
                bpg: bpg,
                mpg: mpg,
                topg: topg,
                fgPct: fgPct,
                fg3Pct: fg3Pct,
                ftPct: ftPct,
                photoWebpPath: photoWebpPath,
                careerPoints: careerPoints,
                careerRebounds: careerRebounds,
                careerAssists: careerAssists,
                careerSteals: careerSteals,
                careerBlocks: careerBlocks,
                careerGames: careerGames,
                careerStarts: careerStarts,
                careerTurnovers: careerTurnovers,
                careerTeams: careerTeams,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String playerId,
                required String teamId,
                required String fullName,
                Value<String?> displayName = const Value.absent(),
                Value<String?> position = const Value.absent(),
                Value<String?> jerseyNumber = const Value.absent(),
                Value<double?> heightCm = const Value.absent(),
                Value<double?> weightKg = const Value.absent(),
                Value<DateTime?> birthDate = const Value.absent(),
                Value<String?> country = const Value.absent(),
                Value<String?> previousTeam = const Value.absent(),
                Value<int?> experienceYears = const Value.absent(),
                Value<double> ppg = const Value.absent(),
                Value<double> rpg = const Value.absent(),
                Value<double> apg = const Value.absent(),
                Value<double> spg = const Value.absent(),
                Value<double> bpg = const Value.absent(),
                Value<double> mpg = const Value.absent(),
                Value<double> topg = const Value.absent(),
                Value<double> fgPct = const Value.absent(),
                Value<double> fg3Pct = const Value.absent(),
                Value<double> ftPct = const Value.absent(),
                Value<String?> photoWebpPath = const Value.absent(),
                Value<int> careerPoints = const Value.absent(),
                Value<int> careerRebounds = const Value.absent(),
                Value<int> careerAssists = const Value.absent(),
                Value<int> careerSteals = const Value.absent(),
                Value<int> careerBlocks = const Value.absent(),
                Value<int> careerGames = const Value.absent(),
                Value<int> careerStarts = const Value.absent(),
                Value<int> careerTurnovers = const Value.absent(),
                Value<String?> careerTeams = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlayersCompanion.insert(
                playerId: playerId,
                teamId: teamId,
                fullName: fullName,
                displayName: displayName,
                position: position,
                jerseyNumber: jerseyNumber,
                heightCm: heightCm,
                weightKg: weightKg,
                birthDate: birthDate,
                country: country,
                previousTeam: previousTeam,
                experienceYears: experienceYears,
                ppg: ppg,
                rpg: rpg,
                apg: apg,
                spg: spg,
                bpg: bpg,
                mpg: mpg,
                topg: topg,
                fgPct: fgPct,
                fg3Pct: fg3Pct,
                ftPct: ftPct,
                photoWebpPath: photoWebpPath,
                careerPoints: careerPoints,
                careerRebounds: careerRebounds,
                careerAssists: careerAssists,
                careerSteals: careerSteals,
                careerBlocks: careerBlocks,
                careerGames: careerGames,
                careerStarts: careerStarts,
                careerTurnovers: careerTurnovers,
                careerTeams: careerTeams,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PlayersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({teamId = false, playerSeasonsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (playerSeasonsRefs) db.playerSeasons,
              ],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (teamId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.teamId,
                                referencedTable: $$PlayersTableReferences
                                    ._teamIdTable(db),
                                referencedColumn: $$PlayersTableReferences
                                    ._teamIdTable(db)
                                    .teamId,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (playerSeasonsRefs)
                    await $_getPrefetchedData<
                      Player,
                      $PlayersTable,
                      PlayerSeason
                    >(
                      currentTable: table,
                      referencedTable: $$PlayersTableReferences
                          ._playerSeasonsRefsTable(db),
                      managerFromTypedResult: (p0) => $$PlayersTableReferences(
                        db,
                        table,
                        p0,
                      ).playerSeasonsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.playerId == item.playerId,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$PlayersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlayersTable,
      Player,
      $$PlayersTableFilterComposer,
      $$PlayersTableOrderingComposer,
      $$PlayersTableAnnotationComposer,
      $$PlayersTableCreateCompanionBuilder,
      $$PlayersTableUpdateCompanionBuilder,
      (Player, $$PlayersTableReferences),
      Player,
      PrefetchHooks Function({bool teamId, bool playerSeasonsRefs})
    >;
typedef $$CachedGamesTableCreateCompanionBuilder =
    CachedGamesCompanion Function({
      required String gameId,
      required String homeTeamId,
      required String awayTeamId,
      Value<int> scoreHome,
      Value<int> scoreAway,
      required String status,
      required DateTime gameDate,
      Value<DateTime> cachedAt,
      Value<int> rowid,
    });
typedef $$CachedGamesTableUpdateCompanionBuilder =
    CachedGamesCompanion Function({
      Value<String> gameId,
      Value<String> homeTeamId,
      Value<String> awayTeamId,
      Value<int> scoreHome,
      Value<int> scoreAway,
      Value<String> status,
      Value<DateTime> gameDate,
      Value<DateTime> cachedAt,
      Value<int> rowid,
    });

final class $$CachedGamesTableReferences
    extends BaseReferences<_$AppDatabase, $CachedGamesTable, CachedGame> {
  $$CachedGamesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $NbaTeamsTable _homeTeamIdTable(_$AppDatabase db) =>
      db.nbaTeams.createAlias(
        $_aliasNameGenerator(db.cachedGames.homeTeamId, db.nbaTeams.teamId),
      );

  $$NbaTeamsTableProcessedTableManager get homeTeamId {
    final $_column = $_itemColumn<String>('home_team_id')!;

    final manager = $$NbaTeamsTableTableManager(
      $_db,
      $_db.nbaTeams,
    ).filter((f) => f.teamId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_homeTeamIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $NbaTeamsTable _awayTeamIdTable(_$AppDatabase db) =>
      db.nbaTeams.createAlias(
        $_aliasNameGenerator(db.cachedGames.awayTeamId, db.nbaTeams.teamId),
      );

  $$NbaTeamsTableProcessedTableManager get awayTeamId {
    final $_column = $_itemColumn<String>('away_team_id')!;

    final manager = $$NbaTeamsTableTableManager(
      $_db,
      $_db.nbaTeams,
    ).filter((f) => f.teamId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_awayTeamIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CachedGamesTableFilterComposer
    extends Composer<_$AppDatabase, $CachedGamesTable> {
  $$CachedGamesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get gameId => $composableBuilder(
    column: $table.gameId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scoreHome => $composableBuilder(
    column: $table.scoreHome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scoreAway => $composableBuilder(
    column: $table.scoreAway,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get gameDate => $composableBuilder(
    column: $table.gameDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$NbaTeamsTableFilterComposer get homeTeamId {
    final $$NbaTeamsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.homeTeamId,
      referencedTable: $db.nbaTeams,
      getReferencedColumn: (t) => t.teamId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NbaTeamsTableFilterComposer(
            $db: $db,
            $table: $db.nbaTeams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$NbaTeamsTableFilterComposer get awayTeamId {
    final $$NbaTeamsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.awayTeamId,
      referencedTable: $db.nbaTeams,
      getReferencedColumn: (t) => t.teamId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NbaTeamsTableFilterComposer(
            $db: $db,
            $table: $db.nbaTeams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CachedGamesTableOrderingComposer
    extends Composer<_$AppDatabase, $CachedGamesTable> {
  $$CachedGamesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get gameId => $composableBuilder(
    column: $table.gameId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scoreHome => $composableBuilder(
    column: $table.scoreHome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scoreAway => $composableBuilder(
    column: $table.scoreAway,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get gameDate => $composableBuilder(
    column: $table.gameDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cachedAt => $composableBuilder(
    column: $table.cachedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$NbaTeamsTableOrderingComposer get homeTeamId {
    final $$NbaTeamsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.homeTeamId,
      referencedTable: $db.nbaTeams,
      getReferencedColumn: (t) => t.teamId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NbaTeamsTableOrderingComposer(
            $db: $db,
            $table: $db.nbaTeams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$NbaTeamsTableOrderingComposer get awayTeamId {
    final $$NbaTeamsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.awayTeamId,
      referencedTable: $db.nbaTeams,
      getReferencedColumn: (t) => t.teamId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NbaTeamsTableOrderingComposer(
            $db: $db,
            $table: $db.nbaTeams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CachedGamesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CachedGamesTable> {
  $$CachedGamesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get gameId =>
      $composableBuilder(column: $table.gameId, builder: (column) => column);

  GeneratedColumn<int> get scoreHome =>
      $composableBuilder(column: $table.scoreHome, builder: (column) => column);

  GeneratedColumn<int> get scoreAway =>
      $composableBuilder(column: $table.scoreAway, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get gameDate =>
      $composableBuilder(column: $table.gameDate, builder: (column) => column);

  GeneratedColumn<DateTime> get cachedAt =>
      $composableBuilder(column: $table.cachedAt, builder: (column) => column);

  $$NbaTeamsTableAnnotationComposer get homeTeamId {
    final $$NbaTeamsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.homeTeamId,
      referencedTable: $db.nbaTeams,
      getReferencedColumn: (t) => t.teamId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NbaTeamsTableAnnotationComposer(
            $db: $db,
            $table: $db.nbaTeams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$NbaTeamsTableAnnotationComposer get awayTeamId {
    final $$NbaTeamsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.awayTeamId,
      referencedTable: $db.nbaTeams,
      getReferencedColumn: (t) => t.teamId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NbaTeamsTableAnnotationComposer(
            $db: $db,
            $table: $db.nbaTeams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CachedGamesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CachedGamesTable,
          CachedGame,
          $$CachedGamesTableFilterComposer,
          $$CachedGamesTableOrderingComposer,
          $$CachedGamesTableAnnotationComposer,
          $$CachedGamesTableCreateCompanionBuilder,
          $$CachedGamesTableUpdateCompanionBuilder,
          (CachedGame, $$CachedGamesTableReferences),
          CachedGame,
          PrefetchHooks Function({bool homeTeamId, bool awayTeamId})
        > {
  $$CachedGamesTableTableManager(_$AppDatabase db, $CachedGamesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CachedGamesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CachedGamesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CachedGamesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> gameId = const Value.absent(),
                Value<String> homeTeamId = const Value.absent(),
                Value<String> awayTeamId = const Value.absent(),
                Value<int> scoreHome = const Value.absent(),
                Value<int> scoreAway = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> gameDate = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedGamesCompanion(
                gameId: gameId,
                homeTeamId: homeTeamId,
                awayTeamId: awayTeamId,
                scoreHome: scoreHome,
                scoreAway: scoreAway,
                status: status,
                gameDate: gameDate,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String gameId,
                required String homeTeamId,
                required String awayTeamId,
                Value<int> scoreHome = const Value.absent(),
                Value<int> scoreAway = const Value.absent(),
                required String status,
                required DateTime gameDate,
                Value<DateTime> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CachedGamesCompanion.insert(
                gameId: gameId,
                homeTeamId: homeTeamId,
                awayTeamId: awayTeamId,
                scoreHome: scoreHome,
                scoreAway: scoreAway,
                status: status,
                gameDate: gameDate,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CachedGamesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({homeTeamId = false, awayTeamId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (homeTeamId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.homeTeamId,
                                referencedTable: $$CachedGamesTableReferences
                                    ._homeTeamIdTable(db),
                                referencedColumn: $$CachedGamesTableReferences
                                    ._homeTeamIdTable(db)
                                    .teamId,
                              )
                              as T;
                    }
                    if (awayTeamId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.awayTeamId,
                                referencedTable: $$CachedGamesTableReferences
                                    ._awayTeamIdTable(db),
                                referencedColumn: $$CachedGamesTableReferences
                                    ._awayTeamIdTable(db)
                                    .teamId,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CachedGamesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CachedGamesTable,
      CachedGame,
      $$CachedGamesTableFilterComposer,
      $$CachedGamesTableOrderingComposer,
      $$CachedGamesTableAnnotationComposer,
      $$CachedGamesTableCreateCompanionBuilder,
      $$CachedGamesTableUpdateCompanionBuilder,
      (CachedGame, $$CachedGamesTableReferences),
      CachedGame,
      PrefetchHooks Function({bool homeTeamId, bool awayTeamId})
    >;
typedef $$UserPreferencesTableCreateCompanionBuilder =
    UserPreferencesCompanion Function({
      Value<int> id,
      Value<String?> email,
      Value<String?> passwordHash,
      Value<String?> displayName,
      Value<String?> favoriteTeamId,
      Value<bool> isLoggedIn,
      Value<String> themeMode,
      Value<bool> notificationsOn,
      Value<String> language,
      Value<String> measurementUnit,
      Value<String> currencyCode,
      Value<bool> favoriteTeamAlerts,
      Value<DateTime> updatedAt,
    });
typedef $$UserPreferencesTableUpdateCompanionBuilder =
    UserPreferencesCompanion Function({
      Value<int> id,
      Value<String?> email,
      Value<String?> passwordHash,
      Value<String?> displayName,
      Value<String?> favoriteTeamId,
      Value<bool> isLoggedIn,
      Value<String> themeMode,
      Value<bool> notificationsOn,
      Value<String> language,
      Value<String> measurementUnit,
      Value<String> currencyCode,
      Value<bool> favoriteTeamAlerts,
      Value<DateTime> updatedAt,
    });

final class $$UserPreferencesTableReferences
    extends
        BaseReferences<_$AppDatabase, $UserPreferencesTable, UserPreference> {
  $$UserPreferencesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $NbaTeamsTable _favoriteTeamIdTable(_$AppDatabase db) =>
      db.nbaTeams.createAlias(
        $_aliasNameGenerator(
          db.userPreferences.favoriteTeamId,
          db.nbaTeams.teamId,
        ),
      );

  $$NbaTeamsTableProcessedTableManager? get favoriteTeamId {
    final $_column = $_itemColumn<String>('favorite_team_id');
    if ($_column == null) return null;
    final manager = $$NbaTeamsTableTableManager(
      $_db,
      $_db.nbaTeams,
    ).filter((f) => f.teamId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_favoriteTeamIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$UserPreferencesTableFilterComposer
    extends Composer<_$AppDatabase, $UserPreferencesTable> {
  $$UserPreferencesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isLoggedIn => $composableBuilder(
    column: $table.isLoggedIn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get notificationsOn => $composableBuilder(
    column: $table.notificationsOn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get measurementUnit => $composableBuilder(
    column: $table.measurementUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get favoriteTeamAlerts => $composableBuilder(
    column: $table.favoriteTeamAlerts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$NbaTeamsTableFilterComposer get favoriteTeamId {
    final $$NbaTeamsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.favoriteTeamId,
      referencedTable: $db.nbaTeams,
      getReferencedColumn: (t) => t.teamId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NbaTeamsTableFilterComposer(
            $db: $db,
            $table: $db.nbaTeams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserPreferencesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserPreferencesTable> {
  $$UserPreferencesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isLoggedIn => $composableBuilder(
    column: $table.isLoggedIn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get notificationsOn => $composableBuilder(
    column: $table.notificationsOn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get language => $composableBuilder(
    column: $table.language,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get measurementUnit => $composableBuilder(
    column: $table.measurementUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get favoriteTeamAlerts => $composableBuilder(
    column: $table.favoriteTeamAlerts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$NbaTeamsTableOrderingComposer get favoriteTeamId {
    final $$NbaTeamsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.favoriteTeamId,
      referencedTable: $db.nbaTeams,
      getReferencedColumn: (t) => t.teamId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NbaTeamsTableOrderingComposer(
            $db: $db,
            $table: $db.nbaTeams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserPreferencesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserPreferencesTable> {
  $$UserPreferencesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get passwordHash => $composableBuilder(
    column: $table.passwordHash,
    builder: (column) => column,
  );

  GeneratedColumn<String> get displayName => $composableBuilder(
    column: $table.displayName,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isLoggedIn => $composableBuilder(
    column: $table.isLoggedIn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<bool> get notificationsOn => $composableBuilder(
    column: $table.notificationsOn,
    builder: (column) => column,
  );

  GeneratedColumn<String> get language =>
      $composableBuilder(column: $table.language, builder: (column) => column);

  GeneratedColumn<String> get measurementUnit => $composableBuilder(
    column: $table.measurementUnit,
    builder: (column) => column,
  );

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get favoriteTeamAlerts => $composableBuilder(
    column: $table.favoriteTeamAlerts,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$NbaTeamsTableAnnotationComposer get favoriteTeamId {
    final $$NbaTeamsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.favoriteTeamId,
      referencedTable: $db.nbaTeams,
      getReferencedColumn: (t) => t.teamId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NbaTeamsTableAnnotationComposer(
            $db: $db,
            $table: $db.nbaTeams,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$UserPreferencesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserPreferencesTable,
          UserPreference,
          $$UserPreferencesTableFilterComposer,
          $$UserPreferencesTableOrderingComposer,
          $$UserPreferencesTableAnnotationComposer,
          $$UserPreferencesTableCreateCompanionBuilder,
          $$UserPreferencesTableUpdateCompanionBuilder,
          (UserPreference, $$UserPreferencesTableReferences),
          UserPreference,
          PrefetchHooks Function({bool favoriteTeamId})
        > {
  $$UserPreferencesTableTableManager(
    _$AppDatabase db,
    $UserPreferencesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserPreferencesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserPreferencesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserPreferencesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> passwordHash = const Value.absent(),
                Value<String?> displayName = const Value.absent(),
                Value<String?> favoriteTeamId = const Value.absent(),
                Value<bool> isLoggedIn = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<bool> notificationsOn = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<String> measurementUnit = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<bool> favoriteTeamAlerts = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserPreferencesCompanion(
                id: id,
                email: email,
                passwordHash: passwordHash,
                displayName: displayName,
                favoriteTeamId: favoriteTeamId,
                isLoggedIn: isLoggedIn,
                themeMode: themeMode,
                notificationsOn: notificationsOn,
                language: language,
                measurementUnit: measurementUnit,
                currencyCode: currencyCode,
                favoriteTeamAlerts: favoriteTeamAlerts,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> passwordHash = const Value.absent(),
                Value<String?> displayName = const Value.absent(),
                Value<String?> favoriteTeamId = const Value.absent(),
                Value<bool> isLoggedIn = const Value.absent(),
                Value<String> themeMode = const Value.absent(),
                Value<bool> notificationsOn = const Value.absent(),
                Value<String> language = const Value.absent(),
                Value<String> measurementUnit = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<bool> favoriteTeamAlerts = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => UserPreferencesCompanion.insert(
                id: id,
                email: email,
                passwordHash: passwordHash,
                displayName: displayName,
                favoriteTeamId: favoriteTeamId,
                isLoggedIn: isLoggedIn,
                themeMode: themeMode,
                notificationsOn: notificationsOn,
                language: language,
                measurementUnit: measurementUnit,
                currencyCode: currencyCode,
                favoriteTeamAlerts: favoriteTeamAlerts,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$UserPreferencesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({favoriteTeamId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (favoriteTeamId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.favoriteTeamId,
                                referencedTable:
                                    $$UserPreferencesTableReferences
                                        ._favoriteTeamIdTable(db),
                                referencedColumn:
                                    $$UserPreferencesTableReferences
                                        ._favoriteTeamIdTable(db)
                                        .teamId,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$UserPreferencesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserPreferencesTable,
      UserPreference,
      $$UserPreferencesTableFilterComposer,
      $$UserPreferencesTableOrderingComposer,
      $$UserPreferencesTableAnnotationComposer,
      $$UserPreferencesTableCreateCompanionBuilder,
      $$UserPreferencesTableUpdateCompanionBuilder,
      (UserPreference, $$UserPreferencesTableReferences),
      UserPreference,
      PrefetchHooks Function({bool favoriteTeamId})
    >;
typedef $$PlayerSeasonsTableCreateCompanionBuilder =
    PlayerSeasonsCompanion Function({
      Value<int> id,
      required String playerId,
      required String season,
      required String team,
      Value<int> gp,
      Value<int> gs,
      Value<double> mpg,
      Value<double> ppg,
      Value<double> rpg,
      Value<double> apg,
      Value<double> spg,
      Value<double> bpg,
      Value<double> topg,
      Value<double> fgPct,
      Value<double> fg3Pct,
      Value<double> ftPct,
      Value<double> per,
      Value<double> tsPct,
      Value<double> usgPct,
      Value<DateTime> createdAt,
    });
typedef $$PlayerSeasonsTableUpdateCompanionBuilder =
    PlayerSeasonsCompanion Function({
      Value<int> id,
      Value<String> playerId,
      Value<String> season,
      Value<String> team,
      Value<int> gp,
      Value<int> gs,
      Value<double> mpg,
      Value<double> ppg,
      Value<double> rpg,
      Value<double> apg,
      Value<double> spg,
      Value<double> bpg,
      Value<double> topg,
      Value<double> fgPct,
      Value<double> fg3Pct,
      Value<double> ftPct,
      Value<double> per,
      Value<double> tsPct,
      Value<double> usgPct,
      Value<DateTime> createdAt,
    });

final class $$PlayerSeasonsTableReferences
    extends BaseReferences<_$AppDatabase, $PlayerSeasonsTable, PlayerSeason> {
  $$PlayerSeasonsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PlayersTable _playerIdTable(_$AppDatabase db) =>
      db.players.createAlias(
        $_aliasNameGenerator(db.playerSeasons.playerId, db.players.playerId),
      );

  $$PlayersTableProcessedTableManager get playerId {
    final $_column = $_itemColumn<String>('player_id')!;

    final manager = $$PlayersTableTableManager(
      $_db,
      $_db.players,
    ).filter((f) => f.playerId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_playerIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PlayerSeasonsTableFilterComposer
    extends Composer<_$AppDatabase, $PlayerSeasonsTable> {
  $$PlayerSeasonsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get season => $composableBuilder(
    column: $table.season,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get team => $composableBuilder(
    column: $table.team,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get gp => $composableBuilder(
    column: $table.gp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get gs => $composableBuilder(
    column: $table.gs,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get mpg => $composableBuilder(
    column: $table.mpg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get ppg => $composableBuilder(
    column: $table.ppg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get rpg => $composableBuilder(
    column: $table.rpg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get apg => $composableBuilder(
    column: $table.apg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get spg => $composableBuilder(
    column: $table.spg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get bpg => $composableBuilder(
    column: $table.bpg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get topg => $composableBuilder(
    column: $table.topg,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fgPct => $composableBuilder(
    column: $table.fgPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get fg3Pct => $composableBuilder(
    column: $table.fg3Pct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get ftPct => $composableBuilder(
    column: $table.ftPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get per => $composableBuilder(
    column: $table.per,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get tsPct => $composableBuilder(
    column: $table.tsPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get usgPct => $composableBuilder(
    column: $table.usgPct,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$PlayersTableFilterComposer get playerId {
    final $$PlayersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableFilterComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlayerSeasonsTableOrderingComposer
    extends Composer<_$AppDatabase, $PlayerSeasonsTable> {
  $$PlayerSeasonsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get season => $composableBuilder(
    column: $table.season,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get team => $composableBuilder(
    column: $table.team,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get gp => $composableBuilder(
    column: $table.gp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get gs => $composableBuilder(
    column: $table.gs,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get mpg => $composableBuilder(
    column: $table.mpg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get ppg => $composableBuilder(
    column: $table.ppg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get rpg => $composableBuilder(
    column: $table.rpg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get apg => $composableBuilder(
    column: $table.apg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get spg => $composableBuilder(
    column: $table.spg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get bpg => $composableBuilder(
    column: $table.bpg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get topg => $composableBuilder(
    column: $table.topg,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fgPct => $composableBuilder(
    column: $table.fgPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get fg3Pct => $composableBuilder(
    column: $table.fg3Pct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get ftPct => $composableBuilder(
    column: $table.ftPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get per => $composableBuilder(
    column: $table.per,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get tsPct => $composableBuilder(
    column: $table.tsPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get usgPct => $composableBuilder(
    column: $table.usgPct,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$PlayersTableOrderingComposer get playerId {
    final $$PlayersTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableOrderingComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlayerSeasonsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PlayerSeasonsTable> {
  $$PlayerSeasonsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get season =>
      $composableBuilder(column: $table.season, builder: (column) => column);

  GeneratedColumn<String> get team =>
      $composableBuilder(column: $table.team, builder: (column) => column);

  GeneratedColumn<int> get gp =>
      $composableBuilder(column: $table.gp, builder: (column) => column);

  GeneratedColumn<int> get gs =>
      $composableBuilder(column: $table.gs, builder: (column) => column);

  GeneratedColumn<double> get mpg =>
      $composableBuilder(column: $table.mpg, builder: (column) => column);

  GeneratedColumn<double> get ppg =>
      $composableBuilder(column: $table.ppg, builder: (column) => column);

  GeneratedColumn<double> get rpg =>
      $composableBuilder(column: $table.rpg, builder: (column) => column);

  GeneratedColumn<double> get apg =>
      $composableBuilder(column: $table.apg, builder: (column) => column);

  GeneratedColumn<double> get spg =>
      $composableBuilder(column: $table.spg, builder: (column) => column);

  GeneratedColumn<double> get bpg =>
      $composableBuilder(column: $table.bpg, builder: (column) => column);

  GeneratedColumn<double> get topg =>
      $composableBuilder(column: $table.topg, builder: (column) => column);

  GeneratedColumn<double> get fgPct =>
      $composableBuilder(column: $table.fgPct, builder: (column) => column);

  GeneratedColumn<double> get fg3Pct =>
      $composableBuilder(column: $table.fg3Pct, builder: (column) => column);

  GeneratedColumn<double> get ftPct =>
      $composableBuilder(column: $table.ftPct, builder: (column) => column);

  GeneratedColumn<double> get per =>
      $composableBuilder(column: $table.per, builder: (column) => column);

  GeneratedColumn<double> get tsPct =>
      $composableBuilder(column: $table.tsPct, builder: (column) => column);

  GeneratedColumn<double> get usgPct =>
      $composableBuilder(column: $table.usgPct, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$PlayersTableAnnotationComposer get playerId {
    final $$PlayersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.playerId,
      referencedTable: $db.players,
      getReferencedColumn: (t) => t.playerId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PlayersTableAnnotationComposer(
            $db: $db,
            $table: $db.players,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PlayerSeasonsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PlayerSeasonsTable,
          PlayerSeason,
          $$PlayerSeasonsTableFilterComposer,
          $$PlayerSeasonsTableOrderingComposer,
          $$PlayerSeasonsTableAnnotationComposer,
          $$PlayerSeasonsTableCreateCompanionBuilder,
          $$PlayerSeasonsTableUpdateCompanionBuilder,
          (PlayerSeason, $$PlayerSeasonsTableReferences),
          PlayerSeason,
          PrefetchHooks Function({bool playerId})
        > {
  $$PlayerSeasonsTableTableManager(_$AppDatabase db, $PlayerSeasonsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PlayerSeasonsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PlayerSeasonsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PlayerSeasonsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> playerId = const Value.absent(),
                Value<String> season = const Value.absent(),
                Value<String> team = const Value.absent(),
                Value<int> gp = const Value.absent(),
                Value<int> gs = const Value.absent(),
                Value<double> mpg = const Value.absent(),
                Value<double> ppg = const Value.absent(),
                Value<double> rpg = const Value.absent(),
                Value<double> apg = const Value.absent(),
                Value<double> spg = const Value.absent(),
                Value<double> bpg = const Value.absent(),
                Value<double> topg = const Value.absent(),
                Value<double> fgPct = const Value.absent(),
                Value<double> fg3Pct = const Value.absent(),
                Value<double> ftPct = const Value.absent(),
                Value<double> per = const Value.absent(),
                Value<double> tsPct = const Value.absent(),
                Value<double> usgPct = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PlayerSeasonsCompanion(
                id: id,
                playerId: playerId,
                season: season,
                team: team,
                gp: gp,
                gs: gs,
                mpg: mpg,
                ppg: ppg,
                rpg: rpg,
                apg: apg,
                spg: spg,
                bpg: bpg,
                topg: topg,
                fgPct: fgPct,
                fg3Pct: fg3Pct,
                ftPct: ftPct,
                per: per,
                tsPct: tsPct,
                usgPct: usgPct,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String playerId,
                required String season,
                required String team,
                Value<int> gp = const Value.absent(),
                Value<int> gs = const Value.absent(),
                Value<double> mpg = const Value.absent(),
                Value<double> ppg = const Value.absent(),
                Value<double> rpg = const Value.absent(),
                Value<double> apg = const Value.absent(),
                Value<double> spg = const Value.absent(),
                Value<double> bpg = const Value.absent(),
                Value<double> topg = const Value.absent(),
                Value<double> fgPct = const Value.absent(),
                Value<double> fg3Pct = const Value.absent(),
                Value<double> ftPct = const Value.absent(),
                Value<double> per = const Value.absent(),
                Value<double> tsPct = const Value.absent(),
                Value<double> usgPct = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => PlayerSeasonsCompanion.insert(
                id: id,
                playerId: playerId,
                season: season,
                team: team,
                gp: gp,
                gs: gs,
                mpg: mpg,
                ppg: ppg,
                rpg: rpg,
                apg: apg,
                spg: spg,
                bpg: bpg,
                topg: topg,
                fgPct: fgPct,
                fg3Pct: fg3Pct,
                ftPct: ftPct,
                per: per,
                tsPct: tsPct,
                usgPct: usgPct,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PlayerSeasonsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({playerId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (playerId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.playerId,
                                referencedTable: $$PlayerSeasonsTableReferences
                                    ._playerIdTable(db),
                                referencedColumn: $$PlayerSeasonsTableReferences
                                    ._playerIdTable(db)
                                    .playerId,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PlayerSeasonsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PlayerSeasonsTable,
      PlayerSeason,
      $$PlayerSeasonsTableFilterComposer,
      $$PlayerSeasonsTableOrderingComposer,
      $$PlayerSeasonsTableAnnotationComposer,
      $$PlayerSeasonsTableCreateCompanionBuilder,
      $$PlayerSeasonsTableUpdateCompanionBuilder,
      (PlayerSeason, $$PlayerSeasonsTableReferences),
      PlayerSeason,
      PrefetchHooks Function({bool playerId})
    >;
typedef $$CartItemsTableCreateCompanionBuilder =
    CartItemsCompanion Function({
      Value<int> id,
      required String productId,
      required String name,
      required String category,
      required double price,
      required String image,
      Value<bool> isNew,
      Value<DateTime> addedAt,
    });
typedef $$CartItemsTableUpdateCompanionBuilder =
    CartItemsCompanion Function({
      Value<int> id,
      Value<String> productId,
      Value<String> name,
      Value<String> category,
      Value<double> price,
      Value<String> image,
      Value<bool> isNew,
      Value<DateTime> addedAt,
    });

class $$CartItemsTableFilterComposer
    extends Composer<_$AppDatabase, $CartItemsTable> {
  $$CartItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isNew => $composableBuilder(
    column: $table.isNew,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CartItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $CartItemsTable> {
  $$CartItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get productId => $composableBuilder(
    column: $table.productId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get price => $composableBuilder(
    column: $table.price,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get image => $composableBuilder(
    column: $table.image,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isNew => $composableBuilder(
    column: $table.isNew,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get addedAt => $composableBuilder(
    column: $table.addedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CartItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CartItemsTable> {
  $$CartItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get productId =>
      $composableBuilder(column: $table.productId, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<double> get price =>
      $composableBuilder(column: $table.price, builder: (column) => column);

  GeneratedColumn<String> get image =>
      $composableBuilder(column: $table.image, builder: (column) => column);

  GeneratedColumn<bool> get isNew =>
      $composableBuilder(column: $table.isNew, builder: (column) => column);

  GeneratedColumn<DateTime> get addedAt =>
      $composableBuilder(column: $table.addedAt, builder: (column) => column);
}

class $$CartItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CartItemsTable,
          CartItem,
          $$CartItemsTableFilterComposer,
          $$CartItemsTableOrderingComposer,
          $$CartItemsTableAnnotationComposer,
          $$CartItemsTableCreateCompanionBuilder,
          $$CartItemsTableUpdateCompanionBuilder,
          (CartItem, BaseReferences<_$AppDatabase, $CartItemsTable, CartItem>),
          CartItem,
          PrefetchHooks Function()
        > {
  $$CartItemsTableTableManager(_$AppDatabase db, $CartItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CartItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CartItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CartItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> productId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<double> price = const Value.absent(),
                Value<String> image = const Value.absent(),
                Value<bool> isNew = const Value.absent(),
                Value<DateTime> addedAt = const Value.absent(),
              }) => CartItemsCompanion(
                id: id,
                productId: productId,
                name: name,
                category: category,
                price: price,
                image: image,
                isNew: isNew,
                addedAt: addedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String productId,
                required String name,
                required String category,
                required double price,
                required String image,
                Value<bool> isNew = const Value.absent(),
                Value<DateTime> addedAt = const Value.absent(),
              }) => CartItemsCompanion.insert(
                id: id,
                productId: productId,
                name: name,
                category: category,
                price: price,
                image: image,
                isNew: isNew,
                addedAt: addedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CartItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CartItemsTable,
      CartItem,
      $$CartItemsTableFilterComposer,
      $$CartItemsTableOrderingComposer,
      $$CartItemsTableAnnotationComposer,
      $$CartItemsTableCreateCompanionBuilder,
      $$CartItemsTableUpdateCompanionBuilder,
      (CartItem, BaseReferences<_$AppDatabase, $CartItemsTable, CartItem>),
      CartItem,
      PrefetchHooks Function()
    >;
typedef $$StoreOrdersTableCreateCompanionBuilder =
    StoreOrdersCompanion Function({
      required String id,
      required String itemsJson,
      required double totalEur,
      required String currencyCode,
      required String deliveryAddress,
      required String paymentMethod,
      required String status,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$StoreOrdersTableUpdateCompanionBuilder =
    StoreOrdersCompanion Function({
      Value<String> id,
      Value<String> itemsJson,
      Value<double> totalEur,
      Value<String> currencyCode,
      Value<String> deliveryAddress,
      Value<String> paymentMethod,
      Value<String> status,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$StoreOrdersTableFilterComposer
    extends Composer<_$AppDatabase, $StoreOrdersTable> {
  $$StoreOrdersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get itemsJson => $composableBuilder(
    column: $table.itemsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get totalEur => $composableBuilder(
    column: $table.totalEur,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get deliveryAddress => $composableBuilder(
    column: $table.deliveryAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$StoreOrdersTableOrderingComposer
    extends Composer<_$AppDatabase, $StoreOrdersTable> {
  $$StoreOrdersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get itemsJson => $composableBuilder(
    column: $table.itemsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get totalEur => $composableBuilder(
    column: $table.totalEur,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get deliveryAddress => $composableBuilder(
    column: $table.deliveryAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$StoreOrdersTableAnnotationComposer
    extends Composer<_$AppDatabase, $StoreOrdersTable> {
  $$StoreOrdersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get itemsJson =>
      $composableBuilder(column: $table.itemsJson, builder: (column) => column);

  GeneratedColumn<double> get totalEur =>
      $composableBuilder(column: $table.totalEur, builder: (column) => column);

  GeneratedColumn<String> get currencyCode => $composableBuilder(
    column: $table.currencyCode,
    builder: (column) => column,
  );

  GeneratedColumn<String> get deliveryAddress => $composableBuilder(
    column: $table.deliveryAddress,
    builder: (column) => column,
  );

  GeneratedColumn<String> get paymentMethod => $composableBuilder(
    column: $table.paymentMethod,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$StoreOrdersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StoreOrdersTable,
          StoreOrder,
          $$StoreOrdersTableFilterComposer,
          $$StoreOrdersTableOrderingComposer,
          $$StoreOrdersTableAnnotationComposer,
          $$StoreOrdersTableCreateCompanionBuilder,
          $$StoreOrdersTableUpdateCompanionBuilder,
          (
            StoreOrder,
            BaseReferences<_$AppDatabase, $StoreOrdersTable, StoreOrder>,
          ),
          StoreOrder,
          PrefetchHooks Function()
        > {
  $$StoreOrdersTableTableManager(_$AppDatabase db, $StoreOrdersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StoreOrdersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StoreOrdersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StoreOrdersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> itemsJson = const Value.absent(),
                Value<double> totalEur = const Value.absent(),
                Value<String> currencyCode = const Value.absent(),
                Value<String> deliveryAddress = const Value.absent(),
                Value<String> paymentMethod = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => StoreOrdersCompanion(
                id: id,
                itemsJson: itemsJson,
                totalEur: totalEur,
                currencyCode: currencyCode,
                deliveryAddress: deliveryAddress,
                paymentMethod: paymentMethod,
                status: status,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String itemsJson,
                required double totalEur,
                required String currencyCode,
                required String deliveryAddress,
                required String paymentMethod,
                required String status,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => StoreOrdersCompanion.insert(
                id: id,
                itemsJson: itemsJson,
                totalEur: totalEur,
                currencyCode: currencyCode,
                deliveryAddress: deliveryAddress,
                paymentMethod: paymentMethod,
                status: status,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$StoreOrdersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StoreOrdersTable,
      StoreOrder,
      $$StoreOrdersTableFilterComposer,
      $$StoreOrdersTableOrderingComposer,
      $$StoreOrdersTableAnnotationComposer,
      $$StoreOrdersTableCreateCompanionBuilder,
      $$StoreOrdersTableUpdateCompanionBuilder,
      (
        StoreOrder,
        BaseReferences<_$AppDatabase, $StoreOrdersTable, StoreOrder>,
      ),
      StoreOrder,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$NbaTeamsTableTableManager get nbaTeams =>
      $$NbaTeamsTableTableManager(_db, _db.nbaTeams);
  $$PlayersTableTableManager get players =>
      $$PlayersTableTableManager(_db, _db.players);
  $$CachedGamesTableTableManager get cachedGames =>
      $$CachedGamesTableTableManager(_db, _db.cachedGames);
  $$UserPreferencesTableTableManager get userPreferences =>
      $$UserPreferencesTableTableManager(_db, _db.userPreferences);
  $$PlayerSeasonsTableTableManager get playerSeasons =>
      $$PlayerSeasonsTableTableManager(_db, _db.playerSeasons);
  $$CartItemsTableTableManager get cartItems =>
      $$CartItemsTableTableManager(_db, _db.cartItems);
  $$StoreOrdersTableTableManager get storeOrders =>
      $$StoreOrdersTableTableManager(_db, _db.storeOrders);
}

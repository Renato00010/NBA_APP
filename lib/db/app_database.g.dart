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
    position,
    ppg,
    rpg,
    apg,
    spg,
    bpg,
    photoWebpPath,
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
    if (data.containsKey('position')) {
      context.handle(
        _positionMeta,
        position.isAcceptableOrUnknown(data['position']!, _positionMeta),
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
    if (data.containsKey('photo_webp_path')) {
      context.handle(
        _photoWebpPathMeta,
        photoWebpPath.isAcceptableOrUnknown(
          data['photo_webp_path']!,
          _photoWebpPathMeta,
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
      position: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}position'],
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
      photoWebpPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_webp_path'],
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
  final String? position;
  final double ppg;
  final double rpg;
  final double apg;
  final double spg;
  final double bpg;
  final String? photoWebpPath;
  final DateTime cachedAt;
  const Player({
    required this.playerId,
    required this.teamId,
    required this.fullName,
    this.position,
    required this.ppg,
    required this.rpg,
    required this.apg,
    required this.spg,
    required this.bpg,
    this.photoWebpPath,
    required this.cachedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['player_id'] = Variable<String>(playerId);
    map['team_id'] = Variable<String>(teamId);
    map['full_name'] = Variable<String>(fullName);
    if (!nullToAbsent || position != null) {
      map['position'] = Variable<String>(position);
    }
    map['ppg'] = Variable<double>(ppg);
    map['rpg'] = Variable<double>(rpg);
    map['apg'] = Variable<double>(apg);
    map['spg'] = Variable<double>(spg);
    map['bpg'] = Variable<double>(bpg);
    if (!nullToAbsent || photoWebpPath != null) {
      map['photo_webp_path'] = Variable<String>(photoWebpPath);
    }
    map['cached_at'] = Variable<DateTime>(cachedAt);
    return map;
  }

  PlayersCompanion toCompanion(bool nullToAbsent) {
    return PlayersCompanion(
      playerId: Value(playerId),
      teamId: Value(teamId),
      fullName: Value(fullName),
      position: position == null && nullToAbsent
          ? const Value.absent()
          : Value(position),
      ppg: Value(ppg),
      rpg: Value(rpg),
      apg: Value(apg),
      spg: Value(spg),
      bpg: Value(bpg),
      photoWebpPath: photoWebpPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoWebpPath),
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
      position: serializer.fromJson<String?>(json['position']),
      ppg: serializer.fromJson<double>(json['ppg']),
      rpg: serializer.fromJson<double>(json['rpg']),
      apg: serializer.fromJson<double>(json['apg']),
      spg: serializer.fromJson<double>(json['spg']),
      bpg: serializer.fromJson<double>(json['bpg']),
      photoWebpPath: serializer.fromJson<String?>(json['photoWebpPath']),
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
      'position': serializer.toJson<String?>(position),
      'ppg': serializer.toJson<double>(ppg),
      'rpg': serializer.toJson<double>(rpg),
      'apg': serializer.toJson<double>(apg),
      'spg': serializer.toJson<double>(spg),
      'bpg': serializer.toJson<double>(bpg),
      'photoWebpPath': serializer.toJson<String?>(photoWebpPath),
      'cachedAt': serializer.toJson<DateTime>(cachedAt),
    };
  }

  Player copyWith({
    String? playerId,
    String? teamId,
    String? fullName,
    Value<String?> position = const Value.absent(),
    double? ppg,
    double? rpg,
    double? apg,
    double? spg,
    double? bpg,
    Value<String?> photoWebpPath = const Value.absent(),
    DateTime? cachedAt,
  }) => Player(
    playerId: playerId ?? this.playerId,
    teamId: teamId ?? this.teamId,
    fullName: fullName ?? this.fullName,
    position: position.present ? position.value : this.position,
    ppg: ppg ?? this.ppg,
    rpg: rpg ?? this.rpg,
    apg: apg ?? this.apg,
    spg: spg ?? this.spg,
    bpg: bpg ?? this.bpg,
    photoWebpPath: photoWebpPath.present
        ? photoWebpPath.value
        : this.photoWebpPath,
    cachedAt: cachedAt ?? this.cachedAt,
  );
  Player copyWithCompanion(PlayersCompanion data) {
    return Player(
      playerId: data.playerId.present ? data.playerId.value : this.playerId,
      teamId: data.teamId.present ? data.teamId.value : this.teamId,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      position: data.position.present ? data.position.value : this.position,
      ppg: data.ppg.present ? data.ppg.value : this.ppg,
      rpg: data.rpg.present ? data.rpg.value : this.rpg,
      apg: data.apg.present ? data.apg.value : this.apg,
      spg: data.spg.present ? data.spg.value : this.spg,
      bpg: data.bpg.present ? data.bpg.value : this.bpg,
      photoWebpPath: data.photoWebpPath.present
          ? data.photoWebpPath.value
          : this.photoWebpPath,
      cachedAt: data.cachedAt.present ? data.cachedAt.value : this.cachedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Player(')
          ..write('playerId: $playerId, ')
          ..write('teamId: $teamId, ')
          ..write('fullName: $fullName, ')
          ..write('position: $position, ')
          ..write('ppg: $ppg, ')
          ..write('rpg: $rpg, ')
          ..write('apg: $apg, ')
          ..write('spg: $spg, ')
          ..write('bpg: $bpg, ')
          ..write('photoWebpPath: $photoWebpPath, ')
          ..write('cachedAt: $cachedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    playerId,
    teamId,
    fullName,
    position,
    ppg,
    rpg,
    apg,
    spg,
    bpg,
    photoWebpPath,
    cachedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Player &&
          other.playerId == this.playerId &&
          other.teamId == this.teamId &&
          other.fullName == this.fullName &&
          other.position == this.position &&
          other.ppg == this.ppg &&
          other.rpg == this.rpg &&
          other.apg == this.apg &&
          other.spg == this.spg &&
          other.bpg == this.bpg &&
          other.photoWebpPath == this.photoWebpPath &&
          other.cachedAt == this.cachedAt);
}

class PlayersCompanion extends UpdateCompanion<Player> {
  final Value<String> playerId;
  final Value<String> teamId;
  final Value<String> fullName;
  final Value<String?> position;
  final Value<double> ppg;
  final Value<double> rpg;
  final Value<double> apg;
  final Value<double> spg;
  final Value<double> bpg;
  final Value<String?> photoWebpPath;
  final Value<DateTime> cachedAt;
  final Value<int> rowid;
  const PlayersCompanion({
    this.playerId = const Value.absent(),
    this.teamId = const Value.absent(),
    this.fullName = const Value.absent(),
    this.position = const Value.absent(),
    this.ppg = const Value.absent(),
    this.rpg = const Value.absent(),
    this.apg = const Value.absent(),
    this.spg = const Value.absent(),
    this.bpg = const Value.absent(),
    this.photoWebpPath = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PlayersCompanion.insert({
    required String playerId,
    required String teamId,
    required String fullName,
    this.position = const Value.absent(),
    this.ppg = const Value.absent(),
    this.rpg = const Value.absent(),
    this.apg = const Value.absent(),
    this.spg = const Value.absent(),
    this.bpg = const Value.absent(),
    this.photoWebpPath = const Value.absent(),
    this.cachedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : playerId = Value(playerId),
       teamId = Value(teamId),
       fullName = Value(fullName);
  static Insertable<Player> custom({
    Expression<String>? playerId,
    Expression<String>? teamId,
    Expression<String>? fullName,
    Expression<String>? position,
    Expression<double>? ppg,
    Expression<double>? rpg,
    Expression<double>? apg,
    Expression<double>? spg,
    Expression<double>? bpg,
    Expression<String>? photoWebpPath,
    Expression<DateTime>? cachedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (playerId != null) 'player_id': playerId,
      if (teamId != null) 'team_id': teamId,
      if (fullName != null) 'full_name': fullName,
      if (position != null) 'position': position,
      if (ppg != null) 'ppg': ppg,
      if (rpg != null) 'rpg': rpg,
      if (apg != null) 'apg': apg,
      if (spg != null) 'spg': spg,
      if (bpg != null) 'bpg': bpg,
      if (photoWebpPath != null) 'photo_webp_path': photoWebpPath,
      if (cachedAt != null) 'cached_at': cachedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PlayersCompanion copyWith({
    Value<String>? playerId,
    Value<String>? teamId,
    Value<String>? fullName,
    Value<String?>? position,
    Value<double>? ppg,
    Value<double>? rpg,
    Value<double>? apg,
    Value<double>? spg,
    Value<double>? bpg,
    Value<String?>? photoWebpPath,
    Value<DateTime>? cachedAt,
    Value<int>? rowid,
  }) {
    return PlayersCompanion(
      playerId: playerId ?? this.playerId,
      teamId: teamId ?? this.teamId,
      fullName: fullName ?? this.fullName,
      position: position ?? this.position,
      ppg: ppg ?? this.ppg,
      rpg: rpg ?? this.rpg,
      apg: apg ?? this.apg,
      spg: spg ?? this.spg,
      bpg: bpg ?? this.bpg,
      photoWebpPath: photoWebpPath ?? this.photoWebpPath,
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
    if (position.present) {
      map['position'] = Variable<String>(position.value);
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
    if (photoWebpPath.present) {
      map['photo_webp_path'] = Variable<String>(photoWebpPath.value);
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
          ..write('position: $position, ')
          ..write('ppg: $ppg, ')
          ..write('rpg: $rpg, ')
          ..write('apg: $apg, ')
          ..write('spg: $spg, ')
          ..write('bpg: $bpg, ')
          ..write('photoWebpPath: $photoWebpPath, ')
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
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $ViewedHistoryTable extends ViewedHistory
    with TableInfo<$ViewedHistoryTable, ViewedHistoryData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ViewedHistoryTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _contentTypeMeta = const VerificationMeta(
    'contentType',
  );
  @override
  late final GeneratedColumn<String> contentType = GeneratedColumn<String>(
    'content_type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentIdMeta = const VerificationMeta(
    'contentId',
  );
  @override
  late final GeneratedColumn<String> contentId = GeneratedColumn<String>(
    'content_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _viewedAtMeta = const VerificationMeta(
    'viewedAt',
  );
  @override
  late final GeneratedColumn<DateTime> viewedAt = GeneratedColumn<DateTime>(
    'viewed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [id, contentType, contentId, viewedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'viewed_history';
  @override
  VerificationContext validateIntegrity(
    Insertable<ViewedHistoryData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('content_type')) {
      context.handle(
        _contentTypeMeta,
        contentType.isAcceptableOrUnknown(
          data['content_type']!,
          _contentTypeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contentTypeMeta);
    }
    if (data.containsKey('content_id')) {
      context.handle(
        _contentIdMeta,
        contentId.isAcceptableOrUnknown(data['content_id']!, _contentIdMeta),
      );
    } else if (isInserting) {
      context.missing(_contentIdMeta);
    }
    if (data.containsKey('viewed_at')) {
      context.handle(
        _viewedAtMeta,
        viewedAt.isAcceptableOrUnknown(data['viewed_at']!, _viewedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ViewedHistoryData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ViewedHistoryData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      contentType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_type'],
      )!,
      contentId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content_id'],
      )!,
      viewedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}viewed_at'],
      )!,
    );
  }

  @override
  $ViewedHistoryTable createAlias(String alias) {
    return $ViewedHistoryTable(attachedDatabase, alias);
  }
}

class ViewedHistoryData extends DataClass
    implements Insertable<ViewedHistoryData> {
  final int id;
  final String contentType;
  final String contentId;
  final DateTime viewedAt;
  const ViewedHistoryData({
    required this.id,
    required this.contentType,
    required this.contentId,
    required this.viewedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['content_type'] = Variable<String>(contentType);
    map['content_id'] = Variable<String>(contentId);
    map['viewed_at'] = Variable<DateTime>(viewedAt);
    return map;
  }

  ViewedHistoryCompanion toCompanion(bool nullToAbsent) {
    return ViewedHistoryCompanion(
      id: Value(id),
      contentType: Value(contentType),
      contentId: Value(contentId),
      viewedAt: Value(viewedAt),
    );
  }

  factory ViewedHistoryData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ViewedHistoryData(
      id: serializer.fromJson<int>(json['id']),
      contentType: serializer.fromJson<String>(json['contentType']),
      contentId: serializer.fromJson<String>(json['contentId']),
      viewedAt: serializer.fromJson<DateTime>(json['viewedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'contentType': serializer.toJson<String>(contentType),
      'contentId': serializer.toJson<String>(contentId),
      'viewedAt': serializer.toJson<DateTime>(viewedAt),
    };
  }

  ViewedHistoryData copyWith({
    int? id,
    String? contentType,
    String? contentId,
    DateTime? viewedAt,
  }) => ViewedHistoryData(
    id: id ?? this.id,
    contentType: contentType ?? this.contentType,
    contentId: contentId ?? this.contentId,
    viewedAt: viewedAt ?? this.viewedAt,
  );
  ViewedHistoryData copyWithCompanion(ViewedHistoryCompanion data) {
    return ViewedHistoryData(
      id: data.id.present ? data.id.value : this.id,
      contentType: data.contentType.present
          ? data.contentType.value
          : this.contentType,
      contentId: data.contentId.present ? data.contentId.value : this.contentId,
      viewedAt: data.viewedAt.present ? data.viewedAt.value : this.viewedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ViewedHistoryData(')
          ..write('id: $id, ')
          ..write('contentType: $contentType, ')
          ..write('contentId: $contentId, ')
          ..write('viewedAt: $viewedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, contentType, contentId, viewedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ViewedHistoryData &&
          other.id == this.id &&
          other.contentType == this.contentType &&
          other.contentId == this.contentId &&
          other.viewedAt == this.viewedAt);
}

class ViewedHistoryCompanion extends UpdateCompanion<ViewedHistoryData> {
  final Value<int> id;
  final Value<String> contentType;
  final Value<String> contentId;
  final Value<DateTime> viewedAt;
  const ViewedHistoryCompanion({
    this.id = const Value.absent(),
    this.contentType = const Value.absent(),
    this.contentId = const Value.absent(),
    this.viewedAt = const Value.absent(),
  });
  ViewedHistoryCompanion.insert({
    this.id = const Value.absent(),
    required String contentType,
    required String contentId,
    this.viewedAt = const Value.absent(),
  }) : contentType = Value(contentType),
       contentId = Value(contentId);
  static Insertable<ViewedHistoryData> custom({
    Expression<int>? id,
    Expression<String>? contentType,
    Expression<String>? contentId,
    Expression<DateTime>? viewedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (contentType != null) 'content_type': contentType,
      if (contentId != null) 'content_id': contentId,
      if (viewedAt != null) 'viewed_at': viewedAt,
    });
  }

  ViewedHistoryCompanion copyWith({
    Value<int>? id,
    Value<String>? contentType,
    Value<String>? contentId,
    Value<DateTime>? viewedAt,
  }) {
    return ViewedHistoryCompanion(
      id: id ?? this.id,
      contentType: contentType ?? this.contentType,
      contentId: contentId ?? this.contentId,
      viewedAt: viewedAt ?? this.viewedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (contentType.present) {
      map['content_type'] = Variable<String>(contentType.value);
    }
    if (contentId.present) {
      map['content_id'] = Variable<String>(contentId.value);
    }
    if (viewedAt.present) {
      map['viewed_at'] = Variable<DateTime>(viewedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ViewedHistoryCompanion(')
          ..write('id: $id, ')
          ..write('contentType: $contentType, ')
          ..write('contentId: $contentId, ')
          ..write('viewedAt: $viewedAt')
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
  late final $ViewedHistoryTable viewedHistory = $ViewedHistoryTable(this);
  late final TeamsDao teamsDao = TeamsDao(this as AppDatabase);
  late final PlayersDao playersDao = PlayersDao(this as AppDatabase);
  late final GamesDao gamesDao = GamesDao(this as AppDatabase);
  late final PreferencesDao preferencesDao = PreferencesDao(
    this as AppDatabase,
  );
  late final HistoryDao historyDao = HistoryDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    nbaTeams,
    players,
    cachedGames,
    userPreferences,
    viewedHistory,
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
      Value<String?> position,
      Value<double> ppg,
      Value<double> rpg,
      Value<double> apg,
      Value<double> spg,
      Value<double> bpg,
      Value<String?> photoWebpPath,
      Value<DateTime> cachedAt,
      Value<int> rowid,
    });
typedef $$PlayersTableUpdateCompanionBuilder =
    PlayersCompanion Function({
      Value<String> playerId,
      Value<String> teamId,
      Value<String> fullName,
      Value<String?> position,
      Value<double> ppg,
      Value<double> rpg,
      Value<double> apg,
      Value<double> spg,
      Value<double> bpg,
      Value<String?> photoWebpPath,
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

  ColumnFilters<String> get position => $composableBuilder(
    column: $table.position,
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

  ColumnFilters<String> get photoWebpPath => $composableBuilder(
    column: $table.photoWebpPath,
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

  ColumnOrderings<String> get position => $composableBuilder(
    column: $table.position,
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

  ColumnOrderings<String> get photoWebpPath => $composableBuilder(
    column: $table.photoWebpPath,
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

  GeneratedColumn<String> get position =>
      $composableBuilder(column: $table.position, builder: (column) => column);

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

  GeneratedColumn<String> get photoWebpPath => $composableBuilder(
    column: $table.photoWebpPath,
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
          PrefetchHooks Function({bool teamId})
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
                Value<String?> position = const Value.absent(),
                Value<double> ppg = const Value.absent(),
                Value<double> rpg = const Value.absent(),
                Value<double> apg = const Value.absent(),
                Value<double> spg = const Value.absent(),
                Value<double> bpg = const Value.absent(),
                Value<String?> photoWebpPath = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlayersCompanion(
                playerId: playerId,
                teamId: teamId,
                fullName: fullName,
                position: position,
                ppg: ppg,
                rpg: rpg,
                apg: apg,
                spg: spg,
                bpg: bpg,
                photoWebpPath: photoWebpPath,
                cachedAt: cachedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String playerId,
                required String teamId,
                required String fullName,
                Value<String?> position = const Value.absent(),
                Value<double> ppg = const Value.absent(),
                Value<double> rpg = const Value.absent(),
                Value<double> apg = const Value.absent(),
                Value<double> spg = const Value.absent(),
                Value<double> bpg = const Value.absent(),
                Value<String?> photoWebpPath = const Value.absent(),
                Value<DateTime> cachedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PlayersCompanion.insert(
                playerId: playerId,
                teamId: teamId,
                fullName: fullName,
                position: position,
                ppg: ppg,
                rpg: rpg,
                apg: apg,
                spg: spg,
                bpg: bpg,
                photoWebpPath: photoWebpPath,
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
          prefetchHooksCallback: ({teamId = false}) {
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
                return [];
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
      PrefetchHooks Function({bool teamId})
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
typedef $$ViewedHistoryTableCreateCompanionBuilder =
    ViewedHistoryCompanion Function({
      Value<int> id,
      required String contentType,
      required String contentId,
      Value<DateTime> viewedAt,
    });
typedef $$ViewedHistoryTableUpdateCompanionBuilder =
    ViewedHistoryCompanion Function({
      Value<int> id,
      Value<String> contentType,
      Value<String> contentId,
      Value<DateTime> viewedAt,
    });

class $$ViewedHistoryTableFilterComposer
    extends Composer<_$AppDatabase, $ViewedHistoryTable> {
  $$ViewedHistoryTableFilterComposer({
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

  ColumnFilters<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get contentId => $composableBuilder(
    column: $table.contentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get viewedAt => $composableBuilder(
    column: $table.viewedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ViewedHistoryTableOrderingComposer
    extends Composer<_$AppDatabase, $ViewedHistoryTable> {
  $$ViewedHistoryTableOrderingComposer({
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

  ColumnOrderings<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contentId => $composableBuilder(
    column: $table.contentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get viewedAt => $composableBuilder(
    column: $table.viewedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ViewedHistoryTableAnnotationComposer
    extends Composer<_$AppDatabase, $ViewedHistoryTable> {
  $$ViewedHistoryTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get contentType => $composableBuilder(
    column: $table.contentType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get contentId =>
      $composableBuilder(column: $table.contentId, builder: (column) => column);

  GeneratedColumn<DateTime> get viewedAt =>
      $composableBuilder(column: $table.viewedAt, builder: (column) => column);
}

class $$ViewedHistoryTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ViewedHistoryTable,
          ViewedHistoryData,
          $$ViewedHistoryTableFilterComposer,
          $$ViewedHistoryTableOrderingComposer,
          $$ViewedHistoryTableAnnotationComposer,
          $$ViewedHistoryTableCreateCompanionBuilder,
          $$ViewedHistoryTableUpdateCompanionBuilder,
          (
            ViewedHistoryData,
            BaseReferences<
              _$AppDatabase,
              $ViewedHistoryTable,
              ViewedHistoryData
            >,
          ),
          ViewedHistoryData,
          PrefetchHooks Function()
        > {
  $$ViewedHistoryTableTableManager(_$AppDatabase db, $ViewedHistoryTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ViewedHistoryTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ViewedHistoryTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ViewedHistoryTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> contentType = const Value.absent(),
                Value<String> contentId = const Value.absent(),
                Value<DateTime> viewedAt = const Value.absent(),
              }) => ViewedHistoryCompanion(
                id: id,
                contentType: contentType,
                contentId: contentId,
                viewedAt: viewedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String contentType,
                required String contentId,
                Value<DateTime> viewedAt = const Value.absent(),
              }) => ViewedHistoryCompanion.insert(
                id: id,
                contentType: contentType,
                contentId: contentId,
                viewedAt: viewedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ViewedHistoryTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ViewedHistoryTable,
      ViewedHistoryData,
      $$ViewedHistoryTableFilterComposer,
      $$ViewedHistoryTableOrderingComposer,
      $$ViewedHistoryTableAnnotationComposer,
      $$ViewedHistoryTableCreateCompanionBuilder,
      $$ViewedHistoryTableUpdateCompanionBuilder,
      (
        ViewedHistoryData,
        BaseReferences<_$AppDatabase, $ViewedHistoryTable, ViewedHistoryData>,
      ),
      ViewedHistoryData,
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
  $$ViewedHistoryTableTableManager get viewedHistory =>
      $$ViewedHistoryTableTableManager(_db, _db.viewedHistory);
}

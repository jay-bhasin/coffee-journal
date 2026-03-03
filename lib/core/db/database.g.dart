// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CoffeesTable extends Coffees with TableInfo<$CoffeesTable, Coffee> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CoffeesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
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
  static const VerificationMeta _roasterMeta = const VerificationMeta(
    'roaster',
  );
  @override
  late final GeneratedColumn<String> roaster = GeneratedColumn<String>(
    'roaster',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _regionMeta = const VerificationMeta('region');
  @override
  late final GeneratedColumn<String> region = GeneratedColumn<String>(
    'region',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _farmMeta = const VerificationMeta('farm');
  @override
  late final GeneratedColumn<String> farm = GeneratedColumn<String>(
    'farm',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _producerMeta = const VerificationMeta(
    'producer',
  );
  @override
  late final GeneratedColumn<String> producer = GeneratedColumn<String>(
    'producer',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _varietalMeta = const VerificationMeta(
    'varietal',
  );
  @override
  late final GeneratedColumn<String> varietal = GeneratedColumn<String>(
    'varietal',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _processMeta = const VerificationMeta(
    'process',
  );
  @override
  late final GeneratedColumn<String> process = GeneratedColumn<String>(
    'process',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _altitudeMMeta = const VerificationMeta(
    'altitudeM',
  );
  @override
  late final GeneratedColumn<String> altitudeM = GeneratedColumn<String>(
    'altitude_m',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _roastDateMeta = const VerificationMeta(
    'roastDate',
  );
  @override
  late final GeneratedColumn<DateTime> roastDate = GeneratedColumn<DateTime>(
    'roast_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _tastingNotesMeta = const VerificationMeta(
    'tastingNotes',
  );
  @override
  late final GeneratedColumn<String> tastingNotes = GeneratedColumn<String>(
    'tasting_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isArchivedMeta = const VerificationMeta(
    'isArchived',
  );
  @override
  late final GeneratedColumn<bool> isArchived = GeneratedColumn<bool>(
    'is_archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _searchTextMeta = const VerificationMeta(
    'searchText',
  );
  @override
  late final GeneratedColumn<String> searchText = GeneratedColumn<String>(
    'search_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
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
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    roaster,
    country,
    region,
    farm,
    producer,
    varietal,
    process,
    altitudeM,
    roastDate,
    tastingNotes,
    isArchived,
    searchText,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'coffees';
  @override
  VerificationContext validateIntegrity(
    Insertable<Coffee> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('roaster')) {
      context.handle(
        _roasterMeta,
        roaster.isAcceptableOrUnknown(data['roaster']!, _roasterMeta),
      );
    } else if (isInserting) {
      context.missing(_roasterMeta);
    }
    if (data.containsKey('country')) {
      context.handle(
        _countryMeta,
        country.isAcceptableOrUnknown(data['country']!, _countryMeta),
      );
    }
    if (data.containsKey('region')) {
      context.handle(
        _regionMeta,
        region.isAcceptableOrUnknown(data['region']!, _regionMeta),
      );
    }
    if (data.containsKey('farm')) {
      context.handle(
        _farmMeta,
        farm.isAcceptableOrUnknown(data['farm']!, _farmMeta),
      );
    }
    if (data.containsKey('producer')) {
      context.handle(
        _producerMeta,
        producer.isAcceptableOrUnknown(data['producer']!, _producerMeta),
      );
    }
    if (data.containsKey('varietal')) {
      context.handle(
        _varietalMeta,
        varietal.isAcceptableOrUnknown(data['varietal']!, _varietalMeta),
      );
    }
    if (data.containsKey('process')) {
      context.handle(
        _processMeta,
        process.isAcceptableOrUnknown(data['process']!, _processMeta),
      );
    }
    if (data.containsKey('altitude_m')) {
      context.handle(
        _altitudeMMeta,
        altitudeM.isAcceptableOrUnknown(data['altitude_m']!, _altitudeMMeta),
      );
    }
    if (data.containsKey('roast_date')) {
      context.handle(
        _roastDateMeta,
        roastDate.isAcceptableOrUnknown(data['roast_date']!, _roastDateMeta),
      );
    }
    if (data.containsKey('tasting_notes')) {
      context.handle(
        _tastingNotesMeta,
        tastingNotes.isAcceptableOrUnknown(
          data['tasting_notes']!,
          _tastingNotesMeta,
        ),
      );
    }
    if (data.containsKey('is_archived')) {
      context.handle(
        _isArchivedMeta,
        isArchived.isAcceptableOrUnknown(data['is_archived']!, _isArchivedMeta),
      );
    }
    if (data.containsKey('search_text')) {
      context.handle(
        _searchTextMeta,
        searchText.isAcceptableOrUnknown(data['search_text']!, _searchTextMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Coffee map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Coffee(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      roaster: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}roaster'],
      )!,
      country: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country'],
      ),
      region: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}region'],
      ),
      farm: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}farm'],
      ),
      producer: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}producer'],
      ),
      varietal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}varietal'],
      ),
      process: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}process'],
      ),
      altitudeM: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}altitude_m'],
      ),
      roastDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}roast_date'],
      ),
      tastingNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tasting_notes'],
      ),
      isArchived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_archived'],
      )!,
      searchText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}search_text'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $CoffeesTable createAlias(String alias) {
    return $CoffeesTable(attachedDatabase, alias);
  }
}

class Coffee extends DataClass implements Insertable<Coffee> {
  final String id;
  final String name;
  final String roaster;
  final String? country;
  final String? region;
  final String? farm;
  final String? producer;
  final String? varietal;
  final String? process;
  final String? altitudeM;
  final DateTime? roastDate;
  final String? tastingNotes;
  final bool isArchived;
  final String searchText;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Coffee({
    required this.id,
    required this.name,
    required this.roaster,
    this.country,
    this.region,
    this.farm,
    this.producer,
    this.varietal,
    this.process,
    this.altitudeM,
    this.roastDate,
    this.tastingNotes,
    required this.isArchived,
    required this.searchText,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['roaster'] = Variable<String>(roaster);
    if (!nullToAbsent || country != null) {
      map['country'] = Variable<String>(country);
    }
    if (!nullToAbsent || region != null) {
      map['region'] = Variable<String>(region);
    }
    if (!nullToAbsent || farm != null) {
      map['farm'] = Variable<String>(farm);
    }
    if (!nullToAbsent || producer != null) {
      map['producer'] = Variable<String>(producer);
    }
    if (!nullToAbsent || varietal != null) {
      map['varietal'] = Variable<String>(varietal);
    }
    if (!nullToAbsent || process != null) {
      map['process'] = Variable<String>(process);
    }
    if (!nullToAbsent || altitudeM != null) {
      map['altitude_m'] = Variable<String>(altitudeM);
    }
    if (!nullToAbsent || roastDate != null) {
      map['roast_date'] = Variable<DateTime>(roastDate);
    }
    if (!nullToAbsent || tastingNotes != null) {
      map['tasting_notes'] = Variable<String>(tastingNotes);
    }
    map['is_archived'] = Variable<bool>(isArchived);
    map['search_text'] = Variable<String>(searchText);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CoffeesCompanion toCompanion(bool nullToAbsent) {
    return CoffeesCompanion(
      id: Value(id),
      name: Value(name),
      roaster: Value(roaster),
      country: country == null && nullToAbsent
          ? const Value.absent()
          : Value(country),
      region: region == null && nullToAbsent
          ? const Value.absent()
          : Value(region),
      farm: farm == null && nullToAbsent ? const Value.absent() : Value(farm),
      producer: producer == null && nullToAbsent
          ? const Value.absent()
          : Value(producer),
      varietal: varietal == null && nullToAbsent
          ? const Value.absent()
          : Value(varietal),
      process: process == null && nullToAbsent
          ? const Value.absent()
          : Value(process),
      altitudeM: altitudeM == null && nullToAbsent
          ? const Value.absent()
          : Value(altitudeM),
      roastDate: roastDate == null && nullToAbsent
          ? const Value.absent()
          : Value(roastDate),
      tastingNotes: tastingNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(tastingNotes),
      isArchived: Value(isArchived),
      searchText: Value(searchText),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Coffee.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Coffee(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      roaster: serializer.fromJson<String>(json['roaster']),
      country: serializer.fromJson<String?>(json['country']),
      region: serializer.fromJson<String?>(json['region']),
      farm: serializer.fromJson<String?>(json['farm']),
      producer: serializer.fromJson<String?>(json['producer']),
      varietal: serializer.fromJson<String?>(json['varietal']),
      process: serializer.fromJson<String?>(json['process']),
      altitudeM: serializer.fromJson<String?>(json['altitudeM']),
      roastDate: serializer.fromJson<DateTime?>(json['roastDate']),
      tastingNotes: serializer.fromJson<String?>(json['tastingNotes']),
      isArchived: serializer.fromJson<bool>(json['isArchived']),
      searchText: serializer.fromJson<String>(json['searchText']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'roaster': serializer.toJson<String>(roaster),
      'country': serializer.toJson<String?>(country),
      'region': serializer.toJson<String?>(region),
      'farm': serializer.toJson<String?>(farm),
      'producer': serializer.toJson<String?>(producer),
      'varietal': serializer.toJson<String?>(varietal),
      'process': serializer.toJson<String?>(process),
      'altitudeM': serializer.toJson<String?>(altitudeM),
      'roastDate': serializer.toJson<DateTime?>(roastDate),
      'tastingNotes': serializer.toJson<String?>(tastingNotes),
      'isArchived': serializer.toJson<bool>(isArchived),
      'searchText': serializer.toJson<String>(searchText),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Coffee copyWith({
    String? id,
    String? name,
    String? roaster,
    Value<String?> country = const Value.absent(),
    Value<String?> region = const Value.absent(),
    Value<String?> farm = const Value.absent(),
    Value<String?> producer = const Value.absent(),
    Value<String?> varietal = const Value.absent(),
    Value<String?> process = const Value.absent(),
    Value<String?> altitudeM = const Value.absent(),
    Value<DateTime?> roastDate = const Value.absent(),
    Value<String?> tastingNotes = const Value.absent(),
    bool? isArchived,
    String? searchText,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Coffee(
    id: id ?? this.id,
    name: name ?? this.name,
    roaster: roaster ?? this.roaster,
    country: country.present ? country.value : this.country,
    region: region.present ? region.value : this.region,
    farm: farm.present ? farm.value : this.farm,
    producer: producer.present ? producer.value : this.producer,
    varietal: varietal.present ? varietal.value : this.varietal,
    process: process.present ? process.value : this.process,
    altitudeM: altitudeM.present ? altitudeM.value : this.altitudeM,
    roastDate: roastDate.present ? roastDate.value : this.roastDate,
    tastingNotes: tastingNotes.present ? tastingNotes.value : this.tastingNotes,
    isArchived: isArchived ?? this.isArchived,
    searchText: searchText ?? this.searchText,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Coffee copyWithCompanion(CoffeesCompanion data) {
    return Coffee(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      roaster: data.roaster.present ? data.roaster.value : this.roaster,
      country: data.country.present ? data.country.value : this.country,
      region: data.region.present ? data.region.value : this.region,
      farm: data.farm.present ? data.farm.value : this.farm,
      producer: data.producer.present ? data.producer.value : this.producer,
      varietal: data.varietal.present ? data.varietal.value : this.varietal,
      process: data.process.present ? data.process.value : this.process,
      altitudeM: data.altitudeM.present ? data.altitudeM.value : this.altitudeM,
      roastDate: data.roastDate.present ? data.roastDate.value : this.roastDate,
      tastingNotes: data.tastingNotes.present
          ? data.tastingNotes.value
          : this.tastingNotes,
      isArchived: data.isArchived.present
          ? data.isArchived.value
          : this.isArchived,
      searchText: data.searchText.present
          ? data.searchText.value
          : this.searchText,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Coffee(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('roaster: $roaster, ')
          ..write('country: $country, ')
          ..write('region: $region, ')
          ..write('farm: $farm, ')
          ..write('producer: $producer, ')
          ..write('varietal: $varietal, ')
          ..write('process: $process, ')
          ..write('altitudeM: $altitudeM, ')
          ..write('roastDate: $roastDate, ')
          ..write('tastingNotes: $tastingNotes, ')
          ..write('isArchived: $isArchived, ')
          ..write('searchText: $searchText, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    roaster,
    country,
    region,
    farm,
    producer,
    varietal,
    process,
    altitudeM,
    roastDate,
    tastingNotes,
    isArchived,
    searchText,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Coffee &&
          other.id == this.id &&
          other.name == this.name &&
          other.roaster == this.roaster &&
          other.country == this.country &&
          other.region == this.region &&
          other.farm == this.farm &&
          other.producer == this.producer &&
          other.varietal == this.varietal &&
          other.process == this.process &&
          other.altitudeM == this.altitudeM &&
          other.roastDate == this.roastDate &&
          other.tastingNotes == this.tastingNotes &&
          other.isArchived == this.isArchived &&
          other.searchText == this.searchText &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CoffeesCompanion extends UpdateCompanion<Coffee> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> roaster;
  final Value<String?> country;
  final Value<String?> region;
  final Value<String?> farm;
  final Value<String?> producer;
  final Value<String?> varietal;
  final Value<String?> process;
  final Value<String?> altitudeM;
  final Value<DateTime?> roastDate;
  final Value<String?> tastingNotes;
  final Value<bool> isArchived;
  final Value<String> searchText;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const CoffeesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.roaster = const Value.absent(),
    this.country = const Value.absent(),
    this.region = const Value.absent(),
    this.farm = const Value.absent(),
    this.producer = const Value.absent(),
    this.varietal = const Value.absent(),
    this.process = const Value.absent(),
    this.altitudeM = const Value.absent(),
    this.roastDate = const Value.absent(),
    this.tastingNotes = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.searchText = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CoffeesCompanion.insert({
    required String id,
    required String name,
    required String roaster,
    this.country = const Value.absent(),
    this.region = const Value.absent(),
    this.farm = const Value.absent(),
    this.producer = const Value.absent(),
    this.varietal = const Value.absent(),
    this.process = const Value.absent(),
    this.altitudeM = const Value.absent(),
    this.roastDate = const Value.absent(),
    this.tastingNotes = const Value.absent(),
    this.isArchived = const Value.absent(),
    this.searchText = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       roaster = Value(roaster),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Coffee> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? roaster,
    Expression<String>? country,
    Expression<String>? region,
    Expression<String>? farm,
    Expression<String>? producer,
    Expression<String>? varietal,
    Expression<String>? process,
    Expression<String>? altitudeM,
    Expression<DateTime>? roastDate,
    Expression<String>? tastingNotes,
    Expression<bool>? isArchived,
    Expression<String>? searchText,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (roaster != null) 'roaster': roaster,
      if (country != null) 'country': country,
      if (region != null) 'region': region,
      if (farm != null) 'farm': farm,
      if (producer != null) 'producer': producer,
      if (varietal != null) 'varietal': varietal,
      if (process != null) 'process': process,
      if (altitudeM != null) 'altitude_m': altitudeM,
      if (roastDate != null) 'roast_date': roastDate,
      if (tastingNotes != null) 'tasting_notes': tastingNotes,
      if (isArchived != null) 'is_archived': isArchived,
      if (searchText != null) 'search_text': searchText,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CoffeesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? roaster,
    Value<String?>? country,
    Value<String?>? region,
    Value<String?>? farm,
    Value<String?>? producer,
    Value<String?>? varietal,
    Value<String?>? process,
    Value<String?>? altitudeM,
    Value<DateTime?>? roastDate,
    Value<String?>? tastingNotes,
    Value<bool>? isArchived,
    Value<String>? searchText,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return CoffeesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      roaster: roaster ?? this.roaster,
      country: country ?? this.country,
      region: region ?? this.region,
      farm: farm ?? this.farm,
      producer: producer ?? this.producer,
      varietal: varietal ?? this.varietal,
      process: process ?? this.process,
      altitudeM: altitudeM ?? this.altitudeM,
      roastDate: roastDate ?? this.roastDate,
      tastingNotes: tastingNotes ?? this.tastingNotes,
      isArchived: isArchived ?? this.isArchived,
      searchText: searchText ?? this.searchText,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (roaster.present) {
      map['roaster'] = Variable<String>(roaster.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (region.present) {
      map['region'] = Variable<String>(region.value);
    }
    if (farm.present) {
      map['farm'] = Variable<String>(farm.value);
    }
    if (producer.present) {
      map['producer'] = Variable<String>(producer.value);
    }
    if (varietal.present) {
      map['varietal'] = Variable<String>(varietal.value);
    }
    if (process.present) {
      map['process'] = Variable<String>(process.value);
    }
    if (altitudeM.present) {
      map['altitude_m'] = Variable<String>(altitudeM.value);
    }
    if (roastDate.present) {
      map['roast_date'] = Variable<DateTime>(roastDate.value);
    }
    if (tastingNotes.present) {
      map['tasting_notes'] = Variable<String>(tastingNotes.value);
    }
    if (isArchived.present) {
      map['is_archived'] = Variable<bool>(isArchived.value);
    }
    if (searchText.present) {
      map['search_text'] = Variable<String>(searchText.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoffeesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('roaster: $roaster, ')
          ..write('country: $country, ')
          ..write('region: $region, ')
          ..write('farm: $farm, ')
          ..write('producer: $producer, ')
          ..write('varietal: $varietal, ')
          ..write('process: $process, ')
          ..write('altitudeM: $altitudeM, ')
          ..write('roastDate: $roastDate, ')
          ..write('tastingNotes: $tastingNotes, ')
          ..write('isArchived: $isArchived, ')
          ..write('searchText: $searchText, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EntriesTable extends Entries with TableInfo<$EntriesTable, Entry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coffeeIdMeta = const VerificationMeta(
    'coffeeId',
  );
  @override
  late final GeneratedColumn<String> coffeeId = GeneratedColumn<String>(
    'coffee_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES coffees (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _brewAtMeta = const VerificationMeta('brewAt');
  @override
  late final GeneratedColumn<DateTime> brewAt = GeneratedColumn<DateTime>(
    'brew_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _brewMethodMeta = const VerificationMeta(
    'brewMethod',
  );
  @override
  late final GeneratedColumn<String> brewMethod = GeneratedColumn<String>(
    'brew_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isStarredMeta = const VerificationMeta(
    'isStarred',
  );
  @override
  late final GeneratedColumn<bool> isStarred = GeneratedColumn<bool>(
    'is_starred',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_starred" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _coffeeDoseGMeta = const VerificationMeta(
    'coffeeDoseG',
  );
  @override
  late final GeneratedColumn<double> coffeeDoseG = GeneratedColumn<double>(
    'coffee_dose_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _waterTotalGMeta = const VerificationMeta(
    'waterTotalG',
  );
  @override
  late final GeneratedColumn<double> waterTotalG = GeneratedColumn<double>(
    'water_total_g',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _waterTempCMeta = const VerificationMeta(
    'waterTempC',
  );
  @override
  late final GeneratedColumn<double> waterTempC = GeneratedColumn<double>(
    'water_temp_c',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _grinderMeta = const VerificationMeta(
    'grinder',
  );
  @override
  late final GeneratedColumn<String> grinder = GeneratedColumn<String>(
    'grinder',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _grindSettingMeta = const VerificationMeta(
    'grindSetting',
  );
  @override
  late final GeneratedColumn<String> grindSetting = GeneratedColumn<String>(
    'grind_setting',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _yieldGMeta = const VerificationMeta('yieldG');
  @override
  late final GeneratedColumn<double> yieldG = GeneratedColumn<double>(
    'yield_g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pressureBarMeta = const VerificationMeta(
    'pressureBar',
  );
  @override
  late final GeneratedColumn<double> pressureBar = GeneratedColumn<double>(
    'pressure_bar',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _preinfusionSecMeta = const VerificationMeta(
    'preinfusionSec',
  );
  @override
  late final GeneratedColumn<int> preinfusionSec = GeneratedColumn<int>(
    'preinfusion_sec',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _brewTimeSecAutoMeta = const VerificationMeta(
    'brewTimeSecAuto',
  );
  @override
  late final GeneratedColumn<int> brewTimeSecAuto = GeneratedColumn<int>(
    'brew_time_sec_auto',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _brewTimeSecManualMeta = const VerificationMeta(
    'brewTimeSecManual',
  );
  @override
  late final GeneratedColumn<int> brewTimeSecManual = GeneratedColumn<int>(
    'brew_time_sec_manual',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sensoryJsonMeta = const VerificationMeta(
    'sensoryJson',
  );
  @override
  late final GeneratedColumn<String> sensoryJson = GeneratedColumn<String>(
    'sensory_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dialInNotesMeta = const VerificationMeta(
    'dialInNotes',
  );
  @override
  late final GeneratedColumn<String> dialInNotes = GeneratedColumn<String>(
    'dial_in_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _miscNotesMeta = const VerificationMeta(
    'miscNotes',
  );
  @override
  late final GeneratedColumn<String> miscNotes = GeneratedColumn<String>(
    'misc_notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _agitationLevelMeta = const VerificationMeta(
    'agitationLevel',
  );
  @override
  late final GeneratedColumn<String> agitationLevel = GeneratedColumn<String>(
    'agitation_level',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _drawdownSecMeta = const VerificationMeta(
    'drawdownSec',
  );
  @override
  late final GeneratedColumn<int> drawdownSec = GeneratedColumn<int>(
    'drawdown_sec',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _extractionOutcomeMeta = const VerificationMeta(
    'extractionOutcome',
  );
  @override
  late final GeneratedColumn<String> extractionOutcome =
      GeneratedColumn<String>(
        'extraction_outcome',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('unknown'),
      );
  static const VerificationMeta _searchTextMeta = const VerificationMeta(
    'searchText',
  );
  @override
  late final GeneratedColumn<String> searchText = GeneratedColumn<String>(
    'search_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
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
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    coffeeId,
    brewAt,
    brewMethod,
    isStarred,
    coffeeDoseG,
    waterTotalG,
    waterTempC,
    grinder,
    grindSetting,
    yieldG,
    pressureBar,
    preinfusionSec,
    brewTimeSecAuto,
    brewTimeSecManual,
    sensoryJson,
    dialInNotes,
    miscNotes,
    agitationLevel,
    drawdownSec,
    extractionOutcome,
    searchText,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<Entry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('coffee_id')) {
      context.handle(
        _coffeeIdMeta,
        coffeeId.isAcceptableOrUnknown(data['coffee_id']!, _coffeeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_coffeeIdMeta);
    }
    if (data.containsKey('brew_at')) {
      context.handle(
        _brewAtMeta,
        brewAt.isAcceptableOrUnknown(data['brew_at']!, _brewAtMeta),
      );
    } else if (isInserting) {
      context.missing(_brewAtMeta);
    }
    if (data.containsKey('brew_method')) {
      context.handle(
        _brewMethodMeta,
        brewMethod.isAcceptableOrUnknown(data['brew_method']!, _brewMethodMeta),
      );
    } else if (isInserting) {
      context.missing(_brewMethodMeta);
    }
    if (data.containsKey('is_starred')) {
      context.handle(
        _isStarredMeta,
        isStarred.isAcceptableOrUnknown(data['is_starred']!, _isStarredMeta),
      );
    }
    if (data.containsKey('coffee_dose_g')) {
      context.handle(
        _coffeeDoseGMeta,
        coffeeDoseG.isAcceptableOrUnknown(
          data['coffee_dose_g']!,
          _coffeeDoseGMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_coffeeDoseGMeta);
    }
    if (data.containsKey('water_total_g')) {
      context.handle(
        _waterTotalGMeta,
        waterTotalG.isAcceptableOrUnknown(
          data['water_total_g']!,
          _waterTotalGMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_waterTotalGMeta);
    }
    if (data.containsKey('water_temp_c')) {
      context.handle(
        _waterTempCMeta,
        waterTempC.isAcceptableOrUnknown(
          data['water_temp_c']!,
          _waterTempCMeta,
        ),
      );
    }
    if (data.containsKey('grinder')) {
      context.handle(
        _grinderMeta,
        grinder.isAcceptableOrUnknown(data['grinder']!, _grinderMeta),
      );
    }
    if (data.containsKey('grind_setting')) {
      context.handle(
        _grindSettingMeta,
        grindSetting.isAcceptableOrUnknown(
          data['grind_setting']!,
          _grindSettingMeta,
        ),
      );
    }
    if (data.containsKey('yield_g')) {
      context.handle(
        _yieldGMeta,
        yieldG.isAcceptableOrUnknown(data['yield_g']!, _yieldGMeta),
      );
    }
    if (data.containsKey('pressure_bar')) {
      context.handle(
        _pressureBarMeta,
        pressureBar.isAcceptableOrUnknown(
          data['pressure_bar']!,
          _pressureBarMeta,
        ),
      );
    }
    if (data.containsKey('preinfusion_sec')) {
      context.handle(
        _preinfusionSecMeta,
        preinfusionSec.isAcceptableOrUnknown(
          data['preinfusion_sec']!,
          _preinfusionSecMeta,
        ),
      );
    }
    if (data.containsKey('brew_time_sec_auto')) {
      context.handle(
        _brewTimeSecAutoMeta,
        brewTimeSecAuto.isAcceptableOrUnknown(
          data['brew_time_sec_auto']!,
          _brewTimeSecAutoMeta,
        ),
      );
    }
    if (data.containsKey('brew_time_sec_manual')) {
      context.handle(
        _brewTimeSecManualMeta,
        brewTimeSecManual.isAcceptableOrUnknown(
          data['brew_time_sec_manual']!,
          _brewTimeSecManualMeta,
        ),
      );
    }
    if (data.containsKey('sensory_json')) {
      context.handle(
        _sensoryJsonMeta,
        sensoryJson.isAcceptableOrUnknown(
          data['sensory_json']!,
          _sensoryJsonMeta,
        ),
      );
    }
    if (data.containsKey('dial_in_notes')) {
      context.handle(
        _dialInNotesMeta,
        dialInNotes.isAcceptableOrUnknown(
          data['dial_in_notes']!,
          _dialInNotesMeta,
        ),
      );
    }
    if (data.containsKey('misc_notes')) {
      context.handle(
        _miscNotesMeta,
        miscNotes.isAcceptableOrUnknown(data['misc_notes']!, _miscNotesMeta),
      );
    }
    if (data.containsKey('agitation_level')) {
      context.handle(
        _agitationLevelMeta,
        agitationLevel.isAcceptableOrUnknown(
          data['agitation_level']!,
          _agitationLevelMeta,
        ),
      );
    }
    if (data.containsKey('drawdown_sec')) {
      context.handle(
        _drawdownSecMeta,
        drawdownSec.isAcceptableOrUnknown(
          data['drawdown_sec']!,
          _drawdownSecMeta,
        ),
      );
    }
    if (data.containsKey('extraction_outcome')) {
      context.handle(
        _extractionOutcomeMeta,
        extractionOutcome.isAcceptableOrUnknown(
          data['extraction_outcome']!,
          _extractionOutcomeMeta,
        ),
      );
    }
    if (data.containsKey('search_text')) {
      context.handle(
        _searchTextMeta,
        searchText.isAcceptableOrUnknown(data['search_text']!, _searchTextMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Entry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Entry(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      coffeeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}coffee_id'],
      )!,
      brewAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}brew_at'],
      )!,
      brewMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brew_method'],
      )!,
      isStarred: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_starred'],
      )!,
      coffeeDoseG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}coffee_dose_g'],
      )!,
      waterTotalG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}water_total_g'],
      )!,
      waterTempC: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}water_temp_c'],
      ),
      grinder: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grinder'],
      ),
      grindSetting: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}grind_setting'],
      ),
      yieldG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}yield_g'],
      ),
      pressureBar: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pressure_bar'],
      ),
      preinfusionSec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}preinfusion_sec'],
      ),
      brewTimeSecAuto: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}brew_time_sec_auto'],
      )!,
      brewTimeSecManual: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}brew_time_sec_manual'],
      ),
      sensoryJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}sensory_json'],
      ),
      dialInNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}dial_in_notes'],
      ),
      miscNotes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}misc_notes'],
      ),
      agitationLevel: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}agitation_level'],
      ),
      drawdownSec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}drawdown_sec'],
      ),
      extractionOutcome: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}extraction_outcome'],
      )!,
      searchText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}search_text'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $EntriesTable createAlias(String alias) {
    return $EntriesTable(attachedDatabase, alias);
  }
}

class Entry extends DataClass implements Insertable<Entry> {
  final String id;
  final String coffeeId;
  final DateTime brewAt;
  final String brewMethod;
  final bool isStarred;
  final double coffeeDoseG;
  final double waterTotalG;
  final double? waterTempC;
  final String? grinder;
  final String? grindSetting;
  final double? yieldG;
  final double? pressureBar;
  final int? preinfusionSec;
  final int brewTimeSecAuto;
  final int? brewTimeSecManual;
  final String? sensoryJson;
  final String? dialInNotes;
  final String? miscNotes;
  final String? agitationLevel;
  final int? drawdownSec;
  final String extractionOutcome;
  final String searchText;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Entry({
    required this.id,
    required this.coffeeId,
    required this.brewAt,
    required this.brewMethod,
    required this.isStarred,
    required this.coffeeDoseG,
    required this.waterTotalG,
    this.waterTempC,
    this.grinder,
    this.grindSetting,
    this.yieldG,
    this.pressureBar,
    this.preinfusionSec,
    required this.brewTimeSecAuto,
    this.brewTimeSecManual,
    this.sensoryJson,
    this.dialInNotes,
    this.miscNotes,
    this.agitationLevel,
    this.drawdownSec,
    required this.extractionOutcome,
    required this.searchText,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['coffee_id'] = Variable<String>(coffeeId);
    map['brew_at'] = Variable<DateTime>(brewAt);
    map['brew_method'] = Variable<String>(brewMethod);
    map['is_starred'] = Variable<bool>(isStarred);
    map['coffee_dose_g'] = Variable<double>(coffeeDoseG);
    map['water_total_g'] = Variable<double>(waterTotalG);
    if (!nullToAbsent || waterTempC != null) {
      map['water_temp_c'] = Variable<double>(waterTempC);
    }
    if (!nullToAbsent || grinder != null) {
      map['grinder'] = Variable<String>(grinder);
    }
    if (!nullToAbsent || grindSetting != null) {
      map['grind_setting'] = Variable<String>(grindSetting);
    }
    if (!nullToAbsent || yieldG != null) {
      map['yield_g'] = Variable<double>(yieldG);
    }
    if (!nullToAbsent || pressureBar != null) {
      map['pressure_bar'] = Variable<double>(pressureBar);
    }
    if (!nullToAbsent || preinfusionSec != null) {
      map['preinfusion_sec'] = Variable<int>(preinfusionSec);
    }
    map['brew_time_sec_auto'] = Variable<int>(brewTimeSecAuto);
    if (!nullToAbsent || brewTimeSecManual != null) {
      map['brew_time_sec_manual'] = Variable<int>(brewTimeSecManual);
    }
    if (!nullToAbsent || sensoryJson != null) {
      map['sensory_json'] = Variable<String>(sensoryJson);
    }
    if (!nullToAbsent || dialInNotes != null) {
      map['dial_in_notes'] = Variable<String>(dialInNotes);
    }
    if (!nullToAbsent || miscNotes != null) {
      map['misc_notes'] = Variable<String>(miscNotes);
    }
    if (!nullToAbsent || agitationLevel != null) {
      map['agitation_level'] = Variable<String>(agitationLevel);
    }
    if (!nullToAbsent || drawdownSec != null) {
      map['drawdown_sec'] = Variable<int>(drawdownSec);
    }
    map['extraction_outcome'] = Variable<String>(extractionOutcome);
    map['search_text'] = Variable<String>(searchText);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  EntriesCompanion toCompanion(bool nullToAbsent) {
    return EntriesCompanion(
      id: Value(id),
      coffeeId: Value(coffeeId),
      brewAt: Value(brewAt),
      brewMethod: Value(brewMethod),
      isStarred: Value(isStarred),
      coffeeDoseG: Value(coffeeDoseG),
      waterTotalG: Value(waterTotalG),
      waterTempC: waterTempC == null && nullToAbsent
          ? const Value.absent()
          : Value(waterTempC),
      grinder: grinder == null && nullToAbsent
          ? const Value.absent()
          : Value(grinder),
      grindSetting: grindSetting == null && nullToAbsent
          ? const Value.absent()
          : Value(grindSetting),
      yieldG: yieldG == null && nullToAbsent
          ? const Value.absent()
          : Value(yieldG),
      pressureBar: pressureBar == null && nullToAbsent
          ? const Value.absent()
          : Value(pressureBar),
      preinfusionSec: preinfusionSec == null && nullToAbsent
          ? const Value.absent()
          : Value(preinfusionSec),
      brewTimeSecAuto: Value(brewTimeSecAuto),
      brewTimeSecManual: brewTimeSecManual == null && nullToAbsent
          ? const Value.absent()
          : Value(brewTimeSecManual),
      sensoryJson: sensoryJson == null && nullToAbsent
          ? const Value.absent()
          : Value(sensoryJson),
      dialInNotes: dialInNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(dialInNotes),
      miscNotes: miscNotes == null && nullToAbsent
          ? const Value.absent()
          : Value(miscNotes),
      agitationLevel: agitationLevel == null && nullToAbsent
          ? const Value.absent()
          : Value(agitationLevel),
      drawdownSec: drawdownSec == null && nullToAbsent
          ? const Value.absent()
          : Value(drawdownSec),
      extractionOutcome: Value(extractionOutcome),
      searchText: Value(searchText),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Entry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Entry(
      id: serializer.fromJson<String>(json['id']),
      coffeeId: serializer.fromJson<String>(json['coffeeId']),
      brewAt: serializer.fromJson<DateTime>(json['brewAt']),
      brewMethod: serializer.fromJson<String>(json['brewMethod']),
      isStarred: serializer.fromJson<bool>(json['isStarred']),
      coffeeDoseG: serializer.fromJson<double>(json['coffeeDoseG']),
      waterTotalG: serializer.fromJson<double>(json['waterTotalG']),
      waterTempC: serializer.fromJson<double?>(json['waterTempC']),
      grinder: serializer.fromJson<String?>(json['grinder']),
      grindSetting: serializer.fromJson<String?>(json['grindSetting']),
      yieldG: serializer.fromJson<double?>(json['yieldG']),
      pressureBar: serializer.fromJson<double?>(json['pressureBar']),
      preinfusionSec: serializer.fromJson<int?>(json['preinfusionSec']),
      brewTimeSecAuto: serializer.fromJson<int>(json['brewTimeSecAuto']),
      brewTimeSecManual: serializer.fromJson<int?>(json['brewTimeSecManual']),
      sensoryJson: serializer.fromJson<String?>(json['sensoryJson']),
      dialInNotes: serializer.fromJson<String?>(json['dialInNotes']),
      miscNotes: serializer.fromJson<String?>(json['miscNotes']),
      agitationLevel: serializer.fromJson<String?>(json['agitationLevel']),
      drawdownSec: serializer.fromJson<int?>(json['drawdownSec']),
      extractionOutcome: serializer.fromJson<String>(json['extractionOutcome']),
      searchText: serializer.fromJson<String>(json['searchText']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'coffeeId': serializer.toJson<String>(coffeeId),
      'brewAt': serializer.toJson<DateTime>(brewAt),
      'brewMethod': serializer.toJson<String>(brewMethod),
      'isStarred': serializer.toJson<bool>(isStarred),
      'coffeeDoseG': serializer.toJson<double>(coffeeDoseG),
      'waterTotalG': serializer.toJson<double>(waterTotalG),
      'waterTempC': serializer.toJson<double?>(waterTempC),
      'grinder': serializer.toJson<String?>(grinder),
      'grindSetting': serializer.toJson<String?>(grindSetting),
      'yieldG': serializer.toJson<double?>(yieldG),
      'pressureBar': serializer.toJson<double?>(pressureBar),
      'preinfusionSec': serializer.toJson<int?>(preinfusionSec),
      'brewTimeSecAuto': serializer.toJson<int>(brewTimeSecAuto),
      'brewTimeSecManual': serializer.toJson<int?>(brewTimeSecManual),
      'sensoryJson': serializer.toJson<String?>(sensoryJson),
      'dialInNotes': serializer.toJson<String?>(dialInNotes),
      'miscNotes': serializer.toJson<String?>(miscNotes),
      'agitationLevel': serializer.toJson<String?>(agitationLevel),
      'drawdownSec': serializer.toJson<int?>(drawdownSec),
      'extractionOutcome': serializer.toJson<String>(extractionOutcome),
      'searchText': serializer.toJson<String>(searchText),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Entry copyWith({
    String? id,
    String? coffeeId,
    DateTime? brewAt,
    String? brewMethod,
    bool? isStarred,
    double? coffeeDoseG,
    double? waterTotalG,
    Value<double?> waterTempC = const Value.absent(),
    Value<String?> grinder = const Value.absent(),
    Value<String?> grindSetting = const Value.absent(),
    Value<double?> yieldG = const Value.absent(),
    Value<double?> pressureBar = const Value.absent(),
    Value<int?> preinfusionSec = const Value.absent(),
    int? brewTimeSecAuto,
    Value<int?> brewTimeSecManual = const Value.absent(),
    Value<String?> sensoryJson = const Value.absent(),
    Value<String?> dialInNotes = const Value.absent(),
    Value<String?> miscNotes = const Value.absent(),
    Value<String?> agitationLevel = const Value.absent(),
    Value<int?> drawdownSec = const Value.absent(),
    String? extractionOutcome,
    String? searchText,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Entry(
    id: id ?? this.id,
    coffeeId: coffeeId ?? this.coffeeId,
    brewAt: brewAt ?? this.brewAt,
    brewMethod: brewMethod ?? this.brewMethod,
    isStarred: isStarred ?? this.isStarred,
    coffeeDoseG: coffeeDoseG ?? this.coffeeDoseG,
    waterTotalG: waterTotalG ?? this.waterTotalG,
    waterTempC: waterTempC.present ? waterTempC.value : this.waterTempC,
    grinder: grinder.present ? grinder.value : this.grinder,
    grindSetting: grindSetting.present ? grindSetting.value : this.grindSetting,
    yieldG: yieldG.present ? yieldG.value : this.yieldG,
    pressureBar: pressureBar.present ? pressureBar.value : this.pressureBar,
    preinfusionSec: preinfusionSec.present
        ? preinfusionSec.value
        : this.preinfusionSec,
    brewTimeSecAuto: brewTimeSecAuto ?? this.brewTimeSecAuto,
    brewTimeSecManual: brewTimeSecManual.present
        ? brewTimeSecManual.value
        : this.brewTimeSecManual,
    sensoryJson: sensoryJson.present ? sensoryJson.value : this.sensoryJson,
    dialInNotes: dialInNotes.present ? dialInNotes.value : this.dialInNotes,
    miscNotes: miscNotes.present ? miscNotes.value : this.miscNotes,
    agitationLevel: agitationLevel.present
        ? agitationLevel.value
        : this.agitationLevel,
    drawdownSec: drawdownSec.present ? drawdownSec.value : this.drawdownSec,
    extractionOutcome: extractionOutcome ?? this.extractionOutcome,
    searchText: searchText ?? this.searchText,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Entry copyWithCompanion(EntriesCompanion data) {
    return Entry(
      id: data.id.present ? data.id.value : this.id,
      coffeeId: data.coffeeId.present ? data.coffeeId.value : this.coffeeId,
      brewAt: data.brewAt.present ? data.brewAt.value : this.brewAt,
      brewMethod: data.brewMethod.present
          ? data.brewMethod.value
          : this.brewMethod,
      isStarred: data.isStarred.present ? data.isStarred.value : this.isStarred,
      coffeeDoseG: data.coffeeDoseG.present
          ? data.coffeeDoseG.value
          : this.coffeeDoseG,
      waterTotalG: data.waterTotalG.present
          ? data.waterTotalG.value
          : this.waterTotalG,
      waterTempC: data.waterTempC.present
          ? data.waterTempC.value
          : this.waterTempC,
      grinder: data.grinder.present ? data.grinder.value : this.grinder,
      grindSetting: data.grindSetting.present
          ? data.grindSetting.value
          : this.grindSetting,
      yieldG: data.yieldG.present ? data.yieldG.value : this.yieldG,
      pressureBar: data.pressureBar.present
          ? data.pressureBar.value
          : this.pressureBar,
      preinfusionSec: data.preinfusionSec.present
          ? data.preinfusionSec.value
          : this.preinfusionSec,
      brewTimeSecAuto: data.brewTimeSecAuto.present
          ? data.brewTimeSecAuto.value
          : this.brewTimeSecAuto,
      brewTimeSecManual: data.brewTimeSecManual.present
          ? data.brewTimeSecManual.value
          : this.brewTimeSecManual,
      sensoryJson: data.sensoryJson.present
          ? data.sensoryJson.value
          : this.sensoryJson,
      dialInNotes: data.dialInNotes.present
          ? data.dialInNotes.value
          : this.dialInNotes,
      miscNotes: data.miscNotes.present ? data.miscNotes.value : this.miscNotes,
      agitationLevel: data.agitationLevel.present
          ? data.agitationLevel.value
          : this.agitationLevel,
      drawdownSec: data.drawdownSec.present
          ? data.drawdownSec.value
          : this.drawdownSec,
      extractionOutcome: data.extractionOutcome.present
          ? data.extractionOutcome.value
          : this.extractionOutcome,
      searchText: data.searchText.present
          ? data.searchText.value
          : this.searchText,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Entry(')
          ..write('id: $id, ')
          ..write('coffeeId: $coffeeId, ')
          ..write('brewAt: $brewAt, ')
          ..write('brewMethod: $brewMethod, ')
          ..write('isStarred: $isStarred, ')
          ..write('coffeeDoseG: $coffeeDoseG, ')
          ..write('waterTotalG: $waterTotalG, ')
          ..write('waterTempC: $waterTempC, ')
          ..write('grinder: $grinder, ')
          ..write('grindSetting: $grindSetting, ')
          ..write('yieldG: $yieldG, ')
          ..write('pressureBar: $pressureBar, ')
          ..write('preinfusionSec: $preinfusionSec, ')
          ..write('brewTimeSecAuto: $brewTimeSecAuto, ')
          ..write('brewTimeSecManual: $brewTimeSecManual, ')
          ..write('sensoryJson: $sensoryJson, ')
          ..write('dialInNotes: $dialInNotes, ')
          ..write('miscNotes: $miscNotes, ')
          ..write('agitationLevel: $agitationLevel, ')
          ..write('drawdownSec: $drawdownSec, ')
          ..write('extractionOutcome: $extractionOutcome, ')
          ..write('searchText: $searchText, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    coffeeId,
    brewAt,
    brewMethod,
    isStarred,
    coffeeDoseG,
    waterTotalG,
    waterTempC,
    grinder,
    grindSetting,
    yieldG,
    pressureBar,
    preinfusionSec,
    brewTimeSecAuto,
    brewTimeSecManual,
    sensoryJson,
    dialInNotes,
    miscNotes,
    agitationLevel,
    drawdownSec,
    extractionOutcome,
    searchText,
    createdAt,
    updatedAt,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Entry &&
          other.id == this.id &&
          other.coffeeId == this.coffeeId &&
          other.brewAt == this.brewAt &&
          other.brewMethod == this.brewMethod &&
          other.isStarred == this.isStarred &&
          other.coffeeDoseG == this.coffeeDoseG &&
          other.waterTotalG == this.waterTotalG &&
          other.waterTempC == this.waterTempC &&
          other.grinder == this.grinder &&
          other.grindSetting == this.grindSetting &&
          other.yieldG == this.yieldG &&
          other.pressureBar == this.pressureBar &&
          other.preinfusionSec == this.preinfusionSec &&
          other.brewTimeSecAuto == this.brewTimeSecAuto &&
          other.brewTimeSecManual == this.brewTimeSecManual &&
          other.sensoryJson == this.sensoryJson &&
          other.dialInNotes == this.dialInNotes &&
          other.miscNotes == this.miscNotes &&
          other.agitationLevel == this.agitationLevel &&
          other.drawdownSec == this.drawdownSec &&
          other.extractionOutcome == this.extractionOutcome &&
          other.searchText == this.searchText &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class EntriesCompanion extends UpdateCompanion<Entry> {
  final Value<String> id;
  final Value<String> coffeeId;
  final Value<DateTime> brewAt;
  final Value<String> brewMethod;
  final Value<bool> isStarred;
  final Value<double> coffeeDoseG;
  final Value<double> waterTotalG;
  final Value<double?> waterTempC;
  final Value<String?> grinder;
  final Value<String?> grindSetting;
  final Value<double?> yieldG;
  final Value<double?> pressureBar;
  final Value<int?> preinfusionSec;
  final Value<int> brewTimeSecAuto;
  final Value<int?> brewTimeSecManual;
  final Value<String?> sensoryJson;
  final Value<String?> dialInNotes;
  final Value<String?> miscNotes;
  final Value<String?> agitationLevel;
  final Value<int?> drawdownSec;
  final Value<String> extractionOutcome;
  final Value<String> searchText;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const EntriesCompanion({
    this.id = const Value.absent(),
    this.coffeeId = const Value.absent(),
    this.brewAt = const Value.absent(),
    this.brewMethod = const Value.absent(),
    this.isStarred = const Value.absent(),
    this.coffeeDoseG = const Value.absent(),
    this.waterTotalG = const Value.absent(),
    this.waterTempC = const Value.absent(),
    this.grinder = const Value.absent(),
    this.grindSetting = const Value.absent(),
    this.yieldG = const Value.absent(),
    this.pressureBar = const Value.absent(),
    this.preinfusionSec = const Value.absent(),
    this.brewTimeSecAuto = const Value.absent(),
    this.brewTimeSecManual = const Value.absent(),
    this.sensoryJson = const Value.absent(),
    this.dialInNotes = const Value.absent(),
    this.miscNotes = const Value.absent(),
    this.agitationLevel = const Value.absent(),
    this.drawdownSec = const Value.absent(),
    this.extractionOutcome = const Value.absent(),
    this.searchText = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EntriesCompanion.insert({
    required String id,
    required String coffeeId,
    required DateTime brewAt,
    required String brewMethod,
    this.isStarred = const Value.absent(),
    required double coffeeDoseG,
    required double waterTotalG,
    this.waterTempC = const Value.absent(),
    this.grinder = const Value.absent(),
    this.grindSetting = const Value.absent(),
    this.yieldG = const Value.absent(),
    this.pressureBar = const Value.absent(),
    this.preinfusionSec = const Value.absent(),
    this.brewTimeSecAuto = const Value.absent(),
    this.brewTimeSecManual = const Value.absent(),
    this.sensoryJson = const Value.absent(),
    this.dialInNotes = const Value.absent(),
    this.miscNotes = const Value.absent(),
    this.agitationLevel = const Value.absent(),
    this.drawdownSec = const Value.absent(),
    this.extractionOutcome = const Value.absent(),
    this.searchText = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       coffeeId = Value(coffeeId),
       brewAt = Value(brewAt),
       brewMethod = Value(brewMethod),
       coffeeDoseG = Value(coffeeDoseG),
       waterTotalG = Value(waterTotalG),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Entry> custom({
    Expression<String>? id,
    Expression<String>? coffeeId,
    Expression<DateTime>? brewAt,
    Expression<String>? brewMethod,
    Expression<bool>? isStarred,
    Expression<double>? coffeeDoseG,
    Expression<double>? waterTotalG,
    Expression<double>? waterTempC,
    Expression<String>? grinder,
    Expression<String>? grindSetting,
    Expression<double>? yieldG,
    Expression<double>? pressureBar,
    Expression<int>? preinfusionSec,
    Expression<int>? brewTimeSecAuto,
    Expression<int>? brewTimeSecManual,
    Expression<String>? sensoryJson,
    Expression<String>? dialInNotes,
    Expression<String>? miscNotes,
    Expression<String>? agitationLevel,
    Expression<int>? drawdownSec,
    Expression<String>? extractionOutcome,
    Expression<String>? searchText,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (coffeeId != null) 'coffee_id': coffeeId,
      if (brewAt != null) 'brew_at': brewAt,
      if (brewMethod != null) 'brew_method': brewMethod,
      if (isStarred != null) 'is_starred': isStarred,
      if (coffeeDoseG != null) 'coffee_dose_g': coffeeDoseG,
      if (waterTotalG != null) 'water_total_g': waterTotalG,
      if (waterTempC != null) 'water_temp_c': waterTempC,
      if (grinder != null) 'grinder': grinder,
      if (grindSetting != null) 'grind_setting': grindSetting,
      if (yieldG != null) 'yield_g': yieldG,
      if (pressureBar != null) 'pressure_bar': pressureBar,
      if (preinfusionSec != null) 'preinfusion_sec': preinfusionSec,
      if (brewTimeSecAuto != null) 'brew_time_sec_auto': brewTimeSecAuto,
      if (brewTimeSecManual != null) 'brew_time_sec_manual': brewTimeSecManual,
      if (sensoryJson != null) 'sensory_json': sensoryJson,
      if (dialInNotes != null) 'dial_in_notes': dialInNotes,
      if (miscNotes != null) 'misc_notes': miscNotes,
      if (agitationLevel != null) 'agitation_level': agitationLevel,
      if (drawdownSec != null) 'drawdown_sec': drawdownSec,
      if (extractionOutcome != null) 'extraction_outcome': extractionOutcome,
      if (searchText != null) 'search_text': searchText,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EntriesCompanion copyWith({
    Value<String>? id,
    Value<String>? coffeeId,
    Value<DateTime>? brewAt,
    Value<String>? brewMethod,
    Value<bool>? isStarred,
    Value<double>? coffeeDoseG,
    Value<double>? waterTotalG,
    Value<double?>? waterTempC,
    Value<String?>? grinder,
    Value<String?>? grindSetting,
    Value<double?>? yieldG,
    Value<double?>? pressureBar,
    Value<int?>? preinfusionSec,
    Value<int>? brewTimeSecAuto,
    Value<int?>? brewTimeSecManual,
    Value<String?>? sensoryJson,
    Value<String?>? dialInNotes,
    Value<String?>? miscNotes,
    Value<String?>? agitationLevel,
    Value<int?>? drawdownSec,
    Value<String>? extractionOutcome,
    Value<String>? searchText,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return EntriesCompanion(
      id: id ?? this.id,
      coffeeId: coffeeId ?? this.coffeeId,
      brewAt: brewAt ?? this.brewAt,
      brewMethod: brewMethod ?? this.brewMethod,
      isStarred: isStarred ?? this.isStarred,
      coffeeDoseG: coffeeDoseG ?? this.coffeeDoseG,
      waterTotalG: waterTotalG ?? this.waterTotalG,
      waterTempC: waterTempC ?? this.waterTempC,
      grinder: grinder ?? this.grinder,
      grindSetting: grindSetting ?? this.grindSetting,
      yieldG: yieldG ?? this.yieldG,
      pressureBar: pressureBar ?? this.pressureBar,
      preinfusionSec: preinfusionSec ?? this.preinfusionSec,
      brewTimeSecAuto: brewTimeSecAuto ?? this.brewTimeSecAuto,
      brewTimeSecManual: brewTimeSecManual ?? this.brewTimeSecManual,
      sensoryJson: sensoryJson ?? this.sensoryJson,
      dialInNotes: dialInNotes ?? this.dialInNotes,
      miscNotes: miscNotes ?? this.miscNotes,
      agitationLevel: agitationLevel ?? this.agitationLevel,
      drawdownSec: drawdownSec ?? this.drawdownSec,
      extractionOutcome: extractionOutcome ?? this.extractionOutcome,
      searchText: searchText ?? this.searchText,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (coffeeId.present) {
      map['coffee_id'] = Variable<String>(coffeeId.value);
    }
    if (brewAt.present) {
      map['brew_at'] = Variable<DateTime>(brewAt.value);
    }
    if (brewMethod.present) {
      map['brew_method'] = Variable<String>(brewMethod.value);
    }
    if (isStarred.present) {
      map['is_starred'] = Variable<bool>(isStarred.value);
    }
    if (coffeeDoseG.present) {
      map['coffee_dose_g'] = Variable<double>(coffeeDoseG.value);
    }
    if (waterTotalG.present) {
      map['water_total_g'] = Variable<double>(waterTotalG.value);
    }
    if (waterTempC.present) {
      map['water_temp_c'] = Variable<double>(waterTempC.value);
    }
    if (grinder.present) {
      map['grinder'] = Variable<String>(grinder.value);
    }
    if (grindSetting.present) {
      map['grind_setting'] = Variable<String>(grindSetting.value);
    }
    if (yieldG.present) {
      map['yield_g'] = Variable<double>(yieldG.value);
    }
    if (pressureBar.present) {
      map['pressure_bar'] = Variable<double>(pressureBar.value);
    }
    if (preinfusionSec.present) {
      map['preinfusion_sec'] = Variable<int>(preinfusionSec.value);
    }
    if (brewTimeSecAuto.present) {
      map['brew_time_sec_auto'] = Variable<int>(brewTimeSecAuto.value);
    }
    if (brewTimeSecManual.present) {
      map['brew_time_sec_manual'] = Variable<int>(brewTimeSecManual.value);
    }
    if (sensoryJson.present) {
      map['sensory_json'] = Variable<String>(sensoryJson.value);
    }
    if (dialInNotes.present) {
      map['dial_in_notes'] = Variable<String>(dialInNotes.value);
    }
    if (miscNotes.present) {
      map['misc_notes'] = Variable<String>(miscNotes.value);
    }
    if (agitationLevel.present) {
      map['agitation_level'] = Variable<String>(agitationLevel.value);
    }
    if (drawdownSec.present) {
      map['drawdown_sec'] = Variable<int>(drawdownSec.value);
    }
    if (extractionOutcome.present) {
      map['extraction_outcome'] = Variable<String>(extractionOutcome.value);
    }
    if (searchText.present) {
      map['search_text'] = Variable<String>(searchText.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntriesCompanion(')
          ..write('id: $id, ')
          ..write('coffeeId: $coffeeId, ')
          ..write('brewAt: $brewAt, ')
          ..write('brewMethod: $brewMethod, ')
          ..write('isStarred: $isStarred, ')
          ..write('coffeeDoseG: $coffeeDoseG, ')
          ..write('waterTotalG: $waterTotalG, ')
          ..write('waterTempC: $waterTempC, ')
          ..write('grinder: $grinder, ')
          ..write('grindSetting: $grindSetting, ')
          ..write('yieldG: $yieldG, ')
          ..write('pressureBar: $pressureBar, ')
          ..write('preinfusionSec: $preinfusionSec, ')
          ..write('brewTimeSecAuto: $brewTimeSecAuto, ')
          ..write('brewTimeSecManual: $brewTimeSecManual, ')
          ..write('sensoryJson: $sensoryJson, ')
          ..write('dialInNotes: $dialInNotes, ')
          ..write('miscNotes: $miscNotes, ')
          ..write('agitationLevel: $agitationLevel, ')
          ..write('drawdownSec: $drawdownSec, ')
          ..write('extractionOutcome: $extractionOutcome, ')
          ..write('searchText: $searchText, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EntryStepsTable extends EntrySteps
    with TableInfo<$EntryStepsTable, EntryStep> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EntryStepsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _entryIdMeta = const VerificationMeta(
    'entryId',
  );
  @override
  late final GeneratedColumn<String> entryId = GeneratedColumn<String>(
    'entry_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES entries (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _stepIndexMeta = const VerificationMeta(
    'stepIndex',
  );
  @override
  late final GeneratedColumn<int> stepIndex = GeneratedColumn<int>(
    'step_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startSecMeta = const VerificationMeta(
    'startSec',
  );
  @override
  late final GeneratedColumn<int> startSec = GeneratedColumn<int>(
    'start_sec',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationSecMeta = const VerificationMeta(
    'durationSec',
  );
  @override
  late final GeneratedColumn<int> durationSec = GeneratedColumn<int>(
    'duration_sec',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _waterGMeta = const VerificationMeta('waterG');
  @override
  late final GeneratedColumn<double> waterG = GeneratedColumn<double>(
    'water_g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _flowRateGPerSecMeta = const VerificationMeta(
    'flowRateGPerSec',
  );
  @override
  late final GeneratedColumn<double> flowRateGPerSec = GeneratedColumn<double>(
    'flow_rate_g_per_sec',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pressureBarMeta = const VerificationMeta(
    'pressureBar',
  );
  @override
  late final GeneratedColumn<double> pressureBar = GeneratedColumn<double>(
    'pressure_bar',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _countMeta = const VerificationMeta('count');
  @override
  late final GeneratedColumn<int> count = GeneratedColumn<int>(
    'count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _toolMeta = const VerificationMeta('tool');
  @override
  late final GeneratedColumn<String> tool = GeneratedColumn<String>(
    'tool',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _jsonPayloadMeta = const VerificationMeta(
    'jsonPayload',
  );
  @override
  late final GeneratedColumn<String> jsonPayload = GeneratedColumn<String>(
    'json_payload',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    entryId,
    stepIndex,
    type,
    startSec,
    durationSec,
    note,
    waterG,
    flowRateGPerSec,
    pressureBar,
    count,
    tool,
    label,
    jsonPayload,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'entry_steps';
  @override
  VerificationContext validateIntegrity(
    Insertable<EntryStep> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('entry_id')) {
      context.handle(
        _entryIdMeta,
        entryId.isAcceptableOrUnknown(data['entry_id']!, _entryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entryIdMeta);
    }
    if (data.containsKey('step_index')) {
      context.handle(
        _stepIndexMeta,
        stepIndex.isAcceptableOrUnknown(data['step_index']!, _stepIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_stepIndexMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('start_sec')) {
      context.handle(
        _startSecMeta,
        startSec.isAcceptableOrUnknown(data['start_sec']!, _startSecMeta),
      );
    }
    if (data.containsKey('duration_sec')) {
      context.handle(
        _durationSecMeta,
        durationSec.isAcceptableOrUnknown(
          data['duration_sec']!,
          _durationSecMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('water_g')) {
      context.handle(
        _waterGMeta,
        waterG.isAcceptableOrUnknown(data['water_g']!, _waterGMeta),
      );
    }
    if (data.containsKey('flow_rate_g_per_sec')) {
      context.handle(
        _flowRateGPerSecMeta,
        flowRateGPerSec.isAcceptableOrUnknown(
          data['flow_rate_g_per_sec']!,
          _flowRateGPerSecMeta,
        ),
      );
    }
    if (data.containsKey('pressure_bar')) {
      context.handle(
        _pressureBarMeta,
        pressureBar.isAcceptableOrUnknown(
          data['pressure_bar']!,
          _pressureBarMeta,
        ),
      );
    }
    if (data.containsKey('count')) {
      context.handle(
        _countMeta,
        count.isAcceptableOrUnknown(data['count']!, _countMeta),
      );
    }
    if (data.containsKey('tool')) {
      context.handle(
        _toolMeta,
        tool.isAcceptableOrUnknown(data['tool']!, _toolMeta),
      );
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    }
    if (data.containsKey('json_payload')) {
      context.handle(
        _jsonPayloadMeta,
        jsonPayload.isAcceptableOrUnknown(
          data['json_payload']!,
          _jsonPayloadMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EntryStep map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EntryStep(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      entryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entry_id'],
      )!,
      stepIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}step_index'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      startSec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_sec'],
      ),
      durationSec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_sec'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      waterG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}water_g'],
      ),
      flowRateGPerSec: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}flow_rate_g_per_sec'],
      ),
      pressureBar: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pressure_bar'],
      ),
      count: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}count'],
      ),
      tool: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tool'],
      ),
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      ),
      jsonPayload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}json_payload'],
      ),
    );
  }

  @override
  $EntryStepsTable createAlias(String alias) {
    return $EntryStepsTable(attachedDatabase, alias);
  }
}

class EntryStep extends DataClass implements Insertable<EntryStep> {
  final String id;
  final String entryId;
  final int stepIndex;
  final String type;
  final int? startSec;
  final int? durationSec;
  final String? note;
  final double? waterG;
  final double? flowRateGPerSec;
  final double? pressureBar;
  final int? count;
  final String? tool;
  final String? label;
  final String? jsonPayload;
  const EntryStep({
    required this.id,
    required this.entryId,
    required this.stepIndex,
    required this.type,
    this.startSec,
    this.durationSec,
    this.note,
    this.waterG,
    this.flowRateGPerSec,
    this.pressureBar,
    this.count,
    this.tool,
    this.label,
    this.jsonPayload,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['entry_id'] = Variable<String>(entryId);
    map['step_index'] = Variable<int>(stepIndex);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || startSec != null) {
      map['start_sec'] = Variable<int>(startSec);
    }
    if (!nullToAbsent || durationSec != null) {
      map['duration_sec'] = Variable<int>(durationSec);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || waterG != null) {
      map['water_g'] = Variable<double>(waterG);
    }
    if (!nullToAbsent || flowRateGPerSec != null) {
      map['flow_rate_g_per_sec'] = Variable<double>(flowRateGPerSec);
    }
    if (!nullToAbsent || pressureBar != null) {
      map['pressure_bar'] = Variable<double>(pressureBar);
    }
    if (!nullToAbsent || count != null) {
      map['count'] = Variable<int>(count);
    }
    if (!nullToAbsent || tool != null) {
      map['tool'] = Variable<String>(tool);
    }
    if (!nullToAbsent || label != null) {
      map['label'] = Variable<String>(label);
    }
    if (!nullToAbsent || jsonPayload != null) {
      map['json_payload'] = Variable<String>(jsonPayload);
    }
    return map;
  }

  EntryStepsCompanion toCompanion(bool nullToAbsent) {
    return EntryStepsCompanion(
      id: Value(id),
      entryId: Value(entryId),
      stepIndex: Value(stepIndex),
      type: Value(type),
      startSec: startSec == null && nullToAbsent
          ? const Value.absent()
          : Value(startSec),
      durationSec: durationSec == null && nullToAbsent
          ? const Value.absent()
          : Value(durationSec),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      waterG: waterG == null && nullToAbsent
          ? const Value.absent()
          : Value(waterG),
      flowRateGPerSec: flowRateGPerSec == null && nullToAbsent
          ? const Value.absent()
          : Value(flowRateGPerSec),
      pressureBar: pressureBar == null && nullToAbsent
          ? const Value.absent()
          : Value(pressureBar),
      count: count == null && nullToAbsent
          ? const Value.absent()
          : Value(count),
      tool: tool == null && nullToAbsent ? const Value.absent() : Value(tool),
      label: label == null && nullToAbsent
          ? const Value.absent()
          : Value(label),
      jsonPayload: jsonPayload == null && nullToAbsent
          ? const Value.absent()
          : Value(jsonPayload),
    );
  }

  factory EntryStep.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EntryStep(
      id: serializer.fromJson<String>(json['id']),
      entryId: serializer.fromJson<String>(json['entryId']),
      stepIndex: serializer.fromJson<int>(json['stepIndex']),
      type: serializer.fromJson<String>(json['type']),
      startSec: serializer.fromJson<int?>(json['startSec']),
      durationSec: serializer.fromJson<int?>(json['durationSec']),
      note: serializer.fromJson<String?>(json['note']),
      waterG: serializer.fromJson<double?>(json['waterG']),
      flowRateGPerSec: serializer.fromJson<double?>(json['flowRateGPerSec']),
      pressureBar: serializer.fromJson<double?>(json['pressureBar']),
      count: serializer.fromJson<int?>(json['count']),
      tool: serializer.fromJson<String?>(json['tool']),
      label: serializer.fromJson<String?>(json['label']),
      jsonPayload: serializer.fromJson<String?>(json['jsonPayload']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'entryId': serializer.toJson<String>(entryId),
      'stepIndex': serializer.toJson<int>(stepIndex),
      'type': serializer.toJson<String>(type),
      'startSec': serializer.toJson<int?>(startSec),
      'durationSec': serializer.toJson<int?>(durationSec),
      'note': serializer.toJson<String?>(note),
      'waterG': serializer.toJson<double?>(waterG),
      'flowRateGPerSec': serializer.toJson<double?>(flowRateGPerSec),
      'pressureBar': serializer.toJson<double?>(pressureBar),
      'count': serializer.toJson<int?>(count),
      'tool': serializer.toJson<String?>(tool),
      'label': serializer.toJson<String?>(label),
      'jsonPayload': serializer.toJson<String?>(jsonPayload),
    };
  }

  EntryStep copyWith({
    String? id,
    String? entryId,
    int? stepIndex,
    String? type,
    Value<int?> startSec = const Value.absent(),
    Value<int?> durationSec = const Value.absent(),
    Value<String?> note = const Value.absent(),
    Value<double?> waterG = const Value.absent(),
    Value<double?> flowRateGPerSec = const Value.absent(),
    Value<double?> pressureBar = const Value.absent(),
    Value<int?> count = const Value.absent(),
    Value<String?> tool = const Value.absent(),
    Value<String?> label = const Value.absent(),
    Value<String?> jsonPayload = const Value.absent(),
  }) => EntryStep(
    id: id ?? this.id,
    entryId: entryId ?? this.entryId,
    stepIndex: stepIndex ?? this.stepIndex,
    type: type ?? this.type,
    startSec: startSec.present ? startSec.value : this.startSec,
    durationSec: durationSec.present ? durationSec.value : this.durationSec,
    note: note.present ? note.value : this.note,
    waterG: waterG.present ? waterG.value : this.waterG,
    flowRateGPerSec: flowRateGPerSec.present
        ? flowRateGPerSec.value
        : this.flowRateGPerSec,
    pressureBar: pressureBar.present ? pressureBar.value : this.pressureBar,
    count: count.present ? count.value : this.count,
    tool: tool.present ? tool.value : this.tool,
    label: label.present ? label.value : this.label,
    jsonPayload: jsonPayload.present ? jsonPayload.value : this.jsonPayload,
  );
  EntryStep copyWithCompanion(EntryStepsCompanion data) {
    return EntryStep(
      id: data.id.present ? data.id.value : this.id,
      entryId: data.entryId.present ? data.entryId.value : this.entryId,
      stepIndex: data.stepIndex.present ? data.stepIndex.value : this.stepIndex,
      type: data.type.present ? data.type.value : this.type,
      startSec: data.startSec.present ? data.startSec.value : this.startSec,
      durationSec: data.durationSec.present
          ? data.durationSec.value
          : this.durationSec,
      note: data.note.present ? data.note.value : this.note,
      waterG: data.waterG.present ? data.waterG.value : this.waterG,
      flowRateGPerSec: data.flowRateGPerSec.present
          ? data.flowRateGPerSec.value
          : this.flowRateGPerSec,
      pressureBar: data.pressureBar.present
          ? data.pressureBar.value
          : this.pressureBar,
      count: data.count.present ? data.count.value : this.count,
      tool: data.tool.present ? data.tool.value : this.tool,
      label: data.label.present ? data.label.value : this.label,
      jsonPayload: data.jsonPayload.present
          ? data.jsonPayload.value
          : this.jsonPayload,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EntryStep(')
          ..write('id: $id, ')
          ..write('entryId: $entryId, ')
          ..write('stepIndex: $stepIndex, ')
          ..write('type: $type, ')
          ..write('startSec: $startSec, ')
          ..write('durationSec: $durationSec, ')
          ..write('note: $note, ')
          ..write('waterG: $waterG, ')
          ..write('flowRateGPerSec: $flowRateGPerSec, ')
          ..write('pressureBar: $pressureBar, ')
          ..write('count: $count, ')
          ..write('tool: $tool, ')
          ..write('label: $label, ')
          ..write('jsonPayload: $jsonPayload')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    entryId,
    stepIndex,
    type,
    startSec,
    durationSec,
    note,
    waterG,
    flowRateGPerSec,
    pressureBar,
    count,
    tool,
    label,
    jsonPayload,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EntryStep &&
          other.id == this.id &&
          other.entryId == this.entryId &&
          other.stepIndex == this.stepIndex &&
          other.type == this.type &&
          other.startSec == this.startSec &&
          other.durationSec == this.durationSec &&
          other.note == this.note &&
          other.waterG == this.waterG &&
          other.flowRateGPerSec == this.flowRateGPerSec &&
          other.pressureBar == this.pressureBar &&
          other.count == this.count &&
          other.tool == this.tool &&
          other.label == this.label &&
          other.jsonPayload == this.jsonPayload);
}

class EntryStepsCompanion extends UpdateCompanion<EntryStep> {
  final Value<String> id;
  final Value<String> entryId;
  final Value<int> stepIndex;
  final Value<String> type;
  final Value<int?> startSec;
  final Value<int?> durationSec;
  final Value<String?> note;
  final Value<double?> waterG;
  final Value<double?> flowRateGPerSec;
  final Value<double?> pressureBar;
  final Value<int?> count;
  final Value<String?> tool;
  final Value<String?> label;
  final Value<String?> jsonPayload;
  final Value<int> rowid;
  const EntryStepsCompanion({
    this.id = const Value.absent(),
    this.entryId = const Value.absent(),
    this.stepIndex = const Value.absent(),
    this.type = const Value.absent(),
    this.startSec = const Value.absent(),
    this.durationSec = const Value.absent(),
    this.note = const Value.absent(),
    this.waterG = const Value.absent(),
    this.flowRateGPerSec = const Value.absent(),
    this.pressureBar = const Value.absent(),
    this.count = const Value.absent(),
    this.tool = const Value.absent(),
    this.label = const Value.absent(),
    this.jsonPayload = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EntryStepsCompanion.insert({
    required String id,
    required String entryId,
    required int stepIndex,
    required String type,
    this.startSec = const Value.absent(),
    this.durationSec = const Value.absent(),
    this.note = const Value.absent(),
    this.waterG = const Value.absent(),
    this.flowRateGPerSec = const Value.absent(),
    this.pressureBar = const Value.absent(),
    this.count = const Value.absent(),
    this.tool = const Value.absent(),
    this.label = const Value.absent(),
    this.jsonPayload = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       entryId = Value(entryId),
       stepIndex = Value(stepIndex),
       type = Value(type);
  static Insertable<EntryStep> custom({
    Expression<String>? id,
    Expression<String>? entryId,
    Expression<int>? stepIndex,
    Expression<String>? type,
    Expression<int>? startSec,
    Expression<int>? durationSec,
    Expression<String>? note,
    Expression<double>? waterG,
    Expression<double>? flowRateGPerSec,
    Expression<double>? pressureBar,
    Expression<int>? count,
    Expression<String>? tool,
    Expression<String>? label,
    Expression<String>? jsonPayload,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (entryId != null) 'entry_id': entryId,
      if (stepIndex != null) 'step_index': stepIndex,
      if (type != null) 'type': type,
      if (startSec != null) 'start_sec': startSec,
      if (durationSec != null) 'duration_sec': durationSec,
      if (note != null) 'note': note,
      if (waterG != null) 'water_g': waterG,
      if (flowRateGPerSec != null) 'flow_rate_g_per_sec': flowRateGPerSec,
      if (pressureBar != null) 'pressure_bar': pressureBar,
      if (count != null) 'count': count,
      if (tool != null) 'tool': tool,
      if (label != null) 'label': label,
      if (jsonPayload != null) 'json_payload': jsonPayload,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EntryStepsCompanion copyWith({
    Value<String>? id,
    Value<String>? entryId,
    Value<int>? stepIndex,
    Value<String>? type,
    Value<int?>? startSec,
    Value<int?>? durationSec,
    Value<String?>? note,
    Value<double?>? waterG,
    Value<double?>? flowRateGPerSec,
    Value<double?>? pressureBar,
    Value<int?>? count,
    Value<String?>? tool,
    Value<String?>? label,
    Value<String?>? jsonPayload,
    Value<int>? rowid,
  }) {
    return EntryStepsCompanion(
      id: id ?? this.id,
      entryId: entryId ?? this.entryId,
      stepIndex: stepIndex ?? this.stepIndex,
      type: type ?? this.type,
      startSec: startSec ?? this.startSec,
      durationSec: durationSec ?? this.durationSec,
      note: note ?? this.note,
      waterG: waterG ?? this.waterG,
      flowRateGPerSec: flowRateGPerSec ?? this.flowRateGPerSec,
      pressureBar: pressureBar ?? this.pressureBar,
      count: count ?? this.count,
      tool: tool ?? this.tool,
      label: label ?? this.label,
      jsonPayload: jsonPayload ?? this.jsonPayload,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (entryId.present) {
      map['entry_id'] = Variable<String>(entryId.value);
    }
    if (stepIndex.present) {
      map['step_index'] = Variable<int>(stepIndex.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (startSec.present) {
      map['start_sec'] = Variable<int>(startSec.value);
    }
    if (durationSec.present) {
      map['duration_sec'] = Variable<int>(durationSec.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (waterG.present) {
      map['water_g'] = Variable<double>(waterG.value);
    }
    if (flowRateGPerSec.present) {
      map['flow_rate_g_per_sec'] = Variable<double>(flowRateGPerSec.value);
    }
    if (pressureBar.present) {
      map['pressure_bar'] = Variable<double>(pressureBar.value);
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    if (tool.present) {
      map['tool'] = Variable<String>(tool.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (jsonPayload.present) {
      map['json_payload'] = Variable<String>(jsonPayload.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntryStepsCompanion(')
          ..write('id: $id, ')
          ..write('entryId: $entryId, ')
          ..write('stepIndex: $stepIndex, ')
          ..write('type: $type, ')
          ..write('startSec: $startSec, ')
          ..write('durationSec: $durationSec, ')
          ..write('note: $note, ')
          ..write('waterG: $waterG, ')
          ..write('flowRateGPerSec: $flowRateGPerSec, ')
          ..write('pressureBar: $pressureBar, ')
          ..write('count: $count, ')
          ..write('tool: $tool, ')
          ..write('label: $label, ')
          ..write('jsonPayload: $jsonPayload, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TemplatesTable extends Templates
    with TableInfo<$TemplatesTable, Template> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TemplatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
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
  static const VerificationMeta _scopeMeta = const VerificationMeta('scope');
  @override
  late final GeneratedColumn<String> scope = GeneratedColumn<String>(
    'scope',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _coffeeIdMeta = const VerificationMeta(
    'coffeeId',
  );
  @override
  late final GeneratedColumn<String> coffeeId = GeneratedColumn<String>(
    'coffee_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES coffees (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _brewMethodMeta = const VerificationMeta(
    'brewMethod',
  );
  @override
  late final GeneratedColumn<String> brewMethod = GeneratedColumn<String>(
    'brew_method',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _defaultCoffeeDoseGMeta =
      const VerificationMeta('defaultCoffeeDoseG');
  @override
  late final GeneratedColumn<double> defaultCoffeeDoseG =
      GeneratedColumn<double>(
        'default_coffee_dose_g',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _defaultWaterTotalGMeta =
      const VerificationMeta('defaultWaterTotalG');
  @override
  late final GeneratedColumn<double> defaultWaterTotalG =
      GeneratedColumn<double>(
        'default_water_total_g',
        aliasedName,
        true,
        type: DriftSqlType.double,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _searchTextMeta = const VerificationMeta(
    'searchText',
  );
  @override
  late final GeneratedColumn<String> searchText = GeneratedColumn<String>(
    'search_text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
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
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    scope,
    coffeeId,
    brewMethod,
    defaultCoffeeDoseG,
    defaultWaterTotalG,
    searchText,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'templates';
  @override
  VerificationContext validateIntegrity(
    Insertable<Template> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('scope')) {
      context.handle(
        _scopeMeta,
        scope.isAcceptableOrUnknown(data['scope']!, _scopeMeta),
      );
    } else if (isInserting) {
      context.missing(_scopeMeta);
    }
    if (data.containsKey('coffee_id')) {
      context.handle(
        _coffeeIdMeta,
        coffeeId.isAcceptableOrUnknown(data['coffee_id']!, _coffeeIdMeta),
      );
    }
    if (data.containsKey('brew_method')) {
      context.handle(
        _brewMethodMeta,
        brewMethod.isAcceptableOrUnknown(data['brew_method']!, _brewMethodMeta),
      );
    } else if (isInserting) {
      context.missing(_brewMethodMeta);
    }
    if (data.containsKey('default_coffee_dose_g')) {
      context.handle(
        _defaultCoffeeDoseGMeta,
        defaultCoffeeDoseG.isAcceptableOrUnknown(
          data['default_coffee_dose_g']!,
          _defaultCoffeeDoseGMeta,
        ),
      );
    }
    if (data.containsKey('default_water_total_g')) {
      context.handle(
        _defaultWaterTotalGMeta,
        defaultWaterTotalG.isAcceptableOrUnknown(
          data['default_water_total_g']!,
          _defaultWaterTotalGMeta,
        ),
      );
    }
    if (data.containsKey('search_text')) {
      context.handle(
        _searchTextMeta,
        searchText.isAcceptableOrUnknown(data['search_text']!, _searchTextMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Template map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Template(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      scope: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}scope'],
      )!,
      coffeeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}coffee_id'],
      ),
      brewMethod: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}brew_method'],
      )!,
      defaultCoffeeDoseG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}default_coffee_dose_g'],
      ),
      defaultWaterTotalG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}default_water_total_g'],
      ),
      searchText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}search_text'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $TemplatesTable createAlias(String alias) {
    return $TemplatesTable(attachedDatabase, alias);
  }
}

class Template extends DataClass implements Insertable<Template> {
  final String id;
  final String name;
  final String scope;
  final String? coffeeId;
  final String brewMethod;
  final double? defaultCoffeeDoseG;
  final double? defaultWaterTotalG;
  final String searchText;
  final DateTime createdAt;
  final DateTime updatedAt;
  const Template({
    required this.id,
    required this.name,
    required this.scope,
    this.coffeeId,
    required this.brewMethod,
    this.defaultCoffeeDoseG,
    this.defaultWaterTotalG,
    required this.searchText,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['scope'] = Variable<String>(scope);
    if (!nullToAbsent || coffeeId != null) {
      map['coffee_id'] = Variable<String>(coffeeId);
    }
    map['brew_method'] = Variable<String>(brewMethod);
    if (!nullToAbsent || defaultCoffeeDoseG != null) {
      map['default_coffee_dose_g'] = Variable<double>(defaultCoffeeDoseG);
    }
    if (!nullToAbsent || defaultWaterTotalG != null) {
      map['default_water_total_g'] = Variable<double>(defaultWaterTotalG);
    }
    map['search_text'] = Variable<String>(searchText);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  TemplatesCompanion toCompanion(bool nullToAbsent) {
    return TemplatesCompanion(
      id: Value(id),
      name: Value(name),
      scope: Value(scope),
      coffeeId: coffeeId == null && nullToAbsent
          ? const Value.absent()
          : Value(coffeeId),
      brewMethod: Value(brewMethod),
      defaultCoffeeDoseG: defaultCoffeeDoseG == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultCoffeeDoseG),
      defaultWaterTotalG: defaultWaterTotalG == null && nullToAbsent
          ? const Value.absent()
          : Value(defaultWaterTotalG),
      searchText: Value(searchText),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory Template.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Template(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      scope: serializer.fromJson<String>(json['scope']),
      coffeeId: serializer.fromJson<String?>(json['coffeeId']),
      brewMethod: serializer.fromJson<String>(json['brewMethod']),
      defaultCoffeeDoseG: serializer.fromJson<double?>(
        json['defaultCoffeeDoseG'],
      ),
      defaultWaterTotalG: serializer.fromJson<double?>(
        json['defaultWaterTotalG'],
      ),
      searchText: serializer.fromJson<String>(json['searchText']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'scope': serializer.toJson<String>(scope),
      'coffeeId': serializer.toJson<String?>(coffeeId),
      'brewMethod': serializer.toJson<String>(brewMethod),
      'defaultCoffeeDoseG': serializer.toJson<double?>(defaultCoffeeDoseG),
      'defaultWaterTotalG': serializer.toJson<double?>(defaultWaterTotalG),
      'searchText': serializer.toJson<String>(searchText),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  Template copyWith({
    String? id,
    String? name,
    String? scope,
    Value<String?> coffeeId = const Value.absent(),
    String? brewMethod,
    Value<double?> defaultCoffeeDoseG = const Value.absent(),
    Value<double?> defaultWaterTotalG = const Value.absent(),
    String? searchText,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => Template(
    id: id ?? this.id,
    name: name ?? this.name,
    scope: scope ?? this.scope,
    coffeeId: coffeeId.present ? coffeeId.value : this.coffeeId,
    brewMethod: brewMethod ?? this.brewMethod,
    defaultCoffeeDoseG: defaultCoffeeDoseG.present
        ? defaultCoffeeDoseG.value
        : this.defaultCoffeeDoseG,
    defaultWaterTotalG: defaultWaterTotalG.present
        ? defaultWaterTotalG.value
        : this.defaultWaterTotalG,
    searchText: searchText ?? this.searchText,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  Template copyWithCompanion(TemplatesCompanion data) {
    return Template(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      scope: data.scope.present ? data.scope.value : this.scope,
      coffeeId: data.coffeeId.present ? data.coffeeId.value : this.coffeeId,
      brewMethod: data.brewMethod.present
          ? data.brewMethod.value
          : this.brewMethod,
      defaultCoffeeDoseG: data.defaultCoffeeDoseG.present
          ? data.defaultCoffeeDoseG.value
          : this.defaultCoffeeDoseG,
      defaultWaterTotalG: data.defaultWaterTotalG.present
          ? data.defaultWaterTotalG.value
          : this.defaultWaterTotalG,
      searchText: data.searchText.present
          ? data.searchText.value
          : this.searchText,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Template(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('scope: $scope, ')
          ..write('coffeeId: $coffeeId, ')
          ..write('brewMethod: $brewMethod, ')
          ..write('defaultCoffeeDoseG: $defaultCoffeeDoseG, ')
          ..write('defaultWaterTotalG: $defaultWaterTotalG, ')
          ..write('searchText: $searchText, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    scope,
    coffeeId,
    brewMethod,
    defaultCoffeeDoseG,
    defaultWaterTotalG,
    searchText,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Template &&
          other.id == this.id &&
          other.name == this.name &&
          other.scope == this.scope &&
          other.coffeeId == this.coffeeId &&
          other.brewMethod == this.brewMethod &&
          other.defaultCoffeeDoseG == this.defaultCoffeeDoseG &&
          other.defaultWaterTotalG == this.defaultWaterTotalG &&
          other.searchText == this.searchText &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class TemplatesCompanion extends UpdateCompanion<Template> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> scope;
  final Value<String?> coffeeId;
  final Value<String> brewMethod;
  final Value<double?> defaultCoffeeDoseG;
  final Value<double?> defaultWaterTotalG;
  final Value<String> searchText;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const TemplatesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.scope = const Value.absent(),
    this.coffeeId = const Value.absent(),
    this.brewMethod = const Value.absent(),
    this.defaultCoffeeDoseG = const Value.absent(),
    this.defaultWaterTotalG = const Value.absent(),
    this.searchText = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TemplatesCompanion.insert({
    required String id,
    required String name,
    required String scope,
    this.coffeeId = const Value.absent(),
    required String brewMethod,
    this.defaultCoffeeDoseG = const Value.absent(),
    this.defaultWaterTotalG = const Value.absent(),
    this.searchText = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       scope = Value(scope),
       brewMethod = Value(brewMethod),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Template> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? scope,
    Expression<String>? coffeeId,
    Expression<String>? brewMethod,
    Expression<double>? defaultCoffeeDoseG,
    Expression<double>? defaultWaterTotalG,
    Expression<String>? searchText,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (scope != null) 'scope': scope,
      if (coffeeId != null) 'coffee_id': coffeeId,
      if (brewMethod != null) 'brew_method': brewMethod,
      if (defaultCoffeeDoseG != null)
        'default_coffee_dose_g': defaultCoffeeDoseG,
      if (defaultWaterTotalG != null)
        'default_water_total_g': defaultWaterTotalG,
      if (searchText != null) 'search_text': searchText,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TemplatesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? scope,
    Value<String?>? coffeeId,
    Value<String>? brewMethod,
    Value<double?>? defaultCoffeeDoseG,
    Value<double?>? defaultWaterTotalG,
    Value<String>? searchText,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return TemplatesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      scope: scope ?? this.scope,
      coffeeId: coffeeId ?? this.coffeeId,
      brewMethod: brewMethod ?? this.brewMethod,
      defaultCoffeeDoseG: defaultCoffeeDoseG ?? this.defaultCoffeeDoseG,
      defaultWaterTotalG: defaultWaterTotalG ?? this.defaultWaterTotalG,
      searchText: searchText ?? this.searchText,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (scope.present) {
      map['scope'] = Variable<String>(scope.value);
    }
    if (coffeeId.present) {
      map['coffee_id'] = Variable<String>(coffeeId.value);
    }
    if (brewMethod.present) {
      map['brew_method'] = Variable<String>(brewMethod.value);
    }
    if (defaultCoffeeDoseG.present) {
      map['default_coffee_dose_g'] = Variable<double>(defaultCoffeeDoseG.value);
    }
    if (defaultWaterTotalG.present) {
      map['default_water_total_g'] = Variable<double>(defaultWaterTotalG.value);
    }
    if (searchText.present) {
      map['search_text'] = Variable<String>(searchText.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TemplatesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('scope: $scope, ')
          ..write('coffeeId: $coffeeId, ')
          ..write('brewMethod: $brewMethod, ')
          ..write('defaultCoffeeDoseG: $defaultCoffeeDoseG, ')
          ..write('defaultWaterTotalG: $defaultWaterTotalG, ')
          ..write('searchText: $searchText, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TemplateStepsTable extends TemplateSteps
    with TableInfo<$TemplateStepsTable, TemplateStep> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TemplateStepsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _templateIdMeta = const VerificationMeta(
    'templateId',
  );
  @override
  late final GeneratedColumn<String> templateId = GeneratedColumn<String>(
    'template_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES templates (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _stepIndexMeta = const VerificationMeta(
    'stepIndex',
  );
  @override
  late final GeneratedColumn<int> stepIndex = GeneratedColumn<int>(
    'step_index',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startSecMeta = const VerificationMeta(
    'startSec',
  );
  @override
  late final GeneratedColumn<int> startSec = GeneratedColumn<int>(
    'start_sec',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationSecMeta = const VerificationMeta(
    'durationSec',
  );
  @override
  late final GeneratedColumn<int> durationSec = GeneratedColumn<int>(
    'duration_sec',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _waterGMeta = const VerificationMeta('waterG');
  @override
  late final GeneratedColumn<double> waterG = GeneratedColumn<double>(
    'water_g',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _flowRateGPerSecMeta = const VerificationMeta(
    'flowRateGPerSec',
  );
  @override
  late final GeneratedColumn<double> flowRateGPerSec = GeneratedColumn<double>(
    'flow_rate_g_per_sec',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _pressureBarMeta = const VerificationMeta(
    'pressureBar',
  );
  @override
  late final GeneratedColumn<double> pressureBar = GeneratedColumn<double>(
    'pressure_bar',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _countMeta = const VerificationMeta('count');
  @override
  late final GeneratedColumn<int> count = GeneratedColumn<int>(
    'count',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _toolMeta = const VerificationMeta('tool');
  @override
  late final GeneratedColumn<String> tool = GeneratedColumn<String>(
    'tool',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _jsonPayloadMeta = const VerificationMeta(
    'jsonPayload',
  );
  @override
  late final GeneratedColumn<String> jsonPayload = GeneratedColumn<String>(
    'json_payload',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    templateId,
    stepIndex,
    type,
    startSec,
    durationSec,
    note,
    waterG,
    flowRateGPerSec,
    pressureBar,
    count,
    tool,
    label,
    jsonPayload,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'template_steps';
  @override
  VerificationContext validateIntegrity(
    Insertable<TemplateStep> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('template_id')) {
      context.handle(
        _templateIdMeta,
        templateId.isAcceptableOrUnknown(data['template_id']!, _templateIdMeta),
      );
    } else if (isInserting) {
      context.missing(_templateIdMeta);
    }
    if (data.containsKey('step_index')) {
      context.handle(
        _stepIndexMeta,
        stepIndex.isAcceptableOrUnknown(data['step_index']!, _stepIndexMeta),
      );
    } else if (isInserting) {
      context.missing(_stepIndexMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('start_sec')) {
      context.handle(
        _startSecMeta,
        startSec.isAcceptableOrUnknown(data['start_sec']!, _startSecMeta),
      );
    }
    if (data.containsKey('duration_sec')) {
      context.handle(
        _durationSecMeta,
        durationSec.isAcceptableOrUnknown(
          data['duration_sec']!,
          _durationSecMeta,
        ),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('water_g')) {
      context.handle(
        _waterGMeta,
        waterG.isAcceptableOrUnknown(data['water_g']!, _waterGMeta),
      );
    }
    if (data.containsKey('flow_rate_g_per_sec')) {
      context.handle(
        _flowRateGPerSecMeta,
        flowRateGPerSec.isAcceptableOrUnknown(
          data['flow_rate_g_per_sec']!,
          _flowRateGPerSecMeta,
        ),
      );
    }
    if (data.containsKey('pressure_bar')) {
      context.handle(
        _pressureBarMeta,
        pressureBar.isAcceptableOrUnknown(
          data['pressure_bar']!,
          _pressureBarMeta,
        ),
      );
    }
    if (data.containsKey('count')) {
      context.handle(
        _countMeta,
        count.isAcceptableOrUnknown(data['count']!, _countMeta),
      );
    }
    if (data.containsKey('tool')) {
      context.handle(
        _toolMeta,
        tool.isAcceptableOrUnknown(data['tool']!, _toolMeta),
      );
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    }
    if (data.containsKey('json_payload')) {
      context.handle(
        _jsonPayloadMeta,
        jsonPayload.isAcceptableOrUnknown(
          data['json_payload']!,
          _jsonPayloadMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TemplateStep map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TemplateStep(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      templateId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_id'],
      )!,
      stepIndex: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}step_index'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      startSec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}start_sec'],
      ),
      durationSec: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_sec'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      waterG: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}water_g'],
      ),
      flowRateGPerSec: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}flow_rate_g_per_sec'],
      ),
      pressureBar: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pressure_bar'],
      ),
      count: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}count'],
      ),
      tool: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tool'],
      ),
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      ),
      jsonPayload: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}json_payload'],
      ),
    );
  }

  @override
  $TemplateStepsTable createAlias(String alias) {
    return $TemplateStepsTable(attachedDatabase, alias);
  }
}

class TemplateStep extends DataClass implements Insertable<TemplateStep> {
  final String id;
  final String templateId;
  final int stepIndex;
  final String type;
  final int? startSec;
  final int? durationSec;
  final String? note;
  final double? waterG;
  final double? flowRateGPerSec;
  final double? pressureBar;
  final int? count;
  final String? tool;
  final String? label;
  final String? jsonPayload;
  const TemplateStep({
    required this.id,
    required this.templateId,
    required this.stepIndex,
    required this.type,
    this.startSec,
    this.durationSec,
    this.note,
    this.waterG,
    this.flowRateGPerSec,
    this.pressureBar,
    this.count,
    this.tool,
    this.label,
    this.jsonPayload,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['template_id'] = Variable<String>(templateId);
    map['step_index'] = Variable<int>(stepIndex);
    map['type'] = Variable<String>(type);
    if (!nullToAbsent || startSec != null) {
      map['start_sec'] = Variable<int>(startSec);
    }
    if (!nullToAbsent || durationSec != null) {
      map['duration_sec'] = Variable<int>(durationSec);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || waterG != null) {
      map['water_g'] = Variable<double>(waterG);
    }
    if (!nullToAbsent || flowRateGPerSec != null) {
      map['flow_rate_g_per_sec'] = Variable<double>(flowRateGPerSec);
    }
    if (!nullToAbsent || pressureBar != null) {
      map['pressure_bar'] = Variable<double>(pressureBar);
    }
    if (!nullToAbsent || count != null) {
      map['count'] = Variable<int>(count);
    }
    if (!nullToAbsent || tool != null) {
      map['tool'] = Variable<String>(tool);
    }
    if (!nullToAbsent || label != null) {
      map['label'] = Variable<String>(label);
    }
    if (!nullToAbsent || jsonPayload != null) {
      map['json_payload'] = Variable<String>(jsonPayload);
    }
    return map;
  }

  TemplateStepsCompanion toCompanion(bool nullToAbsent) {
    return TemplateStepsCompanion(
      id: Value(id),
      templateId: Value(templateId),
      stepIndex: Value(stepIndex),
      type: Value(type),
      startSec: startSec == null && nullToAbsent
          ? const Value.absent()
          : Value(startSec),
      durationSec: durationSec == null && nullToAbsent
          ? const Value.absent()
          : Value(durationSec),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      waterG: waterG == null && nullToAbsent
          ? const Value.absent()
          : Value(waterG),
      flowRateGPerSec: flowRateGPerSec == null && nullToAbsent
          ? const Value.absent()
          : Value(flowRateGPerSec),
      pressureBar: pressureBar == null && nullToAbsent
          ? const Value.absent()
          : Value(pressureBar),
      count: count == null && nullToAbsent
          ? const Value.absent()
          : Value(count),
      tool: tool == null && nullToAbsent ? const Value.absent() : Value(tool),
      label: label == null && nullToAbsent
          ? const Value.absent()
          : Value(label),
      jsonPayload: jsonPayload == null && nullToAbsent
          ? const Value.absent()
          : Value(jsonPayload),
    );
  }

  factory TemplateStep.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TemplateStep(
      id: serializer.fromJson<String>(json['id']),
      templateId: serializer.fromJson<String>(json['templateId']),
      stepIndex: serializer.fromJson<int>(json['stepIndex']),
      type: serializer.fromJson<String>(json['type']),
      startSec: serializer.fromJson<int?>(json['startSec']),
      durationSec: serializer.fromJson<int?>(json['durationSec']),
      note: serializer.fromJson<String?>(json['note']),
      waterG: serializer.fromJson<double?>(json['waterG']),
      flowRateGPerSec: serializer.fromJson<double?>(json['flowRateGPerSec']),
      pressureBar: serializer.fromJson<double?>(json['pressureBar']),
      count: serializer.fromJson<int?>(json['count']),
      tool: serializer.fromJson<String?>(json['tool']),
      label: serializer.fromJson<String?>(json['label']),
      jsonPayload: serializer.fromJson<String?>(json['jsonPayload']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'templateId': serializer.toJson<String>(templateId),
      'stepIndex': serializer.toJson<int>(stepIndex),
      'type': serializer.toJson<String>(type),
      'startSec': serializer.toJson<int?>(startSec),
      'durationSec': serializer.toJson<int?>(durationSec),
      'note': serializer.toJson<String?>(note),
      'waterG': serializer.toJson<double?>(waterG),
      'flowRateGPerSec': serializer.toJson<double?>(flowRateGPerSec),
      'pressureBar': serializer.toJson<double?>(pressureBar),
      'count': serializer.toJson<int?>(count),
      'tool': serializer.toJson<String?>(tool),
      'label': serializer.toJson<String?>(label),
      'jsonPayload': serializer.toJson<String?>(jsonPayload),
    };
  }

  TemplateStep copyWith({
    String? id,
    String? templateId,
    int? stepIndex,
    String? type,
    Value<int?> startSec = const Value.absent(),
    Value<int?> durationSec = const Value.absent(),
    Value<String?> note = const Value.absent(),
    Value<double?> waterG = const Value.absent(),
    Value<double?> flowRateGPerSec = const Value.absent(),
    Value<double?> pressureBar = const Value.absent(),
    Value<int?> count = const Value.absent(),
    Value<String?> tool = const Value.absent(),
    Value<String?> label = const Value.absent(),
    Value<String?> jsonPayload = const Value.absent(),
  }) => TemplateStep(
    id: id ?? this.id,
    templateId: templateId ?? this.templateId,
    stepIndex: stepIndex ?? this.stepIndex,
    type: type ?? this.type,
    startSec: startSec.present ? startSec.value : this.startSec,
    durationSec: durationSec.present ? durationSec.value : this.durationSec,
    note: note.present ? note.value : this.note,
    waterG: waterG.present ? waterG.value : this.waterG,
    flowRateGPerSec: flowRateGPerSec.present
        ? flowRateGPerSec.value
        : this.flowRateGPerSec,
    pressureBar: pressureBar.present ? pressureBar.value : this.pressureBar,
    count: count.present ? count.value : this.count,
    tool: tool.present ? tool.value : this.tool,
    label: label.present ? label.value : this.label,
    jsonPayload: jsonPayload.present ? jsonPayload.value : this.jsonPayload,
  );
  TemplateStep copyWithCompanion(TemplateStepsCompanion data) {
    return TemplateStep(
      id: data.id.present ? data.id.value : this.id,
      templateId: data.templateId.present
          ? data.templateId.value
          : this.templateId,
      stepIndex: data.stepIndex.present ? data.stepIndex.value : this.stepIndex,
      type: data.type.present ? data.type.value : this.type,
      startSec: data.startSec.present ? data.startSec.value : this.startSec,
      durationSec: data.durationSec.present
          ? data.durationSec.value
          : this.durationSec,
      note: data.note.present ? data.note.value : this.note,
      waterG: data.waterG.present ? data.waterG.value : this.waterG,
      flowRateGPerSec: data.flowRateGPerSec.present
          ? data.flowRateGPerSec.value
          : this.flowRateGPerSec,
      pressureBar: data.pressureBar.present
          ? data.pressureBar.value
          : this.pressureBar,
      count: data.count.present ? data.count.value : this.count,
      tool: data.tool.present ? data.tool.value : this.tool,
      label: data.label.present ? data.label.value : this.label,
      jsonPayload: data.jsonPayload.present
          ? data.jsonPayload.value
          : this.jsonPayload,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TemplateStep(')
          ..write('id: $id, ')
          ..write('templateId: $templateId, ')
          ..write('stepIndex: $stepIndex, ')
          ..write('type: $type, ')
          ..write('startSec: $startSec, ')
          ..write('durationSec: $durationSec, ')
          ..write('note: $note, ')
          ..write('waterG: $waterG, ')
          ..write('flowRateGPerSec: $flowRateGPerSec, ')
          ..write('pressureBar: $pressureBar, ')
          ..write('count: $count, ')
          ..write('tool: $tool, ')
          ..write('label: $label, ')
          ..write('jsonPayload: $jsonPayload')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    templateId,
    stepIndex,
    type,
    startSec,
    durationSec,
    note,
    waterG,
    flowRateGPerSec,
    pressureBar,
    count,
    tool,
    label,
    jsonPayload,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TemplateStep &&
          other.id == this.id &&
          other.templateId == this.templateId &&
          other.stepIndex == this.stepIndex &&
          other.type == this.type &&
          other.startSec == this.startSec &&
          other.durationSec == this.durationSec &&
          other.note == this.note &&
          other.waterG == this.waterG &&
          other.flowRateGPerSec == this.flowRateGPerSec &&
          other.pressureBar == this.pressureBar &&
          other.count == this.count &&
          other.tool == this.tool &&
          other.label == this.label &&
          other.jsonPayload == this.jsonPayload);
}

class TemplateStepsCompanion extends UpdateCompanion<TemplateStep> {
  final Value<String> id;
  final Value<String> templateId;
  final Value<int> stepIndex;
  final Value<String> type;
  final Value<int?> startSec;
  final Value<int?> durationSec;
  final Value<String?> note;
  final Value<double?> waterG;
  final Value<double?> flowRateGPerSec;
  final Value<double?> pressureBar;
  final Value<int?> count;
  final Value<String?> tool;
  final Value<String?> label;
  final Value<String?> jsonPayload;
  final Value<int> rowid;
  const TemplateStepsCompanion({
    this.id = const Value.absent(),
    this.templateId = const Value.absent(),
    this.stepIndex = const Value.absent(),
    this.type = const Value.absent(),
    this.startSec = const Value.absent(),
    this.durationSec = const Value.absent(),
    this.note = const Value.absent(),
    this.waterG = const Value.absent(),
    this.flowRateGPerSec = const Value.absent(),
    this.pressureBar = const Value.absent(),
    this.count = const Value.absent(),
    this.tool = const Value.absent(),
    this.label = const Value.absent(),
    this.jsonPayload = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TemplateStepsCompanion.insert({
    required String id,
    required String templateId,
    required int stepIndex,
    required String type,
    this.startSec = const Value.absent(),
    this.durationSec = const Value.absent(),
    this.note = const Value.absent(),
    this.waterG = const Value.absent(),
    this.flowRateGPerSec = const Value.absent(),
    this.pressureBar = const Value.absent(),
    this.count = const Value.absent(),
    this.tool = const Value.absent(),
    this.label = const Value.absent(),
    this.jsonPayload = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       templateId = Value(templateId),
       stepIndex = Value(stepIndex),
       type = Value(type);
  static Insertable<TemplateStep> custom({
    Expression<String>? id,
    Expression<String>? templateId,
    Expression<int>? stepIndex,
    Expression<String>? type,
    Expression<int>? startSec,
    Expression<int>? durationSec,
    Expression<String>? note,
    Expression<double>? waterG,
    Expression<double>? flowRateGPerSec,
    Expression<double>? pressureBar,
    Expression<int>? count,
    Expression<String>? tool,
    Expression<String>? label,
    Expression<String>? jsonPayload,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (templateId != null) 'template_id': templateId,
      if (stepIndex != null) 'step_index': stepIndex,
      if (type != null) 'type': type,
      if (startSec != null) 'start_sec': startSec,
      if (durationSec != null) 'duration_sec': durationSec,
      if (note != null) 'note': note,
      if (waterG != null) 'water_g': waterG,
      if (flowRateGPerSec != null) 'flow_rate_g_per_sec': flowRateGPerSec,
      if (pressureBar != null) 'pressure_bar': pressureBar,
      if (count != null) 'count': count,
      if (tool != null) 'tool': tool,
      if (label != null) 'label': label,
      if (jsonPayload != null) 'json_payload': jsonPayload,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TemplateStepsCompanion copyWith({
    Value<String>? id,
    Value<String>? templateId,
    Value<int>? stepIndex,
    Value<String>? type,
    Value<int?>? startSec,
    Value<int?>? durationSec,
    Value<String?>? note,
    Value<double?>? waterG,
    Value<double?>? flowRateGPerSec,
    Value<double?>? pressureBar,
    Value<int?>? count,
    Value<String?>? tool,
    Value<String?>? label,
    Value<String?>? jsonPayload,
    Value<int>? rowid,
  }) {
    return TemplateStepsCompanion(
      id: id ?? this.id,
      templateId: templateId ?? this.templateId,
      stepIndex: stepIndex ?? this.stepIndex,
      type: type ?? this.type,
      startSec: startSec ?? this.startSec,
      durationSec: durationSec ?? this.durationSec,
      note: note ?? this.note,
      waterG: waterG ?? this.waterG,
      flowRateGPerSec: flowRateGPerSec ?? this.flowRateGPerSec,
      pressureBar: pressureBar ?? this.pressureBar,
      count: count ?? this.count,
      tool: tool ?? this.tool,
      label: label ?? this.label,
      jsonPayload: jsonPayload ?? this.jsonPayload,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (templateId.present) {
      map['template_id'] = Variable<String>(templateId.value);
    }
    if (stepIndex.present) {
      map['step_index'] = Variable<int>(stepIndex.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (startSec.present) {
      map['start_sec'] = Variable<int>(startSec.value);
    }
    if (durationSec.present) {
      map['duration_sec'] = Variable<int>(durationSec.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (waterG.present) {
      map['water_g'] = Variable<double>(waterG.value);
    }
    if (flowRateGPerSec.present) {
      map['flow_rate_g_per_sec'] = Variable<double>(flowRateGPerSec.value);
    }
    if (pressureBar.present) {
      map['pressure_bar'] = Variable<double>(pressureBar.value);
    }
    if (count.present) {
      map['count'] = Variable<int>(count.value);
    }
    if (tool.present) {
      map['tool'] = Variable<String>(tool.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (jsonPayload.present) {
      map['json_payload'] = Variable<String>(jsonPayload.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TemplateStepsCompanion(')
          ..write('id: $id, ')
          ..write('templateId: $templateId, ')
          ..write('stepIndex: $stepIndex, ')
          ..write('type: $type, ')
          ..write('startSec: $startSec, ')
          ..write('durationSec: $durationSec, ')
          ..write('note: $note, ')
          ..write('waterG: $waterG, ')
          ..write('flowRateGPerSec: $flowRateGPerSec, ')
          ..write('pressureBar: $pressureBar, ')
          ..write('count: $count, ')
          ..write('tool: $tool, ')
          ..write('label: $label, ')
          ..write('jsonPayload: $jsonPayload, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, Tag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
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
  static const VerificationMeta _normalizedNameMeta = const VerificationMeta(
    'normalizedName',
  );
  @override
  late final GeneratedColumn<String> normalizedName = GeneratedColumn<String>(
    'normalized_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _usageCountMeta = const VerificationMeta(
    'usageCount',
  );
  @override
  late final GeneratedColumn<int> usageCount = GeneratedColumn<int>(
    'usage_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, normalizedName, usageCount];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('normalized_name')) {
      context.handle(
        _normalizedNameMeta,
        normalizedName.isAcceptableOrUnknown(
          data['normalized_name']!,
          _normalizedNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_normalizedNameMeta);
    }
    if (data.containsKey('usage_count')) {
      context.handle(
        _usageCountMeta,
        usageCount.isAcceptableOrUnknown(data['usage_count']!, _usageCountMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tag(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      normalizedName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}normalized_name'],
      )!,
      usageCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}usage_count'],
      )!,
    );
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(attachedDatabase, alias);
  }
}

class Tag extends DataClass implements Insertable<Tag> {
  final String id;
  final String name;
  final String normalizedName;
  final int usageCount;
  const Tag({
    required this.id,
    required this.name,
    required this.normalizedName,
    required this.usageCount,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['normalized_name'] = Variable<String>(normalizedName);
    map['usage_count'] = Variable<int>(usageCount);
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      id: Value(id),
      name: Value(name),
      normalizedName: Value(normalizedName),
      usageCount: Value(usageCount),
    );
  }

  factory Tag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tag(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      normalizedName: serializer.fromJson<String>(json['normalizedName']),
      usageCount: serializer.fromJson<int>(json['usageCount']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'normalizedName': serializer.toJson<String>(normalizedName),
      'usageCount': serializer.toJson<int>(usageCount),
    };
  }

  Tag copyWith({
    String? id,
    String? name,
    String? normalizedName,
    int? usageCount,
  }) => Tag(
    id: id ?? this.id,
    name: name ?? this.name,
    normalizedName: normalizedName ?? this.normalizedName,
    usageCount: usageCount ?? this.usageCount,
  );
  Tag copyWithCompanion(TagsCompanion data) {
    return Tag(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      normalizedName: data.normalizedName.present
          ? data.normalizedName.value
          : this.normalizedName,
      usageCount: data.usageCount.present
          ? data.usageCount.value
          : this.usageCount,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tag(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('normalizedName: $normalizedName, ')
          ..write('usageCount: $usageCount')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, normalizedName, usageCount);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tag &&
          other.id == this.id &&
          other.name == this.name &&
          other.normalizedName == this.normalizedName &&
          other.usageCount == this.usageCount);
}

class TagsCompanion extends UpdateCompanion<Tag> {
  final Value<String> id;
  final Value<String> name;
  final Value<String> normalizedName;
  final Value<int> usageCount;
  final Value<int> rowid;
  const TagsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.normalizedName = const Value.absent(),
    this.usageCount = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TagsCompanion.insert({
    required String id,
    required String name,
    required String normalizedName,
    this.usageCount = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       normalizedName = Value(normalizedName);
  static Insertable<Tag> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? normalizedName,
    Expression<int>? usageCount,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (normalizedName != null) 'normalized_name': normalizedName,
      if (usageCount != null) 'usage_count': usageCount,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TagsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String>? normalizedName,
    Value<int>? usageCount,
    Value<int>? rowid,
  }) {
    return TagsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      normalizedName: normalizedName ?? this.normalizedName,
      usageCount: usageCount ?? this.usageCount,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (normalizedName.present) {
      map['normalized_name'] = Variable<String>(normalizedName.value);
    }
    if (usageCount.present) {
      map['usage_count'] = Variable<int>(usageCount.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('normalizedName: $normalizedName, ')
          ..write('usageCount: $usageCount, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CoffeeTagsTable extends CoffeeTags
    with TableInfo<$CoffeeTagsTable, CoffeeTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CoffeeTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _coffeeIdMeta = const VerificationMeta(
    'coffeeId',
  );
  @override
  late final GeneratedColumn<String> coffeeId = GeneratedColumn<String>(
    'coffee_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES coffees (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<String> tagId = GeneratedColumn<String>(
    'tag_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tags (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [coffeeId, tagId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'coffee_tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<CoffeeTag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('coffee_id')) {
      context.handle(
        _coffeeIdMeta,
        coffeeId.isAcceptableOrUnknown(data['coffee_id']!, _coffeeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_coffeeIdMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
        _tagIdMeta,
        tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {coffeeId, tagId};
  @override
  CoffeeTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CoffeeTag(
      coffeeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}coffee_id'],
      )!,
      tagId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tag_id'],
      )!,
    );
  }

  @override
  $CoffeeTagsTable createAlias(String alias) {
    return $CoffeeTagsTable(attachedDatabase, alias);
  }
}

class CoffeeTag extends DataClass implements Insertable<CoffeeTag> {
  final String coffeeId;
  final String tagId;
  const CoffeeTag({required this.coffeeId, required this.tagId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['coffee_id'] = Variable<String>(coffeeId);
    map['tag_id'] = Variable<String>(tagId);
    return map;
  }

  CoffeeTagsCompanion toCompanion(bool nullToAbsent) {
    return CoffeeTagsCompanion(coffeeId: Value(coffeeId), tagId: Value(tagId));
  }

  factory CoffeeTag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CoffeeTag(
      coffeeId: serializer.fromJson<String>(json['coffeeId']),
      tagId: serializer.fromJson<String>(json['tagId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'coffeeId': serializer.toJson<String>(coffeeId),
      'tagId': serializer.toJson<String>(tagId),
    };
  }

  CoffeeTag copyWith({String? coffeeId, String? tagId}) => CoffeeTag(
    coffeeId: coffeeId ?? this.coffeeId,
    tagId: tagId ?? this.tagId,
  );
  CoffeeTag copyWithCompanion(CoffeeTagsCompanion data) {
    return CoffeeTag(
      coffeeId: data.coffeeId.present ? data.coffeeId.value : this.coffeeId,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CoffeeTag(')
          ..write('coffeeId: $coffeeId, ')
          ..write('tagId: $tagId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(coffeeId, tagId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CoffeeTag &&
          other.coffeeId == this.coffeeId &&
          other.tagId == this.tagId);
}

class CoffeeTagsCompanion extends UpdateCompanion<CoffeeTag> {
  final Value<String> coffeeId;
  final Value<String> tagId;
  final Value<int> rowid;
  const CoffeeTagsCompanion({
    this.coffeeId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CoffeeTagsCompanion.insert({
    required String coffeeId,
    required String tagId,
    this.rowid = const Value.absent(),
  }) : coffeeId = Value(coffeeId),
       tagId = Value(tagId);
  static Insertable<CoffeeTag> custom({
    Expression<String>? coffeeId,
    Expression<String>? tagId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (coffeeId != null) 'coffee_id': coffeeId,
      if (tagId != null) 'tag_id': tagId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CoffeeTagsCompanion copyWith({
    Value<String>? coffeeId,
    Value<String>? tagId,
    Value<int>? rowid,
  }) {
    return CoffeeTagsCompanion(
      coffeeId: coffeeId ?? this.coffeeId,
      tagId: tagId ?? this.tagId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (coffeeId.present) {
      map['coffee_id'] = Variable<String>(coffeeId.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<String>(tagId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CoffeeTagsCompanion(')
          ..write('coffeeId: $coffeeId, ')
          ..write('tagId: $tagId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EntryTagsTable extends EntryTags
    with TableInfo<$EntryTagsTable, EntryTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EntryTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _entryIdMeta = const VerificationMeta(
    'entryId',
  );
  @override
  late final GeneratedColumn<String> entryId = GeneratedColumn<String>(
    'entry_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES entries (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<String> tagId = GeneratedColumn<String>(
    'tag_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tags (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [entryId, tagId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'entry_tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<EntryTag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('entry_id')) {
      context.handle(
        _entryIdMeta,
        entryId.isAcceptableOrUnknown(data['entry_id']!, _entryIdMeta),
      );
    } else if (isInserting) {
      context.missing(_entryIdMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
        _tagIdMeta,
        tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {entryId, tagId};
  @override
  EntryTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EntryTag(
      entryId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entry_id'],
      )!,
      tagId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tag_id'],
      )!,
    );
  }

  @override
  $EntryTagsTable createAlias(String alias) {
    return $EntryTagsTable(attachedDatabase, alias);
  }
}

class EntryTag extends DataClass implements Insertable<EntryTag> {
  final String entryId;
  final String tagId;
  const EntryTag({required this.entryId, required this.tagId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['entry_id'] = Variable<String>(entryId);
    map['tag_id'] = Variable<String>(tagId);
    return map;
  }

  EntryTagsCompanion toCompanion(bool nullToAbsent) {
    return EntryTagsCompanion(entryId: Value(entryId), tagId: Value(tagId));
  }

  factory EntryTag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EntryTag(
      entryId: serializer.fromJson<String>(json['entryId']),
      tagId: serializer.fromJson<String>(json['tagId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'entryId': serializer.toJson<String>(entryId),
      'tagId': serializer.toJson<String>(tagId),
    };
  }

  EntryTag copyWith({String? entryId, String? tagId}) =>
      EntryTag(entryId: entryId ?? this.entryId, tagId: tagId ?? this.tagId);
  EntryTag copyWithCompanion(EntryTagsCompanion data) {
    return EntryTag(
      entryId: data.entryId.present ? data.entryId.value : this.entryId,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EntryTag(')
          ..write('entryId: $entryId, ')
          ..write('tagId: $tagId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(entryId, tagId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EntryTag &&
          other.entryId == this.entryId &&
          other.tagId == this.tagId);
}

class EntryTagsCompanion extends UpdateCompanion<EntryTag> {
  final Value<String> entryId;
  final Value<String> tagId;
  final Value<int> rowid;
  const EntryTagsCompanion({
    this.entryId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EntryTagsCompanion.insert({
    required String entryId,
    required String tagId,
    this.rowid = const Value.absent(),
  }) : entryId = Value(entryId),
       tagId = Value(tagId);
  static Insertable<EntryTag> custom({
    Expression<String>? entryId,
    Expression<String>? tagId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (entryId != null) 'entry_id': entryId,
      if (tagId != null) 'tag_id': tagId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EntryTagsCompanion copyWith({
    Value<String>? entryId,
    Value<String>? tagId,
    Value<int>? rowid,
  }) {
    return EntryTagsCompanion(
      entryId: entryId ?? this.entryId,
      tagId: tagId ?? this.tagId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (entryId.present) {
      map['entry_id'] = Variable<String>(entryId.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<String>(tagId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EntryTagsCompanion(')
          ..write('entryId: $entryId, ')
          ..write('tagId: $tagId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TemplateTagsTable extends TemplateTags
    with TableInfo<$TemplateTagsTable, TemplateTag> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TemplateTagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _templateIdMeta = const VerificationMeta(
    'templateId',
  );
  @override
  late final GeneratedColumn<String> templateId = GeneratedColumn<String>(
    'template_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES templates (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<String> tagId = GeneratedColumn<String>(
    'tag_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tags (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [templateId, tagId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'template_tags';
  @override
  VerificationContext validateIntegrity(
    Insertable<TemplateTag> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('template_id')) {
      context.handle(
        _templateIdMeta,
        templateId.isAcceptableOrUnknown(data['template_id']!, _templateIdMeta),
      );
    } else if (isInserting) {
      context.missing(_templateIdMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
        _tagIdMeta,
        tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta),
      );
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {templateId, tagId};
  @override
  TemplateTag map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TemplateTag(
      templateId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_id'],
      )!,
      tagId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tag_id'],
      )!,
    );
  }

  @override
  $TemplateTagsTable createAlias(String alias) {
    return $TemplateTagsTable(attachedDatabase, alias);
  }
}

class TemplateTag extends DataClass implements Insertable<TemplateTag> {
  final String templateId;
  final String tagId;
  const TemplateTag({required this.templateId, required this.tagId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['template_id'] = Variable<String>(templateId);
    map['tag_id'] = Variable<String>(tagId);
    return map;
  }

  TemplateTagsCompanion toCompanion(bool nullToAbsent) {
    return TemplateTagsCompanion(
      templateId: Value(templateId),
      tagId: Value(tagId),
    );
  }

  factory TemplateTag.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TemplateTag(
      templateId: serializer.fromJson<String>(json['templateId']),
      tagId: serializer.fromJson<String>(json['tagId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'templateId': serializer.toJson<String>(templateId),
      'tagId': serializer.toJson<String>(tagId),
    };
  }

  TemplateTag copyWith({String? templateId, String? tagId}) => TemplateTag(
    templateId: templateId ?? this.templateId,
    tagId: tagId ?? this.tagId,
  );
  TemplateTag copyWithCompanion(TemplateTagsCompanion data) {
    return TemplateTag(
      templateId: data.templateId.present
          ? data.templateId.value
          : this.templateId,
      tagId: data.tagId.present ? data.tagId.value : this.tagId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TemplateTag(')
          ..write('templateId: $templateId, ')
          ..write('tagId: $tagId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(templateId, tagId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TemplateTag &&
          other.templateId == this.templateId &&
          other.tagId == this.tagId);
}

class TemplateTagsCompanion extends UpdateCompanion<TemplateTag> {
  final Value<String> templateId;
  final Value<String> tagId;
  final Value<int> rowid;
  const TemplateTagsCompanion({
    this.templateId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TemplateTagsCompanion.insert({
    required String templateId,
    required String tagId,
    this.rowid = const Value.absent(),
  }) : templateId = Value(templateId),
       tagId = Value(tagId);
  static Insertable<TemplateTag> custom({
    Expression<String>? templateId,
    Expression<String>? tagId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (templateId != null) 'template_id': templateId,
      if (tagId != null) 'tag_id': tagId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TemplateTagsCompanion copyWith({
    Value<String>? templateId,
    Value<String>? tagId,
    Value<int>? rowid,
  }) {
    return TemplateTagsCompanion(
      templateId: templateId ?? this.templateId,
      tagId: tagId ?? this.tagId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (templateId.present) {
      map['template_id'] = Variable<String>(templateId.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<String>(tagId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TemplateTagsCompanion(')
          ..write('templateId: $templateId, ')
          ..write('tagId: $tagId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final String key;
  final String value;
  const AppSetting({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(key: Value(key), value: Value(value));
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  AppSetting copyWith({String? key, String? value}) =>
      AppSetting(key: key ?? this.key, value: value ?? this.value);
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.key == this.key &&
          other.value == this.value);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<AppSetting> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return AppSettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $BrewMethodsTable extends BrewMethods
    with TableInfo<$BrewMethodsTable, BrewMethod> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $BrewMethodsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_active" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
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
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    name,
    sortOrder,
    isActive,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'brew_methods';
  @override
  VerificationContext validateIntegrity(
    Insertable<BrewMethod> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    } else if (isInserting) {
      context.missing(_sortOrderMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {name};
  @override
  BrewMethod map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return BrewMethod(
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      isActive: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_active'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $BrewMethodsTable createAlias(String alias) {
    return $BrewMethodsTable(attachedDatabase, alias);
  }
}

class BrewMethod extends DataClass implements Insertable<BrewMethod> {
  final String name;
  final int sortOrder;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  const BrewMethod({
    required this.name,
    required this.sortOrder,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['name'] = Variable<String>(name);
    map['sort_order'] = Variable<int>(sortOrder);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  BrewMethodsCompanion toCompanion(bool nullToAbsent) {
    return BrewMethodsCompanion(
      name: Value(name),
      sortOrder: Value(sortOrder),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory BrewMethod.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return BrewMethod(
      name: serializer.fromJson<String>(json['name']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'name': serializer.toJson<String>(name),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  BrewMethod copyWith({
    String? name,
    int? sortOrder,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => BrewMethod(
    name: name ?? this.name,
    sortOrder: sortOrder ?? this.sortOrder,
    isActive: isActive ?? this.isActive,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  BrewMethod copyWithCompanion(BrewMethodsCompanion data) {
    return BrewMethod(
      name: data.name.present ? data.name.value : this.name,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('BrewMethod(')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(name, sortOrder, isActive, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BrewMethod &&
          other.name == this.name &&
          other.sortOrder == this.sortOrder &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class BrewMethodsCompanion extends UpdateCompanion<BrewMethod> {
  final Value<String> name;
  final Value<int> sortOrder;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const BrewMethodsCompanion({
    this.name = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  BrewMethodsCompanion.insert({
    required String name,
    required int sortOrder,
    this.isActive = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : name = Value(name),
       sortOrder = Value(sortOrder),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<BrewMethod> custom({
    Expression<String>? name,
    Expression<int>? sortOrder,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (name != null) 'name': name,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  BrewMethodsCompanion copyWith({
    Value<String>? name,
    Value<int>? sortOrder,
    Value<bool>? isActive,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return BrewMethodsCompanion(
      name: name ?? this.name,
      sortOrder: sortOrder ?? this.sortOrder,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('BrewMethodsCompanion(')
          ..write('name: $name, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CoffeesTable coffees = $CoffeesTable(this);
  late final $EntriesTable entries = $EntriesTable(this);
  late final $EntryStepsTable entrySteps = $EntryStepsTable(this);
  late final $TemplatesTable templates = $TemplatesTable(this);
  late final $TemplateStepsTable templateSteps = $TemplateStepsTable(this);
  late final $TagsTable tags = $TagsTable(this);
  late final $CoffeeTagsTable coffeeTags = $CoffeeTagsTable(this);
  late final $EntryTagsTable entryTags = $EntryTagsTable(this);
  late final $TemplateTagsTable templateTags = $TemplateTagsTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  late final $BrewMethodsTable brewMethods = $BrewMethodsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    coffees,
    entries,
    entrySteps,
    templates,
    templateSteps,
    tags,
    coffeeTags,
    entryTags,
    templateTags,
    appSettings,
    brewMethods,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'coffees',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('entries', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'entries',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('entry_steps', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'coffees',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('templates', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'templates',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('template_steps', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'coffees',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('coffee_tags', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tags',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('coffee_tags', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'entries',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('entry_tags', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tags',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('entry_tags', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'templates',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('template_tags', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tags',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('template_tags', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$CoffeesTableCreateCompanionBuilder =
    CoffeesCompanion Function({
      required String id,
      required String name,
      required String roaster,
      Value<String?> country,
      Value<String?> region,
      Value<String?> farm,
      Value<String?> producer,
      Value<String?> varietal,
      Value<String?> process,
      Value<String?> altitudeM,
      Value<DateTime?> roastDate,
      Value<String?> tastingNotes,
      Value<bool> isArchived,
      Value<String> searchText,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$CoffeesTableUpdateCompanionBuilder =
    CoffeesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> roaster,
      Value<String?> country,
      Value<String?> region,
      Value<String?> farm,
      Value<String?> producer,
      Value<String?> varietal,
      Value<String?> process,
      Value<String?> altitudeM,
      Value<DateTime?> roastDate,
      Value<String?> tastingNotes,
      Value<bool> isArchived,
      Value<String> searchText,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$CoffeesTableReferences
    extends BaseReferences<_$AppDatabase, $CoffeesTable, Coffee> {
  $$CoffeesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EntriesTable, List<Entry>> _entriesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.entries,
    aliasName: $_aliasNameGenerator(db.coffees.id, db.entries.coffeeId),
  );

  $$EntriesTableProcessedTableManager get entriesRefs {
    final manager = $$EntriesTableTableManager(
      $_db,
      $_db.entries,
    ).filter((f) => f.coffeeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_entriesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TemplatesTable, List<Template>>
  _templatesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.templates,
    aliasName: $_aliasNameGenerator(db.coffees.id, db.templates.coffeeId),
  );

  $$TemplatesTableProcessedTableManager get templatesRefs {
    final manager = $$TemplatesTableTableManager(
      $_db,
      $_db.templates,
    ).filter((f) => f.coffeeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_templatesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CoffeeTagsTable, List<CoffeeTag>>
  _coffeeTagsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.coffeeTags,
    aliasName: $_aliasNameGenerator(db.coffees.id, db.coffeeTags.coffeeId),
  );

  $$CoffeeTagsTableProcessedTableManager get coffeeTagsRefs {
    final manager = $$CoffeeTagsTableTableManager(
      $_db,
      $_db.coffeeTags,
    ).filter((f) => f.coffeeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_coffeeTagsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CoffeesTableFilterComposer
    extends Composer<_$AppDatabase, $CoffeesTable> {
  $$CoffeesTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get roaster => $composableBuilder(
    column: $table.roaster,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get farm => $composableBuilder(
    column: $table.farm,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get producer => $composableBuilder(
    column: $table.producer,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get varietal => $composableBuilder(
    column: $table.varietal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get process => $composableBuilder(
    column: $table.process,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get altitudeM => $composableBuilder(
    column: $table.altitudeM,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get roastDate => $composableBuilder(
    column: $table.roastDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tastingNotes => $composableBuilder(
    column: $table.tastingNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get searchText => $composableBuilder(
    column: $table.searchText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> entriesRefs(
    Expression<bool> Function($$EntriesTableFilterComposer f) f,
  ) {
    final $$EntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.entries,
      getReferencedColumn: (t) => t.coffeeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntriesTableFilterComposer(
            $db: $db,
            $table: $db.entries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> templatesRefs(
    Expression<bool> Function($$TemplatesTableFilterComposer f) f,
  ) {
    final $$TemplatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.templates,
      getReferencedColumn: (t) => t.coffeeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplatesTableFilterComposer(
            $db: $db,
            $table: $db.templates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> coffeeTagsRefs(
    Expression<bool> Function($$CoffeeTagsTableFilterComposer f) f,
  ) {
    final $$CoffeeTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.coffeeTags,
      getReferencedColumn: (t) => t.coffeeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeeTagsTableFilterComposer(
            $db: $db,
            $table: $db.coffeeTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CoffeesTableOrderingComposer
    extends Composer<_$AppDatabase, $CoffeesTable> {
  $$CoffeesTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get roaster => $composableBuilder(
    column: $table.roaster,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get region => $composableBuilder(
    column: $table.region,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get farm => $composableBuilder(
    column: $table.farm,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get producer => $composableBuilder(
    column: $table.producer,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get varietal => $composableBuilder(
    column: $table.varietal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get process => $composableBuilder(
    column: $table.process,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get altitudeM => $composableBuilder(
    column: $table.altitudeM,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get roastDate => $composableBuilder(
    column: $table.roastDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tastingNotes => $composableBuilder(
    column: $table.tastingNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get searchText => $composableBuilder(
    column: $table.searchText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CoffeesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CoffeesTable> {
  $$CoffeesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get roaster =>
      $composableBuilder(column: $table.roaster, builder: (column) => column);

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<String> get region =>
      $composableBuilder(column: $table.region, builder: (column) => column);

  GeneratedColumn<String> get farm =>
      $composableBuilder(column: $table.farm, builder: (column) => column);

  GeneratedColumn<String> get producer =>
      $composableBuilder(column: $table.producer, builder: (column) => column);

  GeneratedColumn<String> get varietal =>
      $composableBuilder(column: $table.varietal, builder: (column) => column);

  GeneratedColumn<String> get process =>
      $composableBuilder(column: $table.process, builder: (column) => column);

  GeneratedColumn<String> get altitudeM =>
      $composableBuilder(column: $table.altitudeM, builder: (column) => column);

  GeneratedColumn<DateTime> get roastDate =>
      $composableBuilder(column: $table.roastDate, builder: (column) => column);

  GeneratedColumn<String> get tastingNotes => $composableBuilder(
    column: $table.tastingNotes,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isArchived => $composableBuilder(
    column: $table.isArchived,
    builder: (column) => column,
  );

  GeneratedColumn<String> get searchText => $composableBuilder(
    column: $table.searchText,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> entriesRefs<T extends Object>(
    Expression<T> Function($$EntriesTableAnnotationComposer a) f,
  ) {
    final $$EntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.entries,
      getReferencedColumn: (t) => t.coffeeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.entries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> templatesRefs<T extends Object>(
    Expression<T> Function($$TemplatesTableAnnotationComposer a) f,
  ) {
    final $$TemplatesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.templates,
      getReferencedColumn: (t) => t.coffeeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplatesTableAnnotationComposer(
            $db: $db,
            $table: $db.templates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> coffeeTagsRefs<T extends Object>(
    Expression<T> Function($$CoffeeTagsTableAnnotationComposer a) f,
  ) {
    final $$CoffeeTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.coffeeTags,
      getReferencedColumn: (t) => t.coffeeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeeTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.coffeeTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CoffeesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CoffeesTable,
          Coffee,
          $$CoffeesTableFilterComposer,
          $$CoffeesTableOrderingComposer,
          $$CoffeesTableAnnotationComposer,
          $$CoffeesTableCreateCompanionBuilder,
          $$CoffeesTableUpdateCompanionBuilder,
          (Coffee, $$CoffeesTableReferences),
          Coffee,
          PrefetchHooks Function({
            bool entriesRefs,
            bool templatesRefs,
            bool coffeeTagsRefs,
          })
        > {
  $$CoffeesTableTableManager(_$AppDatabase db, $CoffeesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CoffeesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CoffeesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CoffeesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> roaster = const Value.absent(),
                Value<String?> country = const Value.absent(),
                Value<String?> region = const Value.absent(),
                Value<String?> farm = const Value.absent(),
                Value<String?> producer = const Value.absent(),
                Value<String?> varietal = const Value.absent(),
                Value<String?> process = const Value.absent(),
                Value<String?> altitudeM = const Value.absent(),
                Value<DateTime?> roastDate = const Value.absent(),
                Value<String?> tastingNotes = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<String> searchText = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CoffeesCompanion(
                id: id,
                name: name,
                roaster: roaster,
                country: country,
                region: region,
                farm: farm,
                producer: producer,
                varietal: varietal,
                process: process,
                altitudeM: altitudeM,
                roastDate: roastDate,
                tastingNotes: tastingNotes,
                isArchived: isArchived,
                searchText: searchText,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String roaster,
                Value<String?> country = const Value.absent(),
                Value<String?> region = const Value.absent(),
                Value<String?> farm = const Value.absent(),
                Value<String?> producer = const Value.absent(),
                Value<String?> varietal = const Value.absent(),
                Value<String?> process = const Value.absent(),
                Value<String?> altitudeM = const Value.absent(),
                Value<DateTime?> roastDate = const Value.absent(),
                Value<String?> tastingNotes = const Value.absent(),
                Value<bool> isArchived = const Value.absent(),
                Value<String> searchText = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => CoffeesCompanion.insert(
                id: id,
                name: name,
                roaster: roaster,
                country: country,
                region: region,
                farm: farm,
                producer: producer,
                varietal: varietal,
                process: process,
                altitudeM: altitudeM,
                roastDate: roastDate,
                tastingNotes: tastingNotes,
                isArchived: isArchived,
                searchText: searchText,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CoffeesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                entriesRefs = false,
                templatesRefs = false,
                coffeeTagsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (entriesRefs) db.entries,
                    if (templatesRefs) db.templates,
                    if (coffeeTagsRefs) db.coffeeTags,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (entriesRefs)
                        await $_getPrefetchedData<Coffee, $CoffeesTable, Entry>(
                          currentTable: table,
                          referencedTable: $$CoffeesTableReferences
                              ._entriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CoffeesTableReferences(
                                db,
                                table,
                                p0,
                              ).entriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.coffeeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (templatesRefs)
                        await $_getPrefetchedData<
                          Coffee,
                          $CoffeesTable,
                          Template
                        >(
                          currentTable: table,
                          referencedTable: $$CoffeesTableReferences
                              ._templatesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CoffeesTableReferences(
                                db,
                                table,
                                p0,
                              ).templatesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.coffeeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (coffeeTagsRefs)
                        await $_getPrefetchedData<
                          Coffee,
                          $CoffeesTable,
                          CoffeeTag
                        >(
                          currentTable: table,
                          referencedTable: $$CoffeesTableReferences
                              ._coffeeTagsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CoffeesTableReferences(
                                db,
                                table,
                                p0,
                              ).coffeeTagsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.coffeeId == item.id,
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

typedef $$CoffeesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CoffeesTable,
      Coffee,
      $$CoffeesTableFilterComposer,
      $$CoffeesTableOrderingComposer,
      $$CoffeesTableAnnotationComposer,
      $$CoffeesTableCreateCompanionBuilder,
      $$CoffeesTableUpdateCompanionBuilder,
      (Coffee, $$CoffeesTableReferences),
      Coffee,
      PrefetchHooks Function({
        bool entriesRefs,
        bool templatesRefs,
        bool coffeeTagsRefs,
      })
    >;
typedef $$EntriesTableCreateCompanionBuilder =
    EntriesCompanion Function({
      required String id,
      required String coffeeId,
      required DateTime brewAt,
      required String brewMethod,
      Value<bool> isStarred,
      required double coffeeDoseG,
      required double waterTotalG,
      Value<double?> waterTempC,
      Value<String?> grinder,
      Value<String?> grindSetting,
      Value<double?> yieldG,
      Value<double?> pressureBar,
      Value<int?> preinfusionSec,
      Value<int> brewTimeSecAuto,
      Value<int?> brewTimeSecManual,
      Value<String?> sensoryJson,
      Value<String?> dialInNotes,
      Value<String?> miscNotes,
      Value<String?> agitationLevel,
      Value<int?> drawdownSec,
      Value<String> extractionOutcome,
      Value<String> searchText,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$EntriesTableUpdateCompanionBuilder =
    EntriesCompanion Function({
      Value<String> id,
      Value<String> coffeeId,
      Value<DateTime> brewAt,
      Value<String> brewMethod,
      Value<bool> isStarred,
      Value<double> coffeeDoseG,
      Value<double> waterTotalG,
      Value<double?> waterTempC,
      Value<String?> grinder,
      Value<String?> grindSetting,
      Value<double?> yieldG,
      Value<double?> pressureBar,
      Value<int?> preinfusionSec,
      Value<int> brewTimeSecAuto,
      Value<int?> brewTimeSecManual,
      Value<String?> sensoryJson,
      Value<String?> dialInNotes,
      Value<String?> miscNotes,
      Value<String?> agitationLevel,
      Value<int?> drawdownSec,
      Value<String> extractionOutcome,
      Value<String> searchText,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$EntriesTableReferences
    extends BaseReferences<_$AppDatabase, $EntriesTable, Entry> {
  $$EntriesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CoffeesTable _coffeeIdTable(_$AppDatabase db) => db.coffees
      .createAlias($_aliasNameGenerator(db.entries.coffeeId, db.coffees.id));

  $$CoffeesTableProcessedTableManager get coffeeId {
    final $_column = $_itemColumn<String>('coffee_id')!;

    final manager = $$CoffeesTableTableManager(
      $_db,
      $_db.coffees,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_coffeeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$EntryStepsTable, List<EntryStep>>
  _entryStepsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.entrySteps,
    aliasName: $_aliasNameGenerator(db.entries.id, db.entrySteps.entryId),
  );

  $$EntryStepsTableProcessedTableManager get entryStepsRefs {
    final manager = $$EntryStepsTableTableManager(
      $_db,
      $_db.entrySteps,
    ).filter((f) => f.entryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_entryStepsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EntryTagsTable, List<EntryTag>>
  _entryTagsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.entryTags,
    aliasName: $_aliasNameGenerator(db.entries.id, db.entryTags.entryId),
  );

  $$EntryTagsTableProcessedTableManager get entryTagsRefs {
    final manager = $$EntryTagsTableTableManager(
      $_db,
      $_db.entryTags,
    ).filter((f) => f.entryId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_entryTagsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EntriesTableFilterComposer
    extends Composer<_$AppDatabase, $EntriesTable> {
  $$EntriesTableFilterComposer({
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

  ColumnFilters<DateTime> get brewAt => $composableBuilder(
    column: $table.brewAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brewMethod => $composableBuilder(
    column: $table.brewMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isStarred => $composableBuilder(
    column: $table.isStarred,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get coffeeDoseG => $composableBuilder(
    column: $table.coffeeDoseG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get waterTotalG => $composableBuilder(
    column: $table.waterTotalG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get waterTempC => $composableBuilder(
    column: $table.waterTempC,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grinder => $composableBuilder(
    column: $table.grinder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get grindSetting => $composableBuilder(
    column: $table.grindSetting,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get yieldG => $composableBuilder(
    column: $table.yieldG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pressureBar => $composableBuilder(
    column: $table.pressureBar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get preinfusionSec => $composableBuilder(
    column: $table.preinfusionSec,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get brewTimeSecAuto => $composableBuilder(
    column: $table.brewTimeSecAuto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get brewTimeSecManual => $composableBuilder(
    column: $table.brewTimeSecManual,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sensoryJson => $composableBuilder(
    column: $table.sensoryJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get dialInNotes => $composableBuilder(
    column: $table.dialInNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get miscNotes => $composableBuilder(
    column: $table.miscNotes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get agitationLevel => $composableBuilder(
    column: $table.agitationLevel,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get drawdownSec => $composableBuilder(
    column: $table.drawdownSec,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get extractionOutcome => $composableBuilder(
    column: $table.extractionOutcome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get searchText => $composableBuilder(
    column: $table.searchText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CoffeesTableFilterComposer get coffeeId {
    final $$CoffeesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coffeeId,
      referencedTable: $db.coffees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeesTableFilterComposer(
            $db: $db,
            $table: $db.coffees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> entryStepsRefs(
    Expression<bool> Function($$EntryStepsTableFilterComposer f) f,
  ) {
    final $$EntryStepsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.entrySteps,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntryStepsTableFilterComposer(
            $db: $db,
            $table: $db.entrySteps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> entryTagsRefs(
    Expression<bool> Function($$EntryTagsTableFilterComposer f) f,
  ) {
    final $$EntryTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.entryTags,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntryTagsTableFilterComposer(
            $db: $db,
            $table: $db.entryTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $EntriesTable> {
  $$EntriesTableOrderingComposer({
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

  ColumnOrderings<DateTime> get brewAt => $composableBuilder(
    column: $table.brewAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brewMethod => $composableBuilder(
    column: $table.brewMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isStarred => $composableBuilder(
    column: $table.isStarred,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get coffeeDoseG => $composableBuilder(
    column: $table.coffeeDoseG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get waterTotalG => $composableBuilder(
    column: $table.waterTotalG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get waterTempC => $composableBuilder(
    column: $table.waterTempC,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grinder => $composableBuilder(
    column: $table.grinder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get grindSetting => $composableBuilder(
    column: $table.grindSetting,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get yieldG => $composableBuilder(
    column: $table.yieldG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pressureBar => $composableBuilder(
    column: $table.pressureBar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get preinfusionSec => $composableBuilder(
    column: $table.preinfusionSec,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get brewTimeSecAuto => $composableBuilder(
    column: $table.brewTimeSecAuto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get brewTimeSecManual => $composableBuilder(
    column: $table.brewTimeSecManual,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sensoryJson => $composableBuilder(
    column: $table.sensoryJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get dialInNotes => $composableBuilder(
    column: $table.dialInNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get miscNotes => $composableBuilder(
    column: $table.miscNotes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get agitationLevel => $composableBuilder(
    column: $table.agitationLevel,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get drawdownSec => $composableBuilder(
    column: $table.drawdownSec,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get extractionOutcome => $composableBuilder(
    column: $table.extractionOutcome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get searchText => $composableBuilder(
    column: $table.searchText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CoffeesTableOrderingComposer get coffeeId {
    final $$CoffeesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coffeeId,
      referencedTable: $db.coffees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeesTableOrderingComposer(
            $db: $db,
            $table: $db.coffees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $EntriesTable> {
  $$EntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get brewAt =>
      $composableBuilder(column: $table.brewAt, builder: (column) => column);

  GeneratedColumn<String> get brewMethod => $composableBuilder(
    column: $table.brewMethod,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isStarred =>
      $composableBuilder(column: $table.isStarred, builder: (column) => column);

  GeneratedColumn<double> get coffeeDoseG => $composableBuilder(
    column: $table.coffeeDoseG,
    builder: (column) => column,
  );

  GeneratedColumn<double> get waterTotalG => $composableBuilder(
    column: $table.waterTotalG,
    builder: (column) => column,
  );

  GeneratedColumn<double> get waterTempC => $composableBuilder(
    column: $table.waterTempC,
    builder: (column) => column,
  );

  GeneratedColumn<String> get grinder =>
      $composableBuilder(column: $table.grinder, builder: (column) => column);

  GeneratedColumn<String> get grindSetting => $composableBuilder(
    column: $table.grindSetting,
    builder: (column) => column,
  );

  GeneratedColumn<double> get yieldG =>
      $composableBuilder(column: $table.yieldG, builder: (column) => column);

  GeneratedColumn<double> get pressureBar => $composableBuilder(
    column: $table.pressureBar,
    builder: (column) => column,
  );

  GeneratedColumn<int> get preinfusionSec => $composableBuilder(
    column: $table.preinfusionSec,
    builder: (column) => column,
  );

  GeneratedColumn<int> get brewTimeSecAuto => $composableBuilder(
    column: $table.brewTimeSecAuto,
    builder: (column) => column,
  );

  GeneratedColumn<int> get brewTimeSecManual => $composableBuilder(
    column: $table.brewTimeSecManual,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sensoryJson => $composableBuilder(
    column: $table.sensoryJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get dialInNotes => $composableBuilder(
    column: $table.dialInNotes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get miscNotes =>
      $composableBuilder(column: $table.miscNotes, builder: (column) => column);

  GeneratedColumn<String> get agitationLevel => $composableBuilder(
    column: $table.agitationLevel,
    builder: (column) => column,
  );

  GeneratedColumn<int> get drawdownSec => $composableBuilder(
    column: $table.drawdownSec,
    builder: (column) => column,
  );

  GeneratedColumn<String> get extractionOutcome => $composableBuilder(
    column: $table.extractionOutcome,
    builder: (column) => column,
  );

  GeneratedColumn<String> get searchText => $composableBuilder(
    column: $table.searchText,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CoffeesTableAnnotationComposer get coffeeId {
    final $$CoffeesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coffeeId,
      referencedTable: $db.coffees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeesTableAnnotationComposer(
            $db: $db,
            $table: $db.coffees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> entryStepsRefs<T extends Object>(
    Expression<T> Function($$EntryStepsTableAnnotationComposer a) f,
  ) {
    final $$EntryStepsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.entrySteps,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntryStepsTableAnnotationComposer(
            $db: $db,
            $table: $db.entrySteps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> entryTagsRefs<T extends Object>(
    Expression<T> Function($$EntryTagsTableAnnotationComposer a) f,
  ) {
    final $$EntryTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.entryTags,
      getReferencedColumn: (t) => t.entryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntryTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.entryTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EntriesTable,
          Entry,
          $$EntriesTableFilterComposer,
          $$EntriesTableOrderingComposer,
          $$EntriesTableAnnotationComposer,
          $$EntriesTableCreateCompanionBuilder,
          $$EntriesTableUpdateCompanionBuilder,
          (Entry, $$EntriesTableReferences),
          Entry,
          PrefetchHooks Function({
            bool coffeeId,
            bool entryStepsRefs,
            bool entryTagsRefs,
          })
        > {
  $$EntriesTableTableManager(_$AppDatabase db, $EntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> coffeeId = const Value.absent(),
                Value<DateTime> brewAt = const Value.absent(),
                Value<String> brewMethod = const Value.absent(),
                Value<bool> isStarred = const Value.absent(),
                Value<double> coffeeDoseG = const Value.absent(),
                Value<double> waterTotalG = const Value.absent(),
                Value<double?> waterTempC = const Value.absent(),
                Value<String?> grinder = const Value.absent(),
                Value<String?> grindSetting = const Value.absent(),
                Value<double?> yieldG = const Value.absent(),
                Value<double?> pressureBar = const Value.absent(),
                Value<int?> preinfusionSec = const Value.absent(),
                Value<int> brewTimeSecAuto = const Value.absent(),
                Value<int?> brewTimeSecManual = const Value.absent(),
                Value<String?> sensoryJson = const Value.absent(),
                Value<String?> dialInNotes = const Value.absent(),
                Value<String?> miscNotes = const Value.absent(),
                Value<String?> agitationLevel = const Value.absent(),
                Value<int?> drawdownSec = const Value.absent(),
                Value<String> extractionOutcome = const Value.absent(),
                Value<String> searchText = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EntriesCompanion(
                id: id,
                coffeeId: coffeeId,
                brewAt: brewAt,
                brewMethod: brewMethod,
                isStarred: isStarred,
                coffeeDoseG: coffeeDoseG,
                waterTotalG: waterTotalG,
                waterTempC: waterTempC,
                grinder: grinder,
                grindSetting: grindSetting,
                yieldG: yieldG,
                pressureBar: pressureBar,
                preinfusionSec: preinfusionSec,
                brewTimeSecAuto: brewTimeSecAuto,
                brewTimeSecManual: brewTimeSecManual,
                sensoryJson: sensoryJson,
                dialInNotes: dialInNotes,
                miscNotes: miscNotes,
                agitationLevel: agitationLevel,
                drawdownSec: drawdownSec,
                extractionOutcome: extractionOutcome,
                searchText: searchText,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String coffeeId,
                required DateTime brewAt,
                required String brewMethod,
                Value<bool> isStarred = const Value.absent(),
                required double coffeeDoseG,
                required double waterTotalG,
                Value<double?> waterTempC = const Value.absent(),
                Value<String?> grinder = const Value.absent(),
                Value<String?> grindSetting = const Value.absent(),
                Value<double?> yieldG = const Value.absent(),
                Value<double?> pressureBar = const Value.absent(),
                Value<int?> preinfusionSec = const Value.absent(),
                Value<int> brewTimeSecAuto = const Value.absent(),
                Value<int?> brewTimeSecManual = const Value.absent(),
                Value<String?> sensoryJson = const Value.absent(),
                Value<String?> dialInNotes = const Value.absent(),
                Value<String?> miscNotes = const Value.absent(),
                Value<String?> agitationLevel = const Value.absent(),
                Value<int?> drawdownSec = const Value.absent(),
                Value<String> extractionOutcome = const Value.absent(),
                Value<String> searchText = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => EntriesCompanion.insert(
                id: id,
                coffeeId: coffeeId,
                brewAt: brewAt,
                brewMethod: brewMethod,
                isStarred: isStarred,
                coffeeDoseG: coffeeDoseG,
                waterTotalG: waterTotalG,
                waterTempC: waterTempC,
                grinder: grinder,
                grindSetting: grindSetting,
                yieldG: yieldG,
                pressureBar: pressureBar,
                preinfusionSec: preinfusionSec,
                brewTimeSecAuto: brewTimeSecAuto,
                brewTimeSecManual: brewTimeSecManual,
                sensoryJson: sensoryJson,
                dialInNotes: dialInNotes,
                miscNotes: miscNotes,
                agitationLevel: agitationLevel,
                drawdownSec: drawdownSec,
                extractionOutcome: extractionOutcome,
                searchText: searchText,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                coffeeId = false,
                entryStepsRefs = false,
                entryTagsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (entryStepsRefs) db.entrySteps,
                    if (entryTagsRefs) db.entryTags,
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
                        if (coffeeId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.coffeeId,
                                    referencedTable: $$EntriesTableReferences
                                        ._coffeeIdTable(db),
                                    referencedColumn: $$EntriesTableReferences
                                        ._coffeeIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (entryStepsRefs)
                        await $_getPrefetchedData<
                          Entry,
                          $EntriesTable,
                          EntryStep
                        >(
                          currentTable: table,
                          referencedTable: $$EntriesTableReferences
                              ._entryStepsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).entryStepsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.entryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (entryTagsRefs)
                        await $_getPrefetchedData<
                          Entry,
                          $EntriesTable,
                          EntryTag
                        >(
                          currentTable: table,
                          referencedTable: $$EntriesTableReferences
                              ._entryTagsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$EntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).entryTagsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.entryId == item.id,
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

typedef $$EntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EntriesTable,
      Entry,
      $$EntriesTableFilterComposer,
      $$EntriesTableOrderingComposer,
      $$EntriesTableAnnotationComposer,
      $$EntriesTableCreateCompanionBuilder,
      $$EntriesTableUpdateCompanionBuilder,
      (Entry, $$EntriesTableReferences),
      Entry,
      PrefetchHooks Function({
        bool coffeeId,
        bool entryStepsRefs,
        bool entryTagsRefs,
      })
    >;
typedef $$EntryStepsTableCreateCompanionBuilder =
    EntryStepsCompanion Function({
      required String id,
      required String entryId,
      required int stepIndex,
      required String type,
      Value<int?> startSec,
      Value<int?> durationSec,
      Value<String?> note,
      Value<double?> waterG,
      Value<double?> flowRateGPerSec,
      Value<double?> pressureBar,
      Value<int?> count,
      Value<String?> tool,
      Value<String?> label,
      Value<String?> jsonPayload,
      Value<int> rowid,
    });
typedef $$EntryStepsTableUpdateCompanionBuilder =
    EntryStepsCompanion Function({
      Value<String> id,
      Value<String> entryId,
      Value<int> stepIndex,
      Value<String> type,
      Value<int?> startSec,
      Value<int?> durationSec,
      Value<String?> note,
      Value<double?> waterG,
      Value<double?> flowRateGPerSec,
      Value<double?> pressureBar,
      Value<int?> count,
      Value<String?> tool,
      Value<String?> label,
      Value<String?> jsonPayload,
      Value<int> rowid,
    });

final class $$EntryStepsTableReferences
    extends BaseReferences<_$AppDatabase, $EntryStepsTable, EntryStep> {
  $$EntryStepsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EntriesTable _entryIdTable(_$AppDatabase db) => db.entries
      .createAlias($_aliasNameGenerator(db.entrySteps.entryId, db.entries.id));

  $$EntriesTableProcessedTableManager get entryId {
    final $_column = $_itemColumn<String>('entry_id')!;

    final manager = $$EntriesTableTableManager(
      $_db,
      $_db.entries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EntryStepsTableFilterComposer
    extends Composer<_$AppDatabase, $EntryStepsTable> {
  $$EntryStepsTableFilterComposer({
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

  ColumnFilters<int> get stepIndex => $composableBuilder(
    column: $table.stepIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startSec => $composableBuilder(
    column: $table.startSec,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSec => $composableBuilder(
    column: $table.durationSec,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get waterG => $composableBuilder(
    column: $table.waterG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get flowRateGPerSec => $composableBuilder(
    column: $table.flowRateGPerSec,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pressureBar => $composableBuilder(
    column: $table.pressureBar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get count => $composableBuilder(
    column: $table.count,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tool => $composableBuilder(
    column: $table.tool,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jsonPayload => $composableBuilder(
    column: $table.jsonPayload,
    builder: (column) => ColumnFilters(column),
  );

  $$EntriesTableFilterComposer get entryId {
    final $$EntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.entries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntriesTableFilterComposer(
            $db: $db,
            $table: $db.entries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EntryStepsTableOrderingComposer
    extends Composer<_$AppDatabase, $EntryStepsTable> {
  $$EntryStepsTableOrderingComposer({
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

  ColumnOrderings<int> get stepIndex => $composableBuilder(
    column: $table.stepIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startSec => $composableBuilder(
    column: $table.startSec,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSec => $composableBuilder(
    column: $table.durationSec,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get waterG => $composableBuilder(
    column: $table.waterG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get flowRateGPerSec => $composableBuilder(
    column: $table.flowRateGPerSec,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pressureBar => $composableBuilder(
    column: $table.pressureBar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get count => $composableBuilder(
    column: $table.count,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tool => $composableBuilder(
    column: $table.tool,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jsonPayload => $composableBuilder(
    column: $table.jsonPayload,
    builder: (column) => ColumnOrderings(column),
  );

  $$EntriesTableOrderingComposer get entryId {
    final $$EntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.entries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntriesTableOrderingComposer(
            $db: $db,
            $table: $db.entries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EntryStepsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EntryStepsTable> {
  $$EntryStepsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get stepIndex =>
      $composableBuilder(column: $table.stepIndex, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get startSec =>
      $composableBuilder(column: $table.startSec, builder: (column) => column);

  GeneratedColumn<int> get durationSec => $composableBuilder(
    column: $table.durationSec,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<double> get waterG =>
      $composableBuilder(column: $table.waterG, builder: (column) => column);

  GeneratedColumn<double> get flowRateGPerSec => $composableBuilder(
    column: $table.flowRateGPerSec,
    builder: (column) => column,
  );

  GeneratedColumn<double> get pressureBar => $composableBuilder(
    column: $table.pressureBar,
    builder: (column) => column,
  );

  GeneratedColumn<int> get count =>
      $composableBuilder(column: $table.count, builder: (column) => column);

  GeneratedColumn<String> get tool =>
      $composableBuilder(column: $table.tool, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get jsonPayload => $composableBuilder(
    column: $table.jsonPayload,
    builder: (column) => column,
  );

  $$EntriesTableAnnotationComposer get entryId {
    final $$EntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.entries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.entries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EntryStepsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EntryStepsTable,
          EntryStep,
          $$EntryStepsTableFilterComposer,
          $$EntryStepsTableOrderingComposer,
          $$EntryStepsTableAnnotationComposer,
          $$EntryStepsTableCreateCompanionBuilder,
          $$EntryStepsTableUpdateCompanionBuilder,
          (EntryStep, $$EntryStepsTableReferences),
          EntryStep,
          PrefetchHooks Function({bool entryId})
        > {
  $$EntryStepsTableTableManager(_$AppDatabase db, $EntryStepsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EntryStepsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EntryStepsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EntryStepsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> entryId = const Value.absent(),
                Value<int> stepIndex = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int?> startSec = const Value.absent(),
                Value<int?> durationSec = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<double?> waterG = const Value.absent(),
                Value<double?> flowRateGPerSec = const Value.absent(),
                Value<double?> pressureBar = const Value.absent(),
                Value<int?> count = const Value.absent(),
                Value<String?> tool = const Value.absent(),
                Value<String?> label = const Value.absent(),
                Value<String?> jsonPayload = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EntryStepsCompanion(
                id: id,
                entryId: entryId,
                stepIndex: stepIndex,
                type: type,
                startSec: startSec,
                durationSec: durationSec,
                note: note,
                waterG: waterG,
                flowRateGPerSec: flowRateGPerSec,
                pressureBar: pressureBar,
                count: count,
                tool: tool,
                label: label,
                jsonPayload: jsonPayload,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String entryId,
                required int stepIndex,
                required String type,
                Value<int?> startSec = const Value.absent(),
                Value<int?> durationSec = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<double?> waterG = const Value.absent(),
                Value<double?> flowRateGPerSec = const Value.absent(),
                Value<double?> pressureBar = const Value.absent(),
                Value<int?> count = const Value.absent(),
                Value<String?> tool = const Value.absent(),
                Value<String?> label = const Value.absent(),
                Value<String?> jsonPayload = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EntryStepsCompanion.insert(
                id: id,
                entryId: entryId,
                stepIndex: stepIndex,
                type: type,
                startSec: startSec,
                durationSec: durationSec,
                note: note,
                waterG: waterG,
                flowRateGPerSec: flowRateGPerSec,
                pressureBar: pressureBar,
                count: count,
                tool: tool,
                label: label,
                jsonPayload: jsonPayload,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EntryStepsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({entryId = false}) {
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
                    if (entryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.entryId,
                                referencedTable: $$EntryStepsTableReferences
                                    ._entryIdTable(db),
                                referencedColumn: $$EntryStepsTableReferences
                                    ._entryIdTable(db)
                                    .id,
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

typedef $$EntryStepsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EntryStepsTable,
      EntryStep,
      $$EntryStepsTableFilterComposer,
      $$EntryStepsTableOrderingComposer,
      $$EntryStepsTableAnnotationComposer,
      $$EntryStepsTableCreateCompanionBuilder,
      $$EntryStepsTableUpdateCompanionBuilder,
      (EntryStep, $$EntryStepsTableReferences),
      EntryStep,
      PrefetchHooks Function({bool entryId})
    >;
typedef $$TemplatesTableCreateCompanionBuilder =
    TemplatesCompanion Function({
      required String id,
      required String name,
      required String scope,
      Value<String?> coffeeId,
      required String brewMethod,
      Value<double?> defaultCoffeeDoseG,
      Value<double?> defaultWaterTotalG,
      Value<String> searchText,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$TemplatesTableUpdateCompanionBuilder =
    TemplatesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> scope,
      Value<String?> coffeeId,
      Value<String> brewMethod,
      Value<double?> defaultCoffeeDoseG,
      Value<double?> defaultWaterTotalG,
      Value<String> searchText,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$TemplatesTableReferences
    extends BaseReferences<_$AppDatabase, $TemplatesTable, Template> {
  $$TemplatesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CoffeesTable _coffeeIdTable(_$AppDatabase db) => db.coffees
      .createAlias($_aliasNameGenerator(db.templates.coffeeId, db.coffees.id));

  $$CoffeesTableProcessedTableManager? get coffeeId {
    final $_column = $_itemColumn<String>('coffee_id');
    if ($_column == null) return null;
    final manager = $$CoffeesTableTableManager(
      $_db,
      $_db.coffees,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_coffeeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TemplateStepsTable, List<TemplateStep>>
  _templateStepsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.templateSteps,
    aliasName: $_aliasNameGenerator(
      db.templates.id,
      db.templateSteps.templateId,
    ),
  );

  $$TemplateStepsTableProcessedTableManager get templateStepsRefs {
    final manager = $$TemplateStepsTableTableManager(
      $_db,
      $_db.templateSteps,
    ).filter((f) => f.templateId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_templateStepsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TemplateTagsTable, List<TemplateTag>>
  _templateTagsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.templateTags,
    aliasName: $_aliasNameGenerator(
      db.templates.id,
      db.templateTags.templateId,
    ),
  );

  $$TemplateTagsTableProcessedTableManager get templateTagsRefs {
    final manager = $$TemplateTagsTableTableManager(
      $_db,
      $_db.templateTags,
    ).filter((f) => f.templateId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_templateTagsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TemplatesTableFilterComposer
    extends Composer<_$AppDatabase, $TemplatesTable> {
  $$TemplatesTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get brewMethod => $composableBuilder(
    column: $table.brewMethod,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get defaultCoffeeDoseG => $composableBuilder(
    column: $table.defaultCoffeeDoseG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get defaultWaterTotalG => $composableBuilder(
    column: $table.defaultWaterTotalG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get searchText => $composableBuilder(
    column: $table.searchText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CoffeesTableFilterComposer get coffeeId {
    final $$CoffeesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coffeeId,
      referencedTable: $db.coffees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeesTableFilterComposer(
            $db: $db,
            $table: $db.coffees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> templateStepsRefs(
    Expression<bool> Function($$TemplateStepsTableFilterComposer f) f,
  ) {
    final $$TemplateStepsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.templateSteps,
      getReferencedColumn: (t) => t.templateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplateStepsTableFilterComposer(
            $db: $db,
            $table: $db.templateSteps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> templateTagsRefs(
    Expression<bool> Function($$TemplateTagsTableFilterComposer f) f,
  ) {
    final $$TemplateTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.templateTags,
      getReferencedColumn: (t) => t.templateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplateTagsTableFilterComposer(
            $db: $db,
            $table: $db.templateTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TemplatesTableOrderingComposer
    extends Composer<_$AppDatabase, $TemplatesTable> {
  $$TemplatesTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scope => $composableBuilder(
    column: $table.scope,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get brewMethod => $composableBuilder(
    column: $table.brewMethod,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get defaultCoffeeDoseG => $composableBuilder(
    column: $table.defaultCoffeeDoseG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get defaultWaterTotalG => $composableBuilder(
    column: $table.defaultWaterTotalG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get searchText => $composableBuilder(
    column: $table.searchText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$CoffeesTableOrderingComposer get coffeeId {
    final $$CoffeesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coffeeId,
      referencedTable: $db.coffees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeesTableOrderingComposer(
            $db: $db,
            $table: $db.coffees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TemplatesTableAnnotationComposer
    extends Composer<_$AppDatabase, $TemplatesTable> {
  $$TemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get scope =>
      $composableBuilder(column: $table.scope, builder: (column) => column);

  GeneratedColumn<String> get brewMethod => $composableBuilder(
    column: $table.brewMethod,
    builder: (column) => column,
  );

  GeneratedColumn<double> get defaultCoffeeDoseG => $composableBuilder(
    column: $table.defaultCoffeeDoseG,
    builder: (column) => column,
  );

  GeneratedColumn<double> get defaultWaterTotalG => $composableBuilder(
    column: $table.defaultWaterTotalG,
    builder: (column) => column,
  );

  GeneratedColumn<String> get searchText => $composableBuilder(
    column: $table.searchText,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CoffeesTableAnnotationComposer get coffeeId {
    final $$CoffeesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coffeeId,
      referencedTable: $db.coffees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeesTableAnnotationComposer(
            $db: $db,
            $table: $db.coffees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> templateStepsRefs<T extends Object>(
    Expression<T> Function($$TemplateStepsTableAnnotationComposer a) f,
  ) {
    final $$TemplateStepsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.templateSteps,
      getReferencedColumn: (t) => t.templateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplateStepsTableAnnotationComposer(
            $db: $db,
            $table: $db.templateSteps,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> templateTagsRefs<T extends Object>(
    Expression<T> Function($$TemplateTagsTableAnnotationComposer a) f,
  ) {
    final $$TemplateTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.templateTags,
      getReferencedColumn: (t) => t.templateId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplateTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.templateTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TemplatesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TemplatesTable,
          Template,
          $$TemplatesTableFilterComposer,
          $$TemplatesTableOrderingComposer,
          $$TemplatesTableAnnotationComposer,
          $$TemplatesTableCreateCompanionBuilder,
          $$TemplatesTableUpdateCompanionBuilder,
          (Template, $$TemplatesTableReferences),
          Template,
          PrefetchHooks Function({
            bool coffeeId,
            bool templateStepsRefs,
            bool templateTagsRefs,
          })
        > {
  $$TemplatesTableTableManager(_$AppDatabase db, $TemplatesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TemplatesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TemplatesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TemplatesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> scope = const Value.absent(),
                Value<String?> coffeeId = const Value.absent(),
                Value<String> brewMethod = const Value.absent(),
                Value<double?> defaultCoffeeDoseG = const Value.absent(),
                Value<double?> defaultWaterTotalG = const Value.absent(),
                Value<String> searchText = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TemplatesCompanion(
                id: id,
                name: name,
                scope: scope,
                coffeeId: coffeeId,
                brewMethod: brewMethod,
                defaultCoffeeDoseG: defaultCoffeeDoseG,
                defaultWaterTotalG: defaultWaterTotalG,
                searchText: searchText,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String scope,
                Value<String?> coffeeId = const Value.absent(),
                required String brewMethod,
                Value<double?> defaultCoffeeDoseG = const Value.absent(),
                Value<double?> defaultWaterTotalG = const Value.absent(),
                Value<String> searchText = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => TemplatesCompanion.insert(
                id: id,
                name: name,
                scope: scope,
                coffeeId: coffeeId,
                brewMethod: brewMethod,
                defaultCoffeeDoseG: defaultCoffeeDoseG,
                defaultWaterTotalG: defaultWaterTotalG,
                searchText: searchText,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TemplatesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                coffeeId = false,
                templateStepsRefs = false,
                templateTagsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (templateStepsRefs) db.templateSteps,
                    if (templateTagsRefs) db.templateTags,
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
                        if (coffeeId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.coffeeId,
                                    referencedTable: $$TemplatesTableReferences
                                        ._coffeeIdTable(db),
                                    referencedColumn: $$TemplatesTableReferences
                                        ._coffeeIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (templateStepsRefs)
                        await $_getPrefetchedData<
                          Template,
                          $TemplatesTable,
                          TemplateStep
                        >(
                          currentTable: table,
                          referencedTable: $$TemplatesTableReferences
                              ._templateStepsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TemplatesTableReferences(
                                db,
                                table,
                                p0,
                              ).templateStepsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.templateId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (templateTagsRefs)
                        await $_getPrefetchedData<
                          Template,
                          $TemplatesTable,
                          TemplateTag
                        >(
                          currentTable: table,
                          referencedTable: $$TemplatesTableReferences
                              ._templateTagsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$TemplatesTableReferences(
                                db,
                                table,
                                p0,
                              ).templateTagsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.templateId == item.id,
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

typedef $$TemplatesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TemplatesTable,
      Template,
      $$TemplatesTableFilterComposer,
      $$TemplatesTableOrderingComposer,
      $$TemplatesTableAnnotationComposer,
      $$TemplatesTableCreateCompanionBuilder,
      $$TemplatesTableUpdateCompanionBuilder,
      (Template, $$TemplatesTableReferences),
      Template,
      PrefetchHooks Function({
        bool coffeeId,
        bool templateStepsRefs,
        bool templateTagsRefs,
      })
    >;
typedef $$TemplateStepsTableCreateCompanionBuilder =
    TemplateStepsCompanion Function({
      required String id,
      required String templateId,
      required int stepIndex,
      required String type,
      Value<int?> startSec,
      Value<int?> durationSec,
      Value<String?> note,
      Value<double?> waterG,
      Value<double?> flowRateGPerSec,
      Value<double?> pressureBar,
      Value<int?> count,
      Value<String?> tool,
      Value<String?> label,
      Value<String?> jsonPayload,
      Value<int> rowid,
    });
typedef $$TemplateStepsTableUpdateCompanionBuilder =
    TemplateStepsCompanion Function({
      Value<String> id,
      Value<String> templateId,
      Value<int> stepIndex,
      Value<String> type,
      Value<int?> startSec,
      Value<int?> durationSec,
      Value<String?> note,
      Value<double?> waterG,
      Value<double?> flowRateGPerSec,
      Value<double?> pressureBar,
      Value<int?> count,
      Value<String?> tool,
      Value<String?> label,
      Value<String?> jsonPayload,
      Value<int> rowid,
    });

final class $$TemplateStepsTableReferences
    extends BaseReferences<_$AppDatabase, $TemplateStepsTable, TemplateStep> {
  $$TemplateStepsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $TemplatesTable _templateIdTable(_$AppDatabase db) =>
      db.templates.createAlias(
        $_aliasNameGenerator(db.templateSteps.templateId, db.templates.id),
      );

  $$TemplatesTableProcessedTableManager get templateId {
    final $_column = $_itemColumn<String>('template_id')!;

    final manager = $$TemplatesTableTableManager(
      $_db,
      $_db.templates,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_templateIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TemplateStepsTableFilterComposer
    extends Composer<_$AppDatabase, $TemplateStepsTable> {
  $$TemplateStepsTableFilterComposer({
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

  ColumnFilters<int> get stepIndex => $composableBuilder(
    column: $table.stepIndex,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get startSec => $composableBuilder(
    column: $table.startSec,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationSec => $composableBuilder(
    column: $table.durationSec,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get waterG => $composableBuilder(
    column: $table.waterG,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get flowRateGPerSec => $composableBuilder(
    column: $table.flowRateGPerSec,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get pressureBar => $composableBuilder(
    column: $table.pressureBar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get count => $composableBuilder(
    column: $table.count,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tool => $composableBuilder(
    column: $table.tool,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get jsonPayload => $composableBuilder(
    column: $table.jsonPayload,
    builder: (column) => ColumnFilters(column),
  );

  $$TemplatesTableFilterComposer get templateId {
    final $$TemplatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateId,
      referencedTable: $db.templates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplatesTableFilterComposer(
            $db: $db,
            $table: $db.templates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TemplateStepsTableOrderingComposer
    extends Composer<_$AppDatabase, $TemplateStepsTable> {
  $$TemplateStepsTableOrderingComposer({
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

  ColumnOrderings<int> get stepIndex => $composableBuilder(
    column: $table.stepIndex,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get startSec => $composableBuilder(
    column: $table.startSec,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationSec => $composableBuilder(
    column: $table.durationSec,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get waterG => $composableBuilder(
    column: $table.waterG,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get flowRateGPerSec => $composableBuilder(
    column: $table.flowRateGPerSec,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pressureBar => $composableBuilder(
    column: $table.pressureBar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get count => $composableBuilder(
    column: $table.count,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tool => $composableBuilder(
    column: $table.tool,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get jsonPayload => $composableBuilder(
    column: $table.jsonPayload,
    builder: (column) => ColumnOrderings(column),
  );

  $$TemplatesTableOrderingComposer get templateId {
    final $$TemplatesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateId,
      referencedTable: $db.templates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplatesTableOrderingComposer(
            $db: $db,
            $table: $db.templates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TemplateStepsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TemplateStepsTable> {
  $$TemplateStepsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get stepIndex =>
      $composableBuilder(column: $table.stepIndex, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get startSec =>
      $composableBuilder(column: $table.startSec, builder: (column) => column);

  GeneratedColumn<int> get durationSec => $composableBuilder(
    column: $table.durationSec,
    builder: (column) => column,
  );

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<double> get waterG =>
      $composableBuilder(column: $table.waterG, builder: (column) => column);

  GeneratedColumn<double> get flowRateGPerSec => $composableBuilder(
    column: $table.flowRateGPerSec,
    builder: (column) => column,
  );

  GeneratedColumn<double> get pressureBar => $composableBuilder(
    column: $table.pressureBar,
    builder: (column) => column,
  );

  GeneratedColumn<int> get count =>
      $composableBuilder(column: $table.count, builder: (column) => column);

  GeneratedColumn<String> get tool =>
      $composableBuilder(column: $table.tool, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get jsonPayload => $composableBuilder(
    column: $table.jsonPayload,
    builder: (column) => column,
  );

  $$TemplatesTableAnnotationComposer get templateId {
    final $$TemplatesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateId,
      referencedTable: $db.templates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplatesTableAnnotationComposer(
            $db: $db,
            $table: $db.templates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TemplateStepsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TemplateStepsTable,
          TemplateStep,
          $$TemplateStepsTableFilterComposer,
          $$TemplateStepsTableOrderingComposer,
          $$TemplateStepsTableAnnotationComposer,
          $$TemplateStepsTableCreateCompanionBuilder,
          $$TemplateStepsTableUpdateCompanionBuilder,
          (TemplateStep, $$TemplateStepsTableReferences),
          TemplateStep,
          PrefetchHooks Function({bool templateId})
        > {
  $$TemplateStepsTableTableManager(_$AppDatabase db, $TemplateStepsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TemplateStepsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TemplateStepsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TemplateStepsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> templateId = const Value.absent(),
                Value<int> stepIndex = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int?> startSec = const Value.absent(),
                Value<int?> durationSec = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<double?> waterG = const Value.absent(),
                Value<double?> flowRateGPerSec = const Value.absent(),
                Value<double?> pressureBar = const Value.absent(),
                Value<int?> count = const Value.absent(),
                Value<String?> tool = const Value.absent(),
                Value<String?> label = const Value.absent(),
                Value<String?> jsonPayload = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TemplateStepsCompanion(
                id: id,
                templateId: templateId,
                stepIndex: stepIndex,
                type: type,
                startSec: startSec,
                durationSec: durationSec,
                note: note,
                waterG: waterG,
                flowRateGPerSec: flowRateGPerSec,
                pressureBar: pressureBar,
                count: count,
                tool: tool,
                label: label,
                jsonPayload: jsonPayload,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String templateId,
                required int stepIndex,
                required String type,
                Value<int?> startSec = const Value.absent(),
                Value<int?> durationSec = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<double?> waterG = const Value.absent(),
                Value<double?> flowRateGPerSec = const Value.absent(),
                Value<double?> pressureBar = const Value.absent(),
                Value<int?> count = const Value.absent(),
                Value<String?> tool = const Value.absent(),
                Value<String?> label = const Value.absent(),
                Value<String?> jsonPayload = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TemplateStepsCompanion.insert(
                id: id,
                templateId: templateId,
                stepIndex: stepIndex,
                type: type,
                startSec: startSec,
                durationSec: durationSec,
                note: note,
                waterG: waterG,
                flowRateGPerSec: flowRateGPerSec,
                pressureBar: pressureBar,
                count: count,
                tool: tool,
                label: label,
                jsonPayload: jsonPayload,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TemplateStepsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({templateId = false}) {
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
                    if (templateId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.templateId,
                                referencedTable: $$TemplateStepsTableReferences
                                    ._templateIdTable(db),
                                referencedColumn: $$TemplateStepsTableReferences
                                    ._templateIdTable(db)
                                    .id,
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

typedef $$TemplateStepsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TemplateStepsTable,
      TemplateStep,
      $$TemplateStepsTableFilterComposer,
      $$TemplateStepsTableOrderingComposer,
      $$TemplateStepsTableAnnotationComposer,
      $$TemplateStepsTableCreateCompanionBuilder,
      $$TemplateStepsTableUpdateCompanionBuilder,
      (TemplateStep, $$TemplateStepsTableReferences),
      TemplateStep,
      PrefetchHooks Function({bool templateId})
    >;
typedef $$TagsTableCreateCompanionBuilder =
    TagsCompanion Function({
      required String id,
      required String name,
      required String normalizedName,
      Value<int> usageCount,
      Value<int> rowid,
    });
typedef $$TagsTableUpdateCompanionBuilder =
    TagsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String> normalizedName,
      Value<int> usageCount,
      Value<int> rowid,
    });

final class $$TagsTableReferences
    extends BaseReferences<_$AppDatabase, $TagsTable, Tag> {
  $$TagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$CoffeeTagsTable, List<CoffeeTag>>
  _coffeeTagsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.coffeeTags,
    aliasName: $_aliasNameGenerator(db.tags.id, db.coffeeTags.tagId),
  );

  $$CoffeeTagsTableProcessedTableManager get coffeeTagsRefs {
    final manager = $$CoffeeTagsTableTableManager(
      $_db,
      $_db.coffeeTags,
    ).filter((f) => f.tagId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_coffeeTagsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$EntryTagsTable, List<EntryTag>>
  _entryTagsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.entryTags,
    aliasName: $_aliasNameGenerator(db.tags.id, db.entryTags.tagId),
  );

  $$EntryTagsTableProcessedTableManager get entryTagsRefs {
    final manager = $$EntryTagsTableTableManager(
      $_db,
      $_db.entryTags,
    ).filter((f) => f.tagId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_entryTagsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TemplateTagsTable, List<TemplateTag>>
  _templateTagsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.templateTags,
    aliasName: $_aliasNameGenerator(db.tags.id, db.templateTags.tagId),
  );

  $$TemplateTagsTableProcessedTableManager get templateTagsRefs {
    final manager = $$TemplateTagsTableTableManager(
      $_db,
      $_db.templateTags,
    ).filter((f) => f.tagId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_templateTagsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TagsTableFilterComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get usageCount => $composableBuilder(
    column: $table.usageCount,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> coffeeTagsRefs(
    Expression<bool> Function($$CoffeeTagsTableFilterComposer f) f,
  ) {
    final $$CoffeeTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.coffeeTags,
      getReferencedColumn: (t) => t.tagId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeeTagsTableFilterComposer(
            $db: $db,
            $table: $db.coffeeTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> entryTagsRefs(
    Expression<bool> Function($$EntryTagsTableFilterComposer f) f,
  ) {
    final $$EntryTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.entryTags,
      getReferencedColumn: (t) => t.tagId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntryTagsTableFilterComposer(
            $db: $db,
            $table: $db.entryTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> templateTagsRefs(
    Expression<bool> Function($$TemplateTagsTableFilterComposer f) f,
  ) {
    final $$TemplateTagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.templateTags,
      getReferencedColumn: (t) => t.tagId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplateTagsTableFilterComposer(
            $db: $db,
            $table: $db.templateTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TagsTableOrderingComposer extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get usageCount => $composableBuilder(
    column: $table.usageCount,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TagsTable> {
  $$TagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get normalizedName => $composableBuilder(
    column: $table.normalizedName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get usageCount => $composableBuilder(
    column: $table.usageCount,
    builder: (column) => column,
  );

  Expression<T> coffeeTagsRefs<T extends Object>(
    Expression<T> Function($$CoffeeTagsTableAnnotationComposer a) f,
  ) {
    final $$CoffeeTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.coffeeTags,
      getReferencedColumn: (t) => t.tagId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeeTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.coffeeTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> entryTagsRefs<T extends Object>(
    Expression<T> Function($$EntryTagsTableAnnotationComposer a) f,
  ) {
    final $$EntryTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.entryTags,
      getReferencedColumn: (t) => t.tagId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntryTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.entryTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> templateTagsRefs<T extends Object>(
    Expression<T> Function($$TemplateTagsTableAnnotationComposer a) f,
  ) {
    final $$TemplateTagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.templateTags,
      getReferencedColumn: (t) => t.tagId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplateTagsTableAnnotationComposer(
            $db: $db,
            $table: $db.templateTags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TagsTable,
          Tag,
          $$TagsTableFilterComposer,
          $$TagsTableOrderingComposer,
          $$TagsTableAnnotationComposer,
          $$TagsTableCreateCompanionBuilder,
          $$TagsTableUpdateCompanionBuilder,
          (Tag, $$TagsTableReferences),
          Tag,
          PrefetchHooks Function({
            bool coffeeTagsRefs,
            bool entryTagsRefs,
            bool templateTagsRefs,
          })
        > {
  $$TagsTableTableManager(_$AppDatabase db, $TagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> normalizedName = const Value.absent(),
                Value<int> usageCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TagsCompanion(
                id: id,
                name: name,
                normalizedName: normalizedName,
                usageCount: usageCount,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required String normalizedName,
                Value<int> usageCount = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TagsCompanion.insert(
                id: id,
                name: name,
                normalizedName: normalizedName,
                usageCount: usageCount,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$TagsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                coffeeTagsRefs = false,
                entryTagsRefs = false,
                templateTagsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (coffeeTagsRefs) db.coffeeTags,
                    if (entryTagsRefs) db.entryTags,
                    if (templateTagsRefs) db.templateTags,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (coffeeTagsRefs)
                        await $_getPrefetchedData<Tag, $TagsTable, CoffeeTag>(
                          currentTable: table,
                          referencedTable: $$TagsTableReferences
                              ._coffeeTagsRefsTable(db),
                          managerFromTypedResult: (p0) => $$TagsTableReferences(
                            db,
                            table,
                            p0,
                          ).coffeeTagsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.tagId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (entryTagsRefs)
                        await $_getPrefetchedData<Tag, $TagsTable, EntryTag>(
                          currentTable: table,
                          referencedTable: $$TagsTableReferences
                              ._entryTagsRefsTable(db),
                          managerFromTypedResult: (p0) => $$TagsTableReferences(
                            db,
                            table,
                            p0,
                          ).entryTagsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.tagId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (templateTagsRefs)
                        await $_getPrefetchedData<Tag, $TagsTable, TemplateTag>(
                          currentTable: table,
                          referencedTable: $$TagsTableReferences
                              ._templateTagsRefsTable(db),
                          managerFromTypedResult: (p0) => $$TagsTableReferences(
                            db,
                            table,
                            p0,
                          ).templateTagsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.tagId == item.id,
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

typedef $$TagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TagsTable,
      Tag,
      $$TagsTableFilterComposer,
      $$TagsTableOrderingComposer,
      $$TagsTableAnnotationComposer,
      $$TagsTableCreateCompanionBuilder,
      $$TagsTableUpdateCompanionBuilder,
      (Tag, $$TagsTableReferences),
      Tag,
      PrefetchHooks Function({
        bool coffeeTagsRefs,
        bool entryTagsRefs,
        bool templateTagsRefs,
      })
    >;
typedef $$CoffeeTagsTableCreateCompanionBuilder =
    CoffeeTagsCompanion Function({
      required String coffeeId,
      required String tagId,
      Value<int> rowid,
    });
typedef $$CoffeeTagsTableUpdateCompanionBuilder =
    CoffeeTagsCompanion Function({
      Value<String> coffeeId,
      Value<String> tagId,
      Value<int> rowid,
    });

final class $$CoffeeTagsTableReferences
    extends BaseReferences<_$AppDatabase, $CoffeeTagsTable, CoffeeTag> {
  $$CoffeeTagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CoffeesTable _coffeeIdTable(_$AppDatabase db) => db.coffees
      .createAlias($_aliasNameGenerator(db.coffeeTags.coffeeId, db.coffees.id));

  $$CoffeesTableProcessedTableManager get coffeeId {
    final $_column = $_itemColumn<String>('coffee_id')!;

    final manager = $$CoffeesTableTableManager(
      $_db,
      $_db.coffees,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_coffeeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TagsTable _tagIdTable(_$AppDatabase db) => db.tags.createAlias(
    $_aliasNameGenerator(db.coffeeTags.tagId, db.tags.id),
  );

  $$TagsTableProcessedTableManager get tagId {
    final $_column = $_itemColumn<String>('tag_id')!;

    final manager = $$TagsTableTableManager(
      $_db,
      $_db.tags,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tagIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CoffeeTagsTableFilterComposer
    extends Composer<_$AppDatabase, $CoffeeTagsTable> {
  $$CoffeeTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$CoffeesTableFilterComposer get coffeeId {
    final $$CoffeesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coffeeId,
      referencedTable: $db.coffees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeesTableFilterComposer(
            $db: $db,
            $table: $db.coffees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableFilterComposer get tagId {
    final $$TagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableFilterComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CoffeeTagsTableOrderingComposer
    extends Composer<_$AppDatabase, $CoffeeTagsTable> {
  $$CoffeeTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$CoffeesTableOrderingComposer get coffeeId {
    final $$CoffeesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coffeeId,
      referencedTable: $db.coffees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeesTableOrderingComposer(
            $db: $db,
            $table: $db.coffees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableOrderingComposer get tagId {
    final $$TagsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableOrderingComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CoffeeTagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $CoffeeTagsTable> {
  $$CoffeeTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$CoffeesTableAnnotationComposer get coffeeId {
    final $$CoffeesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.coffeeId,
      referencedTable: $db.coffees,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CoffeesTableAnnotationComposer(
            $db: $db,
            $table: $db.coffees,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableAnnotationComposer get tagId {
    final $$TagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableAnnotationComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CoffeeTagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CoffeeTagsTable,
          CoffeeTag,
          $$CoffeeTagsTableFilterComposer,
          $$CoffeeTagsTableOrderingComposer,
          $$CoffeeTagsTableAnnotationComposer,
          $$CoffeeTagsTableCreateCompanionBuilder,
          $$CoffeeTagsTableUpdateCompanionBuilder,
          (CoffeeTag, $$CoffeeTagsTableReferences),
          CoffeeTag,
          PrefetchHooks Function({bool coffeeId, bool tagId})
        > {
  $$CoffeeTagsTableTableManager(_$AppDatabase db, $CoffeeTagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CoffeeTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CoffeeTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CoffeeTagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> coffeeId = const Value.absent(),
                Value<String> tagId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CoffeeTagsCompanion(
                coffeeId: coffeeId,
                tagId: tagId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String coffeeId,
                required String tagId,
                Value<int> rowid = const Value.absent(),
              }) => CoffeeTagsCompanion.insert(
                coffeeId: coffeeId,
                tagId: tagId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CoffeeTagsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({coffeeId = false, tagId = false}) {
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
                    if (coffeeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.coffeeId,
                                referencedTable: $$CoffeeTagsTableReferences
                                    ._coffeeIdTable(db),
                                referencedColumn: $$CoffeeTagsTableReferences
                                    ._coffeeIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (tagId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.tagId,
                                referencedTable: $$CoffeeTagsTableReferences
                                    ._tagIdTable(db),
                                referencedColumn: $$CoffeeTagsTableReferences
                                    ._tagIdTable(db)
                                    .id,
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

typedef $$CoffeeTagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CoffeeTagsTable,
      CoffeeTag,
      $$CoffeeTagsTableFilterComposer,
      $$CoffeeTagsTableOrderingComposer,
      $$CoffeeTagsTableAnnotationComposer,
      $$CoffeeTagsTableCreateCompanionBuilder,
      $$CoffeeTagsTableUpdateCompanionBuilder,
      (CoffeeTag, $$CoffeeTagsTableReferences),
      CoffeeTag,
      PrefetchHooks Function({bool coffeeId, bool tagId})
    >;
typedef $$EntryTagsTableCreateCompanionBuilder =
    EntryTagsCompanion Function({
      required String entryId,
      required String tagId,
      Value<int> rowid,
    });
typedef $$EntryTagsTableUpdateCompanionBuilder =
    EntryTagsCompanion Function({
      Value<String> entryId,
      Value<String> tagId,
      Value<int> rowid,
    });

final class $$EntryTagsTableReferences
    extends BaseReferences<_$AppDatabase, $EntryTagsTable, EntryTag> {
  $$EntryTagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EntriesTable _entryIdTable(_$AppDatabase db) => db.entries
      .createAlias($_aliasNameGenerator(db.entryTags.entryId, db.entries.id));

  $$EntriesTableProcessedTableManager get entryId {
    final $_column = $_itemColumn<String>('entry_id')!;

    final manager = $$EntriesTableTableManager(
      $_db,
      $_db.entries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_entryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TagsTable _tagIdTable(_$AppDatabase db) =>
      db.tags.createAlias($_aliasNameGenerator(db.entryTags.tagId, db.tags.id));

  $$TagsTableProcessedTableManager get tagId {
    final $_column = $_itemColumn<String>('tag_id')!;

    final manager = $$TagsTableTableManager(
      $_db,
      $_db.tags,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tagIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$EntryTagsTableFilterComposer
    extends Composer<_$AppDatabase, $EntryTagsTable> {
  $$EntryTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$EntriesTableFilterComposer get entryId {
    final $$EntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.entries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntriesTableFilterComposer(
            $db: $db,
            $table: $db.entries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableFilterComposer get tagId {
    final $$TagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableFilterComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EntryTagsTableOrderingComposer
    extends Composer<_$AppDatabase, $EntryTagsTable> {
  $$EntryTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$EntriesTableOrderingComposer get entryId {
    final $$EntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.entries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntriesTableOrderingComposer(
            $db: $db,
            $table: $db.entries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableOrderingComposer get tagId {
    final $$TagsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableOrderingComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EntryTagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EntryTagsTable> {
  $$EntryTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$EntriesTableAnnotationComposer get entryId {
    final $$EntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.entryId,
      referencedTable: $db.entries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.entries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableAnnotationComposer get tagId {
    final $$TagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableAnnotationComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EntryTagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EntryTagsTable,
          EntryTag,
          $$EntryTagsTableFilterComposer,
          $$EntryTagsTableOrderingComposer,
          $$EntryTagsTableAnnotationComposer,
          $$EntryTagsTableCreateCompanionBuilder,
          $$EntryTagsTableUpdateCompanionBuilder,
          (EntryTag, $$EntryTagsTableReferences),
          EntryTag,
          PrefetchHooks Function({bool entryId, bool tagId})
        > {
  $$EntryTagsTableTableManager(_$AppDatabase db, $EntryTagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EntryTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EntryTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EntryTagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> entryId = const Value.absent(),
                Value<String> tagId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EntryTagsCompanion(
                entryId: entryId,
                tagId: tagId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String entryId,
                required String tagId,
                Value<int> rowid = const Value.absent(),
              }) => EntryTagsCompanion.insert(
                entryId: entryId,
                tagId: tagId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$EntryTagsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({entryId = false, tagId = false}) {
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
                    if (entryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.entryId,
                                referencedTable: $$EntryTagsTableReferences
                                    ._entryIdTable(db),
                                referencedColumn: $$EntryTagsTableReferences
                                    ._entryIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (tagId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.tagId,
                                referencedTable: $$EntryTagsTableReferences
                                    ._tagIdTable(db),
                                referencedColumn: $$EntryTagsTableReferences
                                    ._tagIdTable(db)
                                    .id,
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

typedef $$EntryTagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EntryTagsTable,
      EntryTag,
      $$EntryTagsTableFilterComposer,
      $$EntryTagsTableOrderingComposer,
      $$EntryTagsTableAnnotationComposer,
      $$EntryTagsTableCreateCompanionBuilder,
      $$EntryTagsTableUpdateCompanionBuilder,
      (EntryTag, $$EntryTagsTableReferences),
      EntryTag,
      PrefetchHooks Function({bool entryId, bool tagId})
    >;
typedef $$TemplateTagsTableCreateCompanionBuilder =
    TemplateTagsCompanion Function({
      required String templateId,
      required String tagId,
      Value<int> rowid,
    });
typedef $$TemplateTagsTableUpdateCompanionBuilder =
    TemplateTagsCompanion Function({
      Value<String> templateId,
      Value<String> tagId,
      Value<int> rowid,
    });

final class $$TemplateTagsTableReferences
    extends BaseReferences<_$AppDatabase, $TemplateTagsTable, TemplateTag> {
  $$TemplateTagsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $TemplatesTable _templateIdTable(_$AppDatabase db) =>
      db.templates.createAlias(
        $_aliasNameGenerator(db.templateTags.templateId, db.templates.id),
      );

  $$TemplatesTableProcessedTableManager get templateId {
    final $_column = $_itemColumn<String>('template_id')!;

    final manager = $$TemplatesTableTableManager(
      $_db,
      $_db.templates,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_templateIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TagsTable _tagIdTable(_$AppDatabase db) => db.tags.createAlias(
    $_aliasNameGenerator(db.templateTags.tagId, db.tags.id),
  );

  $$TagsTableProcessedTableManager get tagId {
    final $_column = $_itemColumn<String>('tag_id')!;

    final manager = $$TagsTableTableManager(
      $_db,
      $_db.tags,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_tagIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TemplateTagsTableFilterComposer
    extends Composer<_$AppDatabase, $TemplateTagsTable> {
  $$TemplateTagsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$TemplatesTableFilterComposer get templateId {
    final $$TemplatesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateId,
      referencedTable: $db.templates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplatesTableFilterComposer(
            $db: $db,
            $table: $db.templates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableFilterComposer get tagId {
    final $$TagsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableFilterComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TemplateTagsTableOrderingComposer
    extends Composer<_$AppDatabase, $TemplateTagsTable> {
  $$TemplateTagsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$TemplatesTableOrderingComposer get templateId {
    final $$TemplatesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateId,
      referencedTable: $db.templates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplatesTableOrderingComposer(
            $db: $db,
            $table: $db.templates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableOrderingComposer get tagId {
    final $$TagsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableOrderingComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TemplateTagsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TemplateTagsTable> {
  $$TemplateTagsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$TemplatesTableAnnotationComposer get templateId {
    final $$TemplatesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.templateId,
      referencedTable: $db.templates,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TemplatesTableAnnotationComposer(
            $db: $db,
            $table: $db.templates,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TagsTableAnnotationComposer get tagId {
    final $$TagsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tagId,
      referencedTable: $db.tags,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TagsTableAnnotationComposer(
            $db: $db,
            $table: $db.tags,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TemplateTagsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TemplateTagsTable,
          TemplateTag,
          $$TemplateTagsTableFilterComposer,
          $$TemplateTagsTableOrderingComposer,
          $$TemplateTagsTableAnnotationComposer,
          $$TemplateTagsTableCreateCompanionBuilder,
          $$TemplateTagsTableUpdateCompanionBuilder,
          (TemplateTag, $$TemplateTagsTableReferences),
          TemplateTag,
          PrefetchHooks Function({bool templateId, bool tagId})
        > {
  $$TemplateTagsTableTableManager(_$AppDatabase db, $TemplateTagsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TemplateTagsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TemplateTagsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TemplateTagsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> templateId = const Value.absent(),
                Value<String> tagId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TemplateTagsCompanion(
                templateId: templateId,
                tagId: tagId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String templateId,
                required String tagId,
                Value<int> rowid = const Value.absent(),
              }) => TemplateTagsCompanion.insert(
                templateId: templateId,
                tagId: tagId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TemplateTagsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({templateId = false, tagId = false}) {
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
                    if (templateId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.templateId,
                                referencedTable: $$TemplateTagsTableReferences
                                    ._templateIdTable(db),
                                referencedColumn: $$TemplateTagsTableReferences
                                    ._templateIdTable(db)
                                    .id,
                              )
                              as T;
                    }
                    if (tagId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.tagId,
                                referencedTable: $$TemplateTagsTableReferences
                                    ._tagIdTable(db),
                                referencedColumn: $$TemplateTagsTableReferences
                                    ._tagIdTable(db)
                                    .id,
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

typedef $$TemplateTagsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TemplateTagsTable,
      TemplateTag,
      $$TemplateTagsTableFilterComposer,
      $$TemplateTagsTableOrderingComposer,
      $$TemplateTagsTableAnnotationComposer,
      $$TemplateTagsTableCreateCompanionBuilder,
      $$TemplateTagsTableUpdateCompanionBuilder,
      (TemplateTag, $$TemplateTagsTableReferences),
      TemplateTag,
      PrefetchHooks Function({bool templateId, bool tagId})
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> key = const Value.absent(),
                Value<String> value = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;
typedef $$BrewMethodsTableCreateCompanionBuilder =
    BrewMethodsCompanion Function({
      required String name,
      required int sortOrder,
      Value<bool> isActive,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$BrewMethodsTableUpdateCompanionBuilder =
    BrewMethodsCompanion Function({
      Value<String> name,
      Value<int> sortOrder,
      Value<bool> isActive,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$BrewMethodsTableFilterComposer
    extends Composer<_$AppDatabase, $BrewMethodsTable> {
  $$BrewMethodsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$BrewMethodsTableOrderingComposer
    extends Composer<_$AppDatabase, $BrewMethodsTable> {
  $$BrewMethodsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$BrewMethodsTableAnnotationComposer
    extends Composer<_$AppDatabase, $BrewMethodsTable> {
  $$BrewMethodsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$BrewMethodsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $BrewMethodsTable,
          BrewMethod,
          $$BrewMethodsTableFilterComposer,
          $$BrewMethodsTableOrderingComposer,
          $$BrewMethodsTableAnnotationComposer,
          $$BrewMethodsTableCreateCompanionBuilder,
          $$BrewMethodsTableUpdateCompanionBuilder,
          (
            BrewMethod,
            BaseReferences<_$AppDatabase, $BrewMethodsTable, BrewMethod>,
          ),
          BrewMethod,
          PrefetchHooks Function()
        > {
  $$BrewMethodsTableTableManager(_$AppDatabase db, $BrewMethodsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$BrewMethodsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$BrewMethodsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$BrewMethodsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> name = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => BrewMethodsCompanion(
                name: name,
                sortOrder: sortOrder,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String name,
                required int sortOrder,
                Value<bool> isActive = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => BrewMethodsCompanion.insert(
                name: name,
                sortOrder: sortOrder,
                isActive: isActive,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$BrewMethodsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $BrewMethodsTable,
      BrewMethod,
      $$BrewMethodsTableFilterComposer,
      $$BrewMethodsTableOrderingComposer,
      $$BrewMethodsTableAnnotationComposer,
      $$BrewMethodsTableCreateCompanionBuilder,
      $$BrewMethodsTableUpdateCompanionBuilder,
      (
        BrewMethod,
        BaseReferences<_$AppDatabase, $BrewMethodsTable, BrewMethod>,
      ),
      BrewMethod,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CoffeesTableTableManager get coffees =>
      $$CoffeesTableTableManager(_db, _db.coffees);
  $$EntriesTableTableManager get entries =>
      $$EntriesTableTableManager(_db, _db.entries);
  $$EntryStepsTableTableManager get entrySteps =>
      $$EntryStepsTableTableManager(_db, _db.entrySteps);
  $$TemplatesTableTableManager get templates =>
      $$TemplatesTableTableManager(_db, _db.templates);
  $$TemplateStepsTableTableManager get templateSteps =>
      $$TemplateStepsTableTableManager(_db, _db.templateSteps);
  $$TagsTableTableManager get tags => $$TagsTableTableManager(_db, _db.tags);
  $$CoffeeTagsTableTableManager get coffeeTags =>
      $$CoffeeTagsTableTableManager(_db, _db.coffeeTags);
  $$EntryTagsTableTableManager get entryTags =>
      $$EntryTagsTableTableManager(_db, _db.entryTags);
  $$TemplateTagsTableTableManager get templateTags =>
      $$TemplateTagsTableTableManager(_db, _db.templateTags);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
  $$BrewMethodsTableTableManager get brewMethods =>
      $$BrewMethodsTableTableManager(_db, _db.brewMethods);
}

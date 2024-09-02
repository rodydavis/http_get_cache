// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class HttpCache extends Table with TableInfo<HttpCache, HttpCacheData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  HttpCache(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _headersMeta =
      const VerificationMeta('headers');
  late final GeneratedColumn<String> headers = GeneratedColumn<String>(
      'headers', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
      'body', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  late final GeneratedColumn<int> date = GeneratedColumn<int>(
      'date', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _maxAgeMeta = const VerificationMeta('maxAge');
  late final GeneratedColumn<int> maxAge = GeneratedColumn<int>(
      'max_age', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _staleWhileRevalidateMeta =
      const VerificationMeta('staleWhileRevalidate');
  late final GeneratedColumn<int> staleWhileRevalidate = GeneratedColumn<int>(
      'stale_while_revalidate', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _staleIfErrorMeta =
      const VerificationMeta('staleIfError');
  late final GeneratedColumn<int> staleIfError = GeneratedColumn<int>(
      'stale_if_error', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _immutableMeta =
      const VerificationMeta('immutable');
  late final GeneratedColumn<bool> immutable = GeneratedColumn<bool>(
      'immutable', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        url,
        headers,
        body,
        date,
        maxAge,
        staleWhileRevalidate,
        staleIfError,
        immutable
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'http_cache';
  @override
  VerificationContext validateIntegrity(Insertable<HttpCacheData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    } else if (isInserting) {
      context.missing(_urlMeta);
    }
    if (data.containsKey('headers')) {
      context.handle(_headersMeta,
          headers.isAcceptableOrUnknown(data['headers']!, _headersMeta));
    } else if (isInserting) {
      context.missing(_headersMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
          _bodyMeta, body.isAcceptableOrUnknown(data['body']!, _bodyMeta));
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('max_age')) {
      context.handle(_maxAgeMeta,
          maxAge.isAcceptableOrUnknown(data['max_age']!, _maxAgeMeta));
    } else if (isInserting) {
      context.missing(_maxAgeMeta);
    }
    if (data.containsKey('stale_while_revalidate')) {
      context.handle(
          _staleWhileRevalidateMeta,
          staleWhileRevalidate.isAcceptableOrUnknown(
              data['stale_while_revalidate']!, _staleWhileRevalidateMeta));
    } else if (isInserting) {
      context.missing(_staleWhileRevalidateMeta);
    }
    if (data.containsKey('stale_if_error')) {
      context.handle(
          _staleIfErrorMeta,
          staleIfError.isAcceptableOrUnknown(
              data['stale_if_error']!, _staleIfErrorMeta));
    } else if (isInserting) {
      context.missing(_staleIfErrorMeta);
    }
    if (data.containsKey('immutable')) {
      context.handle(_immutableMeta,
          immutable.isAcceptableOrUnknown(data['immutable']!, _immutableMeta));
    } else if (isInserting) {
      context.missing(_immutableMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
        {url},
      ];
  @override
  HttpCacheData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HttpCacheData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url'])!,
      headers: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}headers'])!,
      body: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}body'])!,
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}date'])!,
      maxAge: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}max_age'])!,
      staleWhileRevalidate: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}stale_while_revalidate'])!,
      staleIfError: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}stale_if_error'])!,
      immutable: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}immutable'])!,
    );
  }

  @override
  HttpCache createAlias(String alias) {
    return HttpCache(attachedDatabase, alias);
  }

  @override
  List<String> get customConstraints => const ['UNIQUE(url)'];
  @override
  bool get dontWriteConstraints => true;
}

class HttpCacheData extends DataClass implements Insertable<HttpCacheData> {
  int id;
  String url;
  String headers;
  String body;
  int date;
  int maxAge;
  int staleWhileRevalidate;
  int staleIfError;
  bool immutable;
  HttpCacheData(
      {required this.id,
      required this.url,
      required this.headers,
      required this.body,
      required this.date,
      required this.maxAge,
      required this.staleWhileRevalidate,
      required this.staleIfError,
      required this.immutable});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['url'] = Variable<String>(url);
    map['headers'] = Variable<String>(headers);
    map['body'] = Variable<String>(body);
    map['date'] = Variable<int>(date);
    map['max_age'] = Variable<int>(maxAge);
    map['stale_while_revalidate'] = Variable<int>(staleWhileRevalidate);
    map['stale_if_error'] = Variable<int>(staleIfError);
    map['immutable'] = Variable<bool>(immutable);
    return map;
  }

  HttpCacheCompanion toCompanion(bool nullToAbsent) {
    return HttpCacheCompanion(
      id: Value(id),
      url: Value(url),
      headers: Value(headers),
      body: Value(body),
      date: Value(date),
      maxAge: Value(maxAge),
      staleWhileRevalidate: Value(staleWhileRevalidate),
      staleIfError: Value(staleIfError),
      immutable: Value(immutable),
    );
  }

  factory HttpCacheData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HttpCacheData(
      id: serializer.fromJson<int>(json['id']),
      url: serializer.fromJson<String>(json['url']),
      headers: serializer.fromJson<String>(json['headers']),
      body: serializer.fromJson<String>(json['body']),
      date: serializer.fromJson<int>(json['date']),
      maxAge: serializer.fromJson<int>(json['max_age']),
      staleWhileRevalidate:
          serializer.fromJson<int>(json['stale_while_revalidate']),
      staleIfError: serializer.fromJson<int>(json['stale_if_error']),
      immutable: serializer.fromJson<bool>(json['immutable']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'url': serializer.toJson<String>(url),
      'headers': serializer.toJson<String>(headers),
      'body': serializer.toJson<String>(body),
      'date': serializer.toJson<int>(date),
      'max_age': serializer.toJson<int>(maxAge),
      'stale_while_revalidate': serializer.toJson<int>(staleWhileRevalidate),
      'stale_if_error': serializer.toJson<int>(staleIfError),
      'immutable': serializer.toJson<bool>(immutable),
    };
  }

  HttpCacheData copyWith(
          {int? id,
          String? url,
          String? headers,
          String? body,
          int? date,
          int? maxAge,
          int? staleWhileRevalidate,
          int? staleIfError,
          bool? immutable}) =>
      HttpCacheData(
        id: id ?? this.id,
        url: url ?? this.url,
        headers: headers ?? this.headers,
        body: body ?? this.body,
        date: date ?? this.date,
        maxAge: maxAge ?? this.maxAge,
        staleWhileRevalidate: staleWhileRevalidate ?? this.staleWhileRevalidate,
        staleIfError: staleIfError ?? this.staleIfError,
        immutable: immutable ?? this.immutable,
      );
  HttpCacheData copyWithCompanion(HttpCacheCompanion data) {
    return HttpCacheData(
      id: data.id.present ? data.id.value : this.id,
      url: data.url.present ? data.url.value : this.url,
      headers: data.headers.present ? data.headers.value : this.headers,
      body: data.body.present ? data.body.value : this.body,
      date: data.date.present ? data.date.value : this.date,
      maxAge: data.maxAge.present ? data.maxAge.value : this.maxAge,
      staleWhileRevalidate: data.staleWhileRevalidate.present
          ? data.staleWhileRevalidate.value
          : this.staleWhileRevalidate,
      staleIfError: data.staleIfError.present
          ? data.staleIfError.value
          : this.staleIfError,
      immutable: data.immutable.present ? data.immutable.value : this.immutable,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HttpCacheData(')
          ..write('id: $id, ')
          ..write('url: $url, ')
          ..write('headers: $headers, ')
          ..write('body: $body, ')
          ..write('date: $date, ')
          ..write('maxAge: $maxAge, ')
          ..write('staleWhileRevalidate: $staleWhileRevalidate, ')
          ..write('staleIfError: $staleIfError, ')
          ..write('immutable: $immutable')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, url, headers, body, date, maxAge,
      staleWhileRevalidate, staleIfError, immutable);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HttpCacheData &&
          other.id == this.id &&
          other.url == this.url &&
          other.headers == this.headers &&
          other.body == this.body &&
          other.date == this.date &&
          other.maxAge == this.maxAge &&
          other.staleWhileRevalidate == this.staleWhileRevalidate &&
          other.staleIfError == this.staleIfError &&
          other.immutable == this.immutable);
}

class HttpCacheCompanion extends UpdateCompanion<HttpCacheData> {
  Value<int> id;
  Value<String> url;
  Value<String> headers;
  Value<String> body;
  Value<int> date;
  Value<int> maxAge;
  Value<int> staleWhileRevalidate;
  Value<int> staleIfError;
  Value<bool> immutable;
  HttpCacheCompanion({
    this.id = const Value.absent(),
    this.url = const Value.absent(),
    this.headers = const Value.absent(),
    this.body = const Value.absent(),
    this.date = const Value.absent(),
    this.maxAge = const Value.absent(),
    this.staleWhileRevalidate = const Value.absent(),
    this.staleIfError = const Value.absent(),
    this.immutable = const Value.absent(),
  });
  HttpCacheCompanion.insert({
    this.id = const Value.absent(),
    required String url,
    required String headers,
    required String body,
    required int date,
    required int maxAge,
    required int staleWhileRevalidate,
    required int staleIfError,
    required bool immutable,
  })  : url = Value(url),
        headers = Value(headers),
        body = Value(body),
        date = Value(date),
        maxAge = Value(maxAge),
        staleWhileRevalidate = Value(staleWhileRevalidate),
        staleIfError = Value(staleIfError),
        immutable = Value(immutable);
  static Insertable<HttpCacheData> custom({
    Expression<int>? id,
    Expression<String>? url,
    Expression<String>? headers,
    Expression<String>? body,
    Expression<int>? date,
    Expression<int>? maxAge,
    Expression<int>? staleWhileRevalidate,
    Expression<int>? staleIfError,
    Expression<bool>? immutable,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (url != null) 'url': url,
      if (headers != null) 'headers': headers,
      if (body != null) 'body': body,
      if (date != null) 'date': date,
      if (maxAge != null) 'max_age': maxAge,
      if (staleWhileRevalidate != null)
        'stale_while_revalidate': staleWhileRevalidate,
      if (staleIfError != null) 'stale_if_error': staleIfError,
      if (immutable != null) 'immutable': immutable,
    });
  }

  HttpCacheCompanion copyWith(
      {Value<int>? id,
      Value<String>? url,
      Value<String>? headers,
      Value<String>? body,
      Value<int>? date,
      Value<int>? maxAge,
      Value<int>? staleWhileRevalidate,
      Value<int>? staleIfError,
      Value<bool>? immutable}) {
    return HttpCacheCompanion(
      id: id ?? this.id,
      url: url ?? this.url,
      headers: headers ?? this.headers,
      body: body ?? this.body,
      date: date ?? this.date,
      maxAge: maxAge ?? this.maxAge,
      staleWhileRevalidate: staleWhileRevalidate ?? this.staleWhileRevalidate,
      staleIfError: staleIfError ?? this.staleIfError,
      immutable: immutable ?? this.immutable,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (headers.present) {
      map['headers'] = Variable<String>(headers.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (date.present) {
      map['date'] = Variable<int>(date.value);
    }
    if (maxAge.present) {
      map['max_age'] = Variable<int>(maxAge.value);
    }
    if (staleWhileRevalidate.present) {
      map['stale_while_revalidate'] = Variable<int>(staleWhileRevalidate.value);
    }
    if (staleIfError.present) {
      map['stale_if_error'] = Variable<int>(staleIfError.value);
    }
    if (immutable.present) {
      map['immutable'] = Variable<bool>(immutable.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HttpCacheCompanion(')
          ..write('id: $id, ')
          ..write('url: $url, ')
          ..write('headers: $headers, ')
          ..write('body: $body, ')
          ..write('date: $date, ')
          ..write('maxAge: $maxAge, ')
          ..write('staleWhileRevalidate: $staleWhileRevalidate, ')
          ..write('staleIfError: $staleIfError, ')
          ..write('immutable: $immutable')
          ..write(')'))
        .toString();
  }
}

abstract class _$HttpGetCacheDatabase extends GeneratedDatabase {
  _$HttpGetCacheDatabase(QueryExecutor e) : super(e);
  $HttpGetCacheDatabaseManager get managers =>
      $HttpGetCacheDatabaseManager(this);
  late final HttpCache httpCache = HttpCache(this);
  late final Index httpCacheIdx = Index('http_cache_idx',
      'CREATE UNIQUE INDEX http_cache_idx ON http_cache (url, date, max_age, stale_if_error, stale_while_revalidate)');
  Future<List<HttpCacheData>> setHttpCache(
      {required String url,
      required String headers,
      required String body,
      required int date,
      required int maxAge,
      required int staleWhileRevalidate,
      required int staleIfError,
      required bool immutable}) {
    return customWriteReturning(
        'INSERT OR REPLACE INTO http_cache (url, headers, body, date, max_age, stale_while_revalidate, stale_if_error, immutable) VALUES (?1, ?2, ?3, ?4, ?5, ?6, ?7, ?8) RETURNING *',
        variables: [
          Variable<String>(url),
          Variable<String>(headers),
          Variable<String>(body),
          Variable<int>(date),
          Variable<int>(maxAge),
          Variable<int>(staleWhileRevalidate),
          Variable<int>(staleIfError),
          Variable<bool>(immutable)
        ],
        updates: {
          httpCache
        }).then((rows) => Future.wait(rows.map(httpCache.mapFromRow)));
  }

  Selectable<HttpCacheData> getHttpCacheByUrl({required String url}) {
    return customSelect('SELECT * FROM http_cache WHERE url = ?1', variables: [
      Variable<String>(url)
    ], readsFrom: {
      httpCache,
    }).asyncMap(httpCache.mapFromRow);
  }

  Selectable<HttpCacheData> getHttpCache({required String url}) {
    return customSelect('SELECT * FROM http_cache WHERE url = ?1', variables: [
      Variable<String>(url)
    ], readsFrom: {
      httpCache,
    }).asyncMap(httpCache.mapFromRow);
  }

  Future<int> deleteHttpCache({required String url}) {
    return customUpdate(
      'DELETE FROM http_cache WHERE url = ?1',
      variables: [Variable<String>(url)],
      updates: {httpCache},
      updateKind: UpdateKind.delete,
    );
  }

  Future<int> deleteHttpCacheStale() {
    return customUpdate(
      'DELETE FROM http_cache WHERE unixepoch() >(date +(max_age * 1000)+(MAX(stale_while_revalidate, stale_if_error) * 1000))',
      variables: [],
      updates: {httpCache},
      updateKind: UpdateKind.delete,
    );
  }

  Future<int> deleteHttpCacheStaleWithoutRevalidate() {
    return customUpdate(
      'DELETE FROM http_cache WHERE unixepoch() >(date +(max_age * 1000))',
      variables: [],
      updates: {httpCache},
      updateKind: UpdateKind.delete,
    );
  }

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [httpCache, httpCacheIdx];
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $HttpCacheCreateCompanionBuilder = HttpCacheCompanion Function({
  Value<int> id,
  required String url,
  required String headers,
  required String body,
  required int date,
  required int maxAge,
  required int staleWhileRevalidate,
  required int staleIfError,
  required bool immutable,
});
typedef $HttpCacheUpdateCompanionBuilder = HttpCacheCompanion Function({
  Value<int> id,
  Value<String> url,
  Value<String> headers,
  Value<String> body,
  Value<int> date,
  Value<int> maxAge,
  Value<int> staleWhileRevalidate,
  Value<int> staleIfError,
  Value<bool> immutable,
});

class $HttpCacheFilterComposer
    extends FilterComposer<_$HttpGetCacheDatabase, HttpCache> {
  $HttpCacheFilterComposer(super.$state);
  ColumnFilters<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get url => $state.composableBuilder(
      column: $state.table.url,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get headers => $state.composableBuilder(
      column: $state.table.headers,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<String> get body => $state.composableBuilder(
      column: $state.table.body,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get maxAge => $state.composableBuilder(
      column: $state.table.maxAge,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get staleWhileRevalidate => $state.composableBuilder(
      column: $state.table.staleWhileRevalidate,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<int> get staleIfError => $state.composableBuilder(
      column: $state.table.staleIfError,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));

  ColumnFilters<bool> get immutable => $state.composableBuilder(
      column: $state.table.immutable,
      builder: (column, joinBuilders) =>
          ColumnFilters(column, joinBuilders: joinBuilders));
}

class $HttpCacheOrderingComposer
    extends OrderingComposer<_$HttpGetCacheDatabase, HttpCache> {
  $HttpCacheOrderingComposer(super.$state);
  ColumnOrderings<int> get id => $state.composableBuilder(
      column: $state.table.id,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get url => $state.composableBuilder(
      column: $state.table.url,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get headers => $state.composableBuilder(
      column: $state.table.headers,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<String> get body => $state.composableBuilder(
      column: $state.table.body,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get date => $state.composableBuilder(
      column: $state.table.date,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get maxAge => $state.composableBuilder(
      column: $state.table.maxAge,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get staleWhileRevalidate => $state.composableBuilder(
      column: $state.table.staleWhileRevalidate,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<int> get staleIfError => $state.composableBuilder(
      column: $state.table.staleIfError,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));

  ColumnOrderings<bool> get immutable => $state.composableBuilder(
      column: $state.table.immutable,
      builder: (column, joinBuilders) =>
          ColumnOrderings(column, joinBuilders: joinBuilders));
}

class $HttpCacheTableManager extends RootTableManager<
    _$HttpGetCacheDatabase,
    HttpCache,
    HttpCacheData,
    $HttpCacheFilterComposer,
    $HttpCacheOrderingComposer,
    $HttpCacheCreateCompanionBuilder,
    $HttpCacheUpdateCompanionBuilder,
    (
      HttpCacheData,
      BaseReferences<_$HttpGetCacheDatabase, HttpCache, HttpCacheData>
    ),
    HttpCacheData,
    PrefetchHooks Function()> {
  $HttpCacheTableManager(_$HttpGetCacheDatabase db, HttpCache table)
      : super(TableManagerState(
          db: db,
          table: table,
          filteringComposer: $HttpCacheFilterComposer(ComposerState(db, table)),
          orderingComposer:
              $HttpCacheOrderingComposer(ComposerState(db, table)),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> url = const Value.absent(),
            Value<String> headers = const Value.absent(),
            Value<String> body = const Value.absent(),
            Value<int> date = const Value.absent(),
            Value<int> maxAge = const Value.absent(),
            Value<int> staleWhileRevalidate = const Value.absent(),
            Value<int> staleIfError = const Value.absent(),
            Value<bool> immutable = const Value.absent(),
          }) =>
              HttpCacheCompanion(
            id: id,
            url: url,
            headers: headers,
            body: body,
            date: date,
            maxAge: maxAge,
            staleWhileRevalidate: staleWhileRevalidate,
            staleIfError: staleIfError,
            immutable: immutable,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String url,
            required String headers,
            required String body,
            required int date,
            required int maxAge,
            required int staleWhileRevalidate,
            required int staleIfError,
            required bool immutable,
          }) =>
              HttpCacheCompanion.insert(
            id: id,
            url: url,
            headers: headers,
            body: body,
            date: date,
            maxAge: maxAge,
            staleWhileRevalidate: staleWhileRevalidate,
            staleIfError: staleIfError,
            immutable: immutable,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ));
}

typedef $HttpCacheProcessedTableManager = ProcessedTableManager<
    _$HttpGetCacheDatabase,
    HttpCache,
    HttpCacheData,
    $HttpCacheFilterComposer,
    $HttpCacheOrderingComposer,
    $HttpCacheCreateCompanionBuilder,
    $HttpCacheUpdateCompanionBuilder,
    (
      HttpCacheData,
      BaseReferences<_$HttpGetCacheDatabase, HttpCache, HttpCacheData>
    ),
    HttpCacheData,
    PrefetchHooks Function()>;

class $HttpGetCacheDatabaseManager {
  final _$HttpGetCacheDatabase _db;
  $HttpGetCacheDatabaseManager(this._db);
  $HttpCacheTableManager get httpCache =>
      $HttpCacheTableManager(_db, _db.httpCache);
}

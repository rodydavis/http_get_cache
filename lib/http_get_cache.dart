library http_get_cache;

export 'src/client/http_client.dart';
export 'src/http_get_cache.dart';

import 'dart:typed_data';

import 'package:sqlite3/common.dart';

import 'http_get_cache.dart';
import 'src/constants.dart';

export 'src/store/base.dart';
export 'src/store/sqlite.dart';
export 'src/database/settings.dart';
export 'src/database/connection/connect.dart';
export 'src/database/database.dart';

Future<HttpGetCacheDatabase> initHttpGetCache({
  String name = 'http-get-cache',
  bool logStatements = false,
  String driftWorkerUri = 'drift_worker.js',
  String sqlite3Uri = kDebugMode ? 'sqlite3.debug.wasm' : 'sqlite3.wasm',
  void Function(CommonDatabase)? setup,
  Future<Uint8List?> Function()? initializeDatabase,
  required String cachePath,
  required String databasePath,
}) async {
  final settings = DatabaseSettings(
    name,
    logStatements: logStatements,
    driftWorkerUri: driftWorkerUri,
    sqlite3Uri: sqlite3Uri,
    setup: setup,
    initializeDatabase: initializeDatabase,
    cacheDir: cachePath,
    databaseDir: databasePath,
  );
  final e = createExecutor(settings);
  final database = HttpGetCacheDatabase(settings, e);
  HttpGetCacheDatabase.instance = database;
  if (!kIsWeb) {
    SqliteHttpCacheStore.deleteExpired(database).ignore();
  }
  return database;
}

import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/common.dart';

import 'src/constants.dart';
import 'src/database/connection/connect.dart';
import 'src/database/connection/settings.dart';
import 'src/database/database.dart';

Future<HttpGetCacheDatabase> initFlutterHttpGetCache({
  String name = 'http-get-cache',
  bool logStatements = false,
  String driftWorkerUri = 'drift_worker.js',
  String sqlite3Uri = kDebugMode ? 'sqlite3.debug.wasm' : 'sqlite3.wasm',
  void Function(CommonDatabase)? setup,
  Future<Uint8List?> Function()? initializeDatabase,
  QueryExecutor? executor,
  String? cachePath,
  String? databasePath,
}) async {
  final settings = DatabaseSettings(
    name,
    logStatements: logStatements,
    driftWorkerUri: driftWorkerUri,
    sqlite3Uri: sqlite3Uri,
    setup: setup,
    initializeDatabase: initializeDatabase,
    cacheDir: await () async {
      if (cachePath != null) return cachePath;
      final dir = await getApplicationCacheDirectory();
      return dir.path;
    }(),
    databaseDir: await () async {
      if (databasePath != null) return databasePath;
      final dir = await getApplicationDocumentsDirectory();
      return dir.path;
    }(),
  );
  final e = executor ?? createExecutor(settings);
  final database = HttpGetCacheDatabase(settings, e);
  HttpGetCacheDatabase.instance = database;
  return database;
}

library http_get_cache_flutter;

import 'package:drift/drift.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/common.dart';

import 'http_get_cache.dart';
import 'src/constants.dart';

Future<HttpGetCacheDatabase> initFlutterHttpGetCache({
  String name = 'http-get-cache',
  bool logStatements = false,
  String driftWorkerUri = 'drift_worker.js',
  String sqlite3Uri = kDebugMode ? 'sqlite3.debug.wasm' : 'sqlite3.wasm',
  void Function(CommonDatabase)? setup,
  Future<Uint8List?> Function()? initializeDatabase,
}) async {
  final cacheDir = await getApplicationCacheDirectory();
  final databaseDir = await getApplicationDocumentsDirectory();
  return await initHttpGetCache(
    cachePath: cacheDir.path,
    databasePath: databaseDir.path,
    name: name,
    driftWorkerUri: driftWorkerUri,
    sqlite3Uri: sqlite3Uri,
    setup: setup,
    initializeDatabase: initializeDatabase,
    logStatements: logStatements,
  );
}

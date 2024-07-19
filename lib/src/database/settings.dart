import 'dart:typed_data';

import 'package:path/path.dart' as p;
import 'package:sqlite3/common.dart';

import '../constants.dart';

class DatabaseSettings {
  final String name;
  final bool logStatements;
  final String driftWorkerUri;
  final String sqlite3Uri;
  final String databaseDir;
  final String cacheDir;
  final void Function(CommonDatabase)? setup;
  final Future<Uint8List?> Function()? initializeDatabase;

  const DatabaseSettings(
    this.name, {
    this.logStatements = false,
    this.driftWorkerUri = 'drift_worker.js',
    this.sqlite3Uri = kDebugMode ? 'sqlite3.debug.wasm' : 'sqlite3.wasm',
    this.setup,
    this.initializeDatabase,
    required this.databaseDir,
    required this.cacheDir,
  });

  String get dbPath => p.join(databaseDir, name);
  String get cachePath => p.join(cacheDir, 'cache');
}

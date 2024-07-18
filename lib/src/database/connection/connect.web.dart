import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

import 'package:flutter/foundation.dart';

QueryExecutor createExecutor(
  String name, {
  bool logStatements = false,
}) {
  return DatabaseConnection.delayed(Future(() async {
    final db = await WasmDatabase.open(
      databaseName: name.split('.').first,
      sqlite3Uri: sqliteUrl(),
      driftWorkerUri: Uri.parse('drift_worker.js'),
    );

    if (db.missingFeatures.isNotEmpty) {
      debugPrint(
        'Using ${db.chosenImplementation} due to unsupported '
        'browser features: ${db.missingFeatures}',
      );
    }

    return db.resolvedExecutor;
  }));
}

Uri sqliteUrl() {
  // TODO: Server url
  if (kDebugMode) {
    return Uri.parse('sqlite3.debug.wasm');
  }
  return Uri.parse('sqlite3.wasm');
}

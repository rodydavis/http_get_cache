import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';

import '../settings.dart';

QueryExecutor createExecutor(DatabaseSettings settings) {
  return DatabaseConnection.delayed(Future(() async {
    final db = await WasmDatabase.open(
      databaseName: settings.name.split('.').first,
      sqlite3Uri: Uri.parse(settings.sqlite3Uri),
      driftWorkerUri: Uri.parse(settings.driftWorkerUri),
      localSetup: settings.setup,
      initializeDatabase: settings.initializeDatabase,
    );

    if (db.missingFeatures.isNotEmpty) {
      log(
        'Using ${db.chosenImplementation} due to unsupported '
        'browser features: ${db.missingFeatures}',
      );
    }

    return db.resolvedExecutor;
  }));
}

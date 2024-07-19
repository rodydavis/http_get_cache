import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'package:drift/native.dart';

import 'settings.dart';

LazyDatabase createExecutor(DatabaseSettings settings) {
  return LazyDatabase(() async {
    final dbFile = File(p.join(settings.dbPath, settings.name));
    if (!dbFile.existsSync()) {
      await dbFile.create(recursive: true);
      if (settings.initializeDatabase != null) {
        final bytes = await settings.initializeDatabase!();
        if (bytes != null) {
          await dbFile.writeAsBytes(bytes);
        }
      }
    }
    return NativeDatabase.createInBackground(
      dbFile,
      setup: settings.setup,
      logStatements: settings.logStatements,
    );
  });
}

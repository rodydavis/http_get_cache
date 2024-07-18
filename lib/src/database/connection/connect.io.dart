import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';

LazyDatabase createExecutor(
  String name, {
  bool logStatements = false,
}) {
  return LazyDatabase(() async {
    final appDir = await getApplicationDocumentsDirectory();
    final dbFile = File(p.join(appDir.path, name));
    return NativeDatabase.createInBackground(
      dbFile,
      // setup: (db) => setup(db),
      logStatements: logStatements,
    );
  });
}

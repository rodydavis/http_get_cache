import 'package:drift/native.dart';

import '../database.dart';
import '../settings.dart';

HttpGetCacheDatabase createMemoryDatabase(DatabaseSettings settings) {
  final e = NativeDatabase.memory(
    logStatements: settings.logStatements,
    setup: settings.setup,
  );
  return HttpGetCacheDatabase(settings, e);
}

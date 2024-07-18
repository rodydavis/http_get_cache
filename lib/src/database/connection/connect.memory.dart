import 'package:drift/native.dart';

import '../database.dart';

HttpCacheDatabase createMemoryDatabase({
  bool logStatements = false,
}) {
  final e = NativeDatabase.memory(
    logStatements: logStatements,
  );
  return HttpCacheDatabase(e);
}

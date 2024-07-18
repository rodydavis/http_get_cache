import 'connect.web.dart' if (dart.library.ffi) 'connect.io.dart';

import '../database.dart';

HttpCacheDatabase createDatabase(
  String name, {
  bool logStatements = false,
}) {
  final e = createExecutor(
    name,
    logStatements: logStatements,
  );
  return HttpCacheDatabase(e);
}

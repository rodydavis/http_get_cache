import 'package:drift/drift.dart';

import 'connection/connect.dart';

part 'database.g.dart';

@DriftDatabase(include: {
  "sql/http_cache.drift",
})
class HttpCacheDatabase extends _$HttpCacheDatabase {
  HttpCacheDatabase(super.e);

  @override
  int get schemaVersion => 2;

  static HttpCacheDatabase instance = createDatabase('http-cache');
}

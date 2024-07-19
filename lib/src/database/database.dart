import 'package:drift/drift.dart';
import 'settings.dart';

part 'database.g.dart';

@DriftDatabase(include: {
  "sql/http_cache.drift",
})
class HttpGetCacheDatabase extends _$HttpGetCacheDatabase {
  final DatabaseSettings settings;

  HttpGetCacheDatabase(this.settings, super.e);

  @override
  int get schemaVersion => 1;

  static HttpGetCacheDatabase? instance;
}

import 'dart:io';

import 'package:http/http.dart';
import 'package:http/io_client.dart';

import '../database/database.dart';
import '../http_get_cache.dart';
import '../store/sqlite.dart';

Client httpClient({
  String userAgent = 'Example',
  Client? innerClient,
}) {
  final store = SqliteHttpCacheStore(HttpCacheDatabase.instance);
  return HttpGetCache(
    () {
      if (innerClient != null) return innerClient;
      final client = HttpClient();
      client.userAgent = userAgent;
      return IOClient(client);
    }(),
    store,
  );
}

import 'package:fetch_client/fetch_client.dart';
import 'package:http/http.dart';

import '../http_get_cache.dart';
import '../store/base.dart';

Client httpClient({
  Client? innerClient,
  HttpCacheStore? store,
}) {
  return HttpGetCache(
    () {
      if (innerClient != null) return innerClient;
      return FetchClient(
        mode: RequestMode.cors,
        cache: RequestCache.byDefault,
        // streamRequests: true,
      );
    }(),
    store ?? HttpCacheStore(),
  );
}

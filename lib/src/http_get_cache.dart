import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart';

import 'constants.dart';
import 'request_headers.dart';
import 'date_parser.dart';
import 'store/base.dart';

class HttpGetCache extends BaseClient {
  final HttpCacheStore store;
  final Client inner;

  HttpGetCache(this.inner, this.store);

  static Future<StreamedResponse> networkError(Object? error) async {
    return StreamedResponse(
      Stream.value(utf8.encode('$error')),
      500,
    );
  }

  static Future<StreamedResponse> offlineError(Object? error) async {
    return StreamedResponse(
      Stream.value(utf8.encode('$error')),
      503,
    );
  }

  static Future<StreamedResponse> gatewayTimeout() async {
    return StreamedResponse(
      Stream.value(utf8.encode('Gateway Timeout')),
      504,
    );
  }

  Future<StreamedResponse> save(BaseRequest request) async {
    final reqCC = request.cacheControl;
    final res = await inner.send(request);
    final resCC = res.cacheControl;
    if (res.statusCode == 200) {
      if (reqCC.noStore || resCC.noStore || resCC.noCache) {
        return res;
      } else {
        return await store.set(request, res);
      }
    } else {
      final cached = await store.get(request);
      if (cached != null) {
        final cachedCC = cached.cacheControl;
        final now = getDateInt();
        final date = cached.requestHeaders.created;
        if (reqCC.staleIfError.$2 || resCC.staleIfError.$2) {
          return cached;
        } else if (date != null &&
            now <
                (date +
                    cachedCC.maxAge +
                    max(
                      cachedCC.staleIfError.$1,
                      reqCC.staleIfError.$1,
                    ))) {
          return cached;
        }
      }
    }
    return res;
  }

  Stream<StreamedResponse> stream(BaseRequest request) async* {
    final method = request.method.toLowerCase();
    final reqCC = request.cacheControl;

    if (kIsWeb || method != 'get') {
      yield await inner.send(request);
      return;
    }

    // Check for early fetch
    var cached = await store.get(request);
    bool needsUpdate = true;

    if (cached == null && reqCC.onlyIfCached) {
      yield await gatewayTimeout();
      return;
    }

    // Check for cache
    if (cached != null) {
      final cachedCC = cached.cacheControl;
      if (cachedCC.mustRevalidate || cachedCC.noCache || reqCC.noCache) {
        needsUpdate = true;
      } else {
        final now = getDateInt();
        final date = cached.requestHeaders.created;
        if (date != null && now < (date + cachedCC.maxAge)) {
          needsUpdate = false;
          yield cached;
        } else if (date != null &&
            now < (date + cachedCC.maxAge + cachedCC.staleWhileRevalidate.$1)) {
          yield cached;
        } else if (cachedCC.staleWhileRevalidate.$2) {
          yield cached;
        }

        if (!cachedCC.immutable && needsUpdate) {
          // Check for new eTag, Last-Modified change
          final headRes = await inner.head(request.url);
          final headHeaders = headRes.requestHeaders;
          if (headRes.statusCode == 200) {
            // Check eTag
            if ((cached.requestHeaders.eTag + headHeaders.eTag).isNotEmpty &&
                cached.requestHeaders.eTag == headHeaders.eTag) {
              needsUpdate = false;
            }
            if ((max(
                      cached.requestHeaders.lastModified ?? 0,
                      headHeaders.lastModified ?? 0,
                    ) >
                    0) &&
                cached.requestHeaders.lastModified ==
                    headHeaders.lastModified) {
              needsUpdate = false;
            }
          } else if (headRes.statusCode == 304) {
            // Or 304 cache is still good to reuse
            needsUpdate = false;
            if (cachedCC.mustRevalidate || cachedCC.noCache || reqCC.noCache) {
              yield cached;
            }
          }
        }
      }
    }

    if (!needsUpdate) return;
    yield await save(request);
  }

  @override
  Future<StreamedResponse> send(BaseRequest request) {
    return stream(request).last;
  }
}

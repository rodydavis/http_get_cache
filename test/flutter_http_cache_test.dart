import 'dart:convert';
import 'dart:io';

import 'package:http_get_cache/http_get_cache_store.dart';
import 'package:http_get_cache/src/http_get_cache.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late HttpGetCacheDatabase db;
  late SqliteHttpCacheStore store;

  setUp(() async {
    db = await initHttpGetCache(cachePath: 'temp', databasePath: 'temp');
    store = SqliteHttpCacheStore(db);
  });

  tearDown(() async {
    await db.close();
  });

  tearDownAll(() async {
    await Directory(db.settings.cacheDir).delete(recursive: true);
    // await Directory(db.settings.databaseDir).delete(recursive: true);
  });

  group('HttpGetCache', () {
    test('check for no cache headers', () async {
      final inner = TestHttpClient();
      final client = HttpGetCache(inner, store);

      var res = await client.get(Uri.http('example.com'));

      expect(res.statusCode, 200);
      expect(inner.calls, 1);

      res = await client.get(Uri.http('example.com'));

      expect(res.statusCode, 200);
      expect(inner.calls, 2);
    });

    test('check if cache-control header is respected', () async {
      final inner = TestHttpClient();
      const target = 'http://example.com/cache-control';
      inner.handle = (req) async {
        return Response('', 200, headers: {
          'Cache-Control': 'public, immutable',
        });
      };
      final client = HttpGetCache(inner, store);

      var res = await client.get(Uri.parse(target));

      expect(res.statusCode, 200);
      expect(res.headers['Cache-Control'], 'public, immutable');
      expect(inner.calls, 1);

      res = await client.get(Uri.parse(target));

      expect(res.statusCode, 200);
      expect(res.headers['Cache-Control'], 'public, immutable');
      expect(inner.calls, 2);
    });

    test('check if max-age is respected', () async {
      final inner = TestHttpClient();
      const target = 'http://example.com/max-age';
      const ma = 5;
      inner.handle = (req) async {
        return Response.bytes(utf8.encode('Success!'), 200, headers: {
          'Cache-Control': 'max-age=$ma',
        });
      };
      final client = HttpGetCache(inner, store);

      var res = await client.get(Uri.parse(target));

      expect(res.statusCode, 200);
      expect(res.headers['Cache-Control'], 'max-age=$ma');
      expect(inner.calls, 1);

      res = await client.get(Uri.parse(target));

      expect(res.statusCode, 200);
      expect(res.headers['Cache-Control'], 'max-age=$ma');
      expect(inner.calls, 1);

      await Future.delayed(const Duration(seconds: ma + 1));
      res = await client.get(Uri.parse(target));

      expect(res.statusCode, 200);
      expect(res.headers['Cache-Control'], 'max-age=$ma');
      expect(inner.calls, 2);
    });

    test('check if max-age + stale-while-revalidate is respected', () async {
      final inner = TestHttpClient();
      const target = 'http://example.com/max-age/stale-while-revalidate';
      const ma = 3;
      const swr = 5;
      inner.handle = (req) async {
        return Response.bytes(utf8.encode('Success!'), 200, headers: {
          'Cache-Control': 'max-age=$ma, stale-while-revalidate=$swr',
        });
      };
      final client = HttpGetCache(inner, store);

      var res = await client.get(Uri.parse(target));

      expect(res.statusCode, 200);
      expect(res.headers['Cache-Control'],
          'max-age=$ma, stale-while-revalidate=$swr');
      expect(inner.calls, 1);

      res = await client.get(Uri.parse(target));

      expect(res.statusCode, 200);
      expect(res.headers['Cache-Control'],
          'max-age=$ma, stale-while-revalidate=$swr');
      expect(inner.calls, 1);

      await Future.delayed(const Duration(seconds: ma));
      await client.stream(Request('GET', Uri.parse(target))).first;

      expect(res.statusCode, 200);
      expect(res.headers['Cache-Control'],
          'max-age=$ma, stale-while-revalidate=$swr');
      expect(inner.calls, 1);

      await Future.delayed(const Duration(seconds: swr + 1));
      await client.get(Uri.parse(target));

      expect(res.statusCode, 200);
      expect(res.headers['Cache-Control'],
          'max-age=$ma, stale-while-revalidate=$swr');
      expect(inner.calls, 2);
    });

    test('stale-if-error', () async {
      final inner = TestHttpClient();
      const ma = 3;
      const sie = 5;
      const target = 'http://example.com/error-check';
      int count = 0;
      bool error = false;
      inner.handle = (req) async {
        if (error) return Response('', 500);
        if (req.method == 'GET') count++;
        return Response.bytes(utf8.encode('count: $count'), 200, headers: {
          'Cache-Control': 'max-age=$ma, stale-if-error=$sie',
        });
      };
      final client = HttpGetCache(inner, store);
      final url = Uri.parse(target);

      var res = await client.get(url);

      expect(res.statusCode, 200);
      expect(res.body, 'count: 1');

      error = true;
      await Future.delayed(const Duration(seconds: ma + 1));
      res = await client.get(url);

      expect(res.statusCode, 200);
      expect(res.body, 'count: 1');

      await Future.delayed(const Duration(seconds: sie + 1));
      res = await client.get(url);

      expect(res.statusCode, 500);
    });
  });
}

class TestHttpClient extends BaseClient {
  TestHttpClient();

  int calls = 0;

  Future<Response> Function(BaseRequest request) handle = (req) async {
    return Response('', 200);
  };

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    final res = await handle(request);
    if (request.method == 'GET') calls++;
    return StreamedResponse(
      Stream.value(res.bodyBytes),
      res.statusCode,
      headers: res.headers,
      request: request,
      isRedirect: res.isRedirect,
      persistentConnection: res.persistentConnection,
      reasonPhrase: res.reasonPhrase,
      contentLength: res.contentLength,
    );
  }
}

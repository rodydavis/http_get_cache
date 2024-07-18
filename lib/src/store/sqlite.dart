import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import '../database/database.dart';
import '../date_parser.dart';
import '../request_headers.dart';
import 'base.dart';

class SqliteHttpCacheStore extends HttpCacheStore {
  final HttpCacheDatabase database;

  SqliteHttpCacheStore(this.database);

  static String cacheDirPath = '';
  static Future<String> getCacheDir() async {
    if (kIsWeb) return '';
    final cacheDir = cacheDirPath.isNotEmpty
        ? Directory(cacheDirPath)
        : await getApplicationCacheDirectory();
    if (!cacheDir.existsSync()) {
      await cacheDir.create(recursive: true);
    }
    return cacheDir.path;
  }

  static Future<void> deleteCacheDir() async {
    if (kIsWeb) return;
    final cachePath = await getCacheDir();
    if (cachePath.isEmpty) return;
    final cacheDir = Directory(cachePath);

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  static Future<int> getCacheDirSize() async {
    if (kIsWeb) return 0;
    final cachePath = await getCacheDir();
    if (cachePath.isEmpty) return 0;
    final cacheDir = Directory(cachePath);

    if (cacheDir.existsSync()) {
      final files = await cacheDir.list(recursive: true).toList();
      final dirSize =
          files.fold(0, (int sum, file) => sum + file.statSync().size);
      return dirSize;
    }

    return 0;
  }

  static Future<void> deleteExpired({HttpCacheDatabase? database}) async {
    final db = database ?? HttpCacheDatabase.instance;
    await db.deleteHttpCacheStale();
  }

  Stream<List<int>> _streamAndSaveBytes(
    BaseRequest req,
    StreamedResponse res,
    File file,
  ) async* {
    final date = res.requestHeaders.created ?? getDateInt();
    if (!file.existsSync()) {
      await file.create(recursive: true);
    }
    final writer = file.openWrite();
    await for (final event in res.stream) {
      yield event;
      writer.add(event);
    }
    await writer.flush();
    await writer.close();
    await database.setHttpCache(
      url: req.url.key,
      headers: jsonEncode(res.headers),
      body: file.path,
      maxAge: res.cacheControl.maxAge,
      staleWhileRevalidate: res.cacheControl.staleWhileRevalidate.$1,
      staleIfError: res.cacheControl.staleIfError.$1,
      immutable: res.cacheControl.immutable,
      date: date,
    );
  }

  @override
  Future<StreamedResponse> set(
    BaseRequest request,
    StreamedResponse response,
  ) async {
    if (kIsWeb) return response;
    if (response.cacheControl.noStore || request.cacheControl.noStore) {
      return response;
    }
    final dirPath = await getCacheDir();
    if (dirPath.isEmpty) return response;
    final dir = Directory(dirPath);
    final file = File(p.join(dir.path, 'http-cache', request.key));
    return StreamedResponse(
      _streamAndSaveBytes(request, response, file),
      response.statusCode,
      contentLength: response.contentLength,
      request: response.request,
      headers: response.headers,
      isRedirect: response.isRedirect,
      persistentConnection: response.persistentConnection,
      reasonPhrase: response.reasonPhrase,
    );
  }

  @override
  Future<StreamedResponse?> get(BaseRequest request) async {
    final current = await database //
        .getHttpCache(url: request.url.key)
        .getSingleOrNull();
    if (current == null) return null;
    final headers = _parseHeaders(current.headers);
    final path = current.body;
    final file = File(path);
    if (await file.exists()) {
      final stats = await file.stat();
      final h = {...headers};
      final rq = RequestHeaders(h);
      if (rq.created == null) {
        final d = DateTime.fromMillisecondsSinceEpoch(current.date);
        h['Date'] = d.toIso8601String();
      }
      return StreamedResponse(
        file.openRead(),
        200,
        contentLength: stats.size,
        headers: h,
      );
    } else {
      return null;
    }
  }
}

extension on BaseRequest {
  String get key => Uri.encodeQueryComponent(url.key);
}

extension on Uri {
  String get key => toString();
}

Map<String, String> _parseHeaders(String key) {
  final headers = <String, String>{};
  if (key.isNotEmpty) {
    final data = jsonDecode(key) as Map<String, Object?>;
    for (final entry in data.entries) {
      headers[entry.key] = entry.value?.toString() ?? '';
    }
  }
  return headers;
}

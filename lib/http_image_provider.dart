import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:http/http.dart';

import 'http_get_cache.dart';

/// Fetches the given URL from the network, associating it with the given scale.
///
/// The image will be cached regardless of cache headers from the server.
///
/// See also:
///
///  * [Image.network].
///  * https://pub.dev/packages/dio_image_provider
///  * https://github.com/dart-lang/http/tree/master/pkgs/flutter_http_example
@immutable
class HttpImageProvider extends ImageProvider<HttpImageProvider> {
  /// Can be set to override the default [Client] for the
  /// [HttpImageProvider].
  static Client defaultClient = httpClient();

  final Future<Uint8List?> Function(Request request)? readFromCache;
  final Future<void> Function(Request request, Uint8List bytes)? writeToCache;

  /// Creates an object that fetches the image at the given URL.
  ///
  /// The arguments [url] and [scale] must not be null.
  /// [client] will be the default [Client] if not set.
  HttpImageProvider.string(
    String url, {
    this.scale = 1.0,
    this.headers,
    Client? client,
    this.readFromCache,
    this.writeToCache,
  })  : client = client ?? defaultClient,
        url = Uri.parse(url);

  /// Creates an object that fetches the image at the given URL.
  ///
  /// The arguments [url] and [scale] must not be null.
  /// [client] will be the default [Client] if not set.
  HttpImageProvider(
    this.url, {
    this.scale = 1.0,
    this.headers,
    Client? client,
    this.readFromCache,
    this.writeToCache,
  }) : client = client ?? defaultClient;

  /// The URL from which the image will be fetched.
  final Uri url;

  /// The scale to place in the [ImageInfo] object of the image.
  final double scale;

  /// The HTTP headers that will be used with [Client.get] to fetch image from network.
  ///
  /// When running flutter on the web, headers are not used.
  final Map<String, String>? headers;

  /// [client] will be the default [Client] if not set.
  final Client client;

  @override
  Future<HttpImageProvider> obtainKey(ImageConfiguration configuration) {
    return SynchronousFuture<HttpImageProvider>(this);
  }

  final controller = StreamController<ImageChunkEvent>();

  @override
  ImageStreamCompleter loadImage(
    HttpImageProvider key,
    ImageDecoderCallback decode,
  ) {
    return MultiFrameImageStreamCompleter(
      codec: _loadAsync(key, decode),
      scale: key.scale,
      debugLabel: key.url.toString(),
      informationCollector: () => <DiagnosticsNode>[
        DiagnosticsProperty<ImageProvider>('Image provider', this),
        DiagnosticsProperty<HttpImageProvider>('Image key', key),
      ],
      chunkEvents: controller.stream,
    );
  }

  Future<ui.Codec> _loadAsync(
    HttpImageProvider key,
    ImageDecoderCallback decode,
  ) async {
    try {
      assert(key == this);

      // final head = await client.head(url, headers: headers);
      // if (head.statusCode == 200) {
      //   final contentLength = head.headers['content-length'];
      //   if (contentLength != null) {
      //     totalBytes = int.tryParse(contentLength);
      //   }
      // }

      int? totalBytes;
      int currentBytes = 0;
      final list = <int>[];
      final req = Request('GET', url);
      if (headers != null) req.headers.addAll(headers!);

      // Check cache
      if (readFromCache != null) {
        final bytes = await readFromCache!(req);
        if (bytes != null) {
          final buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
          return decode(buffer);
        }
      }

      final res = await client.send(req);
      totalBytes = res.contentLength;
      if (res.statusCode != 200) {
        throw NetworkImageLoadException(
          uri: url,
          statusCode: res.statusCode,
        );
      }

      await res.stream.asyncMap((e) {
        currentBytes += e.length;
        controller.add(ImageChunkEvent(
          expectedTotalBytes: totalBytes,
          cumulativeBytesLoaded: currentBytes,
        ));
        list.addAll(e);
        return e;
      }).last;

      final bytes = Uint8List.fromList(list);
      if (bytes.lengthInBytes == 0) {
        throw NetworkImageLoadException(
          uri: url,
          statusCode: res.statusCode,
        );
      }

      // Write to cache
      if (writeToCache != null) {
        await writeToCache!(req, bytes);
      }

      final buffer = await ui.ImmutableBuffer.fromUint8List(bytes);
      return decode(buffer);
    } catch (e) {
      // Depending on where the exception was thrown, the image cache may not
      // have had a chance to track the key in the cache at all.
      // Schedule a microtask to give the cache a chance to add the key.
      scheduleMicrotask(() {
        PaintingBinding.instance.imageCache.evict(key);
      });
      rethrow;
    }
  }

  @override
  bool operator ==(Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is HttpImageProvider &&
        other.url == url &&
        other.scale == scale;
  }

  @override
  int get hashCode => Object.hash(url, scale);

  @override
  String toString() =>
      '${objectRuntimeType(this, 'HttpImageProvider')}("$url", scale: $scale)';
}

@Deprecated('Use HttpImageProvider instead')
typedef HttpImage = HttpImageProvider;

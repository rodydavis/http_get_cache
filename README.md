# http_get_cache

HTTP compliant cache for Flutter. This package is a wrapper around the `http` package that provides a simple way to cache responses using the 'Cache-Control', 'eTag' and 'Last-Modified' headers.

## Dart

```dart
import 'package:http_get_cache/http_get_cache.dart';

void main() async {
    ...
    await initHttpGetCache(cachePath: '.cache', databasePath: '.db');

    // Create a new HTTP Client
    final client = httpClient();
    // Future<StreamedResponse>
    final res = await client.send('...');
    // Stream<StreamedResponse>
    final res = await client.stream('...');
}
```

## Flutter

In the `main.dart` file you can add the following code:

```dart
import 'package:http_get_cache/http_get_cache_flutter.dart';

void main() async {
    ...
    await initFlutterHttpGetCache();
    ...
}
```

When building the Flutter app you can remove the default client with the following variable:

```
--dart-define=no_default_http_client=true
```

## Wrap with RetryClient

```dart
import 'package:http/retry.dart';

final inner = httpClient();
final client = RetryClient(inner);
```
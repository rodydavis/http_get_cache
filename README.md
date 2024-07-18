# flutter_http_cache

HTTP compliant cache for Flutter. This package is a wrapper around the `http` package that provides a simple way to cache responses using the 'Cache-Control', 'eTag' and 'Last-Modified' headers.

## Usage

```dart
import 'package:flutter_http_cache/flutter_http_cache.dart';
...
// Create a new HTTP Client
final client = httpClient();
// Future<StreamedResponse>
final res = await client.send('...');
// Stream<StreamedResponse>
final res = await client.stream('...');
// Wrap with RetryClient
final retryClient = RetryClient(client);
```

When building the Flutter app you can remove the default client with the following variable:

```
--dart-define=no_default_http_client=true
```

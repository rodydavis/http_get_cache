import 'package:collection/collection.dart';
import 'package:http/http.dart';

import 'cache_control.dart';
import 'date_parser.dart';

class RequestHeaders {
  final Map<String, String> value;
  RequestHeaders(this.value);

  static DateParser dateParser = const DateParser();

  String getValue(String key) {
    final result = value.entries.firstWhere(
      (e) => e.key.toLowerCase() == key.toLowerCase(),
      orElse: () => MapEntry(key, ''),
    );
    return result.value;
  }

  String get eTag => getValue('eTag');

  int get age => int.tryParse(getValue('Age')) ?? 0;

  int? get lastModified => dateParser(getValue('Last-Modified'))?.toSeconds();

  int? get date => dateParser(getValue('Date'))?.toSeconds();

  int? get expires => dateParser(getValue('Expires'))?.toSeconds();

  int? get created {
    final lastModifiedKey = value.keys.firstWhereOrNull(
      (e) => e.toLowerCase() == 'last-modified',
    );
    final dateKey = value.keys.firstWhereOrNull(
      (e) => e.toLowerCase() == 'date',
    );
    final key = lastModifiedKey ?? dateKey;
    if (key != null) {
      final d = dateParser(value[key]!);
      if (d != null) return d.millisecondsSinceEpoch;
    }
    return null;
  }
}

extension BaseRequestCCUtils on BaseRequest {
  RequestHeaders get requestHeaders {
    return RequestHeaders(headers);
  }

  RequestCacheControl get cacheControl {
    return RequestCacheControl(requestHeaders.getValue('cache-control'));
  }
}

extension StreamedResponseCCUtils on StreamedResponse {
  RequestHeaders get requestHeaders {
    return RequestHeaders(headers);
  }

  ResponseCacheControl get cacheControl {
    return ResponseCacheControl(requestHeaders.getValue('cache-control'));
  }
}

extension ResponseCCUtils on Response {
  RequestHeaders get requestHeaders {
    return RequestHeaders(headers);
  }

  ResponseCacheControl get cacheControl {
    return ResponseCacheControl(requestHeaders.getValue('cache-control'));
  }
}

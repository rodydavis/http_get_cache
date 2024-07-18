import 'package:collection/collection.dart';

class CacheControl {
  final String value;
  CacheControl(this.value);

  Iterable<(String, String?)> get parts => value.split(',').map((e) {
        final p = e.split('=').map((e) => e.trim()).toList();
        return (p.first, p.length > 1 ? p.last : null);
      });

  int _getSeconds(String key, [bool allowBool = false]) {
    final part = parts.firstWhereOrNull((e) {
      return e.$1.toLowerCase() == key.toLowerCase();
    });
    final val = int.tryParse(part?.$2 ?? '');
    if (val != null) return val;
    if (allowBool && _getBool(key)) return double.minPositive.toInt();
    return 0;
  }

  bool _getBool(String key) {
    return parts.any((e) => e.$1.toLowerCase() == key.toLowerCase());
  }

  (int, bool) _getMixed(String key) => (_getSeconds(key), _getBool(key));
}

class RequestCacheControl extends CacheControl {
  RequestCacheControl(super.value);
  int get maxAge => _getSeconds('max-age');
  int get maxStale => _getSeconds('max-stale');
  int get minFresh => _getSeconds('min-fresh');
  bool get noCache => _getBool('no-cache');
  bool get noStore => _getBool('no-store');
  bool get noTransform => _getBool('no-transform');
  bool get onlyIfCached => _getBool('only-of-cached');
  (int, bool) get staleIfError => _getMixed('stale-if-error');
}

class ResponseCacheControl extends CacheControl {
  ResponseCacheControl(super.value);
  int get maxAge => _getSeconds('max-age');
  int get sMaxAge => _getSeconds('s-maxage');
  bool get noCache => _getBool('no-cache');
  bool get noStore => _getBool('no-store');
  bool get noTransform => _getBool('no-transform');
  bool get mustRevalidate => _getBool('must-revalidate');
  bool get mustUnderstand => _getBool('must-understand');
  bool get private => _getBool('private');
  bool get public => _getBool('public');
  bool get immutable => _getBool('immutable');
  (int, bool) get staleWhileRevalidate => _getMixed('stale-while-revalidate');
  (int, bool) get staleIfError => _getMixed('stale-if-error');
}

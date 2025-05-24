import 'package:cachecontrol/cachecontrol.dart';
import 'package:http/http.dart';

extension CacheControlRequest on BaseRequest {
  CacheControl get cacheControl {
    final raw = headers[cacheControlHeader] ?? '';
    return CacheControl.parse(raw);
  }

  set cacheControl(CacheControl value) {
    headers[cacheControlHeader] = value.toString();
  }
}

extension CacheControlBaseResponse on BaseResponse {
  CacheControl get cacheControl {
    final raw = headers[cacheControlHeader] ?? '';
    return CacheControl.parse(raw);
  }

  set cacheControl(CacheControl value) {
    headers[cacheControlHeader] = value.toString();
  }
}

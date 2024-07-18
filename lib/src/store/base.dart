import 'package:http/http.dart';

class HttpCacheStore {
  Future<StreamedResponse?> get(BaseRequest request) async {
    return null;
  }

  Future<StreamedResponse> set(
    BaseRequest request,
    StreamedResponse response,
  ) async {
    return response;
  }
}

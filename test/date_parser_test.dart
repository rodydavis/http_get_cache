import 'package:http_get_cache/src/date_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('date-parse', () {
    const str = 'Wed, 17 Jul 2024 23:19:37 GMT';
    const parser = DateParser();
    final date = parser(str);
    expect(date != null, true);
  });
}

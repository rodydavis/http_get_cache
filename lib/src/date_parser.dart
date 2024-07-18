/// Parse a date from a request/response header value into
/// a valid dart DateTime.
///
/// Example: Wed, 17 Jul 2024 23:19:37 GMT
class DateParser {
  const DateParser();
  DateTime? call(String value) {
    if (value.isEmpty) return null;
    final d = DateTime.tryParse(value);
    if (d != null) return d;
    final [
      _,
      dayOfMonth,
      monthName,
      yearName,
      time,
      _,
    ] = value.trim().split(' ');
    var year = int.parse(yearName).toString();
    var month = (switch (monthName.toLowerCase()) {
      'jan' => DateTime.january,
      'feb' => DateTime.february,
      'mar' => DateTime.march,
      'apr' => DateTime.april,
      'may' => DateTime.may,
      'jun' => DateTime.june,
      'jul' => DateTime.july,
      'aug' => DateTime.august,
      'sep' => DateTime.september,
      'oct' => DateTime.october,
      'nov' => DateTime.november,
      'dec' => DateTime.december,
      (_) => -1,
    })
        .toString()
        .padLeft(2, '0');
    var day = int.parse(dayOfMonth).toString().padLeft(2, '0');
    final str = '$year-$month-$day $time';
    return DateTime.tryParse(str);
  }
}

DateTime getDate() => DateTime.now();
int getDateInt() => getDate().toSeconds();

extension DateTimeUtils on DateTime {
  int toSeconds() => Duration(milliseconds: millisecondsSinceEpoch).inSeconds;
}

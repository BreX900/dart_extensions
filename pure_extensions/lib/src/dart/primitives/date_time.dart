import 'package:time/time.dart';

extension DateTimeExtDart on DateTime {
  DateTime copyWithPosition({int leading, int middle, int trailing}) {
    return copyWith(
      year: leading,
      month: leading,
      day: leading,
      hour: middle,
      minute: middle,
      second: middle,
      millisecond: trailing,
      microsecond: trailing,
    );
  }
}

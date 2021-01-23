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

  /// Converts this in [DateTimeBuilder]
  DateTime rebuild(void Function(DateTimeBuilder b) updates) {
    return (DateTimeBuilder.of(this)..update(updates)).build();
  }

  /// Update this by [DateTimeBuilder]
  DateTimeBuilder toBuilder() => DateTimeBuilder.of(this);
}

/// Builder for [DateTime]
class DateTimeBuilder {
  int _year;
  int _month;
  int _day;
  int _hour;
  int _minute;
  int _second;
  int _millisecond;
  int _microsecond;

  int get year => _year;
  set year(int value) {
    _year = value ?? 0;
  }

  int get month => _month;
  set month(int value) {
    _month = value ?? 0;
  }

  int get day => _day;
  set day(int value) {
    _day = value ?? 0;
  }

  int get hour => _hour;
  set hour(int value) {
    _hour = value ?? 0;
  }

  int get minute => _minute;
  set minute(int value) {
    _minute = value ?? 0;
  }

  int get second => _second;
  set second(int value) {
    _second = value ?? 0;
  }

  int get millisecond => _millisecond;
  set millisecond(int value) {
    _millisecond = value ?? 0;
  }

  int get microsecond => _microsecond;
  set microsecond(int value) {
    _microsecond = value ?? 0;
  }

  DateTimeBuilder([void Function(DateTimeBuilder b) updates]) {
    update(updates);
  }

  factory DateTimeBuilder.of(DateTime duration) => DateTimeBuilder()..replace(duration);

  void update(void Function(DateTimeBuilder b) updates) {
    if (updates != null) updates(this);
  }

  void replace(DateTime dateTime) {
    assert(dateTime != null);
    year = dateTime.year;
    month = dateTime.month;
    day = dateTime.day;
    hour = dateTime.hour;
    minute = dateTime.minute;
    second = dateTime.second;
    millisecond = dateTime.millisecond;
    millisecond = dateTime.millisecond;
  }

  DateTime build() => DateTime(year, month, day, hour, minute, second, millisecond, millisecond);
}

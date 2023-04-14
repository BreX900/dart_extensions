extension DateTimePureExtensions on DateTime {
  DateTime copyWithPosition({int? leading, int? middle, int? trailing}) {
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
  int year = 0;
  int month = 1;
  int day = 1;
  int hour = 0;
  int minute = 0;
  int second = 0;
  int millisecond = 0;
  int microsecond = 0;

  DateTimeBuilder([void Function(DateTimeBuilder b)? updates]) {
    update(updates);
  }

  factory DateTimeBuilder.of(DateTime duration) => DateTimeBuilder()..replace(duration);

  void update(void Function(DateTimeBuilder b)? updates) {
    if (updates != null) updates(this);
  }

  void replace(DateTime dateTime) {
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

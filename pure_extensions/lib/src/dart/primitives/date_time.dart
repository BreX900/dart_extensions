extension DateTimeExtDart on DateTime {
  DateTime copyWith({
    int year,
    int month,
    int hour,
    int day,
    int minute,
    int second,
    int millisecond,
    int microsecond,
  }) {
    return DateTime(
      year ?? this.year,
      month ?? this.month,
      day ?? this.day,
      hour ?? this.hour,
      minute ?? this.minute,
      second ?? this.second,
      millisecond ?? this.millisecond,
      microsecond ?? this.microsecond,
    );
  }

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

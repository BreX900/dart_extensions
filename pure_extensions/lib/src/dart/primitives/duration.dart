extension DurationDartExtension on Duration {
  /// Human days representation (0 -> ...)
  int get days => inDays;

  /// Human hours representation (0 -> 24)
  int get hours => inHours % Duration.hoursPerDay;

  /// Human minutes representation (0 -> 59)
  int get minutes => inMinutes % Duration.minutesPerHour;

  /// Human seconds representation (0 -> 59)
  int get seconds => inSeconds % Duration.secondsPerMinute;

  /// Human milliseconds representation (0 -> 999)
  int get milliseconds => inMilliseconds % Duration.millisecondsPerSecond;

  /// Human microseconds representation (0 -> 999)
  int get microseconds => inMicroseconds % Duration.microsecondsPerMillisecond;

  /// Copy this with new values
  Duration copyWith({
    int days,
    int hours,
    int minutes,
    int seconds,
    int milliseconds,
    int microseconds,
  }) {
    return Duration(
      days: days ?? this.days,
      hours: hours ?? this.hours,
      minutes: minutes ?? this.minutes,
      seconds: seconds ?? this.seconds,
      milliseconds: milliseconds ?? this.milliseconds,
      microseconds: microseconds ?? this.microseconds,
    );
  }

  /// Converts this in builder
  DurationBuilder toBuilder() => DurationBuilder.of(this);

  /// Update this by [DurationBuilder]
  Duration rebuild(void Function(DurationBuilder b) updates) {
    return (toBuilder()..update(updates)).build();
  }
}

/// Builder for [Duration]
class DurationBuilder {
  int _days = 0;
  int _hours = 0;
  int _minutes = 0;
  int _seconds = 0;
  int _milliseconds = 0;
  int _microseconds = 0;

  int get days => _days;
  set days(int days) {
    _days = days ?? 0;
  }

  int get hours => _hours;
  set hours(int hours) {
    _hours = hours ?? 0;
  }

  int get minutes => _minutes;
  set minutes(int minutes) {
    _minutes = minutes ?? 0;
  }

  int get seconds => _seconds;
  set seconds(int seconds) {
    _seconds = seconds ?? 0;
  }

  int get milliseconds => _milliseconds;
  set milliseconds(int milliseconds) {
    _milliseconds = milliseconds ?? 0;
  }

  int get microseconds => _microseconds;
  set microseconds(int microseconds) {
    _microseconds = microseconds ?? 0;
  }

  DurationBuilder([void Function(DurationBuilder b) updates]) {
    update(updates);
  }

  factory DurationBuilder.of(Duration duration) => DurationBuilder()..replace(duration);

  void update(void Function(DurationBuilder b) updates) {
    if (updates != null) updates(this);
  }

  void replace(Duration duration) {
    assert(duration != null);
    days = duration.days;
    hours = duration.hours;
    minutes = duration.minutes;
    seconds = duration.seconds;
    milliseconds = duration.milliseconds;
    microseconds = duration.microseconds;
  }

  Duration build() {
    return Duration(
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      milliseconds: milliseconds,
      microseconds: microseconds,
    );
  }
}

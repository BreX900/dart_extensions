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
  DurationBuilder toBuilder() => DurationBuilder.from(this);

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
    assert(days >= 0, 'Not valid days: $days');
    _days = days;
  }

  int get hours => _hours;
  set hours(int hours) {
    assert(hours != null && hours >= 0 && hours < Duration.hoursPerDay, 'Not valid hours: $hours');
    _hours = hours;
  }

  int get minutes => _minutes;
  set minutes(int minutes) {
    assert(
      minutes != null && minutes >= 0 && minutes < Duration.minutesPerHour,
      'Not valid minutes: $minutes',
    );
    _minutes = minutes;
  }

  int get seconds => _seconds;
  set seconds(int seconds) {
    assert(
      seconds != null && seconds >= 0 && seconds < Duration.secondsPerMinute,
      'Not valid seconds: $seconds',
    );
    _seconds = seconds;
  }

  int get milliseconds => _milliseconds;
  set milliseconds(int milliseconds) {
    assert(
      milliseconds != null && milliseconds >= 0 && milliseconds < Duration.millisecondsPerSecond,
      'Not valid milliseconds: $milliseconds',
    );
    _milliseconds = milliseconds;
  }

  int get microseconds => _microseconds;
  set microseconds(int microseconds) {
    assert(
      microseconds != null &&
          microseconds >= 0 &&
          microseconds < Duration.microsecondsPerMillisecond,
      'Not valid microseconds: $microseconds',
    );
    _microseconds = microseconds;
  }

  void update(void Function(DurationBuilder b) updates) {
    if (updates != null) updates(this);
  }

  void replace(Duration duration) {
    days = duration.days;
    hours = duration.hours;
    minutes = duration.minutes;
    seconds = duration.seconds;
    milliseconds = duration.milliseconds;
    microseconds = duration.microseconds;
  }

  DurationBuilder([void Function(DurationBuilder b) updates]) {
    update(updates);
  }

  DurationBuilder.of({
    int days = 0,
    int hours = 0,
    int minutes = 0,
    int seconds = 0,
    int milliseconds = 0,
    int microseconds = 0,
  }) {
    this.days = days;
    this.hours = hours;
    this.minutes = minutes;
    this.seconds = seconds;
    this.milliseconds = milliseconds;
    this.microseconds = microseconds;
  }

  factory DurationBuilder.from(Duration duration) => DurationBuilder.of(
        days: duration.days,
        hours: duration.hours,
        minutes: duration.minutes,
        seconds: duration.seconds,
        milliseconds: duration.milliseconds,
        microseconds: duration.microseconds,
      );

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

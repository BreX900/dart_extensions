import 'package:flutter/material.dart';
import 'package:pure_extensions/pure_extensions.dart';

extension DateTimeFlutterExtensions on DateTime {
  TimeOfDay toTimeOfDay(DateTime dateTime) => TimeOfDay.fromDateTime(dateTime);

  DateTime copyWithTimeOfDay(TimeOfDay timeOfDay) {
    return copyWith(hour: timeOfDay.hour, minute: timeOfDay.minute);
  }
}

extension DurationFlutterExtension on Duration {
  DateTime toDateTime({DateTime from, bool isUtc = false}) {
    from ??= DateTime(0, 1, 1, 0, 0, 0, 0, 0);
    return from.add(this);
  }
}

import 'package:flutter/material.dart';

extension DateTimeExtension on DateTime {
  DateTime setTime(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }

  DateTime setDate(DateTime date) {
    return DateTime(date.year, date.month, date.day, hour, minute);
  }
}

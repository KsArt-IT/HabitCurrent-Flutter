import 'package:flutter/material.dart';

extension IntTime on int {
  String toTime() {
    final hours = this ~/ 60;
    final minutes = this % 60;
    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}";
  }

  TimeOfDay toTimeOfDay() {
    final hours = this ~/ 60;
    final minutes = this % 60;
    return TimeOfDay(hour: hours, minute: minutes);
  }
}

extension IntTimeOfDay on TimeOfDay {
  int toMinutes() => hour * 60 + minute;
}

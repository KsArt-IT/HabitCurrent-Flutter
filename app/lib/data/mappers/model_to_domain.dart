import 'package:habit_current/data/models/models.dart';
import 'package:habit_current/models/habit.dart';
import 'package:habit_current/models/hour_interval.dart';
import 'package:habit_current/models/hour_interval_completed.dart';
import 'package:habit_current/models/user.dart';
import 'package:habit_current/models/weekdays.dart';

extension UserToDomain on UserModel {
  User toDomain() {
    return User(
      id: id,
      name: name,
      avatar: avatar,
      created: created, //
    );
  }
}

extension HabitToDomain on HabitModel {
  Habit toDomain() {
    return Habit(
      id: id,
      userId: userId,
      name: name,
      details: details,
      created: created,
      updated: updated,
      completed: completed,
      weekDays: weekDaysRaw > 0 ? WeekDays.fromInt(weekDaysRaw) : WeekDays.values.toSet(),
      intervals: intervals.map((e) => e.toDomain()).toList(),
      completedIntervals: completedIntervals.map((e) => e.toDomain()).toList(),
    );
  }
}

extension HourIntervalToDomain on HourIntervalModel {
  HourInterval toDomain() {
    return HourInterval(
      id: id,
      time: time, //
    );
  }
}

extension HourIntervalCompletedToDomain on HourIntervalCompletedModel {
  HourIntervalCompleted toDomain() {
    return HourIntervalCompleted(
      id: id,
      time: time,
      completed: completed, //
    );
  }
}

import 'package:habit_current/data/models/models.dart';
import 'package:habit_current/models/models.dart';
import 'package:habit_current/models/weekdays.dart';

extension UserToDomain on UserModel {
  User toDomain() {
    return User(
      id: id,
      name: name,
      avatar: avatar,
      created: created,
      updated: updated,
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
      notifications: notifications.map((e) => e.toDomain()).toList(),
    );
  }
}

extension HourIntervalToDomain on HourIntervalModel {
  HourInterval toDomain() {
    return HourInterval(
      id: id,
      time: time,
    );
  }
}

extension HourIntervalCompletedToDomain on HourIntervalCompletedModel {
  HourIntervalCompleted toDomain() {
    return HourIntervalCompleted(
      id: id,
      intervalId: intervalId,
      time: time,
      completed: completed,
    );
  }
}

extension HabitNotificationModelToDomain on HabitNotificationModel {
  HabitNotification toDomain() => HabitNotification(
    id: id,
    intervalId: intervalId,
    weekDay: weekDay,
    time: time,
    repeats: repeats,
  );
}

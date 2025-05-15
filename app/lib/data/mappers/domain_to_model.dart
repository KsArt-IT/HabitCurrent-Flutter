import 'package:habit_current/data/models/models.dart';
import 'package:habit_current/models/models.dart';
import 'package:habit_current/models/weekdays.dart';

extension UserToModel on User {
  UserModel toModel() => UserModel(
    id: id,
    name: name,
    avatar: avatar,
    created: created, //
  );
}

extension HabitToModel on Habit {
  HabitModel toModel() => HabitModel(
    id: id,
    userId: userId,
    name: name,
    details: details,
    created: created,
    updated: updated,
    completed: completed,
    weekDaysRaw: weekDays.isNotEmpty ? weekDays.toInt() : WeekDays.allDays,
    intervals: intervals.map((e) => e.toModel(id)).toList(),
    completedIntervals: completedIntervals.map((e) => e.toModel(id)).toList(),
    notifications:
        notifications
            .map((e) => e.toModel(userId: userId, habitId: id, title: name))
            .toList(),
  );
}

extension HourIntervalToModel on HourInterval {
  HourIntervalModel toModel(int habitId) => HourIntervalModel(
    id: id,
    habitId: habitId,
    time: time, //
  );
}

extension HourIntervalCompletedToModel on HourIntervalCompleted {
  HourIntervalCompletedModel toModel(int habitId) => HourIntervalCompletedModel(
    id: id,
    habitId: habitId,
    intervalId: intervalId,
    time: time,
    completed: completed,
  );
}

extension HabitNotificationToModel on HabitNotification {
  HabitNotificationModel toModel({
    required int userId,
    required int habitId,
    required String title,
  }) => HabitNotificationModel(
    id: id,
    userId: userId,
    habitId: habitId,
    intervalId: intervalId,
    identifier: identifier,
    title: title,
    weekDay: weekDay,
    time: time,
    repeats: repeats,
  );
}

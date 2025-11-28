import 'package:habit_current/data/models/models.dart';
import 'package:habit_current/models/models.dart';
import 'package:habit_current/models/weekdays.dart';

extension UserToModel on User {
  UserModel toModel() => .new(
    id: id,
    name: name,
    avatar: avatar,
    created: created,
    updated: updated,
  );
}

extension HabitToModel on Habit {
  HabitModel toModel() => .new(
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
    notifications: notifications
        .map((e) => e.toModel(userId: userId, habitId: id, title: name))
        .toList(),
  );
}

extension HourIntervalToModel on HourInterval {
  HourIntervalModel toModel(int habitId) => .new(
    id: id,
    habitId: habitId,
    time: time,
  );
}

extension HourIntervalCompletedToModel on HourIntervalCompleted {
  HourIntervalCompletedModel toModel(int habitId) => .new(
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
  }) => .new(
    id: id,
    userId: userId,
    habitId: habitId,
    intervalId: intervalId,
    title: title,
    weekDay: weekDay,
    time: time,
    repeats: repeats,
  );
}

import 'package:habit_current/models/habit_notification.dart';
import 'package:habit_current/models/hour_interval.dart';
import 'package:habit_current/models/hour_interval_completed.dart';
import 'package:habit_current/models/weekdays.dart';

final class Habit {
  final int id;
  final int userId;
  final String name;
  final String? details;
  final DateTime? created;
  final DateTime? updated;
  final DateTime? completed;

  final Set<WeekDays> weekDays;
  final List<HourInterval> intervals;
  final List<HourIntervalCompleted> completedIntervals;
  final List<HabitNotification> notifications;

  bool get isActive => completed == null;

  const Habit({
    this.id = 0,
    required this.userId,
    required this.name,
    this.details,
    this.created,
    this.updated,
    this.completed,
    required this.weekDays,
    required this.intervals,
    this.completedIntervals = const [],
    this.notifications = const [],
  });

  Habit copyWith({
    String? name,
    String? details,
    DateTime? created,
    DateTime? updated,
    DateTime? completed,
    Set<WeekDays>? weekDays,
    List<HourInterval>? intervals,
    List<HourIntervalCompleted>? completedIntervals,
    List<HabitNotification>? notifications,
  }) => Habit(
    id: id,
    userId: userId,

    name: name ?? this.name,
    details: details ?? this.details,
    created: created ?? this.created,
    updated: updated ?? this.updated,
    completed: completed ?? this.completed,
    weekDays: weekDays ?? this.weekDays,
    intervals: intervals ?? this.intervals,
    completedIntervals: completedIntervals ?? this.completedIntervals,
    notifications: notifications ?? this.notifications,
  );
}

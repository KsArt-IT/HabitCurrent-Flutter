import 'package:habit_current/models/hour_interval.dart';
import 'package:habit_current/models/hour_interval_completed.dart';

final class Habit {
  final int id;
  final String name;
  final String? details;
  final DateTime created;
  final DateTime? updated;
  final DateTime? completed;

  final int weekDaysRaw;
  final List<HourInterval> intervals;
  final List<HourIntervalCompleted> completedIntervals;

  final int userId;

  bool get isActive => completed == null;

  const Habit({
    required this.id,
    required this.name,
    this.details,
    required this.created,
    this.updated,
    this.completed,
    required this.weekDaysRaw,
    required this.intervals,
    required this.completedIntervals,
    required this.userId,
  });

  Habit copyWith({
    String? name,
    String? details,
    DateTime? created,
    DateTime? updated,
    DateTime? completed,
    int? weekDaysRaw,
    List<HourInterval>? intervals,
    List<HourIntervalCompleted>? completedIntervals,
  }) => Habit(
    id: this.id,
    name: name ?? this.name,
    details: details ?? this.details,
    created: created ?? this.created,
    updated: updated ?? this.updated,
    completed: completed ?? this.completed,
    weekDaysRaw: weekDaysRaw ?? this.weekDaysRaw,
    intervals: intervals ?? this.intervals,
    completedIntervals: completedIntervals ?? this.completedIntervals,
    userId: this.userId,
  );
}

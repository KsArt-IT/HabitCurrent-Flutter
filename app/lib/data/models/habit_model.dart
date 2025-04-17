import 'package:habit_current/data/models/hour_interval_completed_model.dart';
import 'package:habit_current/data/models/hour_interval_model.dart';

final class HabitModel {
  final int id;
  final int userId;

  final String name;
  final String? details;
  final DateTime created;
  final DateTime? updated;
  final DateTime? completed;

  final int weekDaysRaw;
  final List<HourIntervalModel> intervals;
  final List<HourIntervalCompletedModel> completedIntervals;

  const HabitModel({
    required this.id,
    required this.userId,
    required this.name,
    this.details,
    required this.created,
    this.updated,
    this.completed,
    required this.weekDaysRaw,
    required this.intervals,
    required this.completedIntervals,
  });

  HabitModel copyWith({
    int? id,
    int? userId,
    String? name,
    String? details,
    DateTime? created,
    DateTime? updated,
    DateTime? completed,
    int? weekDaysRaw,
    List<HourIntervalModel>? intervals,
    List<HourIntervalCompletedModel>? completedIntervals,
  }) => HabitModel(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    name: name ?? this.name,
    details: details ?? this.details,
    created: created ?? this.created,
    updated: updated ?? this.updated,
    completed: completed ?? this.completed,
    weekDaysRaw: weekDaysRaw ?? this.weekDaysRaw,
    intervals: intervals ?? this.intervals,
    completedIntervals: completedIntervals ?? this.completedIntervals,
  );
}

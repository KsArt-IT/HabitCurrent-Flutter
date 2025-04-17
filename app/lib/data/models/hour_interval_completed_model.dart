final class HourIntervalCompletedModel {
  final int id;
  final int habitId;
  final int time;
  final DateTime completed;

  const HourIntervalCompletedModel({
    required this.id,
    required this.habitId,
    required this.time,
    required this.completed,
  });

  HourIntervalCompletedModel copyWith({
    int? id,
    int? habitId,
    int? time,
    DateTime? completed, //
  }) => HourIntervalCompletedModel(
    id: id ?? this.id,
    habitId: habitId ?? this.habitId,
    time: time ?? this.time,
    completed: completed ?? this.completed,
  );
}

final class HourIntervalModel {
  final int id;
  final int habitId;
  final int time;

  const HourIntervalModel({
    required this.id,
    required this.habitId,
    required this.time,
  });

  HourIntervalModel copyWith({
    int? id,
    int? habitId,
    int? time,
  }) => .new(
    id: id ?? this.id,
    habitId: habitId ?? this.habitId,
    time: time ?? this.time,
  );
}

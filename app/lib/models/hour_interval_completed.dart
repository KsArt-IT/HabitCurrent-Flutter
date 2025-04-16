final class HourIntervalCompleted {
  final int id;
  final int time;
  final DateTime completed;

  const HourIntervalCompleted({
    required this.id,
    required this.time,
    required this.completed,
  });

  HourIntervalCompleted copyWith({
    int? time,
    DateTime? completed, //
  }) => HourIntervalCompleted(
    id: this.id,
    time: time ?? this.time,
    completed: completed ?? this.completed,
  );
}

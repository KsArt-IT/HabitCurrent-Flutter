final class HourIntervalCompletedModel {
  final int id;
  final int habitId;
  final int intervalId;
  final int time;
  final DateTime completed;

  const HourIntervalCompletedModel({
    this.id = 0,
    required this.habitId,
    required this.intervalId,
    required this.time,
    required this.completed,
  });
}

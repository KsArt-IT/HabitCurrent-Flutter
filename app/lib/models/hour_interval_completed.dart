final class HourIntervalCompleted {
  final int id;
  final int intervalId;
  final int time;
  final DateTime completed;

  const HourIntervalCompleted({
    this.id = 0,
    required this.intervalId,
    required this.time,
    required this.completed,
  });
}

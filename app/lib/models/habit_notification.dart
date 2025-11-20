final class HabitNotification {
  final int id;
  final int intervalId;

  final int weekDay;
  final int time;
  final bool repeats;

  HabitNotification({
    this.id = 0,
    required this.intervalId,

    required this.weekDay,
    required this.time,
    required this.repeats,
  });
}

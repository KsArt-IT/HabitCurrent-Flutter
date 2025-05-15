final class HabitNotification {
  final int id;
  final int intervalId;

  final int identifier;
  final int weekDay;
  final int time;
  final bool repeats;

  HabitNotification({
    required this.id,
    required this.intervalId,
    
    required this.identifier,
    required this.weekDay,
    required this.time,
    required this.repeats,
  });
}

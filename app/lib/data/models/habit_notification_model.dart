final class HabitNotificationModel {
  final int id;
  final int userId;
  final int habitId;
  final int intervalId;

  final String title;
  final int weekDay;
  final int time;
  final bool repeats;

  HabitNotificationModel({
    required this.id,
    required this.userId,
    required this.habitId,
    required this.intervalId,
    
    required this.title,
    required this.weekDay,
    required this.time,
    required this.repeats,
  });

  HabitNotificationModel copyWith({
    int? id,
    int? userId,
    int? habitId,
    int? intervalId,

    int? identifier,
    String? title,
    int? weekDay,
    int? time,
    bool? repeats,
  }) => HabitNotificationModel(
    id: id ?? this.id,
    userId: userId ?? this.userId,
    habitId: habitId ?? this.habitId,
    intervalId: intervalId ?? this.intervalId,

    title: title ?? this.title,
    weekDay: weekDay ?? this.weekDay,
    time: time ?? this.time,
    repeats: repeats ?? this.repeats,
  );
}
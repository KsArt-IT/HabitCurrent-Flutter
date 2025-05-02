import 'package:habit_current/models/habit_day_status.dart';

class HabitWeek {
  final int id;
  final String name;
  final List<HabitDayStatus> weekStatus;

  HabitWeek({required this.id, required this.name, required this.weekStatus});
}

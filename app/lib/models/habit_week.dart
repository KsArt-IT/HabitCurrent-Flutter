import 'package:habit_current/models/week_status.dart';

class HabitWeek {
  final int id;
  final String name;
  final List<WeekStatus> weekStatus;

  HabitWeek({required this.id, required this.name, required this.weekStatus});
}

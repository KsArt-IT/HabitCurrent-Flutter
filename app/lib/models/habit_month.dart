import 'package:habit_current/models/habit_day_status.dart';

class HabitMonth {
  final int id;
  final String name;
  final List<List<HabitDayStatus>> habitStatus;

  HabitMonth({required this.id, required this.name, required this.habitStatus});
}

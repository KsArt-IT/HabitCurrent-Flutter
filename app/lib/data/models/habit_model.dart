import 'package:drift/drift.dart';
import 'package:habit_current/models/habit.dart';

@UseRowClass(Habit)
class HabitModel extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get details => text().nullable()();
  DateTimeColumn get created => dateTime()();
  DateTimeColumn get updated => dateTime()();
  DateTimeColumn get completed => dateTime().nullable()();
  IntColumn get weekDaysRaw => integer()();
  IntColumn get intervals => integer()();
  IntColumn get completedIntervals => integer()();
}

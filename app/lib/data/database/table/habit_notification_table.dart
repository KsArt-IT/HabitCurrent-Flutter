import 'package:drift/drift.dart';

class HabitNotificationDatas extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer()();
  IntColumn get habitId => integer()();
  IntColumn get intervalId => integer()();

  TextColumn get title => text()();
  IntColumn get weekDay => integer()();
  IntColumn get time => integer()();
  BoolColumn get repeats => boolean()();
}

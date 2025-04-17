import 'package:drift/drift.dart';

class HourIntervals extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get habitId => integer()();

  IntColumn get time => integer()();
}

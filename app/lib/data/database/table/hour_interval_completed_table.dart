import 'package:drift/drift.dart';

class HourIntervalCompleteds extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get habitId => integer()();
  IntColumn get time => integer()();
  DateTimeColumn get completed => dateTime().clientDefault(()=> DateTime.now())();
}

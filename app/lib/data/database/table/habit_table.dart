import 'package:drift/drift.dart';

class Habits extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get userId => integer()();

  TextColumn get name => text().withLength(min: 1, max: 50)();
  TextColumn get details => text().nullable()();

  DateTimeColumn get created => dateTime().nullable().clientDefault(()=> DateTime.now())();
  DateTimeColumn get updated => dateTime().nullable().withDefault(currentDateAndTime)();
  DateTimeColumn get completed => dateTime().nullable()();

  IntColumn get weekDaysRaw => integer()();
}

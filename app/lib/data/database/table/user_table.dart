import 'package:drift/drift.dart';

class Users extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text().unique()();
  TextColumn get avatar => text().nullable()();
  DateTimeColumn get created => dateTime().clientDefault(() => DateTime.now())();
  DateTimeColumn get updated => dateTime().clientDefault(() => DateTime.now())();
}

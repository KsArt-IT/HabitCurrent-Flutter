import 'package:drift/drift.dart';
import 'package:habit_current/models/user.dart';

@UseRowClass(User)
class UserModel extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().unique()();
  TextColumn get avatar => text()();
}

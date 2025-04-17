import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:habit_current/data/database/tables.dart';

part 'database.g.dart';

@DriftDatabase(
  tables: [
    Users,
    Habits,
    HourIntervals,
    HourIntervalCompleteds,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'db.sqlite',
      native: const DriftNativeOptions(),
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.dart.js'),
      ),
    );
  }
}

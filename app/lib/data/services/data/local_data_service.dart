import 'package:drift/drift.dart';
import 'package:habit_current/data/database/database.dart';
import 'package:habit_current/data/models/models.dart';
import 'package:habit_current/data/services/data/data_service.dart';

final class LocalDataService implements DataService {
  LocalDataService({required this.database});

  final AppDatabase database;

  @override
  Future<void> close() async {
    await database.close();
  }

  // MARK: - User
  @override
  Future<void> deleteUserById(int id) {
    return database.users.deleteOne(UsersCompanion(id: Value(id)));
  }

  @override
  Future<UserModel?> loadUserByName(String name) async {
    try {
      final data =
          await database.managers.users
              .filter((f) => f.name.equals(name))
              .getSingleOrNull();
      if (data == null) return null;

      return UserModel(
        id: data.id,
        name: data.name,
        avatar: data.avatar,
        created: data.created,
      );
    } catch (e) {
      throw Exception('Error loading user: $e');
    }
  }

  @override
  Future<UserModel> createUserByName(String name) async {
    try {
      await database.users.insertOnConflictUpdate(
        UsersCompanion.insert(name: name),
      );
      return await loadUserByName(name) ??
          (throw Exception('User not found after creation'));
    } catch (e) {
      throw Exception('Error creation user: $e');
    }
  }

  @override
  Future<void> saveUser(UserModel user) {
    return database.users.update().write(
      UsersCompanion(
        id: Value(user.id),
        name: Value(user.name),
        avatar: Value(user.avatar),
        created: Value(user.created),
      ),
    );
  }

  // MARK: - Habit
  @override
  Future<void> deleteHabitById(int id) {
    return database.habits.deleteOne(HabitsCompanion(id: Value(id)));
  }

  @override
  Future<HabitModel> createHabit(HabitModel habit) async {
    try {
      int habitId = -1;
      await database.transaction(() async {
        habitId = await database.habits.insertOnConflictUpdate(
          HabitsCompanion.insert(
            userId: habit.userId,
            name: habit.name,
            details: Value(habit.details),
            weekDaysRaw: habit.weekDaysRaw,
          ),
        );

        for (final interval in habit.intervals) {
          await database.hourIntervals.insertOnConflictUpdate(
            HourIntervalsCompanion.insert(
              habitId: habitId,
              time: interval.time,
            ),
          );
        }
        // При создании hourIntervalCompleteds отсутствует
      });
      final habitRow = await loadHabitById(habitId);
      if (habitRow == null) {
        throw Exception('Habit not found after creation');
      }
      return habitRow;
    } catch (e) {
      throw Exception('Error creating habit: $e');
    }
  }

  @override
  Future<void> saveHabit(HabitModel habit) async {
    await database.transaction(() async {
      await database.habits.update().write(
        HabitsCompanion(
          id: Value(habit.id),
          userId: Value(habit.userId),
          name: Value(habit.name),
          details: Value(habit.details),
          weekDaysRaw: Value(habit.weekDaysRaw),
        ),
      );
      await database.hourIntervals.deleteWhere(
        (f) => f.habitId.equals(habit.id),
      );
      for (final interval in habit.intervals) {
        await database.hourIntervals.insertOnConflictUpdate(
          HourIntervalsCompanion.insert(habitId: habit.id, time: interval.time),
        );
      }
      // ! Completed нельзя обновлять
      /*
      await database.hourIntervalCompleteds.deleteWhere(
        (f) => f.habitId.equals(habit.id),
      );
      for (final completed in habit.completedIntervals) {
        await database.hourIntervalCompleteds.insertOnConflictUpdate(
          HourIntervalCompletedsCompanion.insert(
            habitId: habit.id,
            time: completed.time,
            completed: Value(completed.completed),
          ),
        );
      }
      */
    });
  }

  Future<HabitModel?> loadHabitById(int id) async {
    try {
      final habitRow =
          await (database.habits.select()..where((f) => f.id.equals(id)))
              .getSingleOrNull();
      if (habitRow == null) return null;

      return HabitModel(
        id: habitRow.id,
        userId: habitRow.userId,
        name: habitRow.name,
        details: habitRow.details,
        created: habitRow.created,
        updated: habitRow.updated,
        completed: habitRow.completed,
        weekDaysRaw: habitRow.weekDaysRaw,
        intervals: await _loadHourIntervalsByHabitId(habitRow.id),
        completedIntervals: await _loadHourIntervalCompletedsByHabitId(
          habitRow.id,
        ),
      );
    } catch (e) {
      throw Exception('Error loading habit by id: $e');
    }
  }

  @override
  Future<List<HabitModel>> loadHabitsByUserId(int userId) async {
    try {
      final rows =
          await (database.habits.select()
                ..where((f) => f.userId.equals(userId)))
              .get();
      return Future.wait(
        rows.map((habitRow) async {
          return HabitModel(
            id: habitRow.id,
            userId: habitRow.userId,
            name: habitRow.name,
            details: habitRow.details,
            created: habitRow.created,
            updated: habitRow.updated,
            completed: habitRow.completed,
            weekDaysRaw: habitRow.weekDaysRaw,
            intervals: await _loadHourIntervalsByHabitId(habitRow.id),
            completedIntervals: await _loadHourIntervalCompletedsByHabitId(
              habitRow.id,
            ),
          );
        }),
      ).then((List<HabitModel> habitModels) {
        return habitModels;
      });
    } catch (e) {
      throw Exception('Error loading habits by user id: $e');
    }
  }

  // MARK: - HourInterval
  Future<List<HourIntervalModel>> _loadHourIntervalsByHabitId(
    int habitId,
  ) async {
    try {
      final rows =
          await (database.hourIntervals.select()
                ..where((f) => f.habitId.equals(habitId)))
              .get();
      return rows
          .map(
            (e) =>
                HourIntervalModel(id: e.id, habitId: e.habitId, time: e.time),
          )
          .toList();
    } catch (e) {
      return [];
    }
  }

  // MARK: - HourIntervalCompleted
  Future<List<HourIntervalCompletedModel>> _loadHourIntervalCompletedsByHabitId(
    int habitId,
  ) async {
    try {
      final rows =
          await (database.hourIntervalCompleteds.select()
                ..where((f) => f.habitId.equals(habitId)))
              .get();
      return rows
          .map(
            (e) => HourIntervalCompletedModel(
              id: e.id,
              habitId: e.habitId,
              time: e.time,
              completed: e.completed,
            ),
          )
          .toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> deleteHourIntervalCompletedById(int id) {
    return database.hourIntervalCompleteds.deleteOne(
      HourIntervalCompletedsCompanion(id: Value(id)),
    );
  }

  @override
  Future<HourIntervalCompletedModel> createHourIntervalCompleted(
    HourIntervalCompletedModel completed,
  ) async {
    try {
      final id = await database.hourIntervalCompleteds.insertOnConflictUpdate(
        HourIntervalCompletedsCompanion.insert(
          habitId: completed.habitId,
          time: completed.time,
        ),
      );
      final intervalRow =
          await (database.hourIntervalCompleteds.select()
                ..where((f) => f.id.equals(id)))
              .getSingleOrNull();
      if (intervalRow == null) {
        throw Exception('Interval not found after creation');
      }
      return HourIntervalCompletedModel(
        id: intervalRow.id,
        habitId: intervalRow.habitId,
        time: intervalRow.time,
        completed: intervalRow.completed,
      );
    } catch (e) {
      throw Exception('Error creating hour interval completed: $e');
    }
  }

  @override
  Future<void> saveHourIntervalCompleted(HourIntervalCompletedModel completed) {
    return database.hourIntervalCompleteds.update().write(
      HourIntervalCompletedsCompanion(
        id: Value(completed.id),
        habitId: Value(completed.habitId),
        time: Value(completed.time),
        completed: Value(completed.completed),
      ),
    );
  }
}

import 'package:drift/drift.dart';
import 'package:habit_current/core/error/app_error.dart';
import 'package:habit_current/core/extension/datetime_ext.dart';
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
  Future<UserModel?> loadLastUser() async {
    try {
      final data =
          await (database.users.select()
                ..orderBy([(f) => OrderingTerm.desc(f.updated)]))
              .getSingleOrNull();
      if (data == null) return null;

      return UserModel(
        id: data.id,
        name: data.name,
        avatar: data.avatar,
        created: data.created,
        updated: data.updated,
      );
    } catch (e) {
      throw UserInitialError(e.toString());
    }
  }

  @override
  Future<UserModel?> loadUserByName(String name) async {
    try {
      final data =
          await (database.users.select()..where((f) => f.name.equals(name)))
              .getSingleOrNull();
      if (data == null) return null;

      return UserModel(
        id: data.id,
        name: data.name,
        avatar: data.avatar,
        created: data.created,
        updated: data.updated,
      );
    } catch (e) {
      throw UserLoadingError(e.toString());
    }
  }

  @override
  Future<UserModel> createUserByName(String name) async {
    try {
      await database.users.insertOnConflictUpdate(
        UsersCompanion.insert(name: name),
      );
      return await loadUserByName(name) ??
          (throw UserLoadingError('User not found after creation'));
    } catch (e) {
      throw UserLoadingError(e.toString());
    }
  }

  @override
  Future<void> saveUser(UserModel user) {
    try {
      return database.users.insertOnConflictUpdate(
        UsersCompanion(
          id: Value(user.id),
          name: Value(user.name),
          avatar: Value(user.avatar),
          created: Value(user.created),
        ),
      );
    } catch (e) {
      throw UserSavingError(e.toString());
    }
  }

  // MARK: - Habit
  @override
  Future<void> deleteHabitById(int id) async {
    try {
      await database.transaction(() async {
        // Удаляем интервалы и завершенные интервалы
        await database.hourIntervals.deleteWhere((f) => f.habitId.equals(id));
        await database.hourIntervalCompleteds.deleteWhere(
          (f) => f.habitId.equals(id),
        );
        // Удаляем уведомления
        await deleteNotificationByHabitId(id);
        // Удаляем привычку
        await database.habits.deleteOne(HabitsCompanion(id: Value(id)));
      });
    } catch (e) {
      throw DatabaseDeletingError(e.toString());
    }
  }

  @override
  Future<HabitModel> createHabit(HabitModel habit) async {
    try {
      int habitId = -1;
      await database.transaction(() async {
        // Создаем привычку
        habitId = await database.habits.insertOnConflictUpdate(
          HabitsCompanion.insert(
            userId: habit.userId,
            name: habit.name,
            details: Value(habit.details),
            weekDaysRaw: habit.weekDaysRaw,
          ),
        );

        // Создаем интервалы
        for (final interval in habit.intervals) {
          await database.hourIntervals.insertOnConflictUpdate(
            HourIntervalsCompanion.insert(
              habitId: habitId,
              time: interval.time,
            ),
          );
        }

        // Уведомления не создаем
      });

      // Загружаем созданную привычку
      final habitRow = await loadHabitById(habitId, DateTime.now());
      if (habitRow == null) {
        throw DatabaseCreatingError('Habit not found after creation');
      }
      return habitRow;
    } catch (e) {
      throw DatabaseCreatingError(e.toString());
    }
  }

  @override
  Future<HabitModel> saveHabit(HabitModel habit) async {
    // Получаем текущие интервалы
    final oldIntervals = await _loadHourIntervalsByHabitId(habit.id);
    try {
      await database.transaction(() async {
        // Обновляем основную запись привычки
        await database.habits.insertOnConflictUpdate(
          HabitsCompanion(
            id: Value(habit.id),
            userId: Value(habit.userId),
            name: Value(habit.name),
            details: Value(habit.details),
            created: Value(habit.created!),
            completed: Value(habit.completed),
            weekDaysRaw: Value(habit.weekDaysRaw),
          ),
        );

        final newIntervals = habit.intervals;

        // Удаляем интервалы и завершенные интервалы, которых больше нет
        final intervalsToDelete = oldIntervals.where(
          (old) => !newIntervals.any((newInterval) => newInterval.id == old.id),
        );
        for (final interval in intervalsToDelete) {
          await database.hourIntervals.deleteOne(
            HourIntervalsCompanion(id: Value(interval.id)),
          );
          await database.hourIntervalCompleteds.deleteWhere(
            (f) => f.intervalId.equals(interval.id),
          );
        }

        // Обновляем или добавляем новые интервалы
        for (final interval in newIntervals) {
          await database.hourIntervals.insertOnConflictUpdate(
            interval.id == 0
                ? HourIntervalsCompanion.insert(
                  habitId: habit.id,
                  time: interval.time,
                )
                : HourIntervalsCompanion(
                  id: Value(interval.id),
                  habitId: Value(habit.id),
                  time: Value(interval.time),
                ),
          );
        }

        // Удалим все уведомления, но не создаем
        await deleteNotificationByHabitId(habit.id);
      });
      // Загружаем созданную привычку
      final habitRow = await loadHabitById(habit.id, DateTime.now());
      if (habitRow == null) {
        throw DatabaseSavingError('Habit not found after creation');
      }
      return habitRow;
    } catch (e) {
      throw DatabaseSavingError(e.toString());
    }
  }

  @override
  Future<HabitModel?> loadHabitById(int id, DateTime date) async {
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
        completedIntervals: await _loadHourIntervalCompletedsByHabitIdFromDate(
          habitRow.id,
          date,
        ),
        notifications: await loadNotificationsByHabitId(habitRow.id),
      );
    } catch (e) {
      throw DatabaseLoadingError(e.toString());
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
            notifications: await loadNotificationsByHabitId(habitRow.id),
          );
        }),
      ).then((List<HabitModel> habitModels) {
        return habitModels;
      });
    } catch (e) {
      throw DatabaseLoadingError(e.toString());
    }
  }

  @override
  Future<List<HabitModel>> loadHabitsByUserIdFromDate(
    int userId,
    DateTime date,
  ) async {
    try {
      final rows =
          await (database.habits.select()
                ..where((f) => f.userId.equals(userId))
                ..where(
                  (f) =>
                      f.created.isSmallerOrEqualValue(date.toEndOfDay()) &
                      (f.completed.isNull() |
                          f.completed.isBiggerOrEqualValue(
                            date.toStartOfDay(),
                          )),
                ))
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
            completedIntervals:
                await _loadHourIntervalCompletedsByHabitIdFromDate(
                  habitRow.id,
                  date,
                ),
            notifications: await loadNotificationsByHabitId(habitRow.id),
          );
        }),
      ).then((List<HabitModel> habitModels) {
        return habitModels;
      });
    } catch (e) {
      throw DatabaseLoadingError(e.toString());
    }
  }

  @override
  Future<List<HabitModel>> loadHabitsByUserIdFromDateRange(
    int userId,
    DateTime start,
    DateTime end,
  ) async {
    try {
      final rows =
          await (database.habits.select()
                ..where((f) => f.userId.equals(userId))
                ..where(
                  (f) =>
                      f.created.isSmallerOrEqualValue(end.toEndOfDay()) &
                      (f.completed.isNull() |
                          f.completed.isBiggerOrEqualValue(
                            start.toStartOfDay(),
                          )),
                ))
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
            completedIntervals:
                await _loadHourIntervalCompletedsByHabitIdFromDateRange(
                  habitRow.id,
                  start,
                  end,
                ),
            notifications: await loadNotificationsByHabitId(habitRow.id),
          );
        }),
      );
    } catch (e) {
      throw DatabaseLoadingError(e.toString());
    }
  }

  // MARK: - HourInterval
  Future<List<HourIntervalModel>> _loadHourIntervalsByHabitId(
    int habitId,
  ) async {
    final rows =
        await (database.hourIntervals.select()
              ..where((f) => f.habitId.equals(habitId)))
            .get();
    return rows
        .map(
          (e) => HourIntervalModel(id: e.id, habitId: e.habitId, time: e.time),
        )
        .toList();
  }

  // MARK: - HourIntervalCompleted
  Future<List<HourIntervalCompletedModel>> _loadHourIntervalCompletedsByHabitId(
    int habitId,
  ) async {
    final rows =
        await (database.hourIntervalCompleteds.select()
              ..where((f) => f.habitId.equals(habitId)))
            .get();
    return rows
        .map(
          (e) => HourIntervalCompletedModel(
            id: e.id,
            habitId: e.habitId,
            intervalId: e.intervalId,
            time: e.time,
            completed: e.completed,
          ),
        )
        .toList();
  }

  Future<List<HourIntervalCompletedModel>>
  _loadHourIntervalCompletedsByHabitIdFromDate(
    int habitId,
    DateTime date,
  ) async {
    final rows =
        await (database.hourIntervalCompleteds.select()
              ..where((f) => f.habitId.equals(habitId))
              ..where(
                (f) =>
                    f.completed.year.equals(date.year) &
                    f.completed.month.equals(date.month) &
                    f.completed.day.equals(date.day),
              ))
            .get();
    return rows
        .map(
          (e) => HourIntervalCompletedModel(
            id: e.id,
            habitId: e.habitId,
            intervalId: e.intervalId,
            time: e.time,
            completed: e.completed,
          ),
        )
        .toList();
  }

  Future<List<HourIntervalCompletedModel>>
  _loadHourIntervalCompletedsByHabitIdFromDateRange(
    int habitId,
    DateTime start,
    DateTime end,
  ) async {
    final rows =
        await (database.hourIntervalCompleteds.select()
              ..where((f) => f.habitId.equals(habitId))
              ..where(
                (f) =>
                    f.completed.isBiggerOrEqualValue(start.toStartOfDay()) &
                    f.completed.isSmallerOrEqualValue(end.toEndOfDay()),
              ))
            .get();
    return rows
        .map(
          (e) => HourIntervalCompletedModel(
            id: e.id,
            habitId: e.habitId,
            intervalId: e.intervalId,
            time: e.time,
            completed: e.completed,
          ),
        )
        .toList();
  }

  @override
  Future<void> deleteHourIntervalCompletedById(int id) {
    try {
      return database.hourIntervalCompleteds.deleteOne(
        HourIntervalCompletedsCompanion(id: Value(id)),
      );
    } catch (e) {
      throw DatabaseDeletingError(e.toString());
    }
  }

  @override
  Future<HourIntervalCompletedModel> createHourIntervalCompleted(
    HourIntervalCompletedModel completed,
  ) async {
    try {
      final id = await database.hourIntervalCompleteds.insertOnConflictUpdate(
        HourIntervalCompletedsCompanion.insert(
          habitId: completed.habitId,
          intervalId: completed.intervalId,
          time: completed.time,
          completed: Value(completed.completed),
        ),
      );
      final intervalRow =
          await (database.hourIntervalCompleteds.select()
                ..where((f) => f.id.equals(id)))
              .getSingleOrNull();
      if (intervalRow == null) {
        throw DatabaseCreatingError('Interval not found after creation');
      }
      return HourIntervalCompletedModel(
        id: intervalRow.id,
        habitId: intervalRow.habitId,
        intervalId: intervalRow.intervalId,
        time: intervalRow.time,
        completed: intervalRow.completed,
      );
    } catch (e) {
      throw DatabaseCreatingError(e.toString());
    }
  }

  // MARK: - HabitNotification
  @override
  Future<HabitNotificationModel?> loadNotificationById(int id) async {
    try {
      final row =
          await (database.habitNotificationDatas.select()
                ..where((f) => f.id.equals(id)))
              .getSingleOrNull();
      if (row == null) return null;
      return HabitNotificationModel(
        id: row.id,
        userId: row.userId,
        habitId: row.habitId,
        intervalId: row.intervalId,
        title: row.title,
        weekDay: row.weekDay,
        time: row.time,
        repeats: row.repeats,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<HabitNotificationModel?> loadNotificationByIntervalId(int intervalId) async {
    try {
      final row =
          await (database.habitNotificationDatas.select()
                ..where((f) => f.intervalId.equals(intervalId)))
              .getSingleOrNull();
      if (row == null) return null;
      return HabitNotificationModel(
        id: row.id,
        userId: row.userId,
        habitId: row.habitId,
        intervalId: row.intervalId,
        title: row.title,
        weekDay: row.weekDay,
        time: row.time,
        repeats: row.repeats,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  Future<List<HabitNotificationModel>> loadNotificationsByHabitId(
    int habitId,
  ) async {
    try {
      final rows =
          await (database.habitNotificationDatas.select()
                ..where((f) => f.habitId.equals(habitId)))
              .get();
      return rows
          .map(
            (e) => HabitNotificationModel(
              id: e.id,
              userId: e.userId,
              habitId: e.habitId,
              intervalId: e.intervalId,
              title: e.title,
              weekDay: e.weekDay,
              time: e.time,
              repeats: e.repeats,
            ),
          )
          .toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<List<HabitNotificationModel>> loadNotificationsByUserId(
    int userId,
  ) async {
    try {
      final rows =
          await (database.habitNotificationDatas.select()
                ..where((f) => f.userId.equals(userId)))
              .get();
      return rows
          .map(
            (e) => HabitNotificationModel(
              id: e.id,
              userId: e.userId,
              habitId: e.habitId,
              intervalId: e.intervalId,
              title: e.title,
              weekDay: e.weekDay,
              time: e.time,
              repeats: e.repeats,
            ),
          )
          .toList();
    } catch (e) {
      return [];
    }
  }

  @override
  Future<void> saveNotifications(
    List<HabitNotificationModel> notifications,
  ) async {
    try {
      for (final notification in notifications) {
        await _saveNotification(notification);
      }
    } catch (e) {
      throw DatabaseSavingError(e.toString());
    }
  }

  Future<void> _saveNotification(HabitNotificationModel notification) async {
    await database.habitNotificationDatas.insertOnConflictUpdate(
      HabitNotificationDatasCompanion.insert(
        userId: notification.userId,
        habitId: notification.habitId,
        intervalId: notification.intervalId,
        title: notification.title,
        weekDay: notification.weekDay,
        time: notification.time,
        repeats: notification.repeats,
      ),
    );
  }

  @override
  Future<void> deleteNotificationByHabitId(int habitId) async {
    try {
      await database.habitNotificationDatas.deleteWhere(
        (f) => f.habitId.equals(habitId),
      );
    } catch (e) {
      throw DatabaseDeletingError(e.toString());
    }
  }

  @override
  Future<void> deleteNotificationById(int id) async {
    try {
      await database.habitNotificationDatas.deleteOne(
        HabitNotificationDatasCompanion(id: Value(id)),
      );
    } catch (e) {
      throw DatabaseDeletingError(e.toString());
    }
  }
}

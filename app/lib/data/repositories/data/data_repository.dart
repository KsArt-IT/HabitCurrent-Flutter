import 'package:habit_current/models/habit.dart';
import 'package:habit_current/models/habit_notification.dart';
import 'package:habit_current/models/hour_interval_completed.dart';
import 'package:habit_current/models/user.dart';

abstract interface class DataRepository {
  Future<User?> loadUserByName(String name);
  Future<User?> loadLastUser();
  Future<User> createUserByName(String name);
  Future<void> saveUser(User user);
  Future<void> deleteUserById(int id);

  Future<List<Habit>> loadHabitsByUserId(int userId);
  Future<List<Habit>> loadHabitsByUserIdFromDate(int userId, DateTime date);
  Future<List<Habit>> loadHabitsByUserIdFromDateRange({
    required int userId,
    required DateTime start,
    required DateTime end,
  });
  Future<Habit?> loadHabitById(int id, DateTime date);
  Future<Habit> createHabit(Habit habit);
  Future<Habit> saveHabit(Habit habit);
  Future<void> deleteHabitById(int id);

  Future<HourIntervalCompleted> createHourIntervalCompleted(
    int habitId,
    HourIntervalCompleted interval,
  );
  Future<void> deleteHourIntervalCompletedById(int id);

  Future<void> saveNotifications({
    required int userId,
    required int habitId,
    required String title,
    required List<HabitNotification> notifications,
  });

  Future<void> close();
}

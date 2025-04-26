import 'package:habit_current/models/habit.dart';
import 'package:habit_current/models/hour_interval_completed.dart';
import 'package:habit_current/models/user.dart';

abstract interface class DataRepository {
  Future<User?> loadUserByName(String name);
  Future<User> createUserByName(String name);
  Future<void> saveUser(User user);
  Future<void> deleteUserById(int id);

  Future<List<Habit>> loadHabitsByUserId(int userId);
  Future<List<Habit>> loadHabitsByUserIdFromDate(int userId, DateTime date);
  Future<Habit?> loadHabitById(int id, DateTime date);
  Future<Habit> createHabit(Habit habit);
  Future<void> saveHabit(Habit habit);
  Future<void> deleteHabitById(int id);

  Future<HourIntervalCompleted> createHourIntervalCompleted(int habitId, HourIntervalCompleted interval);
  Future<void> deleteHourIntervalCompletedById(int id);

  Future<void> close();
}
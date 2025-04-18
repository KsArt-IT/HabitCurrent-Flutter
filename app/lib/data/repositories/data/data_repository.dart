import 'package:habit_current/models/habit.dart';
import 'package:habit_current/models/user.dart';

abstract interface class DataRepository {
  Future<User?> loadUserByName(String name);
  Future<User> createUserByName(String name);
  Future<void> saveUser(User user);
  Future<void> deleteUserById(int id);

  Future<List<Habit>> loadHabitsByUserId(int userId);
  Future<Habit> createHabit(Habit habit);
  Future<void> saveHabit(Habit habit);
  Future<void> deleteHabitById(int id);

  Future<void> close();
}
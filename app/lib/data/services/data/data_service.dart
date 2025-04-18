import 'package:habit_current/data/models/models.dart';

abstract interface class DataService {
  Future<UserModel?> loadUserByName(String name);
  Future<UserModel> createUserByName(String name);
  Future<void> saveUser(UserModel user);
  Future<void> deleteUserById(int id);

  Future<List<HabitModel>> loadHabitsByUserId(int userId);
  Future<HabitModel> createHabit(HabitModel habit);
  Future<void> saveHabit(HabitModel habit);
  Future<void> deleteHabitById(int id);

  Future<HourIntervalCompletedModel> createHourIntervalCompleted(
    HourIntervalCompletedModel completed,
  );
  Future<void> saveHourIntervalCompleted(HourIntervalCompletedModel completed);
  Future<void> deleteHourIntervalCompletedById(int id);

  Future<void> close();
}

import 'package:habit_current/data/models/models.dart';

abstract interface class DataService {
  Future<UserModel?> loadUserByName(String name);
  Future<UserModel> createUserByName(String name);
  Future<void> saveUser(UserModel user);
  Future<void> deleteUserById(int id);

  Future<List<HabitModel>> loadHabitsByUserId(int userId);
  Future<List<HabitModel>> loadHabitsByUserIdFromDate(
    int userId,
    DateTime date,
  );
  Future<List<HabitModel>> loadHabitsByUserIdFromDateRange(
    int userId,
    DateTime start,
    DateTime end,
  );
  Future<HabitModel?> loadHabitById(int id, DateTime date);
  Future<HabitModel> createHabit(HabitModel habit);
  Future<HabitModel> saveHabit(HabitModel habit);
  Future<void> deleteHabitById(int id);

  Future<HourIntervalCompletedModel> createHourIntervalCompleted(
    HourIntervalCompletedModel completed,
  );
  Future<void> deleteHourIntervalCompletedById(int id);

  Future<List<HabitNotificationModel>> loadNotificationsByHabitId(int habitId);
  Future<void> deleteNotificationById(int id);
  Future<void> deleteNotificationByHabitId(int habitId);

  Future<void> close();
}

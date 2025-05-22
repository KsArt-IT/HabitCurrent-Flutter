import 'package:habit_current/data/mappers/domain_to_model.dart';
import 'package:habit_current/data/mappers/model_to_domain.dart';
import 'package:habit_current/data/repositories/data/data_repository.dart';
import 'package:habit_current/data/services/data/data_service.dart';
import 'package:habit_current/models/habit.dart';
import 'package:habit_current/models/habit_notification.dart';
import 'package:habit_current/models/hour_interval_completed.dart';
import 'package:habit_current/models/user.dart';

final class LocalDataRepository implements DataRepository {
  LocalDataRepository({required DataService service}) : _service = service;

  final DataService _service;

  @override
  Future<void> close() async {
    await _service.close();
  }

  // MARK: - User
  @override
  Future<User> createUserByName(String name) async {
    final user = await _service.createUserByName(name);
    return user.toDomain();
  }

  @override
  Future<User?> loadLastUser() async {
    final user = await _service.loadLastUser();
    return user?.toDomain();
  }

  @override
  Future<User?> loadUserByName(String name) async {
    final user = await _service.loadUserByName(name);
    return user?.toDomain();
  }

  @override
  Future<void> saveUser(User user) {
    return _service.saveUser(user.toModel());
  }

  @override
  Future<void> deleteUserById(int id) {
    return _service.deleteUserById(id);
  }

  // MARK: - Habit
  @override
  Future<List<Habit>> loadHabitsByUserId(int userId) async {
    final habits = await _service.loadHabitsByUserId(userId);
    return habits.map((e) => e.toDomain()).toList();
  }

  @override
  Future<List<Habit>> loadHabitsByUserIdFromDate(
    int userId,
    DateTime date,
  ) async {
    final habits = await _service.loadHabitsByUserIdFromDate(userId, date);
    if (habits.isEmpty) return [];
    return habits.map((e) => e.toDomain()).toList();
  }

  @override
  Future<List<Habit>> loadHabitsByUserIdFromDateRange({
    required int userId,
    required DateTime start,
    required DateTime end,
  }) async {
    final habits = await _service.loadHabitsByUserIdFromDateRange(
      userId,
      start,
      end,
    );
    if (habits.isEmpty) return [];
    return habits.map((e) => e.toDomain()).toList();
  }

  @override
  Future<Habit?> loadHabitById(int id, DateTime date) async {
    final habit = await _service.loadHabitById(id, date);
    return habit?.toDomain();
  }

  @override
  Future<Habit> createHabit(Habit habit) async {
    final model = await _service.createHabit(habit.toModel());
    return model.toDomain();
  }

  @override
  Future<Habit> saveHabit(Habit habit) async {
    final model = await _service.saveHabit(habit.toModel());
    return model.toDomain();
  }

  @override
  Future<void> deleteHabitById(int id) {
    return _service.deleteHabitById(id);
  }

  @override
  Future<HourIntervalCompleted> createHourIntervalCompleted(
    int habitId,
    HourIntervalCompleted interval,
  ) async {
    final model = await _service.createHourIntervalCompleted(
      interval.toModel(habitId),
    );
    return model.toDomain();
  }

  @override
  Future<void> deleteHourIntervalCompletedById(int id) {
    return _service.deleteHourIntervalCompletedById(id);
  }

  @override
  Future<void> saveNotifications({
    required int userId,
    required int habitId,
    required String title,
    required List<HabitNotification> notifications,
  }) {
    final notificationsModel =
        notifications
            .map(
              (e) => e.toModel(
                userId: userId,
                habitId: habitId,
                title: title, //
              ),
            )
            .toList();

    return _service.saveNotifications(notificationsModel);
  }
}

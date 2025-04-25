import 'package:habit_current/data/mappers/domain_to_model.dart';
import 'package:habit_current/data/mappers/model_to_domain.dart';
import 'package:habit_current/data/repositories/data/data_repository.dart';
import 'package:habit_current/data/services/data/data_service.dart';
import 'package:habit_current/models/habit.dart';
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
  Future<List<Habit>> loadHabitsByUserIdFromDate(int userId, DateTime date) async {
    final habits = await _service.loadHabitsByUserIdFromDate(userId, date);
    if (habits.isEmpty) {
      return [];
    }
    return habits.map((e) => e.toDomain()).toList();
  }

  @override
  Future<Habit> createHabit(Habit habit) async {
    final model = await _service.createHabit(habit.toModel());
    return model.toDomain();
  }

  @override
  Future<void> saveHabit(Habit habit) {
    return _service.saveHabit(habit.toModel());
  }

  @override
  Future<void> deleteHabitById(int id) {
    return _service.deleteHabitById(id);
  }
}

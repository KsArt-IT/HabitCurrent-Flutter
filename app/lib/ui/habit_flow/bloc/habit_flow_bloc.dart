import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/data/repositories/data/data_repository.dart';
import 'package:habit_current/models/habit.dart';
import 'package:habit_current/models/habit_state_status.dart';
import 'package:habit_current/models/weekdays.dart';

part 'habit_flow_event.dart';
part 'habit_flow_state.dart';

class HabitFlowBloc extends Bloc<HabitFlowEvent, HabitFlowState> {
  final DataRepository _repository;

  HabitFlowBloc({required DataRepository repository})
    : _repository = repository,
      super(const HabitFlowState()) {
    on<LoadHabitsEvent>(_onLoadHabits);
    on<RefreshHabitsEvent>(_onRefreshHabits);
    on<ReloadHabitEvent>(_onReloadHabit);
    on<DeleteHabitEvent>(_onDeleteHabit);
  }

  List<Habit> _filterAndSortHabits(List<Habit> habits, DateTime date) {
    // Фильтруем привычки по текущему дню недели
    final weekDay = WeekDays.fromDate(date);
    return (habits.where((habit) => habit.weekDays.contains(weekDay)).toList()
      // Сортируем по имени
      ..sort((a, b) => a.name.compareTo(b.name)));
  }

  Future<void> _onLoadHabits(
    LoadHabitsEvent event,
    Emitter<HabitFlowState> emit,
  ) async {
    emit(
      state.copyWith(userId: event.userId, status: HabitStateStatus.loading),
    );

    try {
      final date = DateTime.now();
      final habits = await _repository.loadHabitsByUserIdFromDate(
        event.userId,
        date,
      );
      if (habits.isEmpty) {
        emit(state.copyWith(status: HabitStateStatus.success, habits: []));
        return;
      }

      emit(
        state.copyWith(
          status: HabitStateStatus.success,
          habits: _filterAndSortHabits(habits, date),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: HabitStateStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onRefreshHabits(
    RefreshHabitsEvent event,
    Emitter<HabitFlowState> emit,
  ) async {
    try {
      final date = DateTime.now();
      final habits = await _repository.loadHabitsByUserIdFromDate(
        state.userId,
        date,
      );

      emit(
        state.copyWith(
          status: HabitStateStatus.success,
          habits: _filterAndSortHabits(habits, date),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: HabitStateStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onReloadHabit(
    ReloadHabitEvent event,
    Emitter<HabitFlowState> emit,
  ) async {
    try {
      final date = DateTime.now();
      List<Habit> habits = List<Habit>.from(state.habits);
      if (event.habitId != null) {
        final habit = await _repository.loadHabitById(event.habitId!, date);
        if (habit == null) return;
        final index = state.habits.indexWhere((e) => e.id == habit.id);
        if (index != -1) {
          habits[index] = habit;
        } else {
          habits.add(habit);
        }
      } else {
        habits = await _repository.loadHabitsByUserIdFromDate(
          state.userId,
          date,
        );
      }
      emit(
        state.copyWith(
          status: HabitStateStatus.success,
          habits: _filterAndSortHabits(habits, date),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: HabitStateStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onDeleteHabit(
    DeleteHabitEvent event,
    Emitter<HabitFlowState> emit,
  ) async {
    try {
      await _repository.deleteHabitById(event.habitId);
      List<Habit> habits = List<Habit>.from(state.habits);
      habits.removeWhere((e) => e.id == event.habitId);
      emit(state.copyWith(status: HabitStateStatus.success, habits: habits));
    } catch (e) {
      emit(
        state.copyWith(
          status: HabitStateStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}

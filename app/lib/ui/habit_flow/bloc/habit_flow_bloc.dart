import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/data/repositories/data/data_repository.dart';
import 'package:habit_current/models/habit.dart';
import 'package:habit_current/models/habit_status.dart';

part 'habit_flow_state.dart';
part 'habit_flow_event.dart';

class HabitFlowBloc extends Bloc<HabitFlowEvent, HabitFlowState> {
  final DataRepository _repository;

  HabitFlowBloc({required DataRepository repository})
    : _repository = repository,
      super(const HabitFlowState()) {
    on<LoadHabitsEvent>(_onLoadHabits);
    on<RefreshHabitsEvent>(_onRefreshHabits);
    on<HabitReloadEvent>(_onHabitReload);
    on<HabitDeletedEvent>(_onHabitDeleted);
  }

  Future<void> _onLoadHabits(
    LoadHabitsEvent event,
    Emitter<HabitFlowState> emit,
  ) async {
    emit(state.copyWith(userId: event.userId, status: HabitStatus.loading));

    try {
      final habits = await _repository.loadHabitsByUserIdFromDate(
        event.userId,
        DateTime.now(),
      );
      if (habits.isEmpty) {
        emit(state.copyWith(status: HabitStatus.success, habits: []));
        return;
      }
      print("-----------------------------");
      print("habits: ${habits.length}");
      print("-----------------------------");
      emit(state.copyWith(status: HabitStatus.success, habits: habits));
    } catch (e) {
      emit(
        state.copyWith(
          status: HabitStatus.error,
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
      final habits = await _repository.loadHabitsByUserIdFromDate(
        state.userId,
        DateTime.now(),
      );

      emit(state.copyWith(status: HabitStatus.success, habits: habits));
    } catch (e) {
      emit(
        state.copyWith(
          status: HabitStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onHabitReload(
    HabitReloadEvent event,
    Emitter<HabitFlowState> emit,
  ) async {
    try {
      List<Habit> habits = state.habits.toList();
      if (event.habitId != null) {
        final habit = await _repository.loadHabitById(
          event.habitId!,
          DateTime.now(),
        );
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
          DateTime.now(),
        );
      }
      emit(state.copyWith(status: HabitStatus.success, habits: habits));
    } catch (e) {
      emit(
        state.copyWith(
          status: HabitStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onHabitDeleted(
    HabitDeletedEvent event,
    Emitter<HabitFlowState> emit,
  ) async {
    try {
      await _repository.deleteHabitById(event.habitId);
      List<Habit> habits = state.habits.toList();
      habits.removeWhere((e) => e.id == event.habitId);
      emit(state.copyWith(status: HabitStatus.success, habits: habits));
    } catch (e) {
      emit(state.copyWith(status: HabitStatus.error, errorMessage: e.toString()));
    }
  }
}

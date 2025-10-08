import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:habit_current/core/extension/datetime_ext.dart';
import 'package:habit_current/data/repositories/data/data_repository.dart';
import 'package:habit_current/models/habit.dart';
import 'package:habit_current/models/state_status.dart';
import 'package:habit_current/models/habit_week.dart';
import 'package:habit_current/models/habit_day_status.dart';
import 'package:habit_current/models/weekdays.dart';

part 'habit_week_event.dart';
part 'habit_week_state.dart';

class HabitWeekBloc extends Bloc<HabitWeekEvent, HabitWeekState> {
  final DataRepository repository;

  HabitWeekBloc({required this.repository}) : super(HabitWeekState(date: DateTime.now())) {
    on<LoadHabitWeekEvent>(_onLoadHabitWeekEvent);
    on<ReloadHabitEvent>(_onReloadHabitEvent);
    on<RefreshHabitWeekEvent>(_onRefreshHabitWeekEvent);
  }

  Future<void> _onLoadHabitWeekEvent(
    LoadHabitWeekEvent event,
    Emitter<HabitWeekState> emit,
  ) async {
    emit(state.copyWith(status: StateStatus.loading));
    final currentDate = DateTime.now().toEndOfDay();
    final completedHabits = await _loadHabits(event.userId, currentDate);
    emit(
      state.copyWith(
        userId: event.userId,
        date: currentDate,
        status: StateStatus.success,
        completedHabits: completedHabits,
      ),
    );
  }

  Future<void> _onReloadHabitEvent(
    ReloadHabitEvent event,
    Emitter<HabitWeekState> emit,
  ) async {
    // TODO: переделать на загрузку 1 habit за месяц
    final currentDate = DateTime.now().toEndOfDay();
    final completedHabits = await _loadHabits(state.userId, currentDate);
    emit(
      state.copyWith(
        userId: state.userId,
        date: currentDate,
        status: StateStatus.success,
        completedHabits: completedHabits,
      ),
    );
  }

  Future<void> _onRefreshHabitWeekEvent(
    RefreshHabitWeekEvent event,
    Emitter<HabitWeekState> emit,
  ) async {
    try {
      final currentDate = DateTime.now().toEndOfDay();
      final completedHabits = await _loadHabits(state.userId, currentDate);
      emit(
        state.copyWith(
          userId: state.userId,
          date: currentDate,
          status: StateStatus.success,
          completedHabits: completedHabits,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: StateStatus.error));
    } finally {
      event.completer.complete();
    }
  }

  Future<List<HabitWeek>> _loadHabits(int userId, DateTime date) async {
    final weekRange = date.toWeekRange();

    final habits = await repository.loadHabitsByUserIdFromDateRange(
      userId: userId,
      start: weekRange.start,
      end: weekRange.end,
    );

    if (habits.isEmpty) return [];
    return _filterAndSortHabits(habits, date);
  }

  List<HabitWeek> _filterAndSortHabits(List<Habit> habits, DateTime date) {
    final weekRange = date.toWeekRange();
    final dayStart = weekRange.start.toEndOfDay();
    final dayEnd = weekRange.end;
    return (habits.map((habit) {
        final habitLength = habit.intervals.length;
        final weekStatuses = <HabitDayStatus>[];

        var day = dayStart;
        while (day.isBeforeOrEqual(dayEnd)) {
          final status = _calculateStatus(
            habit: habit,
            day: day,
            habitLength: habitLength,
            currentDate: date,
          );
          weekStatuses.add(status);
          day = day.add(const Duration(days: 1));
        }

        return HabitWeek(
          id: habit.id,
          name: habit.name,
          weekStatus: weekStatuses,
        );
      }).toList()
      // Сортируем по имени
      ..sort((a, b) => a.name.compareTo(b.name)));
  }

  HabitDayStatus _calculateStatus({
    required Habit habit,
    required DateTime day,
    required int habitLength,
    required DateTime currentDate,
  }) {
    // закрыто
    if (habit.completed != null && day.isAfter(habit.completed!.toEndOfDay())) {
      return HabitDayStatus.closed;
    }

    // не начато
    if (habit.created != null && day.isBefore(habit.created!)) {
      return HabitDayStatus.notStarted;
    }

    // не в этот день, пропуск
    if (!habit.weekDays.contains(WeekDays.fromDate(day))) {
      return HabitDayStatus.skipped;
    }

    // ожидает выполнения, завтра
    if (day.isAfter(currentDate)) {
      return HabitDayStatus.awaitsExecution;
    }

    // сколько выполнено
    final completedCount =
        habit.completedIntervals.where((e) => e.completed.isSameDate(day)).length;

    if (completedCount == habitLength) return HabitDayStatus.completed;
    if (completedCount > 0) return HabitDayStatus.partiallyCompleted;
    return HabitDayStatus.notCompleted;
  }
}

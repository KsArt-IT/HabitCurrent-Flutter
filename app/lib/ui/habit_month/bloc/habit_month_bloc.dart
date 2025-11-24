import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:habit_current/core/error/app_error.dart';
import 'package:habit_current/core/extension/datetime_ext.dart';
import 'package:habit_current/data/repositories/data/data_repository.dart';
import 'package:habit_current/models/habit.dart';
import 'package:habit_current/models/habit_day_status.dart';
import 'package:habit_current/models/habit_month.dart';
import 'package:habit_current/models/state_status.dart';
import 'package:habit_current/models/weekdays.dart';

part 'habit_month_event.dart';
part 'habit_month_state.dart';

class HabitMonthBloc extends Bloc<HabitMonthEvent, HabitMonthState> {
  final DataRepository repository;

  HabitMonthBloc({required this.repository})
    : super(
        HabitMonthState(
          currentDate: DateTime.now(),
          selectedMonth: DateTime.now(),
        ),
      ) {
    on<LoadHabitEvent>(_onLoadHabitMonthEvent);
    on<ChangeMonthHabitEvent>(_onChangeHabitMonthEvent);
    on<RefreshHabitEvent>(_onRefreshHabitMonthEvent);
    on<ReloadHabitEvent>(_onReloadHabitEvent);
  }

  Future<void> _onLoadHabitMonthEvent(
    LoadHabitEvent event,
    Emitter<HabitMonthState> emit,
  ) async {
    try {
      emit(state.copyWith(status: StateStatus.loading, userId: event.userId));
      final currentDate = DateTime.now().toEndOfDay();
      final statusHabits = await _loadHabitsAndCheckStatus(
        event.userId,
        currentDate,
      );
      emit(
        state.copyWith(
          currentDate: currentDate,
          status: StateStatus.success,
          selectedMonth: currentDate,
          habits: statusHabits,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: StateStatus.error,
          error: DatabaseLoadingError(e.toString()),
        ),
      );
    }
  }

  Future<void> _onChangeHabitMonthEvent(
    ChangeMonthHabitEvent event,
    Emitter<HabitMonthState> emit,
  ) async {
    try {
      final date = event.selectedMonth.toEndOfDay();
      final statusHabits = await _loadHabitsAndCheckStatus(state.userId, date);
      emit(
        state.copyWith(
          status: StateStatus.success,
          selectedMonth: date,
          habits: statusHabits,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: StateStatus.error,
          error: DatabaseLoadingError(e.toString()),
        ),
      );
    }
  }

  Future<void> _onRefreshHabitMonthEvent(
    RefreshHabitEvent event,
    Emitter<HabitMonthState> emit,
  ) async {
    try {
      final date = state.selectedMonth.toEndOfDay();
      final statusHabits = await _loadHabitsAndCheckStatus(state.userId, date);
      emit(
        state.copyWith(
          status: StateStatus.success,
          selectedMonth: date,
          habits: statusHabits,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: StateStatus.error,
          error: DatabaseLoadingError(e.toString()),
        ),
      );
    } finally {
      event.completer.complete();
    }
  }

  Future<void> _onReloadHabitEvent(
    ReloadHabitEvent event,
    Emitter<HabitMonthState> emit,
  ) async {
    try {
      // TODO: переделать на загрузку 1 habit за месяц
      final date = state.selectedMonth.toEndOfDay();
      final statusHabits = await _loadHabitsAndCheckStatus(state.userId, date);
      emit(
        state.copyWith(
          status: StateStatus.success,
          selectedMonth: date,
          habits: statusHabits,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: StateStatus.error,
          error: DatabaseLoadingError(e.toString()),
        ),
      );
    }
  }

  Future<List<HabitMonth>> _loadHabitsAndCheckStatus(
    int userId,
    DateTime date,
  ) async {
    final monthRange = date.toMonthRange();

    final habits = await repository.loadHabitsByUserIdFromDateRange(
      userId: userId,
      start: monthRange.start,
      end: monthRange.end,
    );
    if (habits.isEmpty) return [];
    return _filterAndSortHabits(habits, monthRange);
  }

  List<HabitMonth> _filterAndSortHabits(
    List<Habit> habits,
    MonthRange monthRange,
  ) {
    final currentDate = DateTime.now().toEndOfDay();
    return (habits.map((habit) {
        final habitLength = habit.intervals.length;
        final habitStatus = <HabitDayStatus>[];

        var day = monthRange.start;
        while (day.isBeforeOrEqual(monthRange.end)) {
          final status = _calculateStatus(
            habit: habit,
            day: day,
            habitLength: habitLength,
            currentDate: currentDate,
          );
          habitStatus.add(status);
          day = day.add(const Duration(days: 1));
        }
        return HabitMonth(
          id: habit.id,
          name: habit.name,
          habitStatus: _cleanAndChunkBySeven(habitStatus),
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
      // log('notStarted: $day habit: ${habit.name} ${habit.created}', name: 'HabitMonthBloc');
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
    final completedCount = habit.completedIntervals
        .where((e) => e.completed.isSameDate(day))
        .length;

    if (completedCount == habitLength) return HabitDayStatus.completed;
    if (completedCount > 0) return HabitDayStatus.partiallyCompleted;
    return HabitDayStatus.notCompleted;
  }

  List<List<HabitDayStatus>> _cleanAndChunkBySeven(List<HabitDayStatus> list) {
    // оставляем только выполнено, частично выполнено, не выполнено, не начато
    final cleanedList = list
        .where(
          (e) =>
              e == HabitDayStatus.completed ||
              e == HabitDayStatus.partiallyCompleted ||
              e == HabitDayStatus.notCompleted ||
              e == HabitDayStatus.awaitsExecution,
        )
        .toList();
    // добавляем пропущенные дни, если не хватает до 7
    final added = cleanedList.length % 7;
    if (added > 0) {
      for (var i = 0; i < 7 - added; i++) {
        cleanedList.add(HabitDayStatus.skipped);
      }
    }
    return _chunkBySeven(cleanedList);
  }

  List<List<T>> _chunkBySeven<T>(List<T> list) {
    final chunks = <List<T>>[];
    for (var i = 0; i < list.length; i += 7) {
      chunks.add(list.sublist(i, i + 7 > list.length ? list.length : i + 7));
    }
    return chunks;
  }
}

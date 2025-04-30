import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:habit_current/core/extension/datetime_ext.dart';
import 'package:habit_current/data/repositories/data/data_repository.dart';
import 'package:habit_current/models/habit.dart';
import 'package:habit_current/models/habit_status.dart';
import 'package:habit_current/models/weekdays.dart';

part 'habit_week_event.dart';
part 'habit_week_state.dart';

class HabitWeekBloc extends Bloc<HabitWeekEvent, HabitWeekState> {
  final DataRepository repository;

  HabitWeekBloc({required this.repository})
    : super(HabitWeekState(date: DateTime.now())) {
    on<LoadHabitWeekEvent>(_onLoadHabitWeekEvent);
    on<ReloadHabitEvent>(_onReloadHabitEvent);
    on<RefreshHabitWeekEvent>(_onRefreshHabitWeekEvent);
  }

  void _onLoadHabitWeekEvent(
    LoadHabitWeekEvent event,
    Emitter<HabitWeekState> emit,
  ) async {
    emit(state.copyWith(status: HabitStatus.loading));
    final currentDate = DateTime.now().toEndOfDay();
    final completedHabits = await _loadHabits(event.userId, currentDate);
    emit(
      state.copyWith(
        userId: event.userId,
        date: currentDate,
        status: HabitStatus.success,
        completedHabits: completedHabits,
      ),
    );
  }

  void _onReloadHabitEvent(
    ReloadHabitEvent event,
    Emitter<HabitWeekState> emit,
  ) async {
    final currentDate = DateTime.now().toEndOfDay();
    final completedHabits = await _loadHabits(state.userId, currentDate);
    emit(
      state.copyWith(
        userId: state.userId,
        date: currentDate,
        status: HabitStatus.success,
        completedHabits: completedHabits,
      ),
    );
  }

  void _onRefreshHabitWeekEvent(
    RefreshHabitWeekEvent event,
    Emitter<HabitWeekState> emit,
  ) async {
    final currentDate = DateTime.now().toEndOfDay();
    final completedHabits = await _loadHabits(state.userId, currentDate);
    emit(
      state.copyWith(
        userId: state.userId,
        date: currentDate,
        status: HabitStatus.success,
        completedHabits: completedHabits,
      ),
    );
  }

  Future<List<HabitWeekStatus>> _loadHabits(
    int userId,
    DateTime currentDate,
  ) async {
    final weekRange = currentDate.toWeekRange();

    final habits = await repository.loadHabitsByUserIdFromDateRange(
      userId: userId,
      start: weekRange.start,
      end: weekRange.end,
    );

    return habits.map((habit) {
      final habitLength = habit.intervals.length;
      final List<WeekStatus> weekStatuses = [];

      DateTime day = weekRange.start.toEndOfDay();
      while (day.isBeforeOrEqual(weekRange.end)) {
        final status = _calculateWeekStatus(
          habit: habit,
          day: day,
          habitLength: habitLength,
          currentDate: currentDate,
        );
        weekStatuses.add(status);
        day = day.add(const Duration(days: 1));
      }

      return HabitWeekStatus(habit: habit, weekStatus: weekStatuses);
    }).toList();
  }

  WeekStatus _calculateWeekStatus({
    required Habit habit,
    required DateTime day,
    required int habitLength,
    required DateTime currentDate,
  }) {
    final weekDayEnum = WeekDays.fromDate(day);

    if (!habit.weekDays.contains(weekDayEnum) || habit.created!.isAfter(day)) {
      return WeekStatus.skipped;
    }

    if (habit.completed != null && day.isAfter(habit.completed!)) {
      return WeekStatus.closed;
    }

    if (day.isAfter(currentDate)) {
      return WeekStatus.notStarted;
    }

    final completedCount =
        habit.completedIntervals
            .where((e) => e.completed.isSameDate(day))
            .length;

    if (completedCount == habitLength) return WeekStatus.completed;
    if (completedCount > 0) return WeekStatus.partiallyCompleted;
    return WeekStatus.notCompleted;
  }
}

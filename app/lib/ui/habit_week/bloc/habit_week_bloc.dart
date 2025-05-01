import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:habit_current/core/extension/datetime_ext.dart';
import 'package:habit_current/data/repositories/data/data_repository.dart';
import 'package:habit_current/models/habit.dart';
import 'package:habit_current/models/habit_status.dart';
import 'package:habit_current/models/habit_week.dart';
import 'package:habit_current/models/week_status.dart';
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
        final List<WeekStatus> weekStatuses = [];

        DateTime day = dayStart;
        while (day.isBeforeOrEqual(dayEnd)) {
          final status = _calculateWeekStatus(
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

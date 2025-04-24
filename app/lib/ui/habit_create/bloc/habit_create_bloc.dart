import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/data/repositories/data/data_repository.dart';
import 'package:habit_current/models/habit.dart';
import 'package:habit_current/models/hour_interval.dart';
import 'package:habit_current/models/weekdays.dart';

part 'habit_create_state.dart';
part 'habit_create_event.dart';

final class HabitCreateBloc extends Bloc<HabitCreateEvent, HabitCreateState> {
  final DataRepository dataRepository;
  final int userId;

  HabitCreateBloc({required this.dataRepository, required this.userId})
    : super(const HabitCreateState()) {
    on<NameChangedEvent>(_onNameChangedEvent);

    on<DailyOrWeekToggledEvent>(_onDailyOrWeekToggledEvent);
    on<WeekDayChangedEvent>(_onWeekDayChangedEvent);

    on<TimeAddedEvent>(_onTimeAddedEvent);
    on<TimeRemovedEvent>(_onTimeRemovedEvent);
    on<TimeChangedEvent>(_onTimeChangedEvent);

    on<ReminderToggledEvent>(_onReminderToggledEvent);

    on<SubmitHabitEvent>(_onHabitCreateSaveEvent);
  }

  void _onNameChangedEvent(
    NameChangedEvent event,
    Emitter<HabitCreateState> emit,
  ) {
    emit(state.copyWith(name: event.name));
  }

  void _onDailyOrWeekToggledEvent(
    DailyOrWeekToggledEvent event,
    Emitter<HabitCreateState> emit,
  ) {
    emit(state.copyWith(frequency: event.frequency));
  }

  void _onWeekDayChangedEvent(
    WeekDayChangedEvent event,
    Emitter<HabitCreateState> emit,
  ) {
    final weekDays = state.weekDays.toList();
    if (weekDays.contains(event.weekDay)) {
      weekDays.remove(event.weekDay);
    } else {
      weekDays.add(event.weekDay);
    }
    emit(state.copyWith(weekDays: weekDays.toSet()));
  }

  void _onTimeAddedEvent(
    TimeAddedEvent event,
    Emitter<HabitCreateState> emit, //
  ) {
    int time = state.intervals.last + 60;
    if (time > 1440) {
      time = 1440;
    }
    emit(state.copyWith(intervals: [...state.intervals, time]));
  }

  void _onTimeRemovedEvent(
    TimeRemovedEvent event,
    Emitter<HabitCreateState> emit,
  ) {
    if (state.intervals.length > 1) {
      emit(
        state.copyWith(
          intervals: state.intervals.sublist(0, state.intervals.length - 1),
        ),
      );
    }
  }

  void _onTimeChangedEvent(
    TimeChangedEvent event,
    Emitter<HabitCreateState> emit,
  ) {
    if (event.index >= 0 && event.index < state.intervals.length) {
      final List<int> intervals = state.intervals.toList();
      intervals[event.index] = event.time;
      emit(state.copyWith(intervals: intervals));
    }
  }

  void _onReminderToggledEvent(
    ReminderToggledEvent event,
    Emitter<HabitCreateState> emit,
  ) {
    emit(state.copyWith(reminder: event.value));
  }

  void _onHabitCreateSaveEvent(
    SubmitHabitEvent event,
    Emitter<HabitCreateState> emit,
  ) async {
    // Save the habit to the database
    await dataRepository.createHabit(
      Habit(
        userId: userId,
        name: state.name,
        details: state.details,
        weekDays: state.weekDays,
        intervals: state.intervals.map((e) => HourInterval(time: e)).toList(),
      ),
    );

    // Закончить создание привычки
    emit(state.copyWith(status: StatsStatus.success));
  }
}

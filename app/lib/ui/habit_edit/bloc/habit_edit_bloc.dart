import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/data/repositories/data/data_repository.dart';
import 'package:habit_current/models/habit.dart';
import 'package:habit_current/models/hour_interval.dart';
import 'package:habit_current/models/weekdays.dart';

part 'habit_edit_event.dart';
part 'habit_edit_state.dart';

class HabitEditBloc extends Bloc<HabitEditEvent, HabitEditState> {
  final DataRepository dataRepository;

  HabitEditBloc({required this.dataRepository}) : super(HabitEditState()) {
    on<StartCreateHabitEvent>(_onStartCreateHabitEvent);

    on<StartEditHabitEvent>(_onStartEditHabitEvent);
    on<SaveHabitEvent>(_onSaveHabitEvent);

    // Редактирование параметров привычки
    on<UpdateHabitNameEvent>(_onUpdateHabitName);

    on<ToggleDailyOrWeekEvent>(_onToggleDailyOrWeekEvent);
    on<ChangeWeekDayEvent>(_onChangeWeekDayEvent);

    on<AddTimeIntervalEvent>(_onAddTimeIntervalEvent);
    on<RemoveTimeIntervalEvent>(_onRemoveTimeIntervalEvent);
    on<ChangeTimeIntervalEvent>(_onChangeTimeIntervalEvent);

    on<ToggleReminderEvent>(_onToggleReminderEvent);
  }

  // Создание привычки
  void _onStartCreateHabitEvent(
    StartCreateHabitEvent event,
    Emitter<HabitEditState> emit,
  ) {
    emit(state.copyWith(status: StatsStatus.initial, userId: event.userId));
  }

  Future<int> _createHabitEvent() async {
    // Save the habit to the database
    final habit = await dataRepository.createHabit(
      Habit(
        userId: state.userId,
        name: state.name,
        details: state.details,
        // если Frequency.weekly, то передаем список, иначе пустой список
        weekDays: state.frequency == Frequency.weekly ? state.weekDays : {},
        intervals: state.intervals,
      ),
    );
    return habit.id;
  }

  // Редактирование привычки
  void _onStartEditHabitEvent(
    StartEditHabitEvent event,
    Emitter<HabitEditState> emit,
  ) async {
    final habit = await dataRepository.loadHabitById(
      event.habitId,
      DateTime.now(),
    );
    if (habit == null) return;
    emit(HabitEditState.fromHabit(habit));
  }

  Future<void> _saveHabitEvent() async {
    final habit = state.habit!.copyWith(
      name: state.name,
      details: state.details,
      weekDays: state.frequency == Frequency.weekly ? state.weekDays : {},
      intervals: state.intervals,
    );
    await dataRepository.saveHabit(habit);
  }

  void _onSaveHabitEvent(
    SaveHabitEvent event,
    Emitter<HabitEditState> emit,
  ) async {
    emit(state.copyWith(status: StatsStatus.initial));
    int habitId;
    if (state.habit != null) {
      await _saveHabitEvent();
      habitId = state.habit!.id;
    } else {
      habitId = await _createHabitEvent();
    }
    emit(state.copyWith(status: StatsStatus.success, habitId: habitId));
  }

  // Редактирование параметров привычки
  void _onUpdateHabitName(
    UpdateHabitNameEvent event,
    Emitter<HabitEditState> emit,
  ) {
    emit(state.copyWith(name: event.name));
  }

  void _onToggleDailyOrWeekEvent(
    ToggleDailyOrWeekEvent event,
    Emitter<HabitEditState> emit,
  ) {
    emit(state.copyWith(frequency: event.frequency));
  }

  void _onChangeWeekDayEvent(
    ChangeWeekDayEvent event,
    Emitter<HabitEditState> emit,
  ) {
    final weekDays = List<WeekDays>.from(state.weekDays);
    if (weekDays.contains(event.weekDay)) {
      weekDays.remove(event.weekDay);
    } else {
      weekDays.add(event.weekDay);
    }
    emit(state.copyWith(weekDays: weekDays.toSet()));
  }

  void _onAddTimeIntervalEvent(
    AddTimeIntervalEvent event,
    Emitter<HabitEditState> emit, //
  ) {
    // Максимальное количество интервалов - 12
    if (state.intervals.length >= 12) return;

    int time = state.intervals.last.time + 60;
    if (time > 1440) {
      time = 1440;
    }
    emit(
      state.copyWith(intervals: [...state.intervals, HourInterval(time: time)]),
    );
  }

  void _onRemoveTimeIntervalEvent(
    RemoveTimeIntervalEvent event,
    Emitter<HabitEditState> emit,
  ) {
    // Минимальное количество интервалов - 1
    if (state.intervals.length > 1) {
      emit(
        state.copyWith(
          intervals: state.intervals.sublist(0, state.intervals.length - 1),
        ),
      );
    }
  }

  void _onChangeTimeIntervalEvent(
    ChangeTimeIntervalEvent event,
    Emitter<HabitEditState> emit,
  ) {
    if (event.index >= 0 && event.index < state.intervals.length) {
      final intervals = List<HourInterval>.from(state.intervals);
      final interval = intervals[event.index];
      intervals[event.index] = interval.copyWith(time: event.time);
      emit(state.copyWith(intervals: intervals));
    }
  }

  void _onToggleReminderEvent(
    ToggleReminderEvent event,
    Emitter<HabitEditState> emit,
  ) {
    emit(state.copyWith(reminder: event.value));
  }
}

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

  HabitCreateBloc({required this.dataRepository, required this.userId}): super(const HabitCreateState()) {
    // on<HabitCreateEvent>(_onHabitCreateEvent);
    // on<HabitCreateNameChangedEvent>(_onHabitCreateNameChangedEvent);
    // on<HabitCreateColorChangedEvent>(_onHabitCreateColorChangedEvent);
    // on<HabitCreateIconChangedEvent>(_onHabitCreateIconChangedEvent);

    on<HabitCreateSaveEvent>(_onHabitCreateSaveEvent);
  }

  void _onHabitCreateSaveEvent(
    HabitCreateSaveEvent event,
    Emitter<HabitCreateState> emit,
  ) async {
    // Save the habit to the database
    await dataRepository.createHabit(
      Habit(
      userId: userId,
      name: state.name,
      details: state.details,
      weekDays: state.weekDays,
      intervals: state.intervals,
      )
    );

    // Закончить создание привычки
    emit(state.copyWith(status: StatsStatus.success));
  }
}
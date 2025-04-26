import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:habit_current/data/repositories/data/data_repository.dart';
import 'package:habit_current/models/habit.dart';
import 'package:habit_current/models/hour_interval_completed.dart';

part 'habit_view_event.dart';
part 'habit_view_state.dart';

class HabitViewBloc extends Bloc<HabitViewEvent, HabitViewState> {
  final DataRepository dataRepository;

  HabitViewBloc({required this.dataRepository, required Habit habit})
    : super(HabitViewState(habit: habit)) {
    on<HabitViewChangedEvent>(_onHabitViewChangedEvent);
  }

  void _onHabitViewChangedEvent(
    HabitViewChangedEvent event,
    Emitter<HabitViewState> emit,
  ) async {
    print('--------------------------------');
    print('event.index: ${event.index}');
    print('--------------------------------');
    if (event.index >= 0 && event.index < state.habit.intervals.length) {
      final interval = state.habit.intervals[event.index];
      print('interval: ${interval.id}');
      final completedIntervals = state.habit.completedIntervals.toList();
      HourIntervalCompleted? completed = completedIntervals
          .where((e) => e.intervalId == interval.id)
          .firstOrNull;
      if (completed == null) {
        completed = HourIntervalCompleted(
          intervalId: interval.id,
          time: interval.time,
          completed: DateTime.now(),
        );
        completed = await dataRepository.createHourIntervalCompleted(
          state.habit.id,
          completed,
        );
        completedIntervals.add(completed);
        print('completed: ${completed.id} ${completed.intervalId}');
      } else {
        dataRepository.deleteHourIntervalCompletedById(completed.id);
        completedIntervals.remove(completed);
        print('remove: ${completed.id} ${completed.intervalId}');
      }
      emit(
        state.copyWith(
          habit: state.habit.copyWith(completedIntervals: completedIntervals),
        ),
      );
    }
  }
}

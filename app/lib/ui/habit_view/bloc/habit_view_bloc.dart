import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:habit_current/core/error/app_error.dart';
import 'package:habit_current/data/repositories/data/data_repository.dart';
import 'package:habit_current/data/repositories/notification/notification_repository.dart';
import 'package:habit_current/models/habit.dart';
import 'package:habit_current/models/hour_interval.dart';
import 'package:habit_current/models/hour_interval_completed.dart';
import 'package:habit_current/models/state_status.dart';

part 'habit_view_event.dart';
part 'habit_view_state.dart';

class HabitViewBloc extends Bloc<HabitViewEvent, HabitViewState> {
  final DataRepository _dataRepository;
  final NotificationRepository _notificationRepository;

  HabitViewBloc({
    required DataRepository dataRepository,
    required NotificationRepository notificationRepository,
    required Habit habit,
  }) : _dataRepository = dataRepository,
       _notificationRepository = notificationRepository,
       super(HabitViewState(habit: habit)) {
    on<HabitViewChangedEvent>(_onHabitViewChangedEvent);
  }

  Future<void> _onHabitViewChangedEvent(
    HabitViewChangedEvent event,
    Emitter<HabitViewState> emit,
  ) async {
    log('--------------------------------', name: 'HabitViewBloc');
    log('event.index: ${event.index}', name: 'HabitViewBloc');
    log('--------------------------------', name: 'HabitViewBloc');
    if (event.index < 0 || event.index >= state.habit.intervals.length) return;
    try {
      final interval = state.habit.intervals[event.index];
      log('interval: ${interval.id}', name: 'HabitViewBloc');
      // изменим статус выполнения интервала и получим список выполненных интервалов
      final (completedIntervals, todayCompleted) = await _changeAndGetCompleted(
        interval,
      );
      // изменим уведомление на завтра или сегодня
      await _changeNotification(
        intervalId: interval.id,
        tomorrow: todayCompleted,
      );
      // обновим список выполненных интервалов
      emit(
        state.copyWith(
          status: StateStatus.initial,
          habit: state.habit.copyWith(completedIntervals: completedIntervals),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: StateStatus.error,
          error: e is AppError ? e : UnknownError(e.toString()),
        ),
      );
    }
  }

  Future<(List<HourIntervalCompleted>, bool)> _changeAndGetCompleted(
    HourInterval interval,
  ) async {
    var todayCompleted = true;
    final completedIntervals = state.habit.completedIntervals.toList();
    var completed = completedIntervals.where((e) => e.intervalId == interval.id).firstOrNull;
    if (completed == null) {
      completed = HourIntervalCompleted(
        intervalId: interval.id,
        time: interval.time,
        completed: DateTime.now(),
      );
      try {
        completed = await _dataRepository.createHourIntervalCompleted(
          state.habit.id,
          completed,
        );
        completedIntervals.add(completed);
      } catch (e) {
        throw DatabaseCreatingError(e.toString());
      }
      log('completed: ${completed.id} ${completed.intervalId}', name: 'HabitViewBloc');
    } else {
      try {
        await _dataRepository.deleteHourIntervalCompletedById(completed.id);
      } catch (e) {
        throw DatabaseDeletingError(e.toString());
      }
      completedIntervals.remove(completed);
      todayCompleted = false;
      log('remove: ${completed.id} ${completed.intervalId}', name: 'HabitViewBloc');
    }
    return (completedIntervals, todayCompleted);
  }

  Future<void> _changeNotification({
    required int intervalId,
    required bool tomorrow,
  }) async {
    try {
      await _notificationRepository.scheduleNotificationByIntervalId(
        intervalId,
        tomorrow,
      );
    } catch (e) {
      throw NotificationError(e.toString());
    }
  }
}

import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/core/error/app_error.dart';
import 'package:habit_current/data/repositories/data/data_repository.dart';
import 'package:habit_current/data/repositories/notification/notification_repository.dart';
import 'package:habit_current/models/habit.dart';
import 'package:habit_current/models/hour_interval_completed.dart';
import 'package:habit_current/models/notification_response_details.dart';
import 'package:habit_current/models/reminder.dart';
import 'package:habit_current/models/user.dart';

part 'app_event.dart';
part 'app_state.dart';

final class AppBloc extends Bloc<AppEvent, AppState> {
  final DataRepository _dataRepository;
  final NotificationRepository _notificationRepository;

  AppBloc({
    required DataRepository dataRepository,
    required NotificationRepository notificationRepository,
  }) : _notificationRepository = notificationRepository,
       _dataRepository = dataRepository,
       super(const AppState()) {
    on<AppInitialEvent>(_onInitialEvent);
    on<AppUserLoadedEvent>(_onUserLoadedEvent);

    on<AppHabitCreateEvent>(_onHabitCreateEvent);
    on<AppHabitViewEvent>(_onHabitViewEvent);
    on<AppHabitEditEvent>(_onHabitEditEvent);
    on<AppHabitReloadEvent>(_onHabitsReloadEvent);
    on<AppHabitDeleteEvent>(_onHabitDeleteEvent);
    on<AppHabitMakeDoneEvent>(_onHabitMakeDoneEvent);

    on<AppReminderCheckEvent>(_onReminderCheckEvent);
    on<AppReminderChangeEvent>(_onReminderChangeEvent);
    on<AppReminderRequestEvent>(_onReminderRequestEvent);
    on<AppReminderOpenEvent>(_onReminderOpenEvent);

    on<AppShowTestNotificationEvent>(_onShowTestNotification);

    on<AppErrorEvent>(_onErrorEvent);
    // обрабатываем получение уведомлений
    unawaited(_notificationRepository.observeNotificationReceived(_onNotificationReceived));
  }

  void _onInitialEvent(AppInitialEvent event, Emitter<AppState> emit) async {
    emit(const AppState());
  }

  // MARK: - User Loaded
  void _onUserLoadedEvent(
    AppUserLoadedEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(state.copyWith(status: .userLoaded, user: event.user));
    // Проверяем, было ли приложение запущено через уведомление
    await _onNotificationReceivedAppLaunch();
  }

  // MARK: - Habit Events
  void _onHabitCreateEvent(
    AppHabitCreateEvent event,
    Emitter<AppState> emit,
  ) async {
    log('--------------------------------', name: 'AppBloc');
    log('onHabitCreateEvent', name: 'AppBloc');
    log('--------------------------------', name: 'AppBloc');
    if (state.user != null) {
      emit(
        state.copyWith(
          status: .habitCreate,
          update: state.update + 1,
        ),
      );
    } else {
      add(AppErrorEvent(UserInitialError('User is not loaded')));
    }
  }

  void _onHabitViewEvent(
    AppHabitViewEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(state.copyWith(status: .habitView, habit: event.habit));
  }

  void _onHabitEditEvent(
    AppHabitEditEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(
      state.copyWith(
        status: .habitEdit,
        habitId: event.habitId,
        update: state.update + 1,
      ),
    );
  }

  void _onHabitsReloadEvent(
    AppHabitReloadEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(
      state.copyWith(
        status: .habitReload,
        habitId: event.habitId,
      ),
    );
  }

  void _onHabitDeleteEvent(
    AppHabitDeleteEvent event,
    Emitter<AppState> emit,
  ) async {
    if (event.habitId == null) return;

    try {
      await _dataRepository.deleteHabitById(event.habitId!);
      emit(
        state.copyWith(
          status: .habitReload,
          habitId: event.habitId,
          update: state.update + 1,
        ),
      );
    } catch (e) {
      _showError(e, emit);
    }
  }

  void _onHabitMakeDoneEvent(
    AppHabitMakeDoneEvent event,
    Emitter<AppState> emit,
  ) async {
    log('_onHabitMakeDoneEvent: ${event.habitId} ${event.intervalId}', name: 'AppBloc');
    try {
      final habit = await _dataRepository.loadHabitById(
        event.habitId,
        DateTime.now(),
      );
      if (habit == null) return;
      final interval = habit.intervals
          .where((interval) => interval.id == event.intervalId)
          .firstOrNull;
      if (interval == null) return;
      // Проверить не отмечен ли интервал ранее
      if (habit.completedIntervals.any(
        (e) => e.intervalId == event.intervalId,
      )) {
        return;
      }
      // make done
      final completed = HourIntervalCompleted(
        intervalId: interval.id,
        time: interval.time,
        completed: DateTime.now(),
      );
      await _dataRepository.createHourIntervalCompleted(
        event.habitId,
        completed,
      );
      // update
      emit(
        state.copyWith(
          status: .habitReload,
          habitId: event.habitId,
          update: state.update + 1,
        ),
      );
    } catch (e) {
      _showError(e, emit);
    }
  }

  // MARK: - Reminder Events
  void _onReminderCheckEvent(
    AppReminderCheckEvent event,
    Emitter<AppState> emit,
  ) async {
    try {
      final permission = await _notificationRepository.getNotificationPermissionStatus();
      emit(
        state.copyWith(
          status: .initial,
          reminder: permission == null
              ? .request
              : permission
              ? .enabled
              : .open,
        ),
      );
    } catch (e) {
      _showError(e, emit);
    }
  }

  void _onReminderChangeEvent(
    AppReminderChangeEvent event,
    Emitter<AppState> emit,
  ) async {
    if (state.user == null) return;
    try {
      final Reminder reminder;
      switch (event.reminder) {
        case .open:
          _onReminderOpenSettings();
          return;
        case .request:
          final permission = await _notificationRepository.requestNotificationPermission();
          reminder = permission ? .enabled : .open;
        case .enabled:
          // отменить все уведомления
          await _notificationRepository.cancelAllNotifications();
          reminder = .disabled;
        case .disabled:
          // перезапустить все уведомления
          await _notificationRepository.cancelAllNotifications();
          await _notificationRepository.scheduleNotificationByUserId(
            state.user!.id,
          );
          reminder = .enabled;
      }
      emit(state.copyWith(status: .initial, reminder: reminder));
    } catch (e) {
      _showError(e, emit);
    }
  }

  void _onReminderRequestEvent(
    AppReminderRequestEvent event,
    Emitter<AppState> emit,
  ) async {
    await _notificationRepository.requestNotificationPermission();
    add(AppReminderCheckEvent());
  }

  void _onReminderOpenEvent(
    AppReminderOpenEvent event,
    Emitter<AppState> emit,
  ) {
    _onReminderOpenSettings();
  }

  void _onReminderOpenSettings() {
    _notificationRepository.openNotificationSettings();
  }

  // MARK: - Notification Received
  Future<void> _onNotificationReceivedAppLaunch() async {
    final notification = await _notificationRepository.getNotificationAppLaunchDetails();
    if (notification != null) {
      await _onNotificationReceived(notification);
    }
  }

  Future<void> _onNotificationReceived(
    NotificationResponseDetails notification,
  ) async {
    if (notification.identifier.isEmpty) return;
    if (notification.laterMinutes != null) {
      // schedule notification with later minutes
      await _notificationRepository.showNotificationLater(
        id: notification.id,
        identifier: notification.identifier,
        laterMinutes: notification.laterMinutes!,
      );
    } else {
      if (notification.id == Constants.testNotificationId) return;
      await _reactToNotification(notification.identifier, notification.isOpen);
    }
  }

  Future<void> _reactToNotification(String identifier, bool isOpen) async {
    try {
      final (
        userId,
        habitId,
        intervalId,
        weekDay,
        reschedule,
      ) = _notificationRepository.parseIdentifier(
        identifier,
      );
      if (userId != state.user?.id) return;
      if (reschedule) {
        // перепланируем уведомление
        await _notificationRepository.scheduleNotificationByIntervalId(
          intervalId,
          false,
        );
      }
      if (isOpen) {
        final habit = await _dataRepository.loadHabitById(
          habitId,
          DateTime.now(),
        );
        if (habit != null) {
          add(AppHabitViewEvent(habit: habit));
        }
      } else {
        log('AppHabitMakeDoneEvent', name: 'AppBloc');
        // Отметим как выполненное
        add(
          AppHabitMakeDoneEvent(
            habitId: habitId,
            intervalId: intervalId,
            weekDay: weekDay,
          ),
        );
        // add(AppHabitReloadEvent(habitId: habitId));
      }
      log('--------------------------------', name: 'AppBloc');
    } catch (e) {
      add(AppErrorEvent(e));
    }
  }

  // MARK: - Error
  void _showError(Object error, Emitter<AppState> emit) {
    emit(
      state.copyWith(
        status: .error,
        error: error is AppError ? error : UnknownError(error.toString()),
        update: state.update + 1,
      ),
    );
  }

  void _onErrorEvent(AppErrorEvent event, Emitter<AppState> emit) {
    _showError(event.error, emit);
  }

  // MARK: - Show Test Notification
  void _onShowTestNotification(
    AppShowTestNotificationEvent event,
    Emitter<AppState> emit,
  ) async {
    await _notificationRepository.showNotification(
      id: Constants.testNotificationId,
      title: event.title,
      body: event.body,
      payload: event.payload,
    );
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final DataRepository dataRepository;
  final NotificationRepository notificationRepository;

  AppBloc({required this.dataRepository, required this.notificationRepository})
    : super(AppState.initial()) {
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
    notificationRepository.observeNotificationReceived(_onNotificationReceived);
  }

  void _onInitialEvent(AppInitialEvent event, Emitter<AppState> emit) async {
    emit(AppState.initial());
  }

  // MARK: - User Loaded
  void _onUserLoadedEvent(
    AppUserLoadedEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(state.copyWith(status: AppStatus.userLoaded, user: event.user));
    // Проверяем, было ли приложение запущено через уведомление
    _onNotificationReceivedAppLaunch();
  }

  // MARK: - Habit Events
  void _onHabitCreateEvent(
    AppHabitCreateEvent event,
    Emitter<AppState> emit,
  ) async {
    print('--------------------------------');
    print('onHabitCreateEvent');
    print('--------------------------------');
    if (state.user != null) {
      emit(
        state.copyWith(
          status: AppStatus.habitCreate,
          update: state.update + 1, //
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
    emit(state.copyWith(status: AppStatus.habitView, habit: event.habit));
  }

  void _onHabitEditEvent(
    AppHabitEditEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(
      state.copyWith(
        status: AppStatus.habitEdit,
        habitId: event.habitId,
        update: state.update + 1,
      ),
    );
  }

  void _onHabitsReloadEvent(
    AppHabitReloadEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(state.copyWith(status: AppStatus.habitReload, habitId: event.habitId));
  }

  void _onHabitDeleteEvent(
    AppHabitDeleteEvent event,
    Emitter<AppState> emit,
  ) async {
    if (event.habitId == null) return;

    try {
      await dataRepository.deleteHabitById(event.habitId!);
      emit(
        state.copyWith(
          status: AppStatus.habitReload,
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
    print('_onHabitMakeDoneEvent: ${event.habitId} ${event.intervalId}');
    try {
      final habit = await dataRepository.loadHabitById(
        event.habitId,
        DateTime.now(),
      );
      if (habit == null) return;
      final interval =
          habit.intervals
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
      await dataRepository.createHourIntervalCompleted(
        event.habitId,
        completed,
      );
      // update
      emit(
        state.copyWith(
          status: AppStatus.habitReload,
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
      final permission =
          await notificationRepository.getNotificationPermissionStatus();
      emit(
        state.copyWith(
          status: AppStatus.initial,
          reminder:
              permission == null
                  ? Reminder.request
                  : permission
                  ? Reminder.enabled
                  : Reminder.open,
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
        case Reminder.open:
          _onReminderOpenSettings();
          return;
        case Reminder.request:
          final permission =
              await notificationRepository.requestNotificationPermission();
          reminder = permission ? Reminder.enabled : Reminder.open;
        case Reminder.enabled:
          // отменить все уведомления
          await notificationRepository.cancelAllNotifications();
          reminder = Reminder.disabled;
        case Reminder.disabled:
          // перезапустить все уведомления
          await notificationRepository.cancelAllNotifications();
          await notificationRepository.scheduleNotificationByUserId(
            state.user!.id,
          );
          reminder = Reminder.enabled;
      }
      emit(state.copyWith(status: AppStatus.initial, reminder: reminder));
    } catch (e) {
      _showError(e, emit);
    }
  }

  void _onReminderRequestEvent(
    AppReminderRequestEvent event,
    Emitter<AppState> emit,
  ) async {
    await notificationRepository.requestNotificationPermission();
    add(AppReminderCheckEvent());
  }

  void _onReminderOpenEvent(
    AppReminderOpenEvent event,
    Emitter<AppState> emit,
  ) {
    _onReminderOpenSettings();
  }

  void _onReminderOpenSettings() {
    notificationRepository.openNotificationSettings();
  }

  // MARK: - Notification Received
  Future<void> _onNotificationReceivedAppLaunch() async {
    final notification =
        await notificationRepository.getNotificationAppLaunchDetails();
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
      await notificationRepository.showNotificationLater(
        id: notification.id,
        identifier: notification.identifier,
        laterMinutes: notification.laterMinutes!,
      );
    } else {
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
      ) = notificationRepository.parseIdentifier(identifier);
      if (userId != state.user?.id) return;
      if (reschedule) {
        // перепланируем уведомление
        await notificationRepository.scheduleNotificationByIntervalId(
          intervalId,
          false,
        );
      }
      if (isOpen) {
        final habit = await dataRepository.loadHabitById(
          habitId,
          DateTime.now(),
        );
        if (habit != null) {
          add(AppHabitViewEvent(habit: habit));
        }
      } else {
        print('AppHabitMakeDoneEvent');
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
      print('--------------------------------');
    } catch (e) {
      add(AppErrorEvent(e));
    }
  }

  // MARK: - Error
  void _showError(Object error, Emitter<AppState> emit) {
    emit(
      state.copyWith(
        status: AppStatus.error,
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
    await notificationRepository.showNotification(
      id: 1000001,
      title: 'Test Notification',
      body: 'This is a test notification',
      payload: 'test',
    );
  }
}

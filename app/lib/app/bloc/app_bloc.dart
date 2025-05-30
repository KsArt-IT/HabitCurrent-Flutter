import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    on<AppReminderOpenEvent>(_onReminderOpenEvent);

    on<AppShowTestNotificationEvent>(_onShowTestNotification);
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
        state.copyWith(status: AppStatus.habitCreate, update: state.update + 1),
      );
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

    await dataRepository.deleteHabitById(event.habitId!);
    emit(
      state.copyWith(
        status: AppStatus.habitReload,
        habitId: event.habitId,
        update: state.update + 1,
      ),
    );
  }

  void _onHabitMakeDoneEvent(
    AppHabitMakeDoneEvent event,
    Emitter<AppState> emit,
  ) async {
    print('_onHabitMakeDoneEvent: ${event.habitId} ${event.intervalId}');
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
    // make done
    final completed = HourIntervalCompleted(
      intervalId: interval.id,
      time: interval.time,
      completed: DateTime.now(),
    );
    await dataRepository.createHourIntervalCompleted(event.habitId, completed);
    // update
    emit(
      state.copyWith(
        status: AppStatus.habitReload,
        habitId: event.habitId,
        update: state.update + 1,
      ),
    );
  }

  // MARK: - Reminder Events
  void _onReminderCheckEvent(
    AppReminderCheckEvent event,
    Emitter<AppState> emit,
  ) async {
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
  }

  void _onReminderChangeEvent(
    AppReminderChangeEvent event,
    Emitter<AppState> emit,
  ) async {
    if (state.user == null) return;
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
    final params = identifier.split('_');
    if (params.length < 8) return;

    final userId = int.parse(params[1]);
    final habitId = int.parse(params[3]);
    final intervalId = int.parse(params[5]);
    final weekDay = int.parse(params[7]);

    print('--------------------------------');
    print('identifier: $identifier');
    print('isOpen: $isOpen');
    print('userId: $userId login: ${state.user?.id}');
    print('habitId: $habitId');
    print('intervalId: $intervalId');
    print('weekDay: $weekDay');
    print('--------------------------------');
    if (userId != state.user?.id) return;
    if (isOpen) {
      final habit = await dataRepository.loadHabitById(habitId, DateTime.now());
      if (habit != null) {
        add(AppHabitViewEvent(habit: habit));
      }
    } else {
      print('AppHabitMakeDoneEvent');
      add(
        AppHabitMakeDoneEvent(
          habitId: habitId,
          intervalId: intervalId,
          weekDay: weekDay,
        ),
      );
      add(AppHabitReloadEvent(habitId: habitId));
    }
    print('--------------------------------');
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

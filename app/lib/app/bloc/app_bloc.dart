import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/data/repositories/data/data_repository.dart';
import 'package:habit_current/data/repositories/notification/notification_repository.dart';
import 'package:habit_current/models/habit.dart';
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

    on<AppReminderCheckEvent>(_onReminderCheckEvent);
    on<AppReminderRequestEvent>(_onReminderRequestEvent);
    on<AppReminderOpenEvent>(_onReminderOpenEvent);
    on<AppReminderEnabledEvent>(_onReminderEnabledEvent);
    on<AppReminderDisabledEvent>(_onReminderDisabledEvent);

    // on<AppUpdateLanguageEvent>(_onLanguageChanged);
    // on<AppUpdateThemeEvent>(_onDarkThemeChanged);
    // on<AppSaveEvent>(_onSave);
    // on<AppResetEvent>(_onReset);
  }

  void _onInitialEvent(AppInitialEvent event, Emitter<AppState> emit) async {
    emit(AppState.initial());
  }

  void _onUserLoadedEvent(
    AppUserLoadedEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(state.copyWith(status: AppStatus.userLoaded, user: event.user));
  }

  void _onHabitCreateEvent(
    AppHabitCreateEvent event,
    Emitter<AppState> emit,
  ) async {
    if (state.user != null) {
      emit(state.copyWith(status: AppStatus.habitCreate));
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
    emit(state.copyWith(status: AppStatus.habitEdit, habitId: event.habitId));
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
    emit(state.copyWith(status: AppStatus.habitReload, habitId: event.habitId));
  }

  void _onReminderCheckEvent(
    AppReminderCheckEvent event,
    Emitter<AppState> emit,
  ) async {
    final reminder =
        await notificationRepository.getNotificationPermissionStatus();
    emit(state.copyWith(reminder: reminder));
  }

  void _onReminderRequestEvent(
    AppReminderRequestEvent event,
    Emitter<AppState> emit,
  ) async {
    final permission =
        await notificationRepository.requestNotificationPermission();
    emit(
      state.copyWith(reminder: permission ? Reminder.enabled : Reminder.open),
    );
  }

  void _onReminderOpenEvent(
    AppReminderOpenEvent event,
    Emitter<AppState> emit,
  ) async {
    notificationRepository.openNotificationSettings();
  }

  void _onReminderEnabledEvent(
    AppReminderEnabledEvent event,
    Emitter<AppState> emit,
  ) async {}

  void _onReminderDisabledEvent(
    AppReminderDisabledEvent event,
    Emitter<AppState> emit,
  ) async {}
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/core/error/app_error.dart';
import 'package:habit_current/data/repositories/data/data_repository.dart';
import 'package:habit_current/data/repositories/notification/notification_repository.dart';
import 'package:habit_current/models/habit.dart';
import 'package:habit_current/models/habit_notification.dart';
import 'package:habit_current/models/hour_interval.dart';
import 'package:habit_current/models/reminder.dart';
import 'package:habit_current/models/state_status.dart';
import 'package:habit_current/models/weekdays.dart';

part 'habit_edit_event.dart';
part 'habit_edit_state.dart';

class HabitEditBloc extends Bloc<HabitEditEvent, HabitEditState> {
  final DataRepository dataRepository;
  final NotificationRepository notificationRepository;

  HabitEditBloc({
    required this.dataRepository,
    required this.notificationRepository,
  }) : super(const HabitEditState()) {
    // проверим разрешения
    on<CheckPermissionEvent>(_onCheckPermissionEvent);

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
    on<RequestPermissionEvent>(_onRequestPermissionEvent);
  }

  // Создание привычки
  void _onStartCreateHabitEvent(
    StartCreateHabitEvent event,
    Emitter<HabitEditState> emit,
  ) {
    emit(state.copyWith(status: StateStatus.initial, userId: event.userId));
  }

  Future<Habit> _createHabit() async {
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
    return habit;
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

  Future<Habit> _saveHabit() async {
    final habit = state.habit!.copyWith(
      name: state.name,
      details: state.details,
      weekDays: state.frequency == Frequency.weekly ? state.weekDays : {},
      intervals: state.intervals,
    );
    return await dataRepository.saveHabit(habit);
  }

  // Сохранение привычки
  void _onSaveHabitEvent(
    SaveHabitEvent event,
    Emitter<HabitEditState> emit,
  ) async {
    print("--------------------------------");
    emit(state.copyWith(status: StateStatus.initial));
    try {
      Habit habit;
      if (state.habit != null) {
        // отменим уведомления для habitId
        await notificationRepository.cancelNotificationByHabitId(
          state.habit!.id,
        );
        // сохраним привычку
        habit = await _saveHabit();
      } else {
        habit = await _createHabit();
      }
      if (state.reminder == Reminder.enabled) {
        await _saveNotifications(habit);
        print("HabitEditBloc: scheduleNotificationByHabitId");
        // создадим новые уведомления для habitId
        await notificationRepository.scheduleNotificationByHabitId(habit.id);
      }
      // завершим
      emit(state.copyWith(status: StateStatus.success, habitId: habit.id));
    } catch (e) {
      emit(
        state.copyWith(
          status: StateStatus.error,
          error: DatabaseSavingError(e.toString()),
        ),
      );
    }
    print("--------------------------------");
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

    // К последнему интервалу добавляем 60 минут
    int time = state.intervals.last.time + 60;
    // Максимальное значение интервала - 1440 минут (24 часа)
    if (time > 1440) {
      time = 1440;
    } else if (time < 0) {
      time = 0;
    }
    emit(
      state.copyWith(
        intervals: [
          ...state.intervals,
          HourInterval(time: time),
        ],
      ),
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

  Future<void> _saveNotifications(Habit habit) async {
    final notifications = _generateNotification(
      habit.weekDays,
      habit.intervals,
    );
    await dataRepository.saveNotifications(
      userId: habit.userId,
      habitId: habit.id,
      title: habit.name,
      notifications: notifications,
    );
  }

  Reminder _getReminderState(bool permission, {bool open = false}) {
    Reminder reminder = Reminder.disabled;
    if (!permission) {
      reminder = open ? Reminder.open : Reminder.request;
    } else if (state.habit != null) {
      reminder = state.habit!.notifications.isNotEmpty ? Reminder.enabled : Reminder.disabled;
    }
    return reminder;
  }

  void _onCheckPermissionEvent(
    CheckPermissionEvent event,
    Emitter<HabitEditState> emit,
  ) async {
    final permission = await notificationRepository.checkNotificationPermission();
    final reminder = _getReminderState(
      permission,
      open: state.reminder == Reminder.open,
    );
    emit(state.copyWith(reminder: reminder));
  }

  void _onRequestPermissionEvent(
    RequestPermissionEvent event,
    Emitter<HabitEditState> emit,
  ) async {
    if (state.reminder == Reminder.request) {
      final permission = await notificationRepository.requestNotificationPermission();
      final reminder = _getReminderState(permission, open: true);
      emit(state.copyWith(reminder: reminder));
    } else {
      // открыть настройки приложения
      notificationRepository.openNotificationSettings();
    }
  }

  List<HabitNotification> _generateNotification(
    Set<WeekDays> weekDays,
    List<HourInterval> intervals,
  ) {
    print("HabitEditBloc: intervals: ${intervals.length}");
    if (intervals.isEmpty) return [];
    final allDays = weekDays.isEmpty || weekDays.length == 7;
    List<HabitNotification> notifications = [];
    for (final interval in intervals) {
      if (allDays) {
        notifications.add(
          HabitNotification(
            intervalId: interval.id,
            weekDay: WeekDays.allDays,
            time: interval.time,
            repeats: true,
          ),
        );
      } else {
        for (final day in weekDays) {
          notifications.add(
            HabitNotification(
              intervalId: interval.id,
              weekDay: day.weekDay,
              time: interval.time,
              repeats: true,
            ),
          );
        }
      }
    }
    return notifications;
  }
}

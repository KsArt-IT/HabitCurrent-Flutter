part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();
  @override
  List<Object?> get props => [];
}

final class AppInitialEvent extends AppEvent {}

final class AppUserLoadedEvent extends AppEvent {
  final User user;
  const AppUserLoadedEvent({required this.user});
  @override
  List<Object?> get props => [user];
}

final class AppHabitMakeDoneEvent extends AppEvent {
  final int habitId;
  final int intervalId;
  final int weekDay;
  const AppHabitMakeDoneEvent({required this.habitId, required this.intervalId, required this.weekDay});
  
  @override
  List<Object?> get props => [habitId, intervalId, weekDay];
}

final class AppHabitCreateEvent extends AppEvent {}

final class AppHabitViewEvent extends AppEvent {
  final Habit habit;
  const AppHabitViewEvent({required this.habit});
  @override
  List<Object?> get props => [habit];
}

final class AppHabitEditEvent extends AppEvent {
  final int habitId;
  const AppHabitEditEvent({required this.habitId});
  @override
  List<Object?> get props => [habitId];
}

final class AppHabitReloadEvent extends AppEvent {
  final int? habitId;
  const AppHabitReloadEvent({this.habitId});
  @override
  List<Object?> get props => [habitId];
}

final class AppHabitDeleteEvent extends AppEvent {
  final int? habitId;
  const AppHabitDeleteEvent({this.habitId});
  @override
  List<Object?> get props => [habitId];
}

final class AppReminderCheckEvent extends AppEvent {}

final class AppReminderRequestEvent extends AppEvent {}

final class AppReminderOpenEvent extends AppEvent {}

final class AppReminderEnabledEvent extends AppEvent {}

final class AppReminderDisabledEvent extends AppEvent {}

final class AppShowTestNotificationEvent extends AppEvent {}

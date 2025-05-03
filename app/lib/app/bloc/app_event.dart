part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();
  @override
  List<Object?> get props => [];
}

final class AppLoadNameEvent extends AppEvent {}

final class AppInitNameEvent extends AppEvent {}

final class AppUpdateNameEvent extends AppEvent {
  final String name;
  const AppUpdateNameEvent({required this.name});
  @override
  List<Object?> get props => [name];
}

final class AppHabitCreateEvent extends AppEvent {}

final class AppHabitCreatedEvent extends AppEvent {}

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

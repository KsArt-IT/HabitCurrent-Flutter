part of 'app_bloc.dart';

sealed class AppState {
  const AppState();
}

final class AppInitialState extends AppState {}

final class AppLoadedState extends AppState {
  final User user;
  const AppLoadedState({required this.user});
}

final class AppOnboardState extends AppState {}

final class AppHelloState extends AppState {}

final class AppHabitCreateState extends AppState {
  final int userId;
  const AppHabitCreateState({required this.userId});
}

final class AppHabitViewState extends AppState {
  final Habit habit;
  const AppHabitViewState({required this.habit});
}

final class AppHabitEditState extends AppState {
  final Habit habit;
  const AppHabitEditState({required this.habit});
}

final class AppHabitReloadState extends AppState {
  final int? habitId;
  const AppHabitReloadState({this.habitId});
}

final class AppErrorState extends AppState {
  final String error;
  const AppErrorState({required this.error});
}

part of 'app_bloc.dart';

sealed class AppState extends Equatable {
  const AppState();
  @override
  List<Object?> get props => [];
}

final class AppInitialState extends AppState {}

final class AppLoadedState extends AppState {
  final User user;
  const AppLoadedState({required this.user});

  @override
  List<Object?> get props => [user];
}

final class AppOnboardState extends AppState {}

final class AppHelloState extends AppState {}

final class AppHabitCreateState extends AppState {}

final class AppErrorState extends AppState {
  final String error;
  const AppErrorState({required this.error});

  @override
  List<Object?> get props => [error];
}

part of 'initial_bloc.dart';

sealed class InitialState {}

final class InitialLoadingState extends InitialState {}

final class InitialOnboardState extends InitialState {}

final class InitialHelloState extends InitialState {}

final class InitialLoadedState extends InitialState {
  final User user;
  InitialLoadedState(this.user);
}

final class InitialErrorState extends InitialState {
  final String message;
  InitialErrorState(this.message);
}

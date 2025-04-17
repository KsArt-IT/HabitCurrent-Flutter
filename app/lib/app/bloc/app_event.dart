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

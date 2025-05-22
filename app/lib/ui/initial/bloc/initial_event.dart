part of 'initial_bloc.dart';

sealed class InitialEvent {}

final class InitialLoadNameEvent extends InitialEvent {}

final class InitialHelloEvent extends InitialEvent {}

final class InitialUpdateNameEvent extends InitialEvent {
  final String name;
  InitialUpdateNameEvent(this.name);
}

part of 'habit_create_bloc.dart';

sealed class HabitCreateEvent extends Equatable {
  const HabitCreateEvent();

  @override
  List<Object?> get props => [];

}

final class HabitCreateSaveEvent extends HabitCreateEvent {}

final class HabitCreateNameChangedEvent extends HabitCreateEvent {
  final String name;

  const HabitCreateNameChangedEvent({required this.name});

  @override
  List<Object?> get props => [name];
}
part of 'habit_flow_bloc.dart';

sealed class HabitFlowEvent {}

class LoadHabitsEvent extends HabitFlowEvent {
  final int userId;

  LoadHabitsEvent({required this.userId});
}

class RefreshHabitsEvent extends HabitFlowEvent {
  final Completer completer;
  
  RefreshHabitsEvent(this.completer);
}

class HabitCreatedEvent extends HabitFlowEvent {}

class ReloadHabitEvent extends HabitFlowEvent {
  final int? habitId;

  ReloadHabitEvent({this.habitId});
}

class DeleteHabitEvent extends HabitFlowEvent {
  final int habitId;

  DeleteHabitEvent({required this.habitId});
}

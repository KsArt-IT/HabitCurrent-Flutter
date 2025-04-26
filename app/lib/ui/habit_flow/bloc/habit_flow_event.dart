part of 'habit_flow_bloc.dart';

sealed class HabitFlowEvent {}

class LoadHabitsEvent extends HabitFlowEvent {
  final int userId;

  LoadHabitsEvent({required this.userId});
}

class RefreshHabitsEvent extends HabitFlowEvent {}

class HabitCreatedEvent extends HabitFlowEvent {}

class HabitReloadEvent extends HabitFlowEvent {
  final int? habitId;

  HabitReloadEvent({this.habitId});
}

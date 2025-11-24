part of 'habit_week_bloc.dart';

sealed class HabitWeekEvent extends Equatable {
  const HabitWeekEvent();

  @override
  List<Object?> get props => [];
}

class LoadHabitWeekEvent extends HabitWeekEvent {
  final int userId;

  const LoadHabitWeekEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class RefreshHabitWeekEvent extends HabitWeekEvent {
  final Completer<void> completer;

  const RefreshHabitWeekEvent(this.completer);

  @override
  List<Object?> get props => [completer];
}

class ReloadHabitEvent extends HabitWeekEvent {
  final int? habitId;

  const ReloadHabitEvent({this.habitId});
  @override
  List<Object?> get props => [habitId];
}

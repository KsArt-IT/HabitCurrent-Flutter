part of 'habit_month_bloc.dart';

sealed class HabitMonthEvent extends Equatable {
  const HabitMonthEvent();

  @override
  List<Object?> get props => [];
}

class LoadHabitEvent extends HabitMonthEvent {
  final int userId;

  const LoadHabitEvent({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class ChangeMonthHabitEvent extends HabitMonthEvent {
  final DateTime selectedMonth;
  const ChangeMonthHabitEvent(this.selectedMonth);

  @override
  List<Object?> get props => [selectedMonth];
}

class RefreshHabitEvent extends HabitMonthEvent {
  final DateTime date;

  const RefreshHabitEvent(this.date);

  @override
  List<Object?> get props => [date];
}

class ReloadHabitEvent extends HabitMonthEvent {
  final int? habitId;

  const ReloadHabitEvent({this.habitId});
  @override
  List<Object?> get props => [habitId];
}

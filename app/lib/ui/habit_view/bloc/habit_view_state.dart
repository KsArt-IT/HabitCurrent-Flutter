part of 'habit_view_bloc.dart';

class HabitViewState extends Equatable {
  final Habit habit;

  const HabitViewState({required this.habit});

  HabitViewState copyWith({Habit? habit}) {
    return HabitViewState(habit: habit ?? this.habit);
  }

  @override
  List<Object?> get props => [habit];
}

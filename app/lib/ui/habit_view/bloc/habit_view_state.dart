part of 'habit_view_bloc.dart';

class HabitViewState extends Equatable {
  final Habit habit;
  final StateStatus status;
  final AppError? error;

  const HabitViewState({
    required this.habit,
    this.status = StateStatus.initial,
    this.error,
  });

  HabitViewState copyWith({
    Habit? habit,
    StateStatus? status,
    AppError? error,
  }) {
    return HabitViewState(
      habit: habit ?? this.habit,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [habit, status, error];
}

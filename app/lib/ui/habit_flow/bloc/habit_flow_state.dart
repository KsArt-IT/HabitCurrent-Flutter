part of 'habit_flow_bloc.dart';

class HabitFlowState extends Equatable {
  final int userId;
  final StateStatus status;
  final List<Habit> habits;
  final String? errorMessage;

  const HabitFlowState({
    this.userId = 0,
    this.status = StateStatus.initial,
    this.habits = const [],
    this.errorMessage,
  });

  HabitFlowState copyWith({
    int? userId,
    StateStatus? status,
    List<Habit>? habits,
    String? errorMessage,
  }) {
    return HabitFlowState(
      userId: userId ?? this.userId,
      status: status ?? this.status,
      habits: habits ?? this.habits,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [userId, status, habits, errorMessage];
}

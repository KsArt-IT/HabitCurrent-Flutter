part of 'habit_flow_bloc.dart';

enum HabitFlowStatus { initial, loading, success, error }

class HabitFlowState  extends Equatable {
  final int userId;
  final HabitFlowStatus status;
  final List<Habit> habits;
  final String? errorMessage;

  const HabitFlowState({
    this.userId = 0,
    this.status = HabitFlowStatus.initial,
    this.habits = const [],
    this.errorMessage,
  });

  HabitFlowState copyWith({
    int? userId,
    HabitFlowStatus? status,
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
  List<Object?> get props => [
    userId,
    status,
    habits,
    errorMessage,
  ];
}

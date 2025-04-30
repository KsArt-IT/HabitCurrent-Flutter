part of 'habit_week_bloc.dart';

class HabitWeekStatus {
  final Habit habit;
  final List<WeekStatus> weekStatus;

  HabitWeekStatus({required this.habit, required this.weekStatus});
}

enum WeekStatus {
  skipped,
  completed,
  partiallyCompleted,
  notCompleted,
  notStarted,
  closed,
}

class HabitWeekState extends Equatable {
  final int userId;
  final DateTime date;
  final HabitStatus status;
  final List<HabitWeekStatus> completedHabits;

  const HabitWeekState({
    this.userId = 0,
    this.status = HabitStatus.initial,
    required this.date,
    this.completedHabits = const [],
  });

  HabitWeekState copyWith({
    int? userId,
    DateTime? date,
    HabitStatus? status,
    List<HabitWeekStatus>? completedHabits,
  }) {
    return HabitWeekState(
      userId: userId ?? this.userId,
      status: status ?? this.status,
      date: date ?? this.date,
      completedHabits: completedHabits ?? this.completedHabits,
    );
  }

  @override
  List<Object?> get props => [userId, status, date, completedHabits];
}

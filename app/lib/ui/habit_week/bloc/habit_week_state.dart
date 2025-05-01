part of 'habit_week_bloc.dart';

class HabitWeekState extends Equatable {
  final int userId;
  final DateTime date;
  final HabitStatus status;
  final List<HabitWeek> completedHabits;

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
    List<HabitWeek>? completedHabits,
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

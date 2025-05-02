part of 'habit_month_bloc.dart';

class HabitMonthState extends Equatable {
  final int userId;
  final DateTime currentDate;
  final DateTime selectedMonth;
  final HabitStateStatus status;
  final List<HabitMonth> statusHabits;

  const HabitMonthState({
    this.userId = 0,
    this.status = HabitStateStatus.initial,
    required this.currentDate,
    required this.selectedMonth,
    this.statusHabits = const [],
  });

  HabitMonthState copyWith({
    int? userId,
    DateTime? currentDate,
    DateTime? selectedMonth,
    HabitStateStatus? status,
    List<HabitMonth>? statusHabits,
  }) => HabitMonthState(
    userId: userId ?? this.userId,
    currentDate: currentDate ?? this.currentDate,
    selectedMonth: selectedMonth ?? this.selectedMonth,
    status: status ?? this.status,
    statusHabits: statusHabits ?? this.statusHabits,
  );

  @override
  List<Object?> get props => [
    userId,
    status,
    currentDate,
    selectedMonth,
    statusHabits,
  ];
}

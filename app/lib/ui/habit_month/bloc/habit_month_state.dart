part of 'habit_month_bloc.dart';

class HabitMonthState extends Equatable {
  final int userId;
  final DateTime currentDate;
  final DateTime selectedMonth;
  final StateStatus status;
  final List<HabitMonth> habits;
  final AppError? error;

  const HabitMonthState({
    this.userId = 0,
    this.status = .initial,
    required this.currentDate,
    required this.selectedMonth,
    this.habits = const [],
    this.error,
  });

  HabitMonthState copyWith({
    int? userId,
    DateTime? currentDate,
    DateTime? selectedMonth,
    StateStatus? status,
    List<HabitMonth>? habits,
    AppError? error,
  }) => .new(
    userId: userId ?? this.userId,
    currentDate: currentDate ?? this.currentDate,
    selectedMonth: selectedMonth ?? this.selectedMonth,
    status: status ?? this.status,
    habits: habits ?? this.habits,
    error: error ?? this.error,
  );

  @override
  List<Object?> get props => [
    userId,
    status,
    currentDate,
    selectedMonth,
    habits,
    error,
  ];
}

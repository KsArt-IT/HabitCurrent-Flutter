part of 'habit_month_bloc.dart';

class HabitMonthState extends Equatable {
  final int userId;
  final DateTime currentDate;
  final DateTime selectedMonth;
  final HabitStateStatus status;
  final List<HabitMonth> habits;

  const HabitMonthState({
    this.userId = 0,
    this.status = HabitStateStatus.initial,
    required this.currentDate,
    required this.selectedMonth,
    this.habits = const [],
  });

  HabitMonthState copyWith({
    int? userId,
    DateTime? currentDate,
    DateTime? selectedMonth,
    HabitStateStatus? status,
    List<HabitMonth>? habits,
  }) => HabitMonthState(
    userId: userId ?? this.userId,
    currentDate: currentDate ?? this.currentDate,
    selectedMonth: selectedMonth ?? this.selectedMonth,
    status: status ?? this.status,
    habits: habits ?? this.habits,
  );

  @override
  List<Object?> get props => [
    userId,
    status,
    currentDate,
    selectedMonth,
    habits,
  ];
}

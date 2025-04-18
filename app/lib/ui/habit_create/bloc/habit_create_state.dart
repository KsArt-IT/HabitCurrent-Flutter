part of 'habit_create_bloc.dart';

enum StatsStatus { initial, loading, valid, success, failure }  

final class HabitCreateState extends Equatable {
  final StatsStatus status;
  final String name;
  final String? details;
  final Set<WeekDays> weekDays;
  final List<HourInterval> intervals;

  const HabitCreateState({
    this.status = StatsStatus.initial, 
    this.name = '',
    this.details,
    this.weekDays = const {},
    this.intervals = const [],
  });
  
  HabitCreateState copyWith({
    StatsStatus? status,
    String? name,
    String? details,
    Set<WeekDays>? weekDays,
    List<HourInterval>? intervals,
  }) => HabitCreateState(
    status: status ?? this.status,
    name: name ?? this.name,
    details: details ?? this.details,
    weekDays: weekDays ?? this.weekDays,
    intervals: intervals ?? this.intervals,
  );

  @override
  List<Object?> get props => [name, details, weekDays, intervals];
}
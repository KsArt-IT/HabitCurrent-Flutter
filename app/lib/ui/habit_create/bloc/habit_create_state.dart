part of 'habit_create_bloc.dart';

enum StatsStatus { initial, loading, change, valid, success, failure }

enum Frequency { daily, weekly }

final class HabitCreateState extends Equatable {
  final StatsStatus status;

  final String name;
  final String? details;

  // Daily or Week days
  final Frequency frequency;
  final Set<WeekDays> weekDays;
  // Hour intervals
  final List<int> intervals;
  // ReminderSelector
  final bool isReminder;

  const HabitCreateState({
    this.status = StatsStatus.initial,

    this.name = '',
    this.details,

    this.frequency = Frequency.daily,
    this.weekDays = const {},
    this.intervals = const [420],
    this.isReminder = false,
  });

  HabitCreateState copyWith({
    StatsStatus? status,
    String? name,
    String? details,
    Frequency? frequency,
    Set<WeekDays>? weekDays,
    List<int>? intervals,
    bool? isReminder,
  }) {
    StatsStatus checkStatus = status ?? StatsStatus.valid;
    if ((name ?? this.name).isEmpty ||
        (frequency ?? this.frequency) == Frequency.weekly &&
            (weekDays ?? this.weekDays).isEmpty) {
      checkStatus = StatsStatus.failure;
    }

    return HabitCreateState(
      status: checkStatus,
      name: name ?? this.name,
      details: details ?? this.details,
      frequency: frequency ?? this.frequency,
      weekDays: weekDays ?? this.weekDays,
      intervals: intervals ?? this.intervals,
      isReminder: isReminder ?? this.isReminder,
    );
  }

  @override
  List<Object?> get props => [
    status,
    name,
    details,
    frequency,
    weekDays,
    intervals,
    isReminder,
  ];
}

part of 'habit_create_bloc.dart';

enum StatsStatus { initial, loading, valid, success, failure }

enum Frequency { daily, weekly }

enum Reminder { enabled, disabled }

final class HabitCreateState extends Equatable {
  final StatsStatus status;
  
  final int? habitId;

  final String name;
  final String? details;

  // Daily or Week days
  final Frequency frequency;
  final Set<WeekDays> weekDays;
  // Hour intervals
  final List<int> intervals;
  // ReminderSelector
  final Reminder reminder;

  const HabitCreateState({
    this.status = StatsStatus.initial,
    this.habitId = 0,
    this.name = '',
    this.details,

    this.frequency = Frequency.daily,
    this.weekDays = const {},
    this.intervals = const [420],
    this.reminder = Reminder.disabled,
  });

  HabitCreateState copyWith({
    StatsStatus? status,
    int? habitId,
    String? name,
    String? details,
    Frequency? frequency,
    Set<WeekDays>? weekDays,
    List<int>? intervals,
    int? selectedTime,
    int? selectedTimeIndex,
    Reminder? reminder,
  }) {
    StatsStatus checkStatus = status ?? StatsStatus.valid;
    if ((name ?? this.name).isEmpty ||
        (frequency ?? this.frequency) == Frequency.weekly &&
            (weekDays ?? this.weekDays).isEmpty) {
      checkStatus = StatsStatus.failure;
    }

    return HabitCreateState(
      status: checkStatus,
      habitId: habitId ?? this.habitId,
      name: name ?? this.name,
      details: details ?? this.details,
      frequency: frequency ?? this.frequency,
      weekDays: weekDays ?? this.weekDays,
      intervals: intervals ?? this.intervals,
      reminder: reminder ?? this.reminder,
    );
  }

  @override
  List<Object?> get props => [
    status,
    habitId,
    name,
    details,
    frequency,
    weekDays,
    intervals,
    reminder,
  ];
}

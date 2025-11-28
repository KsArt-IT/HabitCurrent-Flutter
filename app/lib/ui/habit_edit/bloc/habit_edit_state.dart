part of 'habit_edit_bloc.dart';

enum Frequency { daily, weekly }

class HabitEditState extends Equatable {
  final StateStatus status;
  final Habit? habit;
  bool get isEditing => habit != null;
  final DateTime? startTime;
  final DateTime? endTime;

  final int habitId;
  final int userId;

  final String name;
  final String? details;
  // Daily or Week days
  final Frequency frequency;
  final Set<WeekDays> weekDays;

  // Hour intervals
  final List<HourInterval> intervals;
  // ReminderSelector
  final Reminder reminder;
  // Error
  final AppError? error;

  const HabitEditState({
    this.status = .initial,
    this.habit,
    this.startTime,
    this.endTime,

    this.habitId = 0,
    this.userId = 0,

    this.name = '',
    this.details,
    this.frequency = .daily,
    this.weekDays = const {},
    this.intervals = const [.new(time: 420)],
    this.reminder = .disabled,
    this.error,
  });

  factory HabitEditState.fromHabit(Habit habit) {
    return HabitEditState(
      habit: habit,
      startTime: habit.created,
      endTime: habit.completed,

      habitId: habit.id,
      userId: habit.userId,

      name: habit.name,
      details: habit.details,
      frequency: habit.weekDays.length == 7 ? .daily : .weekly,
      weekDays: habit.weekDays,
      intervals: habit.intervals,
      reminder: habit.notifications.isNotEmpty ? .enabled : .disabled,
    );
  }

  HabitEditState copyWith({
    StateStatus? status,

    Habit? habit,
    DateTime? startTime,
    DateTime? endTime,

    int? habitId,
    int? userId,

    String? name,
    String? details,
    Frequency? frequency,
    Set<WeekDays>? weekDays,
    List<HourInterval>? intervals,
    Reminder? reminder,
    AppError? error,
  }) {
    var checkStatus = status ?? .valid;
    if ((name ?? this.name).isEmpty ||
        (frequency ?? this.frequency) == .weekly && (weekDays ?? this.weekDays).isEmpty) {
      checkStatus = .error;
    }

    return HabitEditState(
      status: checkStatus,

      habit: habit ?? this.habit,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,

      habitId: habitId ?? this.habitId,
      userId: userId ?? this.userId,

      name: name ?? this.name,
      details: details ?? this.details,
      frequency: frequency ?? this.frequency,
      weekDays: weekDays ?? this.weekDays,
      intervals: intervals ?? this.intervals,
      reminder: reminder ?? this.reminder,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    status,

    startTime,
    endTime,
    habit,

    habitId,
    userId,

    name,
    details,
    frequency,
    weekDays,
    intervals,
    reminder,
    error,
  ];
}

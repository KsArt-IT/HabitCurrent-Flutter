part of 'habit_create_bloc.dart';

sealed class HabitCreateEvent extends Equatable {
  const HabitCreateEvent();

  @override
  List<Object?> get props => [];
}

final class SubmitHabitEvent extends HabitCreateEvent {}

final class NameChangedEvent extends HabitCreateEvent {
  final String name;

  const NameChangedEvent({required this.name});

  @override
  List<Object?> get props => [name];
}

// Daily or Week days
final class DailyOrWeekToggledEvent extends HabitCreateEvent {
  final Frequency frequency;

  const DailyOrWeekToggledEvent(Frequency? value)
    : frequency = value ?? Frequency.daily;

  @override
  List<Object?> get props => [frequency];
}

final class WeekDayChangedEvent extends HabitCreateEvent {
  final WeekDays weekDay;

  const WeekDayChangedEvent(this.weekDay);

  @override
  List<Object?> get props => [weekDay];
}

// Hour intervals
class TimeAddedEvent extends HabitCreateEvent {}

class TimeRemovedEvent extends HabitCreateEvent {}

final class ReminderToggledEvent extends HabitCreateEvent {
  final bool enabled;
  const ReminderToggledEvent(this.enabled);
  @override
  List<Object?> get props => [enabled];
}

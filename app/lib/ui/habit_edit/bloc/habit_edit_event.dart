part of 'habit_edit_bloc.dart';

sealed class HabitEditEvent extends Equatable {
  const HabitEditEvent();
  @override
  List<Object?> get props => [];
}

// Создание привычки
final class StartCreateHabitEvent extends HabitEditEvent {
  final int userId;
  const StartCreateHabitEvent({required this.userId});
  @override
  List<Object?> get props => [userId];
}

final class CreateHabitEvent extends HabitEditEvent {}

// Редактирование привычки
final class StartEditHabitEvent extends HabitEditEvent {
  final Habit habit;
  const StartEditHabitEvent({required this.habit});
  @override
  List<Object?> get props => [habit];
}

final class SaveHabitEvent extends HabitEditEvent {}

// Редактирование параметров привычки
final class UpdateHabitNameEvent extends HabitEditEvent {
  final String name;
  const UpdateHabitNameEvent({required this.name});
  @override
  List<Object?> get props => [name];
}

// Daily or Week days
final class ToggleDailyOrWeekEvent extends HabitEditEvent {
  final Frequency frequency;

  const ToggleDailyOrWeekEvent(Frequency? value)
    : frequency = value ?? Frequency.daily;

  @override
  List<Object?> get props => [frequency];
}

final class ChangeWeekDayEvent extends HabitEditEvent {
  final WeekDays weekDay;

  const ChangeWeekDayEvent(this.weekDay);

  @override
  List<Object?> get props => [weekDay];
}

// Hour intervals
class AddTimeIntervalEvent extends HabitEditEvent {}

class RemoveTimeIntervalEvent extends HabitEditEvent {}

final class ChangeTimeIntervalEvent extends HabitEditEvent {
  final int index;
  final int time;

  const ChangeTimeIntervalEvent({required this.index, required this.time});

  @override
  List<Object?> get props => [index, time];
}

final class ToggleReminderEvent extends HabitEditEvent {
  final Reminder value;
  const ToggleReminderEvent(this.value);
  @override
  List<Object?> get props => [value];
}

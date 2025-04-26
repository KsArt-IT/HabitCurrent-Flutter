part of 'habit_view_bloc.dart';

sealed class HabitViewEvent {
  const HabitViewEvent();
}

final class HabitViewChangedEvent extends HabitViewEvent {
  final int index;

  const HabitViewChangedEvent({required this.index});
}

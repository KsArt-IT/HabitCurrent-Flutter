part of 'app_bloc.dart';

enum AppStatus {
  initial,
  userLoaded,
  habitCreate,
  habitView,
  habitEdit,
  habitReload,
  error,
}

class AppState {
  final AppStatus status;

  final User? user;
  final Reminder reminder;
  final Habit? habit;
  final int? habitId;
  final String? error;

  const AppState({
    required this.status,
    this.user,
    this.reminder = Reminder.request, // запросить разрешение
    this.habit,
    this.habitId,
    this.error,
  });

  factory AppState.initial() => const AppState(status: AppStatus.initial);

  AppState copyWith({
    AppStatus? status,
    User? user,
    Reminder? reminder,
    Habit? habit,
    int? habitId,
    String? error,
  }) {
    return AppState(
      status: status ?? this.status,
      user: user ?? this.user,
      reminder: reminder ?? this.reminder,
      habit: habit ?? this.habit,
      habitId: habitId ?? this.habitId,
      error: error ?? this.error,
    );
  }
}

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

class AppState extends Equatable {
  final AppStatus status;

  final User? user;
  final Reminder reminder;
  final Habit? habit;
  final int? habitId;
  final String? error;

  final int update;

  const AppState({
    required this.status,
    this.user,
    this.reminder = Reminder.enabled,
    this.habit,
    this.habitId,
    this.error,
    this.update = 0,
  });

  factory AppState.initial() => AppState(status: AppStatus.initial);

  AppState copyWith({
    AppStatus? status,
    User? user,
    Reminder? reminder,
    Habit? habit,
    int? habitId,
    String? error,
    int? update,
  }) {
    return AppState(
      status: status ?? this.status,
      user: user ?? this.user,
      reminder: reminder ?? this.reminder,
      habit: habit ?? this.habit,
      habitId: habitId ?? this.habitId,
      error: error ?? this.error,
      update: update ?? this.update,
    );
  }

  @override
  List<Object?> get props => [
    status,
    user,
    reminder,
    habit,
    habitId,
    error,
    update,
  ];
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/data/repositories/data/data_repository.dart';
import 'package:habit_current/data/repositories/settings/settings_repository.dart';
import 'package:habit_current/models/habit.dart';
import 'package:habit_current/models/user.dart';

part 'app_event.dart';
part 'app_state.dart';

final class AppBloc extends Bloc<AppEvent, AppState> {
  final SettingsRepository settingsRepository;
  final DataRepository dataRepository;
  User? user;

  AppBloc({required this.settingsRepository, required this.dataRepository})
    : super(AppInitialState()) {
    on<AppLoadNameEvent>(_onLoadNameEvent);
    on<AppInitNameEvent>(_onInitNameEvent);
    on<AppUpdateNameEvent>(_onCreateNameEvent);
    on<AppHabitCreateEvent>(_onHabitCreateEvent);
    on<AppHabitCreatedEvent>(_onHabitCreatedEvent);
    on<AppHabitViewEvent>(_onHabitViewEvent);
    on<AppHabitEditEvent>(_onHabitEditEvent);
    on<AppHabitReloadEvent>(_onHabitsReloadEvent);
    on<AppHabitDeleteEvent>(_onHabitDeleteEvent);
    // on<AppUpdateLanguageEvent>(_onLanguageChanged);
    // on<AppUpdateThemeEvent>(_onDarkThemeChanged);
    // on<AppSaveEvent>(_onSave);
    // on<AppResetEvent>(_onReset);
  }

  void _onLoadNameEvent(AppLoadNameEvent event, Emitter<AppState> emit) async {
    try {
      final name = await settingsRepository.loadName();
      if (name.isEmpty) {
        // If the name is empty, emit the onboard state
        emit(AppOnboardState());
        return;
      }
      user = await dataRepository.loadUserByName(name);
      if (user == null) {
        // If the user is not found, emit the onboard state
        emit(AppOnboardState());
        return;
      }
      // Simulate a delay
      await Future.delayed(const Duration(seconds: 1));
      // Emit the loaded state with the name
      emit(AppLoadedState(user: user!));
    } catch (e) {
      emit(AppErrorState(error: e.toString()));
    }
  }

  void _onInitNameEvent(AppInitNameEvent event, Emitter<AppState> emit) {
    emit(AppHelloState());
  }

  void _onCreateNameEvent(
    AppUpdateNameEvent event,
    Emitter<AppState> emit,
  ) async {
    // Получить пользователя по имени в базе данных
    user =
        await dataRepository.loadUserByName(event.name) ??
        // Создать имя в базе данных
        await dataRepository.createUserByName(event.name);
    if (user != null) {
      // если все ок, то сохранить имя в настройках
      // и перейти на главный экран
      settingsRepository.saveName(user!.name);
      emit(AppLoadedState(user: user!));
    } else {
      emit(AppErrorState(error: 'User not found'));
    }
  }

  void _onHabitCreateEvent(
    AppHabitCreateEvent event,
    Emitter<AppState> emit,
  ) async {
    if (user != null) {
      emit(AppHabitCreateState(userId: user!.id));
    }
  }

  void _onHabitCreatedEvent(
    AppHabitCreatedEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(AppHabitReloadState());
  }

  void _onHabitViewEvent(
    AppHabitViewEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(AppHabitViewState(habit: event.habit));
  }

  void _onHabitEditEvent(
    AppHabitEditEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(AppHabitEditState(habitId: event.habitId));
  }

  void _onHabitsReloadEvent(
    AppHabitReloadEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(AppHabitReloadState(habitId: event.habitId));
  }

  void _onHabitDeleteEvent(
    AppHabitDeleteEvent event,
    Emitter<AppState> emit,
  ) async {
    if (event.habitId == null) return;

    await dataRepository.deleteHabitById(event.habitId!);
    emit(AppHabitReloadState(habitId: event.habitId));
  }
}

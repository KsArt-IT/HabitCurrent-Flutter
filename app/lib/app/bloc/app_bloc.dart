import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:habit_current/data/repositories/data/data_repository.dart';
import 'package:habit_current/data/repositories/settings/settings_repository.dart';
import 'package:habit_current/models/user.dart';

part 'app_state.dart';
part 'app_event.dart';

final class AppBloc extends Bloc<AppEvent, AppState> {
  final SettingsRepository settingsRepository;
  final DataRepository dataRepository;

  AppBloc({required this.settingsRepository, required this.dataRepository})
    : super(AppInitialState()) {
    on<AppLoadNameEvent>(_onLoadNameEvent);
    on<AppInitNameEvent>(_onInitNameEvent);
    on<AppUpdateNameEvent>(_onCreateNameEvent);
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
      final user = await dataRepository.loadUserByName(name);
      if (user == null) {
        // If the user is not found, emit the onboard state
        emit(AppOnboardState());
        return;
      }
      // Simulate a delay
      await Future.delayed(const Duration(seconds: 1));
      // Emit the loaded state with the name
      emit(AppLoadedState(user: user));
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
    final user =
        await dataRepository.loadUserByName(event.name) ??
        // Создать имя в базе данных
        await dataRepository.createUserByName(event.name);

    // если все ок, то сохранить имя в настройках
    // и перейти на главный экран
    settingsRepository.saveName(user.name);
    emit(AppLoadedState(user: user));
  }
}

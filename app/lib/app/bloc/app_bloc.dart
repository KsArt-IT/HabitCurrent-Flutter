import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:habit_current/data/repositories/settings_repository.dart';

part 'app_state.dart';
part 'app_event.dart';

final class AppBloc extends Bloc<AppEvent, AppState> {
  final SettingsRepository settingsRepository;
  
  AppBloc({required this.settingsRepository}) : super(AppInitialState()) {
    on<AppLoadNameEvent>(_onLoadNameEvent);
    on<AppOnboardNextEvent>(_onOnboardNextEvent);
    // on<AppUpdateNameEvent>(_onNameChanged);
    // on<AppUpdateLanguageEvent>(_onLanguageChanged);
    // on<AppUpdateThemeEvent>(_onDarkThemeChanged);
    // on<AppSaveEvent>(_onSave);
    // on<AppResetEvent>(_onReset);
  }

  void _onLoadNameEvent(
    AppLoadNameEvent event,
    Emitter<AppState> emit,
  ) async {
    try {
      final name = await settingsRepository.loadName();
      if (name.isEmpty) {
        // If the name is empty, emit the onboard state
        emit(AppOnboardState());
        return;
      }
      // Simulate a delay
      await Future.delayed(const Duration(seconds: 1));
      // Emit the loaded state with the name
      emit(AppLoadedState(name: name));
    } catch (e) {
      emit(AppErrorState(error: e.toString()));
    }
  }

  void _onOnboardNextEvent(
    AppOnboardNextEvent event,
    Emitter<AppState> emit,
  ) {
    emit(AppHelloState());
  }
}

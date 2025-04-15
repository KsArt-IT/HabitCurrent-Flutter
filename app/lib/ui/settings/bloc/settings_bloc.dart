import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:habit_current/data/repositories/settings_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({required SettingsRepository settingsRepository})
    : _settingsRepository = settingsRepository,
      super(SettingsState()) {
    on<SettingsLoadEvent>(_onLoadEvent);
    on<SettingsUpdateNameEvent>(_onNameChanged);
    on<SettingsUpdateLanguageEvent>(_onLanguageChanged);
    on<SettingsUpdateThemeEvent>(_onDarkThemeChanged);
    on<SettingsSaveEvent>(_onSave);
    on<SettingsResetEvent>(_onReset);
  }

  final SettingsRepository _settingsRepository;

  void _onLoadEvent(
    SettingsLoadEvent event,
    Emitter<SettingsState> emit,
  ) async {
    final language = await _settingsRepository.loadLanguage();
    final name = await _settingsRepository.loadName();
    final darkTheme = await _settingsRepository.loadDarkTheme();
    emit(state.copyWith(language: language, name: name, darkTheme: darkTheme));
  }

  void _onNameChanged(
    SettingsUpdateNameEvent event,
    Emitter<SettingsState> emit,
  ) async {
    await _settingsRepository.saveName(event.name);
    emit(state.copyWith(name: event.name));
  }

  void _onLanguageChanged(
    SettingsUpdateLanguageEvent event,
    Emitter<SettingsState> emit,
  ) async {
    await _settingsRepository.saveLanguage(event.language);
    emit(state.copyWith(language: event.language));
  }

  void _onDarkThemeChanged(
    SettingsUpdateThemeEvent event,
    Emitter<SettingsState> emit,
  ) async {
    await _settingsRepository.saveDarkTheme(event.darkTheme);
    emit(state.copyWith(darkTheme: event.darkTheme));
  }

  void _onSave(SettingsSaveEvent event, Emitter<SettingsState> emit) async {
    await _settingsRepository.saveName(state.name);
    await _settingsRepository.saveLanguage(state.language);
    await _settingsRepository.saveDarkTheme(state.darkTheme);
  }

  void _onReset(SettingsResetEvent event, Emitter<SettingsState> emit) async {
    final newState = SettingsState();
    await _settingsRepository.saveName(newState.name);
    await _settingsRepository.saveLanguage(newState.language);
    await _settingsRepository.saveDarkTheme(newState.darkTheme);
    emit(newState);
  }
}

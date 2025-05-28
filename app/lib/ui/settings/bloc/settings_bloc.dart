import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/data/repositories/settings/settings_repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _settingsRepository;

  SettingsBloc({required SettingsRepository settingsRepository})
    : _settingsRepository = settingsRepository,
      super(SettingsState()) {
    on<SettingsLoadEvent>(_onLoadEvent);
    on<SettingsUpdateNameEvent>(_onNameChanged);
    on<SettingsUpdateLanguageEvent>(_onLanguageChanged);
    on<SettingsUpdateThemeEvent>(_onThemeChanged);
    on<SettingsUpdateReminderEvent>(_onReminderChanged);
    on<SettingsSaveEvent>(_onSave);
    on<SettingsResetEvent>(_onReset);
  }

  void _onLoadEvent(
    SettingsLoadEvent event,
    Emitter<SettingsState> emit,
  ) async {
    final language = await _settingsRepository.loadLanguage();
    final name = await _settingsRepository.loadName();
    final themeName = await _settingsRepository.loadThemeMode();
    final reminder = await _settingsRepository.loadReminder();
    emit(
      state.copyWith(
        language: language,
        name: name,
        themeName: themeName,
        reminder: reminder,
      ),
    );
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

  void _onThemeChanged(
    SettingsUpdateThemeEvent event,
    Emitter<SettingsState> emit,
  ) async {
    await _settingsRepository.saveThemeMode(event.themeName);
    emit(state.copyWith(themeName: event.themeName));
  }

  void _onReminderChanged(
    SettingsUpdateReminderEvent event,
    Emitter<SettingsState> emit,
  ) async {
    await _settingsRepository.saveReminder(event.reminder);
    emit(state.copyWith(reminder: event.reminder));
  }

  void _onSave(SettingsSaveEvent event, Emitter<SettingsState> emit) async {
    await _settingsRepository.saveName(state.name);
    await _settingsRepository.saveLanguage(state.language);
    await _settingsRepository.saveThemeMode(state.themeName);
    await _settingsRepository.saveReminder(state.reminder);
  }

  void _onReset(SettingsResetEvent event, Emitter<SettingsState> emit) async {
    final newState = SettingsState();
    await _settingsRepository.saveName(newState.name);
    await _settingsRepository.saveLanguage(newState.language);
    await _settingsRepository.saveThemeMode(newState.themeName);
    await _settingsRepository.saveReminder(newState.reminder);
    emit(newState);
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/core/error/app_error.dart';
import 'package:habit_current/data/repositories/settings/settings_repository.dart';
import 'package:habit_current/models/state_status.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsRepository _settingsRepository;

  SettingsBloc({required SettingsRepository settingsRepository})
    : _settingsRepository = settingsRepository,
      super(const SettingsState()) {
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
    try {
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
    } catch (e) {
      emit(
        state.copyWith(
          status: StateStatus.error,
          error: SettingsLoadingError(e.toString()),
        ),
      );
    }
  }

  void _onNameChanged(
    SettingsUpdateNameEvent event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      await _settingsRepository.saveName(event.name);
      emit(state.copyWith(name: event.name));
    } catch (e) {
      emit(
        state.copyWith(
          status: StateStatus.error,
          error: SettingsSavingError(e.toString()),
        ),
      );
    }
  }

  void _onLanguageChanged(
    SettingsUpdateLanguageEvent event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      await _settingsRepository.saveLanguage(event.language);
      emit(state.copyWith(language: event.language));
    } catch (e) {
      emit(
        state.copyWith(
          status: StateStatus.error,
          error: SettingsSavingError(e.toString()),
        ),
      );
    }
  }

  void _onThemeChanged(
    SettingsUpdateThemeEvent event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      await _settingsRepository.saveThemeMode(event.themeName);
      emit(state.copyWith(themeName: event.themeName));
    } catch (e) {
      emit(
        state.copyWith(
          status: StateStatus.error,
          error: SettingsSavingError(e.toString()),
        ),
      );
    }
  }

  void _onReminderChanged(
    SettingsUpdateReminderEvent event,
    Emitter<SettingsState> emit,
  ) async {
    try {
      await _settingsRepository.saveReminder(event.reminder);
      emit(state.copyWith(reminder: event.reminder));
    } catch (e) {
      emit(
        state.copyWith(
          status: StateStatus.error,
          error: SettingsSavingError(e.toString()),
        ),
      );
    }
  }

  void _onSave(SettingsSaveEvent event, Emitter<SettingsState> emit) async {
    try {
      await _settingsRepository.saveName(state.name);
      await _settingsRepository.saveLanguage(state.language);
      await _settingsRepository.saveThemeMode(state.themeName);
      await _settingsRepository.saveReminder(state.reminder);
    } catch (e) {
      emit(
        state.copyWith(
          status: StateStatus.error,
          error: SettingsSavingError(e.toString()),
        ),
      );
    }
  }

  void _onReset(SettingsResetEvent event, Emitter<SettingsState> emit) async {
    final newState = const SettingsState();
    add(const SettingsSaveEvent());
    emit(newState);
  }
}

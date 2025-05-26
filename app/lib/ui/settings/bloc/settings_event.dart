part of 'settings_bloc.dart';

sealed class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

// Settings
final class SettingsLoadEvent extends SettingsEvent {
  const SettingsLoadEvent();
}

final class SettingsUpdateEvent extends SettingsEvent {
  final String name;
  final String language;
  final bool darkMode;

  const SettingsUpdateEvent({
    required this.name,
    required this.language,
    required this.darkMode,
  });

  @override
  List<Object?> get props => [name, language, darkMode];
}

final class SettingsUpdateNameEvent extends SettingsEvent {
  final String name;

  const SettingsUpdateNameEvent({required this.name});

  @override
  List<Object?> get props => [name];
}

final class SettingsUpdateLanguageEvent extends SettingsEvent {
  final String language;

  const SettingsUpdateLanguageEvent({required this.language});

  @override
  List<Object?> get props => [language];
}

final class SettingsUpdateThemeEvent extends SettingsEvent {
  final String themeName;

  const SettingsUpdateThemeEvent(this.themeName);

  @override
  List<Object?> get props => [themeName];
}

final class SettingsSaveEvent extends SettingsEvent {
  const SettingsSaveEvent();
}

final class SettingsResetEvent extends SettingsEvent {
  const SettingsResetEvent();
}

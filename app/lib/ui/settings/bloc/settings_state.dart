part of 'settings_bloc.dart';

final class SettingsState extends Equatable {
  const SettingsState({
    this.name = '',
    this.language = 'en',
    this.themeName = 'system',
  });

  final String name;
  final String language;
  final String themeName;

  ThemeMode get theme => ThemeMode.values.firstWhere(
    (e) => e.name == themeName,
    orElse: () => ThemeMode.system,
  );

  SettingsState copyWith({
    String? name,
    String? language,
    String? themeName, //
  }) {
    return SettingsState(
      name: name ?? this.name,
      language: language ?? this.language,
      themeName: themeName ?? this.themeName,
    );
  }

  @override
  List<Object?> get props => [name, language, theme];
}

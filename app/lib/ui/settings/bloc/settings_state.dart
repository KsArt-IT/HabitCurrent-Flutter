part of 'settings_bloc.dart';

final class SettingsState extends Equatable {
  const SettingsState({
    this.name = '',
    this.language = 'en',
    this.darkTheme = false,
  });

  final String name;
  final String language;
  final bool darkTheme;

  SettingsState copyWith({String? name, String? language, bool? darkTheme}) {
    return SettingsState(
      name: name ?? this.name,
      language: language ?? this.language,
      darkTheme: darkTheme ?? this.darkTheme,
    );
  }

  @override
  List<Object?> get props => [name, language, darkTheme];
}

part of 'settings_bloc.dart';

final class SettingsState extends Equatable {
  const SettingsState({
    this.name = '',
    this.language = '',
    this.themeName = 'system',
    this.reminder = true,
    this.status = StateStatus.initial,
    this.error,
  });

  final String name;
  final String language;
  final String themeName;
  final bool reminder;

  final StateStatus status;
  final AppError? error;

  String get languageCode => locale.languageCode;
  Locale get locale =>
      language.isNotEmpty ? Locale(language) : WidgetsBinding.instance.platformDispatcher.locale;

  String get themeCode => theme.name;
  ThemeMode get theme => ThemeMode.values.firstWhere(
    (e) => e.name == themeName,
    orElse: () => ThemeMode.system,
  );

  SettingsState copyWith({
    String? name,
    String? language,
    String? themeName,
    bool? reminder,

    StateStatus? status,
    AppError? error,
  }) {
    return SettingsState(
      name: name ?? this.name,
      language: language ?? this.language,
      themeName: themeName ?? this.themeName,
      reminder: reminder ?? this.reminder,

      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [
    name,
    language,
    theme,
    reminder,
    status,
    error,
    //
  ];
}

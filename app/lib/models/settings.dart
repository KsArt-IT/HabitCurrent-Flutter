final class Settings {
  final String name;
  final String language;
  final bool darkMode;

  const Settings({
    required this.name,
    required this.language,
    required this.darkMode,
  });

  Settings copyWith({String? name, String? language, bool? darkMode}) => Settings(
    name: name ?? this.name,
    language: language ?? this.language,
    darkMode: darkMode ?? this.darkMode,
  );
}

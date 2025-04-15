abstract interface class SettingsService {
  Future<String> loadLanguage();
  Future<void> saveLanguage(String language);
  Future<String> loadName();
  Future<void> saveName(String name);
  Future<bool> loadDarkTheme();
  Future<void> saveDarkTheme(bool theme);
}
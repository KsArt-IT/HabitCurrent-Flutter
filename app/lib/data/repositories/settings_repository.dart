abstract interface class SettingsRepository {
  Future<String> loadLanguage();
  Future<void> saveLanguage(String language);
  Future<String> loadName();
  Future<void> saveName(String language);
  Future<bool> loadDarkTheme();
  Future<void> saveDarkTheme(bool theme);
}

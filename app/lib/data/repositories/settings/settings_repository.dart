abstract interface class SettingsRepository {
  Future<String> loadLanguage();
  Future<void> saveLanguage(String language);
  Future<String> loadName();
  Future<void> saveName(String language);
  Future<String> loadThemeMode();
  Future<void> saveThemeMode(String theme);
  Future<bool> loadReminder();
  Future<void> saveReminder(bool reminder);
}

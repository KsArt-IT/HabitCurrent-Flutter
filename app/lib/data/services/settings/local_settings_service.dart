import 'package:habit_current/data/services/settings/settings_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SettingsKey {
  language,
  name,
  themeMode,
  reminder,
}

final class LocalSettingsService implements SettingsService {
  LocalSettingsService({required SharedPreferences preferences}) : _preferences = preferences;

  final SharedPreferences _preferences;

  String _getValue(String key, {String defaultValue = ''}) {
    final value = _preferences.getString(key);
    return value ?? defaultValue;
  }

  bool _getBool(String key, {bool defaultValue = true}) {
    final value = _preferences.getBool(key);
    return value ?? defaultValue;
  }

  Future<void> _setValue(String key, String value) async {
    await _preferences.setString(key, value);
  }

  Future<void> _setBool(String key, bool value) async {
    await _preferences.setBool(key, value);
  }

  @override
  Future<String> loadLanguage() async {
    return _getValue(SettingsKey.language.name);
  }

  @override
  Future<void> saveLanguage(String language) async {
    await _setValue(SettingsKey.language.name, language);
  }

  @override
  Future<String> loadName() async {
    return _getValue(SettingsKey.name.name);
  }

  @override
  Future<void> saveName(String name) async {
    await _setValue(SettingsKey.name.name, name);
  }

  @override
  Future<String> loadThemeMode() async {
    return _getValue(SettingsKey.themeMode.name);
  }

  @override
  Future<void> saveThemeMode(String theme) async {
    await _setValue(SettingsKey.themeMode.name, theme);
  }

  @override
  Future<bool> loadReminder() async {
    return _getBool(SettingsKey.reminder.name);
  }

  @override
  Future<void> saveReminder(bool reminder) async {
    await _setBool(SettingsKey.reminder.name, reminder);
  }
}

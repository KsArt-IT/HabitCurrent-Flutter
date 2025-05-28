import 'package:habit_current/data/services/settings/settings_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class LocalSettingsService implements SettingsService {
  LocalSettingsService({required SharedPreferences preferences})
    : _preferences = preferences;

  final SharedPreferences _preferences;

  String? _getValue(String key) => _preferences.getString(key);

  bool _getBool(String key, bool defaultValue) => _preferences.getBool(key) ?? defaultValue;

  Future<void> _setValue(String key, String value) =>
      _preferences.setString(key, value);

  Future<void> _setBool(String key, bool value) =>
      _preferences.setBool(key, value);

  @override
  Future<String> loadLanguage() async {
    return _getValue('language') ?? 'en';
  }

  @override
  Future<void> saveLanguage(String language) {
    return _setValue('language', language);
  }

  @override
  Future<String> loadName() async {
    return _getValue('name') ?? '';
  }

  @override
  Future<void> saveName(String name) {
    return _setValue('name', name);
  }

  @override
  Future<String> loadThemeMode() async {
    return _getValue('themeMode') ?? '';
  }

  @override
  Future<void> saveThemeMode(String theme) {
    return _setValue('themeMode', theme);
  }
  
  @override
  Future<bool> loadReminder() async {
    return _getBool('reminder', true);
  }
  
  @override
  Future<void> saveReminder(bool reminder) {
    return _setBool('reminder', reminder);
  }
}

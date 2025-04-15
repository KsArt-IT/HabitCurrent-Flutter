import 'package:habit_current/data/services/settings_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class LocalStorageSettingsService implements SettingsService {
  LocalStorageSettingsService({required SharedPreferences preferences})
    : _preferences = preferences;

  final SharedPreferences _preferences;

  String? _getValue(String key) => _preferences.getString(key);

  bool _getBool(String key) => _preferences.getBool(key) ?? false;

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
  Future<bool> loadDarkTheme() async {
    return _getBool('darkTheme');
  }

  @override
  Future<void> saveDarkTheme(bool theme) {
    return _setBool('darkTheme', theme);
  }
}

import 'package:habit_current/data/repositories/settings/settings_repository.dart';
import 'package:habit_current/data/services/settings/settings_service.dart';

final class LocalSettingsRepository implements SettingsRepository {
  final SettingsService _service;

  LocalSettingsRepository({required SettingsService service})
    : _service = service;

  @override
  Future<String> loadLanguage() async {
    return _service.loadLanguage();
  }

  @override
  Future<void> saveLanguage(String language) {
    return _service.saveLanguage(language);
  }

  @override
  Future<String> loadName() async {
    return _service.loadName();
  }

  @override
  Future<void> saveName(String name) {
    return _service.saveName(name);
  }

  @override
  Future<String> loadThemeMode() async {
    return _service.loadThemeMode();
  }

  @override
  Future<void> saveThemeMode(String theme) {
    return _service.saveThemeMode(theme);
  }

  @override
  Future<bool> loadReminder() async {
    return _service.loadReminder();
  }

  @override
  Future<void> saveReminder(bool reminder) {
    return _service.saveReminder(reminder);
  }
}

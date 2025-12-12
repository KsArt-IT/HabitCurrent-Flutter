import 'package:habit_current/gen/app_localizations.dart';

extension StringExt on String {
  String toLanguageTitle(AppLocalizations locale) => switch (this) {
    'en' => locale.english,
    'ru' => locale.russian,
    'uk' => locale.ukrainian,
    'system' => locale.system,
    _ => locale.unknown,
  };

  String toThemeTitle(AppLocalizations locale) => switch (this) {
    'light' => locale.light,
    'dark' => locale.dark,
    'system' => locale.system,
    _ => locale.unknown,
  };
}

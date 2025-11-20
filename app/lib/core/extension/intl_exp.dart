import 'package:flutter/material.dart';
import 'package:habit_current/gen/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
  AppLocalizations get locale => AppLocalizations.of(this);
}

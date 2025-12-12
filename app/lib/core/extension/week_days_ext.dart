import 'package:habit_current/gen/app_localizations.dart';
import 'package:habit_current/models/weekdays.dart';
import 'package:intl/intl.dart';

extension WeekDaysExt on WeekDays {
  String getDayName(AppLocalizations locale) {
    final date = DateTime(2024, 1, weekDay);
    final name = DateFormat('EEEE', locale.localeName).format(date);

    return name.substring(0, 1).toUpperCase() + name.substring(1);
  }

  String getShortDayName(AppLocalizations locale) {
    final date = DateTime(2024, 1, weekDay);
    final name = DateFormat('EEE', locale.localeName).format(date);

    return name.substring(0, 1).toUpperCase() + name.substring(1);
  }
}

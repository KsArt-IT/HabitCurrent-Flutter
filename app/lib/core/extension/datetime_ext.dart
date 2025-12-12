import 'package:habit_current/gen/app_localizations.dart';
import 'package:intl/intl.dart';

typedef WeekRange = ({DateTime start, DateTime end});
typedef MonthRange = ({DateTime start, DateTime end});

extension IntWeekDay on DateTime {
  DateTime toEndOfDay() => DateTime(year, month, day, 23, 59, 59, 999);
  DateTime toStartOfDay() => DateTime(year, month, day);

  WeekRange toWeekRange() {
    final startOfWeek = subtract(Duration(days: weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 6));
    return (start: startOfWeek.toEndOfDay(), end: endOfWeek.toEndOfDay());
  }

  MonthRange toMonthRange() {
    final start = DateTime(year, month, 1, 23, 59, 59, 999);
    final end = DateTime(year, month + 1, 0, 23, 59, 59, 999);
    return (start: start, end: end);
  }

  String toShortMonthName(AppLocalizations locale) {
    final name = DateFormat('MMM', locale.localeName).format(this);

    return name.substring(0, 1).toUpperCase() + name.substring(1);
  }

  bool isBeforeOrEqual(DateTime other) => isBefore(other) || isAtSameMomentAs(other);

  bool isSameDate(DateTime other) => year == other.year && month == other.month && day == other.day;
}

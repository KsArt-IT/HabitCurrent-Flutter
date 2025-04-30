typedef WeekRange = ({DateTime start, DateTime end});

extension IntWeekDay on DateTime {
  DateTime toEndOfDay() => DateTime(year, month, day, 23, 59, 59, 999);

  WeekRange toWeekRange() {
    final DateTime startOfWeek = subtract(Duration(days: weekday - 1));
    final DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

    final DateTime start = DateTime(
      startOfWeek.year,
      startOfWeek.month,
      startOfWeek.day,
    );

    final DateTime end = endOfWeek.toEndOfDay();

    return (start: start, end: end);
  }

  bool isBeforeOrEqual(DateTime other) =>
      isBefore(other) || isAtSameMomentAs(other);

  bool isSameDate(DateTime other) =>
      year == other.year && month == other.month && day == other.day;
}

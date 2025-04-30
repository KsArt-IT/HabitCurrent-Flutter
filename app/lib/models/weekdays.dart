import 'package:flutter/widgets.dart';
import 'package:habit_current/l10n/app_localizations.dart';

enum WeekDays {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday;

  int get toBit => switch (this) {
    WeekDays.monday => 1,
    WeekDays.tuesday => 2,
    WeekDays.wednesday => 4,
    WeekDays.thursday => 8,
    WeekDays.friday => 16,
    WeekDays.saturday => 32,
    WeekDays.sunday => 64,
  };
  String getDayName(BuildContext context) => switch (this) {
    WeekDays.monday => AppLocalizations.of(context).monday,
    WeekDays.tuesday => AppLocalizations.of(context).tuesday,
    WeekDays.wednesday => AppLocalizations.of(context).wednesday,
    WeekDays.thursday => AppLocalizations.of(context).thursday,
    WeekDays.friday => AppLocalizations.of(context).friday,
    WeekDays.saturday => AppLocalizations.of(context).saturday,
    WeekDays.sunday => AppLocalizations.of(context).sunday,
  };
  String getShortDayName(BuildContext context) => switch (this) {
    WeekDays.monday => AppLocalizations.of(context).mondayShort,
    WeekDays.tuesday => AppLocalizations.of(context).tuesdayShort,
    WeekDays.wednesday => AppLocalizations.of(context).wednesdayShort,
    WeekDays.thursday => AppLocalizations.of(context).thursdayShort,
    WeekDays.friday => AppLocalizations.of(context).fridayShort,
    WeekDays.saturday => AppLocalizations.of(context).saturdayShort,
    WeekDays.sunday => AppLocalizations.of(context).sundayShort,
  };
  static const int none = 0;
  static const int allDays = 127;
  static Set<WeekDays> fromInt(int value) =>
      WeekDays.values.where((element) => value & element.toBit != 0).toSet();
  static WeekDays fromDate([DateTime? date]) {
    final day = (date ?? DateTime.now()).weekday;
    return switch (day) {
      1 => WeekDays.monday,
      2 => WeekDays.tuesday,
      3 => WeekDays.wednesday,
      4 => WeekDays.thursday,
      5 => WeekDays.friday,
      6 => WeekDays.saturday,
      7 => WeekDays.sunday,
      _ => throw ArgumentError('Invalid weekday'),
    };
  }
}

extension Raw on Set<WeekDays> {
  int toInt() => this.fold(0, (value, element) => value | element.toBit);
}

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
  static WeekDays get today => WeekDays.values[DateTime.now().weekday - 1];
  static const int none = 0;
  static const int allDays = 127;
  static Set<WeekDays> fromInt(int value) =>
      WeekDays.values.where((element) => value & element.toBit != 0).toSet();
}

extension Raw on Set<WeekDays> {
  int toInt() => this.fold(0, (value, element) => value | element.toBit);
}

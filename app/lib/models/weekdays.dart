import 'package:habit_current/gen/app_localizations.dart';

enum WeekDays {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday,
  ;

  int get toBit => switch (this) {
    WeekDays.monday => 1,
    WeekDays.tuesday => 2,
    WeekDays.wednesday => 4,
    WeekDays.thursday => 8,
    WeekDays.friday => 16,
    WeekDays.saturday => 32,
    WeekDays.sunday => 64,
  };
  int get weekDay => switch (this) {
    WeekDays.monday => 1,
    WeekDays.tuesday => 2,
    WeekDays.wednesday => 3,
    WeekDays.thursday => 4,
    WeekDays.friday => 5,
    WeekDays.saturday => 6,
    WeekDays.sunday => 7,
  };
  String getDayName(AppLocalizations locale) => switch (this) {
    WeekDays.monday => locale.monday,
    WeekDays.tuesday => locale.tuesday,
    WeekDays.wednesday => locale.wednesday,
    WeekDays.thursday => locale.thursday,
    WeekDays.friday => locale.friday,
    WeekDays.saturday => locale.saturday,
    WeekDays.sunday => locale.sunday,
  };
  String getShortDayName(AppLocalizations locale) => switch (this) {
    WeekDays.monday => locale.mondayShort,
    WeekDays.tuesday => locale.tuesdayShort,
    WeekDays.wednesday => locale.wednesdayShort,
    WeekDays.thursday => locale.thursdayShort,
    WeekDays.friday => locale.fridayShort,
    WeekDays.saturday => locale.saturdayShort,
    WeekDays.sunday => locale.sundayShort,
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

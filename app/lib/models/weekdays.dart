enum WeekDays {
  monday("Monday"),
  tuesday("Tuesday"),
  wednesday("Wednesday"),
  thursday("Thursday"),
  friday("Friday"),
  saturday("Saturday"),
  sunday("Sunday");

  final String name;
  const WeekDays(this.name);

  int get toBit => switch (this) {
    WeekDays.monday => 1,
    WeekDays.tuesday => 2,
    WeekDays.wednesday => 4,
    WeekDays.thursday => 8,
    WeekDays.friday => 16,
    WeekDays.saturday => 32,
    WeekDays.sunday => 64,
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

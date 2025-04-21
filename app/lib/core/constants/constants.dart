abstract final class Constants {
  static const double buttonHeight = 48;
  static const double buttonRadius = buttonHeight / 2;

  static const double textFieldHeight = 44;
  static const double textFieldRadius = textFieldHeight / 2;
  static const double textFieldPaddingHorizontal = 16;
  static const double textFieldPaddingVertical = 12;
  static const double textFieldSpacing = 24;

  static const double paddingSmall = 8;
  static const double paddingMedium = 16;
  static const double paddingLarge = 24;
  static const double paddingXLarge = 32;

  static const double borderRadius = 24;

  static final regExpName = RegExp(r'^[іІїЇєЄґҐʼа-яА-Яa-zA-Z\s]+$');
  static final regExpHabit = RegExp(r'^[іІїЇєЄґҐʼа-яА-Яa-zA-Z0-9\s]+$');
}

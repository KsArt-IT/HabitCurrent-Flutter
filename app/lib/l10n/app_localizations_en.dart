// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Habit Current';

  @override
  String get n_1 => '---Tabs---';

  @override
  String get tabFlow => 'Flow';

  @override
  String get tabWeek => 'Week';

  @override
  String get tabMonth => 'Month';

  @override
  String get tabSettings => 'Settings';

  @override
  String get n_2 => '---Hello---';

  @override
  String get welcome => 'Welcome to the useful habits tracker';

  @override
  String get enterYourName => 'Please enter your name so we know how to address you';

  @override
  String get namePlaceholder => 'Enter your name';

  @override
  String get name => 'Name';

  @override
  String get nameError => 'Please enter your name';

  @override
  String get nameErrorEmpty => 'Name must contain 3-20 letters';

  @override
  String get nameErrorInvalid => 'Name can only contain letters';

  @override
  String get n_3 => '---Buttons---';

  @override
  String get continueBtn => 'Continue';

  @override
  String get createBtn => 'Create';

  @override
  String get addNewHabit => 'Add new habit';

  @override
  String get delete => 'Delete';

  @override
  String get addTime => 'Add Time';

  @override
  String get n_4 => '---Habits Create---';

  @override
  String get createHabit => 'Create a Habit';

  @override
  String get habitEnterName => 'Enter Habit Name';

  @override
  String get habitEnterNameHint => 'Name';

  @override
  String get howOften => 'How Often';

  @override
  String get daily => 'Daily';

  @override
  String get yourSchedule => 'Your own schedule';

  @override
  String get chooseDay => 'Choose a day';

  @override
  String get chooseTime => 'Choose a time';

  @override
  String get reminder => 'Reminder';

  @override
  String get withoutReminder => 'Without Reminder';

  @override
  String get enableReminders => 'Enable Reminders';

  @override
  String get habitEnterNameError => 'Please enter a habit name, it must contain 3-20 letters';

  @override
  String get n_5 => '---Flow---';

  @override
  String get noHabits => 'You have no habits added yet.';

  @override
  String get noHabitsToday => 'You have no added habits for today.';

  @override
  String get errorUnknown => 'Error! Please try again later.';

  @override
  String get n_n => '---';
}

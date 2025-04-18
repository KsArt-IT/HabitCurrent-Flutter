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
  String get n_4 => '---Habits---';

  @override
  String get habitEnterNameHint => 'Enter Habit Name';

  @override
  String get createHabit => 'Create a Habit';

  @override
  String get habitEnterNameError => 'Please enter a habit name, it must contain 3-20 letters';

  @override
  String get n_n => '---';
}

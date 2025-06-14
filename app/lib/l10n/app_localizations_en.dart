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
  String get tabFlow => 'Today';

  @override
  String get tabWeek => 'Week';

  @override
  String get tabMonth => 'Month';

  @override
  String get tabSettings => 'Settings';

  @override
  String get language => 'Language';

  @override
  String get theme => 'Theme';

  @override
  String get notification => 'Notification Permission';

  @override
  String get n_2 => '---Hello---';

  @override
  String get welcome => 'Welcome to the useful habits tracker';

  @override
  String get enterYourName =>
      'Please enter your name so we know how to address you';

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
  String get saveBtn => 'Save';

  @override
  String get addNewHabit => 'Add new habit';

  @override
  String get delete => 'Delete';

  @override
  String get addTime => 'Add Time';

  @override
  String get requestPermission => 'Request Permission';

  @override
  String get openNotificationSettings => 'Open Notification Settings';

  @override
  String get showTestNotification => 'Show Test Notification';

  @override
  String get n_4 => '---Habits Create---';

  @override
  String get createHabit => 'Create a Habit';

  @override
  String editHabit(Object name) {
    return 'Edit: $name';
  }

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
  String get habitEnterNameError =>
      'Please enter a habit name, it must contain 3-20 letters';

  @override
  String get n_5 => '---Flow---';

  @override
  String get noHabits => 'You have no habits added yet.';

  @override
  String get noHabitsToday => 'You have no added habits for today.';

  @override
  String get errorUnknown => 'Error! Please try again later.';

  @override
  String get edit => 'Edit';

  @override
  String get n_6 => '---WeekDays---';

  @override
  String get monday => 'Monday';

  @override
  String get tuesday => 'Tuesday';

  @override
  String get wednesday => 'Wednesday';

  @override
  String get thursday => 'Thursday';

  @override
  String get friday => 'Friday';

  @override
  String get saturday => 'Saturday';

  @override
  String get sunday => 'Sunday';

  @override
  String get mondayShort => 'Mon';

  @override
  String get tuesdayShort => 'Tue';

  @override
  String get wednesdayShort => 'Wed';

  @override
  String get thursdayShort => 'Thu';

  @override
  String get fridayShort => 'Fri';

  @override
  String get saturdayShort => 'Sat';

  @override
  String get sundayShort => 'Sun';

  @override
  String get n_7 => '---Errors---';

  @override
  String get userInitialError => 'User Initial Error';

  @override
  String get userLoadingError => 'User Loading Error';

  @override
  String get userSavingError => 'User Saving Error';

  @override
  String get databaseError => 'Database Error';

  @override
  String get databaseCreatingError => 'Database Creating Object Error';

  @override
  String get databaseLoadingError => 'Database Loading Object Error';

  @override
  String get databaseSavingError => 'Database Saving Object Error';

  @override
  String get databaseDeletingError => 'Database Deleting Object Error';

  @override
  String get notificationError => 'Notification Error';

  @override
  String get settingsLoadingError => 'Settings Loading Error';

  @override
  String get settingsSavingError => 'Settings Saving Error';

  @override
  String get unknownError => 'Unknown Error';

  @override
  String get n_n => '---';
}

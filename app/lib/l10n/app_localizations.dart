import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_uk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
    Locale('uk')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Habit Current'**
  String get appTitle;

  /// No description provided for @n_1.
  ///
  /// In en, this message translates to:
  /// **'---Tabs---'**
  String get n_1;

  /// No description provided for @tabFlow.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get tabFlow;

  /// No description provided for @tabWeek.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get tabWeek;

  /// No description provided for @tabMonth.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get tabMonth;

  /// No description provided for @tabSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get tabSettings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @notification.
  ///
  /// In en, this message translates to:
  /// **'Notification Permission'**
  String get notification;

  /// No description provided for @showTestNotification.
  ///
  /// In en, this message translates to:
  /// **'Show Test Notification'**
  String get showTestNotification;

  /// No description provided for @openNotificationSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Notification Settings'**
  String get openNotificationSettings;

  /// No description provided for @n_2.
  ///
  /// In en, this message translates to:
  /// **'---Hello---'**
  String get n_2;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to the useful habits tracker'**
  String get welcome;

  /// No description provided for @enterYourName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name so we know how to address you'**
  String get enterYourName;

  /// No description provided for @namePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get namePlaceholder;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @nameError.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get nameError;

  /// No description provided for @nameErrorEmpty.
  ///
  /// In en, this message translates to:
  /// **'Name must contain 3-20 letters'**
  String get nameErrorEmpty;

  /// No description provided for @nameErrorInvalid.
  ///
  /// In en, this message translates to:
  /// **'Name can only contain letters'**
  String get nameErrorInvalid;

  /// No description provided for @n_3.
  ///
  /// In en, this message translates to:
  /// **'---Buttons---'**
  String get n_3;

  /// No description provided for @continueBtn.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueBtn;

  /// No description provided for @createBtn.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get createBtn;

  /// No description provided for @saveBtn.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get saveBtn;

  /// No description provided for @addNewHabit.
  ///
  /// In en, this message translates to:
  /// **'Add new habit'**
  String get addNewHabit;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @addTime.
  ///
  /// In en, this message translates to:
  /// **'Add Time'**
  String get addTime;

  /// No description provided for @request.
  ///
  /// In en, this message translates to:
  /// **'Request Permission'**
  String get request;

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Notification Settings'**
  String get openSettings;

  /// No description provided for @n_4.
  ///
  /// In en, this message translates to:
  /// **'---Habits Create---'**
  String get n_4;

  /// No description provided for @createHabit.
  ///
  /// In en, this message translates to:
  /// **'Create a Habit'**
  String get createHabit;

  /// No description provided for @editHabit.
  ///
  /// In en, this message translates to:
  /// **'Edit: {name}'**
  String editHabit(Object name);

  /// No description provided for @habitEnterName.
  ///
  /// In en, this message translates to:
  /// **'Enter Habit Name'**
  String get habitEnterName;

  /// No description provided for @habitEnterNameHint.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get habitEnterNameHint;

  /// No description provided for @howOften.
  ///
  /// In en, this message translates to:
  /// **'How Often'**
  String get howOften;

  /// No description provided for @daily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get daily;

  /// No description provided for @yourSchedule.
  ///
  /// In en, this message translates to:
  /// **'Your own schedule'**
  String get yourSchedule;

  /// No description provided for @chooseDay.
  ///
  /// In en, this message translates to:
  /// **'Choose a day'**
  String get chooseDay;

  /// No description provided for @chooseTime.
  ///
  /// In en, this message translates to:
  /// **'Choose a time'**
  String get chooseTime;

  /// No description provided for @reminder.
  ///
  /// In en, this message translates to:
  /// **'Reminder'**
  String get reminder;

  /// No description provided for @withoutReminder.
  ///
  /// In en, this message translates to:
  /// **'Without Reminder'**
  String get withoutReminder;

  /// No description provided for @enableReminders.
  ///
  /// In en, this message translates to:
  /// **'Enable Reminders'**
  String get enableReminders;

  /// No description provided for @habitEnterNameError.
  ///
  /// In en, this message translates to:
  /// **'Please enter a habit name, it must contain 3-20 letters'**
  String get habitEnterNameError;

  /// No description provided for @n_5.
  ///
  /// In en, this message translates to:
  /// **'---Flow---'**
  String get n_5;

  /// No description provided for @noHabits.
  ///
  /// In en, this message translates to:
  /// **'You have no habits added yet.'**
  String get noHabits;

  /// No description provided for @noHabitsToday.
  ///
  /// In en, this message translates to:
  /// **'You have no added habits for today.'**
  String get noHabitsToday;

  /// No description provided for @errorUnknown.
  ///
  /// In en, this message translates to:
  /// **'Error! Please try again later.'**
  String get errorUnknown;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @n_6.
  ///
  /// In en, this message translates to:
  /// **'---WeekDays---'**
  String get n_6;

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @mondayShort.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get mondayShort;

  /// No description provided for @tuesdayShort.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get tuesdayShort;

  /// No description provided for @wednesdayShort.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get wednesdayShort;

  /// No description provided for @thursdayShort.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get thursdayShort;

  /// No description provided for @fridayShort.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get fridayShort;

  /// No description provided for @saturdayShort.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get saturdayShort;

  /// No description provided for @sundayShort.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get sundayShort;

  /// No description provided for @n_7.
  ///
  /// In en, this message translates to:
  /// **'---Errors---'**
  String get n_7;

  /// No description provided for @userInitialError.
  ///
  /// In en, this message translates to:
  /// **'User Initial Error'**
  String get userInitialError;

  /// No description provided for @userLoadingError.
  ///
  /// In en, this message translates to:
  /// **'User Loading Error'**
  String get userLoadingError;

  /// No description provided for @userSavingError.
  ///
  /// In en, this message translates to:
  /// **'User Saving Error'**
  String get userSavingError;

  /// No description provided for @databaseError.
  ///
  /// In en, this message translates to:
  /// **'Database Error'**
  String get databaseError;

  /// No description provided for @databaseCreatingError.
  ///
  /// In en, this message translates to:
  /// **'Database Creating Object Error'**
  String get databaseCreatingError;

  /// No description provided for @databaseLoadingError.
  ///
  /// In en, this message translates to:
  /// **'Database Loading Object Error'**
  String get databaseLoadingError;

  /// No description provided for @databaseSavingError.
  ///
  /// In en, this message translates to:
  /// **'Database Saving Object Error'**
  String get databaseSavingError;

  /// No description provided for @databaseDeletingError.
  ///
  /// In en, this message translates to:
  /// **'Database Deleting Object Error'**
  String get databaseDeletingError;

  /// No description provided for @notificationError.
  ///
  /// In en, this message translates to:
  /// **'Notification Error'**
  String get notificationError;

  /// No description provided for @unknownError.
  ///
  /// In en, this message translates to:
  /// **'Unknown Error'**
  String get unknownError;

  /// No description provided for @n_n.
  ///
  /// In en, this message translates to:
  /// **'---'**
  String get n_n;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ru', 'uk'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ru': return AppLocalizationsRu();
    case 'uk': return AppLocalizationsUk();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}

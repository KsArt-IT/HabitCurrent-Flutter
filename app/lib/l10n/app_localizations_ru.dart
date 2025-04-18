// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'Развивай привычки';

  @override
  String get n_1 => '---Tabs---';

  @override
  String get tabFlow => 'Поток';

  @override
  String get tabWeek => 'Неделя';

  @override
  String get tabMonth => 'Месяц';

  @override
  String get tabSettings => 'Настройки';

  @override
  String get n_2 => '---Hello---';

  @override
  String get welcome => 'Добро пожаловать в полезный трекер привычек';

  @override
  String get enterYourName => 'Пожалуйста, введите ваше имя, чтобы мы знали, как к вам обращаться';

  @override
  String get namePlaceholder => 'Введите ваше имя';

  @override
  String get name => 'Имя';

  @override
  String get nameError => 'Пожалуйста, введите ваше имя';

  @override
  String get nameErrorEmpty => 'Имя должно содержать 3-20 буквы';

  @override
  String get nameErrorInvalid => 'Имя может содержать только буквы';

  @override
  String get n_3 => '---Buttons---';

  @override
  String get continueBtn => 'Продолжить';

  @override
  String get createBtn => 'Создать';

  @override
  String get addNewHabit => 'Добавить привычку';

  @override
  String get n_4 => '---Habits---';

  @override
  String get habitEnterNameHint => 'Введите привычку';

  @override
  String get createHabit => 'Создать привычку';

  @override
  String get habitEnterNameError => 'Пожалуйста, введите привычку, должна содержать 3-20 букв';

  @override
  String get n_n => '---';
}

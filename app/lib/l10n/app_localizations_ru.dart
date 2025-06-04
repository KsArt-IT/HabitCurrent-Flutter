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
  String get tabFlow => 'Сегодня';

  @override
  String get tabWeek => 'Неделя';

  @override
  String get tabMonth => 'Месяц';

  @override
  String get tabSettings => 'Настройки';

  @override
  String get language => 'Язык';

  @override
  String get theme => 'Тема';

  @override
  String get notification => 'Разрешение на уведомления';

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
  String get saveBtn => 'Сохранить';

  @override
  String get addNewHabit => 'Добавить привычку';

  @override
  String get delete => 'Удалить';

  @override
  String get addTime => 'Добавить время';

  @override
  String get requestPermission => 'Запросить разрешение';

  @override
  String get openNotificationSettings => 'Открыть настройки уведомлений';

  @override
  String get showTestNotification => 'Показать тестовое уведомление';

  @override
  String get n_4 => '---Habits---';

  @override
  String get createHabit => 'Создать привычку';

  @override
  String editHabit(Object name) {
    return 'Редактировать: $name';
  }

  @override
  String get habitEnterName => 'Введите привычку';

  @override
  String get habitEnterNameHint => 'Название';

  @override
  String get howOften => 'Как часто';

  @override
  String get daily => 'Каждый день';

  @override
  String get yourSchedule => 'Ваш график';

  @override
  String get chooseDay => 'Выберите день';

  @override
  String get chooseTime => 'Выберите время';

  @override
  String get reminder => 'Напоминание';

  @override
  String get withoutReminder => 'Без напоминания';

  @override
  String get enableReminders => 'Включить напоминания';

  @override
  String get habitEnterNameError => 'Пожалуйста, введите привычку, должна содержать 3-20 букв';

  @override
  String get n_5 => '---Flow---';

  @override
  String get noHabits => 'У вас нет добавленных привычек';

  @override
  String get noHabitsToday => 'У вас нет добавленных привычек на сегодня';

  @override
  String get errorUnknown => 'Ошибка! Пожалуйста, попробуйте позже';

  @override
  String get edit => 'Редактировать';

  @override
  String get n_6 => '---WeekDays---';

  @override
  String get monday => 'Понедельник';

  @override
  String get tuesday => 'Вторник';

  @override
  String get wednesday => 'Среда';

  @override
  String get thursday => 'Четверг';

  @override
  String get friday => 'Пятница';

  @override
  String get saturday => 'Суббота';

  @override
  String get sunday => 'Воскресенье';

  @override
  String get mondayShort => 'Пн';

  @override
  String get tuesdayShort => 'Вт';

  @override
  String get wednesdayShort => 'Ср';

  @override
  String get thursdayShort => 'Чт';

  @override
  String get fridayShort => 'Пт';

  @override
  String get saturdayShort => 'Сб';

  @override
  String get sundayShort => 'Вс';

  @override
  String get n_7 => '---Errors---';

  @override
  String get userInitialError => 'Ошибка инициализации пользователя';

  @override
  String get userLoadingError => 'Ошибка загрузки пользователя';

  @override
  String get userSavingError => 'Ошибка сохранения пользователя';

  @override
  String get databaseError => 'Ошибка базы данных';

  @override
  String get databaseCreatingError => 'Ошибка создания объекта в базе данных';

  @override
  String get databaseLoadingError => 'Ошибка загрузки объекта из базы данных';

  @override
  String get databaseSavingError => 'Ошибка сохранения объекта в базе данных';

  @override
  String get databaseDeletingError => 'Ошибка удаления объекта из базы данных';

  @override
  String get notificationError => 'Ошибка уведомлений';

  @override
  String get unknownError => 'Неизвестная ошибка';

  @override
  String get n_n => '---';
}

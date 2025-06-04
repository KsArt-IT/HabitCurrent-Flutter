// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'Розвивай звички';

  @override
  String get n_1 => '---Tabs---';

  @override
  String get tabFlow => 'Сьогодні';

  @override
  String get tabWeek => 'Тиждень';

  @override
  String get tabMonth => 'Місяць';

  @override
  String get tabSettings => 'Налаштування';

  @override
  String get language => 'Мова';

  @override
  String get theme => 'Тема';

  @override
  String get notification => 'Дозвіл на сповіщення';

  @override
  String get n_2 => '---Hello---';

  @override
  String get welcome => 'Ласкаво просимо в полезний трекер звичок';

  @override
  String get enterYourName => 'Будь ласка, введіть ваше ім\'я, щоб ми знали, як до вас звертатися';

  @override
  String get namePlaceholder => 'Введіть ваше ім\'я';

  @override
  String get name => 'Ім\'я';

  @override
  String get nameError => 'Будь ласка, введіть ваше ім\'я';

  @override
  String get nameErrorEmpty => 'Ім\'я повинно містити 3-20 букви';

  @override
  String get nameErrorInvalid => 'Ім\'я може містити тільки букви';

  @override
  String get n_3 => '---Buttons---';

  @override
  String get continueBtn => 'Продовжити';

  @override
  String get createBtn => 'Створити';

  @override
  String get saveBtn => 'Зберегти';

  @override
  String get addNewHabit => 'Додати звичку';

  @override
  String get delete => 'Видалити';

  @override
  String get addTime => 'Додати час';

  @override
  String get requestPermission => 'Запитати дозвіл';

  @override
  String get openNotificationSettings => 'Відкрити налаштування сповіщень';

  @override
  String get showTestNotification => 'Показати тестове сповіщення';

  @override
  String get n_4 => '---Habits---';

  @override
  String get createHabit => 'Створити звичку';

  @override
  String editHabit(Object name) {
    return 'Редагувати: $name';
  }

  @override
  String get habitEnterName => 'Введіть звичку';

  @override
  String get habitEnterNameHint => 'Назва';

  @override
  String get howOften => 'Як часто';

  @override
  String get daily => 'Щодня';

  @override
  String get yourSchedule => 'Ваш графік';

  @override
  String get chooseDay => 'Виберіть день';

  @override
  String get chooseTime => 'Виберіть час';

  @override
  String get reminder => 'Нагадування';

  @override
  String get withoutReminder => 'Без нагадування';

  @override
  String get enableReminders => 'Увімкнути нагадування';

  @override
  String get habitEnterNameError => 'Будь ласка, введіть звичку, повинна містити 3-20 букв';

  @override
  String get n_5 => '---Flow---';

  @override
  String get noHabits => 'У вас немає доданих звичок';

  @override
  String get noHabitsToday => 'У вас немає доданих звичок на сьогодні';

  @override
  String get errorUnknown => 'Помилка! Будь ласка, спробуйте пізніше';

  @override
  String get edit => 'Редагувати';

  @override
  String get n_6 => '---WeekDays---';

  @override
  String get monday => 'Понеділок';

  @override
  String get tuesday => 'Вівторок';

  @override
  String get wednesday => 'Середа';

  @override
  String get thursday => 'Четвер';

  @override
  String get friday => 'П\'ятниця';

  @override
  String get saturday => 'Субота';

  @override
  String get sunday => 'Неділя';

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
  String get userInitialError => 'Помилка ініціалізації користувача';

  @override
  String get userLoadingError => 'Помилка завантаження користувача';

  @override
  String get userSavingError => 'Помилка збереження користувача';

  @override
  String get databaseError => 'Помилка бази даних';

  @override
  String get databaseCreatingError => 'Помилка створення об\'єкта в базі даних';

  @override
  String get databaseLoadingError => 'Помилка завантаження об\'єкта з бази даних';

  @override
  String get databaseSavingError => 'Помилка збереження об\'єкта в базі даних';

  @override
  String get databaseDeletingError => 'Помилка видалення об\'єкта з бази даних';

  @override
  String get notificationError => 'Помилка сповіщень';

  @override
  String get settingsLoadingError => 'Помилка завантаження налаштуваннь';

  @override
  String get settingsSavingError => 'Помилка збереження налаштуваннь';

  @override
  String get unknownError => 'Невідома помилка';

  @override
  String get n_n => '---';
}

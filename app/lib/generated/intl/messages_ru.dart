// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "addNewHabit": MessageLookupByLibrary.simpleMessage("Добавить привычку"),
    "appTitle": MessageLookupByLibrary.simpleMessage("Развивай привычки"),
    "continues": MessageLookupByLibrary.simpleMessage("Продолжить"),
    "enterYourName": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите ваше имя, чтобы мы знали, как к вам обращаться",
    ),
    "name": MessageLookupByLibrary.simpleMessage("Имя"),
    "nameError": MessageLookupByLibrary.simpleMessage(
      "Пожалуйста, введите ваше имя",
    ),
    "nameErrorEmpty": MessageLookupByLibrary.simpleMessage(
      "Имя должно содержать 3-20 буквы",
    ),
    "nameErrorInvalid": MessageLookupByLibrary.simpleMessage(
      "Имя может содержать только буквы",
    ),
    "namePlaceholder": MessageLookupByLibrary.simpleMessage("Введите ваше имя"),
    "tabFlow": MessageLookupByLibrary.simpleMessage("Поток"),
    "tabMonth": MessageLookupByLibrary.simpleMessage("Месяц"),
    "tabSettings": MessageLookupByLibrary.simpleMessage("Настройки"),
    "tabWeek": MessageLookupByLibrary.simpleMessage("Неделя"),
    "welcome": MessageLookupByLibrary.simpleMessage(
      "Добро пожаловать в полезный трекер привычек",
    ),
  };
}

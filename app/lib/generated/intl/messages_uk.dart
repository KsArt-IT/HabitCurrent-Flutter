// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a uk locale. All the
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
  String get localeName => 'uk';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "addNewHabit": MessageLookupByLibrary.simpleMessage("Додати звичку"),
    "appTitle": MessageLookupByLibrary.simpleMessage("Розвивай звички"),
    "continues": MessageLookupByLibrary.simpleMessage("Продовжити"),
    "enterYourName": MessageLookupByLibrary.simpleMessage(
      "Будь ласка, введіть ваше ім\'я, щоб ми знали, як до вас звертатися",
    ),
    "name": MessageLookupByLibrary.simpleMessage("Ім\'я"),
    "nameError": MessageLookupByLibrary.simpleMessage(
      "Будь ласка, введіть ваше ім\'я",
    ),
    "nameErrorEmpty": MessageLookupByLibrary.simpleMessage(
      "Ім\'я повинно містити 3-20 букви",
    ),
    "nameErrorInvalid": MessageLookupByLibrary.simpleMessage(
      "Ім\'я може містити тільки букви",
    ),
    "namePlaceholder": MessageLookupByLibrary.simpleMessage(
      "Введіть ваше ім\'я",
    ),
    "tabFlow": MessageLookupByLibrary.simpleMessage("Потік"),
    "tabMonth": MessageLookupByLibrary.simpleMessage("Місяць"),
    "tabSettings": MessageLookupByLibrary.simpleMessage("Налаштування"),
    "tabWeek": MessageLookupByLibrary.simpleMessage("Тиждень"),
    "welcome": MessageLookupByLibrary.simpleMessage(
      "Ласкаво просимо в полезний трекер звичок",
    ),
  };
}

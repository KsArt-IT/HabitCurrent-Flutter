// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Habit Current`
  String get appTitle {
    return Intl.message('Habit Current', name: 'appTitle', desc: '', args: []);
  }

  // skipped getter for the '-' key

  /// `Flow`
  String get tabFlow {
    return Intl.message('Flow', name: 'tabFlow', desc: '', args: []);
  }

  /// `Week`
  String get tabWeek {
    return Intl.message('Week', name: 'tabWeek', desc: '', args: []);
  }

  /// `Month`
  String get tabMonth {
    return Intl.message('Month', name: 'tabMonth', desc: '', args: []);
  }

  /// `Settings`
  String get tabSettings {
    return Intl.message('Settings', name: 'tabSettings', desc: '', args: []);
  }

  // skipped getter for the '--' key

  /// `Welcome to the useful habits tracker`
  String get welcome {
    return Intl.message(
      'Welcome to the useful habits tracker',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your name so we know how to address you`
  String get enterYourName {
    return Intl.message(
      'Please enter your name so we know how to address you',
      name: 'enterYourName',
      desc: '',
      args: [],
    );
  }

  /// `Enter your name`
  String get namePlaceholder {
    return Intl.message(
      'Enter your name',
      name: 'namePlaceholder',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message('Name', name: 'name', desc: '', args: []);
  }

  /// `Please enter your name`
  String get nameError {
    return Intl.message(
      'Please enter your name',
      name: 'nameError',
      desc: '',
      args: [],
    );
  }

  /// `Name must contain 3-20 letters`
  String get nameErrorEmpty {
    return Intl.message(
      'Name must contain 3-20 letters',
      name: 'nameErrorEmpty',
      desc: '',
      args: [],
    );
  }

  /// `Name can only contain letters`
  String get nameErrorInvalid {
    return Intl.message(
      'Name can only contain letters',
      name: 'nameErrorInvalid',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '---' key

  /// `Continue`
  String get continues {
    return Intl.message('Continue', name: 'continues', desc: '', args: []);
  }

  /// `Add new habit`
  String get addNewHabit {
    return Intl.message(
      'Add new habit',
      name: 'addNewHabit',
      desc: '',
      args: [],
    );
  }

  /// `Enter Habit Name`
  String get habitEnterNameHint {
    return Intl.message(
      'Enter Habit Name',
      name: 'habitEnterNameHint',
      desc: '',
      args: [],
    );
  }

  // skipped getter for the '-//' key
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'uk'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}

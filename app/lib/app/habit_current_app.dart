import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/app/bloc/app_bloc.dart';
import 'package:habit_current/core/error/app_error.dart';
import 'package:habit_current/core/extension/intl_exp.dart';
import 'package:habit_current/core/router/app_router.dart';
import 'package:habit_current/core/router/app_router.gr.dart';
import 'package:habit_current/core/theme/app_theme.dart';
import 'package:habit_current/gen/app_localizations.dart';
import 'package:habit_current/ui/settings/bloc/settings_bloc.dart';

class HabitCurrentApp extends StatelessWidget {
  final AppRouter router;

  const HabitCurrentApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    final settings = context.select((SettingsBloc bloc) => bloc.state);

    return MaterialApp.router(
      onGenerateTitle: (context) => context.l10n.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: settings.theme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: settings.locale,
      localeResolutionCallback: _localeCallback,
      routerConfig: router.config(),
      builder: (context, child) {
        return BlocListener<AppBloc, AppState>(
          listener: (context, state) async {
            switch (state.status) {
              case .initial:
                log('AppInitialState', name: 'HabitCurrentApp');
                break;
              case .userLoaded:
                log('AppLoadedState: ${state.user?.name}', name: 'HabitCurrentApp');
                await router.replace(const HomeRoute());
              case .habitView:
                log('AppHabitViewState', name: 'HabitCurrentApp');
                await router.push(const HabitViewRoute());
              case .habitCreate:
                log('AppHabitCreateState', name: 'HabitCurrentApp');
                await router.push(const HabitEditRoute());
              case .habitEdit:
                log('AppHabitEditState: ${state.habitId}', name: 'HabitCurrentApp');
                await router.push(const HabitEditRoute());
              case .habitReload:
                log('AppHabitsReloadState: ${state.habitId}', name: 'HabitCurrentApp');
                break;
              case .error:
                log('AppErrorState: ${state.error}', name: 'HabitCurrentApp');
                if (state.error != null) {
                  _showAppError(context, state.error!);
                }
            }
          },
          child: child,
        );
      },
    );
  }

  Locale _localeCallback(Locale? locale, Iterable<Locale> supportedLocales) {
    if (locale == null) {
      return supportedLocales.first;
    }
    for (final supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return supportedLocale;
      }
    }
    return supportedLocales.first;
  }

  void _showAppError(BuildContext context, AppError error) {
    final strings = context.l10n;
    final theme = Theme.of(context);

    String message = switch (error) {
      UserInitialError() => strings.userInitialError,
      UserLoadingError() => strings.userLoadingError,
      UserSavingError() => strings.userSavingError,
      DatabaseError() => strings.databaseError,
      DatabaseCreatingError() => strings.databaseCreatingError,
      DatabaseLoadingError() => strings.databaseLoadingError,
      DatabaseSavingError() => strings.databaseSavingError,
      DatabaseDeletingError() => strings.databaseDeletingError,
      NotificationError() => strings.notificationError,
      SettingsLoadingError() => strings.settingsLoadingError,
      SettingsSavingError() => strings.settingsSavingError,
      UnknownError() => strings.unknownError,
    };
    if (error.message.isNotEmpty) {
      message += ':\n${error.message}';
    }
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message, style: theme.textTheme.bodySmall),
          duration: const Duration(seconds: 3),
        ),
      );
  }
}

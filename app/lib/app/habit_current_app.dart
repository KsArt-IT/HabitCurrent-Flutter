import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/app/bloc/app_bloc.dart';
import 'package:habit_current/core/error/app_error.dart';
import 'package:habit_current/core/router/app_router.dart';
import 'package:habit_current/core/router/app_router.gr.dart';
import 'package:habit_current/core/theme/app_theme.dart';
import 'package:habit_current/l10n/app_localizations.dart';
import 'package:habit_current/l10n/intl_exp.dart';
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
      locale: Locale(settings.language),
      localeResolutionCallback: (locale, supportedLocales) {
        if (locale == null) {
          return supportedLocales.first;
        }
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode &&
              supportedLocale.countryCode == locale.countryCode) {
            return supportedLocale;
          }
        }
        return supportedLocales.first;
      },
      routerConfig: router.config(),
      builder: (context, child) {
        return BlocListener<AppBloc, AppState>(
          listener: (context, state) {
            switch (state.status) {
              case AppStatus.initial:
                debugPrint('AppInitialState');
                break;
              case AppStatus.userLoaded:
                debugPrint('AppLoadedState: ${state.user?.name}');
                router.replace(const HomeRoute());
              case AppStatus.habitView:
                debugPrint('AppHabitViewState');
                router.push(const HabitViewRoute());
              case AppStatus.habitCreate:
                debugPrint('AppHabitCreateState');
                router.push(const HabitEditRoute());
              case AppStatus.habitEdit:
                debugPrint('AppHabitEditState: ${state.habitId}');
                router.push(const HabitEditRoute());
              case AppStatus.habitReload:
                debugPrint('AppHabitsReloadState: ${state.habitId}');
                break;
              case AppStatus.error:
                debugPrint('AppErrorState: ${state.error}');
                if (state.error != null) {
                  showAppError(context, state.error!);
                }
            }
          },
          child: child,
        );
      },
    );
  }

  void showAppError(BuildContext context, AppError error) {
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
      UnknownError() => strings.unknownError,
    };
    if (error.message.isNotEmpty) {
      message += ":\n${error.message}";
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/app/bloc/app_bloc.dart';
import 'package:habit_current/core/router/app_router.dart';
import 'package:habit_current/core/router/app_router.gr.dart';
import 'package:habit_current/core/theme/app_theme.dart';
import 'package:habit_current/l10n/app_localizations.dart';
import 'package:habit_current/l10n/intl_exp.dart';

class HabitCurrentApp extends StatelessWidget {
  final AppRouter router;

  const HabitCurrentApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      onGenerateTitle: (context) => context.l10n.appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // TODO: get from settings
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
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
      locale: const Locale('ru'), // TODO: get from settings
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
              // TODO: отобразить ошибку;
            }
          },
          child: child,
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:habit_current/app/bloc/app_bloc.dart';
import 'package:habit_current/core/router/app_router.dart';
import 'package:habit_current/core/router/app_router.gr.dart';
import 'package:habit_current/core/theme/app_theme.dart';
import 'package:habit_current/generated/l10n.dart';

class HabitCurrentApp extends StatelessWidget {
  final AppRouter router;

  const HabitCurrentApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      onGenerateTitle: (context) => S.of(context).appTitle,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // TODO: get from settings
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      // locale: const Locale('en'), // TODO: get from settings
      routerConfig: router.config(),
      builder: (context, child) {
        return BlocListener<AppBloc, AppState>(
          listener: (context, state) {
            switch (state) {
              case AppInitialState():
                debugPrint('AppInitialState');
              // router.replace(const SplashRoute());
              case AppOnboardState():
                debugPrint('AppOnboardState');
                router.replace(const OnboardRoute());
              case AppHelloState():
                debugPrint('AppHelloState');
                router.replace(const HelloRoute());
              case AppHabitCreateState():
                debugPrint('AppHabitCreateState');
                router.push(const HabitCreateRoute());
              case AppLoadedState(name: final name):
                debugPrint('AppLoadedState: $name');
                router.replace(const HomeRoute());
              case AppErrorState(error: final error):
                debugPrint('AppErrorState: $error');
              // TO-DO: отобразить ошибку;
            }
          },
          child: child,
        );
      },
    );
  }
}

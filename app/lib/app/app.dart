import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/app/bloc/app_bloc.dart';
import 'package:habit_current/app/habit_current_app.dart';
import 'package:habit_current/core/router/app_router.dart';
import 'package:habit_current/data/repositories/local_storage_settings_repository.dart';
import 'package:habit_current/data/repositories/settings_repository.dart';
import 'package:habit_current/data/services/local_storage_settings_service.dart';
import 'package:habit_current/data/services/settings_service.dart';
import 'package:habit_current/ui/settings/bloc/settings_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends StatelessWidget {
  final AppRouter _router;
  final SharedPreferences _preferences;

  const App({
    super.key,
    required AppRouter router,
    required SharedPreferences preferences,
  }) : _preferences = preferences,
       _router = router;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SettingsRepository>(
          create: (context) {
            final SettingsService service = LocalStorageSettingsService(
              preferences: _preferences,
            );
            return LocalStorageSettingsRepository(service: service);
          },
          // dispose: (context, repository) => repository.close(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppBloc>(
            lazy: false,
            create: (context) {
              final SettingsRepository settingsRepository =
                  context.read<SettingsRepository>();
              final appBloc = AppBloc(settingsRepository: settingsRepository)
                ..add(AppLoadNameEvent());
              return appBloc;
            },
          ),
          BlocProvider<SettingsBloc>(
            lazy: true,
            create:
                (context) => SettingsBloc(
                  settingsRepository: context.read<SettingsRepository>(),
                ),
          ),
        ],
        child: HabitCurrentApp(router: _router),
      ),
    );
  }
}

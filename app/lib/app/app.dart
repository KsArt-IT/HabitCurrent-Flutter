import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/app/bloc/app_bloc.dart';
import 'package:habit_current/app/habit_current_app.dart';
import 'package:habit_current/core/router/app_router.dart';
import 'package:habit_current/data/repositories/data/data_repository.dart';
import 'package:habit_current/data/repositories/data/local_data_repository.dart';
import 'package:habit_current/data/repositories/settings/local_storage_settings_repository.dart';
import 'package:habit_current/data/repositories/settings/settings_repository.dart';
import 'package:habit_current/data/services/data/data_service.dart';
import 'package:habit_current/data/services/settings/settings_service.dart';
import 'package:habit_current/ui/settings/bloc/settings_bloc.dart';

class App extends StatelessWidget {
  final AppRouter _router;

  const App({super.key, required AppRouter router}) : _router = router;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SettingsRepository>(
          create: (context) {
            final SettingsService service = context.read<SettingsService>();
            return LocalStorageSettingsRepository(service: service);
          },
        ),
        RepositoryProvider<DataRepository>(
          create: (context) {
            final DataService service = context.read<DataService>();
            return LocalDataRepository(service: service);
          },
          dispose: (repository) => repository.close(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppBloc>(
            lazy: false,
            create: (context) {
              final SettingsRepository settingsRepository =
                  context.read<SettingsRepository>();
              final DataRepository dataRepository =
                  context.read<DataRepository>();

              final appBloc = AppBloc(
                settingsRepository: settingsRepository,
                dataRepository: dataRepository,
              );

              return appBloc..add(AppLoadNameEvent());
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

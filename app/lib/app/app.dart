import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/app/bloc/app_bloc.dart';
import 'package:habit_current/app/habit_current_app.dart';
import 'package:habit_current/core/router/app_router.dart';
import 'package:habit_current/data/repositories/data/data_repository.dart';
import 'package:habit_current/data/repositories/data/local_data_repository.dart';
import 'package:habit_current/data/repositories/notification/local_notification_repository.dart';
import 'package:habit_current/data/repositories/notification/notification_repository.dart';
import 'package:habit_current/data/repositories/settings/local_settings_repository.dart';
import 'package:habit_current/data/repositories/settings/settings_repository.dart';
import 'package:habit_current/data/services/data/data_service.dart';
import 'package:habit_current/data/services/notification/notification_service.dart';
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
          create:
              (context) => LocalSettingsRepository(
                service: context.read<SettingsService>(),
              ),
        ),
        RepositoryProvider<DataRepository>(
          create:
              (context) =>
                  LocalDataRepository(service: context.read<DataService>()),
          dispose: (repository) => repository.close(),
        ),
        RepositoryProvider<NotificationRepository>(
          create:
              (context) => LocalNotificationRepository(
                service: context.read<DataService>(),
                notification: context.read<NotificationService>(),
              ),
          dispose: (repository) => repository.close(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppBloc>(
            lazy: false,
            create:
                (context) => AppBloc(
                  dataRepository: context.read<DataRepository>(),
                  notificationRepository:
                      context.read<NotificationRepository>(),
                )..add(AppInitialEvent()),
          ),
          BlocProvider<SettingsBloc>(
            lazy: true,
            create:
                (context) => SettingsBloc(
                  settingsRepository: context.read<SettingsRepository>(),
                )..add(SettingsLoadEvent()),
          ),
        ],
        child: HabitCurrentApp(router: _router),
      ),
    );
  }
}

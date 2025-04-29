import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/app/app.dart';
import 'package:habit_current/app/app_bloc_observer.dart';
import 'package:habit_current/core/router/app_router.dart';
import 'package:habit_current/data/database/database.dart';
import 'package:habit_current/data/services/data/data_service.dart';
import 'package:habit_current/data/services/data/local_data_service.dart';
import 'package:habit_current/data/services/settings/local_settings_service.dart';
import 'package:habit_current/data/services/settings/settings_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();
  // Navigation
  final router = AppRouter();
  // SharedPreferences for settings
  final preferences = await SharedPreferences.getInstance();
  // Database
  final database = AppDatabase();
  assert(() {
    getApplicationDocumentsDirectory().then((dir) {
      print('--------------------------------');
      print(dir);
      print('--------------------------------');
    });
    return true;
  }());
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<DataService>(
          create: (_) => LocalDataService(database: database),
        ),
        RepositoryProvider<SettingsService>(
          create: (_) => LocalSettingsService(preferences: preferences),
        ),
      ],
      child: App(router: router),
    ),
  );
}

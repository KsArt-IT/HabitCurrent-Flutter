import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/app/app.dart';
import 'package:habit_current/app/app_bloc_observer.dart';
import 'package:habit_current/core/router/app_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();
  // Navigation
  final router = AppRouter();
  // SharedPreferences for settings
  final preferences = await SharedPreferences.getInstance();

  runApp(App(router: router, preferences: preferences));
}

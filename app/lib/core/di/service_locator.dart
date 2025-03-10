import 'package:get_it/get_it.dart';
import 'package:habit_current/core/router/app_router.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // AppRouter
  getIt.registerLazySingleton<AppRouter>(() => AppRouter());
}

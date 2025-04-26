import 'package:auto_route/auto_route.dart';
import 'package:habit_current/core/router/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
final class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: SplashRoute.page,
      initial: true,
      path: '/', //
    ),
    AutoRoute(
      page: OnboardRoute.page,
      path: '/${OnboardRoute.name}', //
    ),
    AutoRoute(
      page: HelloRoute.page,
      path: '/${HelloRoute.name}', //
    ),
    AutoRoute(
      page: HabitCreateRoute.page,
      path: '/${HabitCreateRoute.name}', //
    ),
    AutoRoute(
      page: HabitViewRoute.page,
      path: '/${HabitViewRoute.name}', //
    ),
    AutoRoute(
      page: HomeRoute.page,
      // initial: false,
      // path: HomeRoute.name,
      children: [
        AutoRoute(page: HabitFlowRoute.page),
        AutoRoute(page: HabitWeekRoute.page),
        AutoRoute(page: HabitMonthRoute.page),
        AutoRoute(page: SettingsRoute.page),
      ],
    ),
  ];
}
/*
dart run build_runner build
*/
import 'package:auto_route/auto_route.dart';
import 'package:habit_current/core/router/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
final class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: InitialRoute.page,
      initial: true,
      path: '/',
      children: [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: OnboardRoute.page),
        AutoRoute(page: HelloRoute.page),
      ],
    ),
    AutoRoute(
      page: OnboardRoute.page,
      path: '/${OnboardRoute.name}',
    ),
    AutoRoute(
      page: HelloRoute.page,
      path: '/${HelloRoute.name}',
    ),
    AutoRoute(
      page: HabitEditRoute.page,
      path: '/${HabitEditRoute.name}',
    ),
    AutoRoute(
      page: HabitViewRoute.page,
      path: '/${HabitViewRoute.name}',
    ),
    AutoRoute(
      page: HomeRoute.page,
      path: '/${HomeRoute.name}',
      children: [
        AutoRoute(page: HabitFlowRoute.page, initial: true),
        AutoRoute(page: HabitWeekRoute.page),
        AutoRoute(page: HabitMonthRoute.page),
        AutoRoute(page: SettingsRoute.page),
      ],
    ),
  ];
}

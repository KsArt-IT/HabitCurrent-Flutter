import 'package:auto_route/auto_route.dart';
import 'package:habit_current/core/router/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: HomeRoute.page,
      initial: true,
      path: '/',
      children: [
        AutoRoute(page: HabitFlowRoute.page),
        AutoRoute(page: HabitWeekRoute.page),
        AutoRoute(page: HabitMonthRoute.page),
        AutoRoute(page: SettingsRoute.page),
      ],
    ),
  ];
}

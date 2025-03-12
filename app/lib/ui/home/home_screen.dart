import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:habit_current/core/router/app_router.gr.dart';
import 'package:habit_current/generated/l10n.dart';
import 'package:habit_current/ui/home/home_tab.dart';
import 'package:habit_current/ui/home/widget/tab_item_button.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [
        HabitFlowRoute(),
        HabitWeekRoute(),
        HabitMonthRoute(),
        SettingsRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = context.tabsRouter;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text('Name'),
            centerTitle: true,
          ),
          body: child,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(),
            key: const Key('homeView_add_floatingActionButton'),
            onPressed: () => {},
            tooltip: 'Add a new habit',
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TabItemButton(
                  tab: HomeTab.flow,
                  active: tabsRouter.activeIndex,
                  onTap: tabsRouter.setActiveIndex,
                ),
                TabItemButton(
                  tab: HomeTab.week,
                  active: tabsRouter.activeIndex,
                  onTap: tabsRouter.setActiveIndex,
                ),
                SizedBox(width: 48),
                TabItemButton(
                  tab: HomeTab.month,
                  active: tabsRouter.activeIndex,
                  onTap: tabsRouter.setActiveIndex,
                ),
                TabItemButton(
                  tab: HomeTab.settings,
                  active: tabsRouter.activeIndex,
                  onTap: tabsRouter.setActiveIndex,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

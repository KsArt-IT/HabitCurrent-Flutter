import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:habit_current/core/router/app_router.gr.dart';
import 'package:habit_current/core/utils/constants.dart';
import 'package:habit_current/generated/l10n.dart';
import 'package:habit_current/ui/home/home_tab.dart';
import 'package:habit_current/ui/home/widget/tab_item_button.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [HabitFlowRoute(), HabitWeekRoute(), HabitMonthRoute(), SettingsRoute()],
      builder: (context, child) {
        final tabsRouter = context.tabsRouter;
        final theme = Theme.of(context);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: theme.colorScheme.inversePrimary,
            title: Text(S.of(context).appTitle),
            centerTitle: true,
          ),
          body: child,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(),
            key: const Key('homeView_add_floatingActionButton'),
            onPressed: _onAddHabit,
            tooltip: S.of(context).addNewHabit,
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: BottomAppBar(
            padding: const EdgeInsets.all(0),
            // color: theme.colorScheme.surface,
            // elevation: 8,
            // notchMargin: 0,
            shape: const CircularNotchedRectangle(),
            child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: _buildNavigationItems(tabsRouter)),
          ),
        );
      },
    );
  }

  void _onAddHabit() {
    // TODO: Implement habit creation
  }

  List<Widget> _buildNavigationItems(TabsRouter tabsRouter) {
    return [
      TabItemButton(tab: HomeTab.flow, active: tabsRouter.activeIndex, onTap: tabsRouter.setActiveIndex),
      TabItemButton(tab: HomeTab.week, active: tabsRouter.activeIndex, onTap: tabsRouter.setActiveIndex),
      SizedBox(width: AppConstants.fabSpacing),
      TabItemButton(tab: HomeTab.month, active: tabsRouter.activeIndex, onTap: tabsRouter.setActiveIndex),
      TabItemButton(tab: HomeTab.settings, active: tabsRouter.activeIndex, onTap: tabsRouter.setActiveIndex),
    ];
  }
}

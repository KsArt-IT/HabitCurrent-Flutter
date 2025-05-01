import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/app/bloc/app_bloc.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/core/router/app_router.gr.dart';
import 'package:habit_current/l10n/intl_exp.dart';
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
        final theme = Theme.of(context);
        final strings = context.l10n;

        return Scaffold(
          appBar: AppBar(
            title: Text(strings.appTitle, style: theme.textTheme.titleLarge),
            centerTitle: true,
          ),
          body: child,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            shape: const CircleBorder(),
            key: const Key('homeView_add_floatingActionButton'),
            onPressed: () {
              context.read<AppBloc>().add(AppHabitCreateEvent());
            },
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
            tooltip: strings.addNewHabit,
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: BottomAppBar(
            padding: EdgeInsets.zero,
            color: theme.colorScheme.surface,
            shape: const CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _buildNavigationItems(tabsRouter),
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildNavigationItems(TabsRouter tabsRouter) {
    return [
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
      SizedBox(width: Constants.fabSpacing),
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
    ];
  }
}

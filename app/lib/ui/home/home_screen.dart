import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:habit_current/core/router/app_router.gr.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text('Name'),
            centerTitle: false,
            actions: [
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () => {},
              ),
            ],
          ),
          body: child,
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: theme.colorScheme.primary,
            unselectedItemColor: theme.colorScheme.onSurface,
            backgroundColor: theme.colorScheme.surface,
            currentIndex: tabsRouter.activeIndex,
            onTap: tabsRouter.setActiveIndex,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home), 
                label: 'Home'
                ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_today),
                label: 'Week',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_view_month),
                label: 'Month',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => {},
            tooltip: 'Increment',
            child: const Icon(Icons.add),
            
          ),
        );
      },
    );
  }
}

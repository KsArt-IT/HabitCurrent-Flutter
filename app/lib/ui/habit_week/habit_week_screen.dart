import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HabitWeekScreen extends StatelessWidget {
  const HabitWeekScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Week', style: Theme.of(context).textTheme.headlineMedium),
        ],
      ),
    );
  }
}

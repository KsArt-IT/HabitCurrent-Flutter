import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HabitMonthScreen extends StatelessWidget {
  const HabitMonthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Month', style: Theme.of(context).textTheme.headlineMedium),
        ],
      ),
    );
  }
}

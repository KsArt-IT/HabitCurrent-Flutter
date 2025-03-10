import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class HabitFlowScreen extends StatelessWidget {
  const HabitFlowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Flow', style: Theme.of(context).textTheme.headlineMedium),
        ],
      ),
    );
  }
}

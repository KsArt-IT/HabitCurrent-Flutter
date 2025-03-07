import 'package:flutter/material.dart';
import 'package:habit_current/features/ui/habit_flow_screen.dart';

class HabitCurrentApp extends StatelessWidget {
  const HabitCurrentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Habit Current',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HabitFlowScreen(title: 'Habit Flow'),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/ui/habit_create/widget/habit_name_edit.dart';

@RoutePage()
class HabitCreateScreen extends StatelessWidget {
  const HabitCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(S.of(context).createHabit),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.router.pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              HabitNameEdit(onChanged: (value) {}),
              const SizedBox(height: Constants.paddingMedium),
            ],
          ),
        ),
      ),
    );
  }
}

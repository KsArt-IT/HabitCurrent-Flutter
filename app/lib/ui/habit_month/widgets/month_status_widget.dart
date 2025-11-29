import 'package:flutter/material.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/models/habit_day_status.dart';
import 'package:habit_current/ui/habit_week/widgets/habit_status_widget.dart';

class MonthStatusWidget extends StatelessWidget {
  final List<List<HabitDayStatus>> weeksStatus;

  const MonthStatusWidget({super.key, required this.weeksStatus});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: weeksStatus.map((week) {
        return Padding(
          padding: const .symmetric(
            vertical: Constants.paddingSmaller,
          ),
          child: HabitStatusWidget(weekStatus: week),
        );
      }).toList(),
    );
  }
}

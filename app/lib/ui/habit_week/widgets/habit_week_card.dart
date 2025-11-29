import 'package:flutter/material.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/models/habit_week.dart';
import 'package:habit_current/ui/habit_week/widgets/habit_status_widget.dart';
import 'package:habit_current/ui/habit_week/widgets/week_days_widget.dart';
import 'package:habit_current/ui/widgets/popup_menu/habit_popup_menu.dart';

class HabitWeekCard extends StatelessWidget {
  final HabitWeek habitWeek;

  const HabitWeekCard({super.key, required this.habitWeek});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const .symmetric(vertical: Constants.paddingSmall),
      padding: const .fromLTRB(0, 0, 0, Constants.paddingMedium),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: .circular(Constants.borderRadius),
      ),
      child: Column(
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          Row(
            mainAxisAlignment: .spaceBetween,
            mainAxisSize: .min,
            children: [
              const SizedBox(width: Constants.paddingMedium),
              Expanded(
                child: Text(
                  habitWeek.name,
                  style: theme.textTheme.titleMedium,
                  maxLines: 1,
                  overflow: .ellipsis,
                ),
              ),
              HabitPopupMenu(habitId: habitWeek.id),
            ],
          ),
          Padding(
            padding: const .symmetric(
              horizontal: Constants.paddingMedium,
            ),
            child: Column(
              children: [
                const WeekDaysWidget(),
                const SizedBox(height: Constants.paddingMedium),
                HabitStatusWidget(weekStatus: habitWeek.weekStatus),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

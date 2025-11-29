import 'package:flutter/material.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/models/habit_month.dart';
import 'package:habit_current/ui/habit_month/widgets/month_status_widget.dart';
import 'package:habit_current/ui/widgets/popup_menu/habit_popup_menu.dart';

class HabitMonthCard extends StatelessWidget {
  const HabitMonthCard({super.key, required this.habitMonth});

  final HabitMonth habitMonth;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const .symmetric(vertical: Constants.paddingSmall),
      padding: const .fromLTRB(0, 0, 0, Constants.paddingAdjust),
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
                  habitMonth.name,
                  style: theme.textTheme.titleMedium,
                  maxLines: 1,
                  overflow: .ellipsis,
                ),
              ),
              HabitPopupMenu(habitId: habitMonth.id),
            ],
          ),
          // const SizedBox(height: Constants.paddingSmall),
          Padding(
            padding: const .symmetric(horizontal: Constants.paddingMedium),
            child: MonthStatusWidget(weeksStatus: habitMonth.habitStatus),
          ),
        ],
      ),
    );
  }
}

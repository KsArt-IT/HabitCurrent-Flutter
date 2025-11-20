import 'package:flutter/material.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/models/habit.dart';
import 'package:habit_current/ui/widgets/popup_menu/habit_popup_menu.dart';

class HabitFlowCard extends StatelessWidget {
  final Habit habit;
  final VoidCallback onPressed;

  const HabitFlowCard({
    super.key,
    required this.habit,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(Constants.borderRadius),
      child: Ink(
        padding: const EdgeInsets.fromLTRB(
          Constants.paddingMedium,
          Constants.paddingMedium,
          Constants.paddingSmall,
          Constants.paddingSmall,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(Constants.borderRadius),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    habit.name,
                    style: theme.textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                HabitPopupMenu(habitId: habit.id),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${habit.completedIntervals.length}/${habit.intervals.length}',
                  style: theme.textTheme.displayMedium,
                ),
                IconButton(
                  padding: const EdgeInsets.all(Constants.paddingMedium),
                  onPressed: onPressed,
                  color: theme.colorScheme.onPrimaryFixed,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      theme.colorScheme.secondaryFixed,
                    ),
                  ),
                  icon: const Icon(size: Constants.iconSize, Icons.north_east),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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
      borderRadius: .circular(Constants.borderRadius),
      child: Ink(
        padding: const .fromLTRB(
          Constants.paddingMedium,
          Constants.paddingMedium,
          Constants.paddingSmall,
          Constants.paddingSmall,
        ),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: .circular(Constants.borderRadius),
        ),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    habit.name,
                    style: theme.textTheme.titleMedium,
                    maxLines: 1,
                    overflow: .ellipsis,
                  ),
                ),
                HabitPopupMenu(habitId: habit.id),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  '${habit.completedIntervals.length}/${habit.intervals.length}',
                  style: theme.textTheme.displayMedium,
                ),
                IconButton(
                  padding: const .all(Constants.paddingMedium),
                  onPressed: onPressed,
                  color: theme.colorScheme.onPrimaryFixed,
                  style: .new(backgroundColor: .all(theme.colorScheme.secondaryFixed)),
                  icon: const Icon(Icons.north_east, size: Constants.iconSize),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/l10n/intl_exp.dart';
import 'package:habit_current/models/habit.dart';

class HabitFlowCard extends StatelessWidget {
  final Habit habit;
  final VoidCallback onPressed;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const HabitFlowCard({
    super.key,
    required this.habit,
    required this.onDelete,
    required this.onEdit,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.l10n;

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
                PopupMenuButton<String>(
                  icon: Icon(
                    Icons.more_horiz,
                    color: theme.colorScheme.secondaryFixed,
                    size: Constants.iconSize,
                  ),
                  itemBuilder:
                      (context) => [
                        PopupMenuItem(
                          onTap: onEdit,
                          child: Text(
                            strings.edit,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                        PopupMenuItem(
                          onTap: onDelete,
                          child: Text(
                            strings.delete,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      ],
                ),
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
                  padding: EdgeInsets.all(Constants.paddingMedium),
                  onPressed: onPressed,
                  color: theme.colorScheme.onPrimaryFixed,
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      theme.colorScheme.secondaryFixed,
                    ),
                  ),
                  icon: Icon(size: Constants.iconSize, Icons.north_east),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

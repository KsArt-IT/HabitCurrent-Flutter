import 'package:flutter/material.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/l10n/intl_exp.dart';
import 'package:habit_current/models/habit.dart';

class HabitFlowItem extends StatelessWidget {
  final Habit habit;

  const HabitFlowItem({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.l10n;

    return InkWell(
      onTap: () {
        // context.read<HabitFlowBloc>().add(
        //   CompleteHabitIntervalEvent(habitId: habit.id),
        // );
      },
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
                    color: theme.colorScheme.onPrimary,
                    size: Constants.iconSize,
                  ),
                  itemBuilder:
                      (context) => [
                        PopupMenuItem(
                          value: 'edit',
                          child: Text(
                            strings.edit,
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                        PopupMenuItem(
                          value: 'delete',
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
                  onPressed: () {},
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

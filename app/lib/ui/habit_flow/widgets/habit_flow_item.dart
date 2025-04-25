import 'package:flutter/material.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/models/habit.dart';

class HabitFlowItem extends StatelessWidget {
  final Habit habit;

  const HabitFlowItem({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: InkWell(
        onTap: () {
          // context.read<HabitFlowBloc>().add(
          //   CompleteHabitIntervalEvent(habitId: habit.id),
          // );
        },
        borderRadius: BorderRadius.circular(Constants.borderRadius),
        child: Padding(
          padding: const EdgeInsets.all(Constants.paddingMedium),
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
                      Icons.more_vert,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    itemBuilder:
                        (context) => [
                          PopupMenuItem(
                            value: 'edit',
                            child: Text('Редактировать'),
                          ),
                          PopupMenuItem(
                            value: 'delete',
                            child: Text('Удалить'),
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
                    style: theme.textTheme.titleMedium,
                  ),
                  IconButton(
                    padding: EdgeInsets.all(16),
                    color: theme.colorScheme.inversePrimary,
                    onPressed: () {},
                    icon: Icon(
                      size: 24,
                      Icons.arrow_forward,
                      color: theme.colorScheme.onPrimaryFixed,
                    ),
                  ),
                  // Container(
                  //   width: 40,
                  //   height: 40,
                  //   decoration: BoxDecoration(
                  //     color: theme.colorScheme.primaryContainer,
                  //     shape: BoxShape.circle,
                  //   ),
                  //   child: Icon(
                  //     Icons.arrow_forward,
                  //     color: theme.colorScheme.onPrimaryContainer,
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/l10n/intl_exp.dart';
import 'package:habit_current/ui/habit_week/bloc/habit_week_bloc.dart';
import 'package:habit_current/ui/habit_week/widgets/week_days_widget.dart';
import 'package:habit_current/ui/habit_week/widgets/week_status_widget.dart';

class HabitWeekCard extends StatelessWidget {
  final String name;
  final List<WeekStatus> weekStatus;

  const HabitWeekCard({
    super.key,
    required this.name,
    required this.weekStatus,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.l10n;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: Constants.paddingSmall),
      padding: const EdgeInsets.fromLTRB(0, 0, 0, Constants.paddingMedium),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(Constants.borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(width: Constants.paddingMedium),
              Expanded(
                child: Text(
                  name,
                  style: theme.textTheme.titleMedium,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              PopupMenuButton<String>(
                padding: EdgeInsets.zero,
                icon: Icon(
                  Icons.more_horiz,
                  color: theme.colorScheme.onPrimary,
                  size: Constants.iconSize,
                ),
                itemBuilder:
                    (context) => [
                      PopupMenuItem(
                        onTap: () {},
                        child: Text(
                          strings.edit,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                      PopupMenuItem(
                        onTap: () {},
                        child: Text(
                          strings.delete,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ],
              ),
            ],
          ),
          // const SizedBox(height: Constants.paddingSmall),
          const WeekDaysWidget(),
          const SizedBox(height: Constants.paddingMedium),
          WeekStatusWidget(weekStatus: weekStatus),
        ],
      ),
    );
  }
}

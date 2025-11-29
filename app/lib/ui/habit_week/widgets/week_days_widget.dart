import 'package:flutter/material.dart';
import 'package:habit_current/core/extension/intl_exp.dart';
import 'package:habit_current/models/weekdays.dart';

class WeekDaysWidget extends StatelessWidget {
  const WeekDaysWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.titleSmall?.copyWith(
      color: theme.colorScheme.onSecondary,
    );
    final l10n = context.l10n;

    return Row(
      mainAxisAlignment: .spaceEvenly,
      children: WeekDays.values
          .map(
            (day) => Expanded(
              child: Text(day.getShortDayName(l10n), textAlign: .center, style: textStyle),
            ),
          )
          .toList(),
    );
  }
}

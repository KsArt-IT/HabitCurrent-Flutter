import 'package:flutter/material.dart';
import 'package:habit_current/models/weekdays.dart';

class WeekDaysWidget extends StatelessWidget {
  const WeekDaysWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
      color: Theme.of(context).colorScheme.onSecondary,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:
          WeekDays.values
              .map(
                (day) => Expanded(
                  child: Text(
                    day.getShortDayName(context),
                    textAlign: TextAlign.center,
                    style: textStyle,
                  ),
                ),
              )
              .toList(),
    );
  }
}

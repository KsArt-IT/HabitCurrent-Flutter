import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/l10n/intl_exp.dart';
import 'package:habit_current/ui/habit_create/bloc/habit_create_bloc.dart';

class FrequencySelector extends StatelessWidget {
  const FrequencySelector({super.key, required this.selector});
  final Widget selector;

  @override
  Widget build(BuildContext context) {
    final frequency = context.select(
      (HabitCreateBloc bloc) => bloc.state.frequency,
    );
    final strings = context.l10n;
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(Constants.paddingMedium),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(Constants.borderRadius),
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(strings.howOften, style: theme.textTheme.titleMedium),
          const SizedBox(height: Constants.paddingMedium),
          RadioListTile(
            title: Text(
              strings.daily,
              style:
                  frequency == Frequency.daily
                      ? theme.textTheme.titleSmall?.copyWith(
                        color: theme.colorScheme.primaryFixed,
                      )
                      : theme.textTheme.titleSmall,
            ),
            contentPadding: const EdgeInsets.all(0),
            controlAffinity: ListTileControlAffinity.leading,
            radioScaleFactor: 1.2,
            value: Frequency.daily,
            groupValue: frequency,
            onChanged: (value) {
              context.read<HabitCreateBloc>().add(
                DailyOrWeekToggledEvent(value),
              );
            },
          ),
          RadioListTile(
            title: Text(
              strings.yourSchedule,
              style:
                  frequency == Frequency.weekly
                      ? theme.textTheme.titleSmall?.copyWith(
                        color: theme.colorScheme.primaryFixed,
                      )
                      : theme.textTheme.titleSmall,
            ),
            contentPadding: const EdgeInsets.all(0),
            controlAffinity: ListTileControlAffinity.leading,
            radioScaleFactor: 1.2,
            value: Frequency.weekly,
            groupValue: frequency,
            onChanged: (value) {
              context.read<HabitCreateBloc>().add(
                DailyOrWeekToggledEvent(value),
              );
            },
          ),
          if (frequency == Frequency.weekly)
            const SizedBox(height: Constants.paddingMedium),
          if (frequency == Frequency.weekly) selector,
        ],
      ),
    );
  }
}

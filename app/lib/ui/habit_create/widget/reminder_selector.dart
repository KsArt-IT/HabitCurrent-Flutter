import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/l10n/intl_exp.dart';
import 'package:habit_current/ui/habit_create/bloc/habit_create_bloc.dart';

class ReminderSelector extends StatelessWidget {
  const ReminderSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final isReminder = context.select(
      (HabitCreateBloc bloc) => bloc.state.isReminder,
    );
    final strings = context.l10n;
    final theme = Theme.of(context);

    RadioListTile radioListTile({required String title, required bool value}) {
      return RadioListTile(
        title: Text(
          title,
          style:
              isReminder
                  ? theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.primaryFixed,
                  )
                  : theme.textTheme.titleSmall,
        ),
        visualDensity: VisualDensity.compact,
        dense: true,
        contentPadding: const EdgeInsets.all(0),
        controlAffinity: ListTileControlAffinity.leading,
        radioScaleFactor: 1.2,
        value: value,
        groupValue: isReminder,
        onChanged: (value) {
          context.read<HabitCreateBloc>().add(ReminderToggledEvent(value));
        },
      );
    }

    return Container(
      padding: const EdgeInsets.all(Constants.paddingMedium),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(Constants.borderRadius),
      ),

      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(strings.reminder, style: theme.textTheme.titleMedium),
          const SizedBox(height: Constants.paddingMedium),
          radioListTile(title: strings.withoutReminder, value: false),
          radioListTile(title: strings.enableReminders, value: true),
        ],
      ),
    );
  }
}

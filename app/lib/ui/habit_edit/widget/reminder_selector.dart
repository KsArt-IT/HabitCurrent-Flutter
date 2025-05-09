import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/l10n/intl_exp.dart';
import 'package:habit_current/ui/habit_edit/bloc/habit_edit_bloc.dart';

class ReminderSelector extends StatelessWidget {
  const ReminderSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final reminder = context.select(
      (HabitEditBloc bloc) => bloc.state.reminder,
    );
    final strings = context.l10n;
    final theme = Theme.of(context);

    RadioListTile radioListTile({
      required String title,
      required Reminder value,
    }) {
      return RadioListTile(
        title: Text(
          title,
          style:
              reminder == value
                  ? theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.primaryFixed,
                  )
                  : theme.textTheme.titleSmall,
        ),
        visualDensity: VisualDensity.compact,
        dense: true,
        contentPadding: EdgeInsets.zero,
        controlAffinity: ListTileControlAffinity.leading,
        radioScaleFactor: 1.2,
        value: value,
        groupValue: reminder,
        onChanged: (value) {
          context.read<HabitEditBloc>().add(ToggleReminderEvent(value));
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
          radioListTile(
            title: strings.withoutReminder,
            value: Reminder.disabled,
          ),
          radioListTile(
            title: strings.enableReminders,
            value: Reminder.enabled,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/core/extension/intl_exp.dart';
import 'package:habit_current/ui/habit_edit/bloc/habit_edit_bloc.dart';
import 'package:habit_current/ui/widgets/text_form_title.dart';

class FrequencySelector extends StatelessWidget {
  const FrequencySelector({super.key, required this.selectorDays});
  final Widget selectorDays;

  @override
  Widget build(BuildContext context) {
    final frequency = context.select(
      (HabitEditBloc bloc) => bloc.state.frequency,
    );
    final strings = context.l10n;
    final theme = Theme.of(context);

    RadioListTile radioListTile({
      required String title,
      required Frequency value,
    }) {
      return RadioListTile(
        title: Text(
          title,
          style: frequency == value
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
        groupValue: frequency,
        onChanged: (value) {
          context.read<HabitEditBloc>().add(ToggleDailyOrWeekEvent(value));
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
          TextFormTitle(strings.howOften),
          const SizedBox(height: Constants.paddingMedium),
          radioListTile(title: strings.daily, value: Frequency.daily),
          radioListTile(title: strings.yourSchedule, value: Frequency.weekly),
          if (frequency == Frequency.weekly) const SizedBox(height: Constants.paddingMedium),
          if (frequency == Frequency.weekly) selectorDays,
        ],
      ),
    );
  }
}

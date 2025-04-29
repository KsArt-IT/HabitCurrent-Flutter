import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/l10n/intl_exp.dart';
import 'package:habit_current/models/weekdays.dart';
import 'package:habit_current/ui/habit_edit/bloc/habit_edit_bloc.dart';

class WeekDaysSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weekDays = context.select(
      (HabitEditBloc bloc) => bloc.state.weekDays,
    );
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.l10n.chooseDay, style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 4,
          ),
          padding: const EdgeInsets.all(0),
          itemCount: WeekDays.values.length,
          itemBuilder: (context, index) {
            final day = WeekDays.values[index];
            final isSelected = weekDays.contains(day);
            return CheckboxListTile(
              title: Text(
                day.getDayName(context),
                style:
                    isSelected
                        ? theme.textTheme.titleSmall?.copyWith(
                          color: theme.colorScheme.primaryFixed,
                        )
                        : theme.textTheme.titleSmall,
              ),
              value: isSelected,
              contentPadding: const EdgeInsets.all(0),
              controlAffinity: ListTileControlAffinity.leading,
              onChanged: (_) {
                context.read<HabitEditBloc>().add(ChangeWeekDayEvent(day));
              },
            );
          },
        ),
      ],
    );
  }
}

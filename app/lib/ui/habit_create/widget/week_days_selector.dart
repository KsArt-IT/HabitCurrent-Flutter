import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/l10n/intl_exp.dart';
import 'package:habit_current/models/weekdays.dart';
import 'package:habit_current/ui/habit_create/bloc/habit_create_bloc.dart';

class WeekDaysSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final weekDays = context.select(
      (HabitCreateBloc bloc) => bloc.state.weekDays,
    );
    final theme = Theme.of(context);
    final strings = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.l10n.chooseDay, style: theme.textTheme.titleMedium),
        const SizedBox(height: 8),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          padding: const EdgeInsets.all(0),
          childAspectRatio: 4,
          children:
              WeekDays.values.map((day) {
                final isSelected = weekDays.contains(day);
                return CheckboxListTile(
                  title: Text(
                    day.name,
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
                  onChanged:
                      (_) => context.read<HabitCreateBloc>().add(
                        WeekDayChangedEvent(day),
                      ),
                );
              }).toList(),
        ),
      ],
    );
  }
}

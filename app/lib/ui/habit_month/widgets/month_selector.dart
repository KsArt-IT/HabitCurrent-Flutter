import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/ui/habit_month/bloc/habit_month_bloc.dart';
import 'package:intl/intl.dart';

class MonthSelector extends StatelessWidget {
  const MonthSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<HabitMonthBloc, HabitMonthState>(
      buildWhen: (previous, current) => previous.selectedMonth != current.selectedMonth,
      builder: (context, state) {
        final selectedMonth = state.selectedMonth;
        final previousMonth = DateTime(
          selectedMonth.year,
          selectedMonth.month - 1,
        );
        final nextMonth = DateTime(selectedMonth.year, selectedMonth.month + 1);
        final isFirstMonth = selectedMonth.month == 1;
        final isLastMonth = selectedMonth.month == 12;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
              color: theme.colorScheme.onPrimary,
              icon: const Icon(Icons.chevron_left),
              onPressed:
                  isFirstMonth
                      ? null
                      : () {
                        context.read<HabitMonthBloc>().add(
                          ChangeMonthHabitEvent(previousMonth),
                        );
                      },
            ),
            if (isFirstMonth) const SizedBox(width: 50)
            else
              SizedBox(
                width: 50,
                child: Text(
                  DateFormat('MMM').format(previousMonth),
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onTertiaryFixed,
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            SizedBox(
              width:50,
              child: Text(
                DateFormat('MMM').format(selectedMonth),
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (isLastMonth) const SizedBox(width: 50)
            else
              SizedBox(
                width: 50,
                child: Text(
                  DateFormat('MMM').format(nextMonth),
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.onTertiaryFixed,
                  fontWeight: FontWeight.w300,
                ),
                  textAlign: TextAlign.center,
                ),
              ),
            IconButton(
              color: theme.colorScheme.onPrimary,
              icon: const Icon(Icons.chevron_right),
              onPressed:
                  isLastMonth
                      ? null
                      : () {
                        context.read<HabitMonthBloc>().add(
                          ChangeMonthHabitEvent(nextMonth),
                        );
                      },
            ),
          ],
        );
      },
    );
  }
}

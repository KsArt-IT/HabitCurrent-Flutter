import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/ui/habit_month/bloc/habit_month_bloc.dart';
import 'package:habit_current/ui/habit_month/widgets/month_name_widget.dart';
import 'package:habit_current/ui/widgets/arrow_button.dart';

class MonthSelector extends StatelessWidget {
  const MonthSelector({super.key});

  @override
  Widget build(BuildContext context) {
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
          mainAxisAlignment: .spaceBetween,
          children: [
            ArrowButton(
              // ignore: avoid_redundant_argument_values
              left: true,
              disabled: isFirstMonth,
              onPressed: () {
                context.read<HabitMonthBloc>().add(
                  ChangeMonthHabitEvent(previousMonth),
                );
              },
            ),
            MonthNameWidget(month: previousMonth, disabled: isFirstMonth),
            MonthNameWidget(month: selectedMonth, selected: true),
            MonthNameWidget(month: nextMonth, disabled: isLastMonth),
            ArrowButton(
              left: false,
              disabled: isLastMonth,
              onPressed: () {
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

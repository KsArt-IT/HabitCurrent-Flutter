import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/core/extension/int_ext.dart';
import 'package:habit_current/l10n/intl_exp.dart';
import 'package:habit_current/ui/habit_edit/bloc/habit_edit_bloc.dart';
import 'package:habit_current/ui/habit_edit/widget/time_container.dart';
import 'package:habit_current/ui/habit_edit/widget/time_picker.dart';
import 'package:habit_current/ui/widgets/sized_outlined_button.dart';
import 'package:habit_current/ui/widgets/text_form_title.dart';

class HourIntervalSelector extends StatelessWidget {
  const HourIntervalSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<HabitEditBloc>();
    final intervals = context.select((HabitEditBloc b) => b.state.intervals);

    final strings = context.l10n;
    final theme = Theme.of(context);

    Widget buildTimeContainer(
      BuildContext context,
      int time,
      Function(int) action,
    ) {
      return TimeContainer(
        time: time,
        onTap: () async {
          final pickedTime = await pickTime(
            context,
            initialTime: time.toTimeOfDay(),
          );
          if (pickedTime != null) action(pickedTime.toMinutes());
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormTitle(strings.chooseTime),
          const SizedBox(height: Constants.paddingMedium),
          Row(
            children: [
              Expanded(
                child: SizedOutlinedButton(
                  label: strings.delete,
                  disabled: intervals.length < 2,
                  negative: true,
                  onPressed: () => bloc.add(RemoveTimeIntervalEvent()),
                ),
              ),
              const SizedBox(width: Constants.paddingMedium),
              Expanded(
                child: SizedOutlinedButton(
                  label: strings.addTime,
                  disabled: intervals.length >= 12,
                  onPressed: () {
                    bloc.add(AddTimeIntervalEvent());
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: Constants.paddingMedium),
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3.0,
              crossAxisSpacing: Constants.paddingMedium,
              mainAxisSpacing: Constants.paddingSmall,
            ),
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: intervals.length,
            itemBuilder:
                (context, index) => buildTimeContainer(
                  context,
                  intervals[index].time,
                  (time) => bloc.add(
                    ChangeTimeIntervalEvent(index: index, time: time),
                  ),
                ),
          ),
        ],
      ),
    );
  }
}

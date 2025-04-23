import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/core/extension/int_ext.dart';
import 'package:habit_current/l10n/intl_exp.dart';
import 'package:habit_current/ui/habit_create/bloc/habit_create_bloc.dart';
import 'package:habit_current/ui/habit_create/widget/time_container.dart';
import 'package:habit_current/ui/habit_create/widget/time_picker.dart';
import 'package:habit_current/ui/widgets/sized_outlined_button.dart';
import 'package:habit_current/ui/widgets/text_form_title.dart';

class HourIntervalSelector extends StatelessWidget {
  const HourIntervalSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final intervals = context.select(
      (HabitCreateBloc bloc) => bloc.state.intervals,
    );
    final bloc = context.read<HabitCreateBloc>();

    final strings = context.l10n;
    final theme = Theme.of(context);

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
                  onPressed: () {
                    context.read<HabitCreateBloc>().add(TimeRemovedEvent());
                  },
                ),
              ),
              const SizedBox(width: Constants.paddingMedium),
              Expanded(
                child: SizedOutlinedButton(
                  label: strings.addTime,
                  disabled: intervals.length >= 12,
                  onPressed: () {
                    context.read<HabitCreateBloc>().add(TimeAddedEvent());
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: Constants.paddingMedium),
          GridView.count(
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: 3.0,
            crossAxisSpacing: Constants.paddingMedium,
            mainAxisSpacing: Constants.paddingSmall,
            padding: const EdgeInsets.all(0),
            physics: const NeverScrollableScrollPhysics(),
            children:
                intervals.indexed.map((indexed) {
                  final time = indexed.$2;
                  final index = indexed.$1;
                  return TimeContainer(
                    time: time,
                    onTap: () async {
                      final pickedTime = await pickTime(
                        context,
                        initialTime: time.toTimeOfDay(),
                      );

                      if (pickedTime != null) {
                        bloc.add(
                          TimeChangedEvent(
                            index: index,
                            time: pickedTime.toMinutes(),
                          ),
                        );
                      }
                    },
                  );
                }).toList(),
          ),
        ],
      ),
    );
  }
}

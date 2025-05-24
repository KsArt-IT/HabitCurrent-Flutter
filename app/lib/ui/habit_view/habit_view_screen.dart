import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/app/bloc/app_bloc.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/core/extension/int_ext.dart';
import 'package:habit_current/ui/habit_view/bloc/habit_view_bloc.dart';

@RoutePage()
class HabitViewScreen extends StatelessWidget {
  const HabitViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final habit = context.read<AppBloc>().state.habit;

    return BlocProvider(
      create:
          (context) =>
              HabitViewBloc(dataRepository: context.read(), habit: habit!),
      child: _HabitViewBody(),
    );
  }
}

class _HabitViewBody extends StatelessWidget {
  const _HabitViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final habit = context.read<HabitViewBloc>().state.habit;

    return Scaffold(
      appBar: AppBar(
        title: Text(habit.name, style: theme.textTheme.titleLarge),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: theme.colorScheme.inversePrimary,
          ),
          onPressed: () {
            context.read<AppBloc>().add(AppHabitReloadEvent(habitId: habit.id));
            context.router.pop();
          },
        ),
      ),
      body: BlocBuilder<HabitViewBloc, HabitViewState>(
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: Constants.paddingMedium,
            ),
            child: Container(
              padding: const EdgeInsets.all(Constants.paddingMedium),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(Constants.borderRadius),
              ),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 4.0,
                  crossAxisSpacing: Constants.paddingMedium,
                  mainAxisSpacing: 0,
                ),
                padding: EdgeInsets.zero,
                itemCount: state.habit.intervals.length,
                itemBuilder: (context, index) {
                  final interval = state.habit.intervals[index];
                  final isSelected = state.habit.completedIntervals.any(
                    (e) => e.intervalId == interval.id,
                  );

                  return CheckboxListTile(
                    title: Text(
                      interval.time.toTime(),
                      style:
                          isSelected
                              ? theme.textTheme.titleSmall?.copyWith(
                                color: theme.colorScheme.primaryFixed,
                              )
                              : theme.textTheme.titleSmall,
                    ),
                    contentPadding: EdgeInsets.zero,
                    controlAffinity: ListTileControlAffinity.leading,
                    visualDensity: VisualDensity.compact,
                    dense: true,
                    value: isSelected,
                    onChanged: (_) {
                      context.read<HabitViewBloc>().add(
                        HabitViewChangedEvent(index: index),
                      );
                    },
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

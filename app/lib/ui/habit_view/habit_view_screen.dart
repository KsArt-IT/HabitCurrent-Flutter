import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/app/bloc/app_bloc.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/core/extension/int_ext.dart';
import 'package:habit_current/models/habit.dart';
import 'package:habit_current/ui/habit_view/bloc/habit_view_bloc.dart';

@RoutePage()
class HabitViewScreen extends StatelessWidget {
  const HabitViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.read<AppBloc>().state;
    Habit? habit;

    if (appState is AppHabitViewState) {
      habit = appState.habit;
    }

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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.read<HabitViewBloc>().state.habit.name,
          style: theme.textTheme.titleLarge,
        ),
        centerTitle: true,
        leading: IconButton(
          color: theme.colorScheme.onPrimary,
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: theme.colorScheme.inversePrimary,
          ),
          onPressed: () {
            final habitId = context.read<HabitViewBloc>().state.habit.id;
            context.read<AppBloc>().add(AppHabitReloadEvent(habitId: habitId));
          },
        ),
      ),
      body: BlocBuilder<HabitViewBloc, HabitViewState>(
        builder: (context, state) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.all(Constants.paddingMedium),
                padding: const EdgeInsets.all(Constants.paddingMedium),
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(Constants.borderRadius),
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3.0,
                    crossAxisSpacing: Constants.paddingMedium,
                    mainAxisSpacing: Constants.paddingSmall,
                  ),
                  itemCount: state.habit.intervals.length,
                  itemBuilder: (context, index) {
                    final interval = state.habit.intervals[index];
                    final isSelected =
                        state.habit.completedIntervals
                            .where((e) => e.intervalId == interval.id)
                            .isNotEmpty;
                    return CheckboxListTile(
                      title: Text(interval.time.toTime()),
                      contentPadding: const EdgeInsets.all(0),
                      controlAffinity: ListTileControlAffinity.leading,
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
              Spacer(),
            ],
          );
        },
      ),
    );
  }
}

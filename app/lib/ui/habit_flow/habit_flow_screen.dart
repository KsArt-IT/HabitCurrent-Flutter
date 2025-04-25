import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/app/bloc/app_bloc.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/l10n/intl_exp.dart';
import 'package:habit_current/models/weekdays.dart';
import 'package:habit_current/ui/habit_flow/bloc/habit_flow_bloc.dart';
import 'package:habit_current/ui/habit_flow/widgets/habit_flow_item.dart';

@RoutePage()
class HabitFlowScreen extends StatelessWidget {
  const HabitFlowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.read<AppBloc>().state;

    int userId = 0;
    if (appState is AppLoadedState) {
      userId = appState.user.id;
    }

    return BlocProvider(
      create:
          (context) =>
              HabitFlowBloc(repository: context.read())
                ..add(LoadHabitsEvent(userId: userId)),
      child: const _HabitFlowBody(),
    );
  }
}

// MARK: - HabitFlowBody
class _HabitFlowBody extends StatelessWidget {
  const _HabitFlowBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.l10n;

    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state is AppHabitCreatedState) {
          print('_HabitFlowBody::AppHabitCreatedState');
          context.read<HabitFlowBloc>().add(HabitCreatedEvent());
        }
      },
      child: RefreshIndicator(
        onRefresh: () async {
          context.read<HabitFlowBloc>().add(RefreshHabitsEvent());
        },
        child: BlocBuilder<HabitFlowBloc, HabitFlowState>(
          builder: (context, state) {
            if (state.status == HabitFlowStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == HabitFlowStatus.error) {
              return Center(
                child: Text(
                  state.errorMessage ?? strings.errorUnknown,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
              );
            }

            if (state.habits.isEmpty) {
              return Center(
                child: Text(strings.noHabits, style: theme.textTheme.bodyLarge),
              );
            }

            // Фильтруем привычки по текущему дню недели
            final weekDay = WeekDays.today;
            final todayHabits =
                state.habits
                    .where((habit) => habit.weekDays.contains(weekDay))
                    .toList();

            if (todayHabits.isEmpty) {
              return Center(
                child: Text(
                  strings.noHabitsToday,
                  style: theme.textTheme.bodyLarge,
                ),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(Constants.paddingMedium),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: Constants.paddingMedium,
                crossAxisSpacing: Constants.paddingMedium,
                childAspectRatio: 1,
              ),
              itemCount: todayHabits.length,
              itemBuilder: (context, index) {
                final habit = todayHabits[index];
                return HabitFlowItem(habit: habit);
              },
            );
          },
        ),
      ),
    );
  }
}

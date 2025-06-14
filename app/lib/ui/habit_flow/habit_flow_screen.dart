import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/app/bloc/app_bloc.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/l10n/intl_exp.dart';
import 'package:habit_current/models/state_status.dart';
import 'package:habit_current/ui/habit_flow/bloc/habit_flow_bloc.dart';
import 'package:habit_current/ui/habit_flow/widgets/habit_flow_card.dart';

@RoutePage()
class HabitFlowScreen extends StatelessWidget {
  const HabitFlowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = context.read<AppBloc>().state.user?.id ?? 0;

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
        if (state.status == AppStatus.habitReload) {
          context.read<HabitFlowBloc>().add(
            ReloadHabitEvent(habitId: state.habitId),
          );
        }
      },
      child: RefreshIndicator(
        color: theme.colorScheme.primaryFixed,
        onRefresh: () {
          final completer = Completer<void>();
          context.read<HabitFlowBloc>().add(RefreshHabitsEvent(completer));
          return completer.future;
        },
        child: BlocBuilder<HabitFlowBloc, HabitFlowState>(
          builder: (context, state) {
            if (state.status == StateStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == StateStatus.error) {
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

            if (state.habits.isEmpty) {
              return Center(
                child: Text(
                  strings.noHabitsToday,
                  style: theme.textTheme.bodyLarge,
                ),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.fromLTRB(
                Constants.paddingMedium,
                Constants.paddingSmall,
                Constants.paddingMedium,
                Constants.paddingXLarge,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: Constants.paddingMedium,
                crossAxisSpacing: Constants.paddingMedium,
                childAspectRatio: 1.2,
              ),
              itemCount: state.habits.length,
              itemBuilder: (context, index) {
                final habit = state.habits[index];
                return HabitFlowCard(
                  habit: habit,
                  onPressed: () {
                    context.read<AppBloc>().add(
                      AppHabitViewEvent(habit: habit),
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}

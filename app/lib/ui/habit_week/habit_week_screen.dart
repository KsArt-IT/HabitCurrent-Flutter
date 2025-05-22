import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/app/bloc/app_bloc.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/l10n/intl_exp.dart';
import 'package:habit_current/models/habit_state_status.dart';
import 'package:habit_current/ui/habit_week/bloc/habit_week_bloc.dart';
import 'package:habit_current/ui/habit_week/widgets/habit_week_card.dart';

@RoutePage()
class HabitWeekScreen extends StatelessWidget {
  const HabitWeekScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = context.read<AppBloc>().state.user?.id ?? 0;

    return BlocProvider(
      create:
          (context) =>
              HabitWeekBloc(repository: context.read())
                ..add(LoadHabitWeekEvent(userId: userId)),
      child: const _HabitWeekBody(),
    );
  }
}

class _HabitWeekBody extends StatelessWidget {
  const _HabitWeekBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.l10n;

    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state.status == AppStatus.habitReload) {
          context.read<HabitWeekBloc>().add(
            ReloadHabitEvent(habitId: state.habitId),
          );
        }
      },
      child: BlocBuilder<HabitWeekBloc, HabitWeekState>(
        builder: (context, state) {
          if (state.status == HabitStateStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.completedHabits.isEmpty) {
            return Center(
              child: Text(strings.noHabits, style: theme.textTheme.bodyLarge),
            );
          }

          return RefreshIndicator(
            color: theme.colorScheme.primaryFixed,
            onRefresh: () async {
              context.read<HabitWeekBloc>().add(
                RefreshHabitWeekEvent(DateTime.now()),
              );
            },
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(
                Constants.paddingMedium,
                Constants.paddingSmall,
                Constants.paddingMedium,
                Constants.paddingXLarge,
              ),
              itemCount: state.completedHabits.length,
              itemBuilder:
                  (_, index) =>
                      HabitWeekCard(habitWeek: state.completedHabits[index]),
            ),
          );
        },
      ),
    );
  }
}

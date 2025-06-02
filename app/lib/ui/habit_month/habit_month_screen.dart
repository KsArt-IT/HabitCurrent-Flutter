import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/app/bloc/app_bloc.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/l10n/intl_exp.dart';
import 'package:habit_current/models/habit_state_status.dart';
import 'package:habit_current/ui/habit_month/bloc/habit_month_bloc.dart';
import 'package:habit_current/ui/habit_month/widgets/habit_month_card.dart';
import 'package:habit_current/ui/habit_month/widgets/month_selector.dart';

@RoutePage()
class HabitMonthScreen extends StatelessWidget {
  const HabitMonthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = context.read<AppBloc>().state.user?.id ?? 0;

    return BlocProvider(
      create:
          (_) =>
              HabitMonthBloc(repository: context.read())
                ..add(LoadHabitEvent(userId: userId)),
      child: const _HabitMonthBody(),
    );
  }
}

class _HabitMonthBody extends StatelessWidget {
  const _HabitMonthBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.l10n;

    return BlocListener<AppBloc, AppState>(
      listener: (context, state) {
        if (state.status == AppStatus.habitReload) {
          context.read<HabitMonthBloc>().add(
            ReloadHabitEvent(habitId: state.habitId),
          );
        }
      },
      child: BlocBuilder<HabitMonthBloc, HabitMonthState>(
        builder: (context, state) {
          if (state.status == HabitStateStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              MonthSelector(),
              // TODO: тут 2 надписи и статус передать за этот месяц нет или вобще нет привычек
              if (state.habits.isEmpty)
                Expanded(
                  child: Center(
                    child: Text(
                      strings.noHabits,
                      style: theme.textTheme.bodyLarge,
                    ),
                  ),
                ),
              if (state.habits.isNotEmpty)
                Expanded(
                  child: RefreshIndicator(
                    color: theme.colorScheme.primaryFixed,
                    onRefresh: () async {
                      context.read<HabitMonthBloc>().add(
                        RefreshHabitEvent(DateTime.now()),
                      );
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.fromLTRB(
                        Constants.paddingMedium,
                        Constants.paddingSmall,
                        Constants.paddingMedium,
                        Constants.paddingXLarge,
                      ),
                      itemCount: state.habits.length,
                      itemBuilder:
                          (_, index) =>
                              HabitMonthCard(habitMonth: state.habits[index]),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

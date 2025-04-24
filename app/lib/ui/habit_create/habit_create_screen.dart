import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/app/bloc/app_bloc.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/l10n/intl_exp.dart';
import 'package:habit_current/ui/habit_create/bloc/habit_create_bloc.dart';
import 'package:habit_current/ui/habit_create/widget/frequency_selector.dart';
import 'package:habit_current/ui/habit_create/widget/habit_name_edit.dart';
import 'package:habit_current/ui/habit_create/widget/hour_interval_selector.dart';
import 'package:habit_current/ui/habit_create/widget/reminder_selector.dart';
import 'package:habit_current/ui/habit_create/widget/week_days_selector.dart';
import 'package:habit_current/ui/widgets/primary_button.dart';

@RoutePage()
class HabitCreateScreen extends StatelessWidget {
  const HabitCreateScreen({super.key});

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
              HabitCreateBloc(dataRepository: context.read(), userId: userId),
      child: const _HabitCreateBody(),
    );
  }
}

class _HabitCreateBody extends StatelessWidget {
  const _HabitCreateBody({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final theme = Theme.of(context);
    final bloc = context.watch<HabitCreateBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.createHabit, style: theme.textTheme.titleLarge),
        centerTitle: true,
        leading: IconButton(
          color: theme.colorScheme.onPrimary,
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: theme.colorScheme.inversePrimary,
          ),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(Constants.paddingMedium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // MARK: - Habit name
                    HabitNameEditWidget(),
                    // MARK: - Frequency selector
                    const SizedBox(height: Constants.paddingMedium),
                    FrequencySelector(selectorDays: WeekDaysSelector()),
                    // MARK: - Time selector
                    const SizedBox(height: Constants.paddingMedium),
                    HourIntervalSelector(),
                    // MARK: - Reminder selector
                    const SizedBox(height: Constants.paddingMedium),
                    ReminderSelector(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(Constants.paddingMedium),
              child: PrimaryButton(
                label: strings.createBtn,
                disabled: bloc.state.status != StatsStatus.valid,
                onPressed: () => bloc.add(SubmitHabitEvent()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/app/bloc/app_bloc.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/l10n/intl_exp.dart';
import 'package:habit_current/ui/habit_edit/bloc/habit_edit_bloc.dart';
import 'package:habit_current/ui/habit_edit/widget/frequency_selector.dart';
import 'package:habit_current/ui/habit_edit/widget/habit_name_edit.dart';
import 'package:habit_current/ui/habit_edit/widget/hour_interval_selector.dart';
import 'package:habit_current/ui/habit_edit/widget/reminder_selector.dart';
import 'package:habit_current/ui/habit_edit/widget/week_days_selector.dart';
import 'package:habit_current/ui/widgets/primary_button.dart';

@RoutePage()
class HabitEditScreen extends StatelessWidget {
  const HabitEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = context.read<AppBloc>().state;
    final habitEvent = _stateToHabitEvent(appState);

    if (habitEvent == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.router.pop();
      });
      return const SizedBox();
    }

    return BlocProvider(
      create:
          (context) => HabitEditBloc(
            dataRepository: context.read(),
            notificationRepository: context.read(),
          )..add(habitEvent),
      child: const _HabitEditBody(),
    );
  }

  HabitEditEvent? _stateToHabitEvent(AppState state) {
    return switch (state) {
      AppHabitCreateState() => StartCreateHabitEvent(userId: state.userId),
      AppHabitEditState() => StartEditHabitEvent(habitId: state.habitId),
      _ => null,
    };
  }
}

class _HabitEditBody extends StatelessWidget {
  const _HabitEditBody();

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;
    final theme = Theme.of(context);

    return BlocConsumer<HabitEditBloc, HabitEditState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == StatsStatus.success) {
          context.read<AppBloc>().add(
            AppHabitReloadEvent(habitId: state.habitId),
          );
        }
      },
      builder: (context, state) {
        final isEdit = state.habit != null;
        return Scaffold(
          appBar: AppBar(
            title: Text(
              isEdit
                  ? strings.editHabit(state.habit!.name)
                  : strings.createHabit,
              style: theme.textTheme.titleLarge,
            ),
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
                        // MARK: - Habit name edit
                        HabitNameEditWidget(
                          initialName: state.habit?.name ?? '',
                        ),
                        const SizedBox(height: Constants.paddingMedium),
                        // MARK: - Frequency selector
                        const SizedBox(height: Constants.paddingMedium),
                        FrequencySelector(selectorDays: WeekDaysSelector()),
                        // MARK: - Time interval selector
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
                  child: BlocBuilder<HabitEditBloc, HabitEditState>(
                    buildWhen:
                        (previous, current) =>
                            previous.status != current.status,
                    builder: (context, state) {
                      return PrimaryButton(
                        label: isEdit ? strings.saveBtn : strings.createBtn,
                        disabled: state.status != StatsStatus.valid,
                        onPressed: () {
                          context.read<HabitEditBloc>().add(SaveHabitEvent());
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

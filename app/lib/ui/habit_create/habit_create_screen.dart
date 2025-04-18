import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/app/bloc/app_bloc.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/generated/l10n.dart';
import 'package:habit_current/ui/habit_create/bloc/habit_create_bloc.dart';
import 'package:habit_current/ui/habit_create/widget/habit_name_edit.dart';
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
          (context) => HabitCreateBloc(
            dataRepository: context.read(),
            userId: userId, //
          ),
      child: const _HabitCreateBody(),
    );
  }
}

class _HabitCreateBody extends StatelessWidget {
  const _HabitCreateBody({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final strings = S.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.createHabit),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.router.pop();
          },
        ),
      ),
      body: BlocBuilder<HabitCreateBloc, HabitCreateState>(
        builder: (context, state) {
          final habitCreateBloc = context.read<HabitCreateBloc>();

          return Column(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      HabitNameEdit(
                        onChanged: (value) {
                          habitCreateBloc.add(
                            HabitCreateNameChangedEvent(name: value),
                          );
                        },
                      ),
                      const SizedBox(height: Constants.paddingMedium),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: Constants.paddingMedium),
              PrimaryButton(
                label: strings.create,
                disabled: state.status != StatsStatus.valid,
                onPressed: () {
                  habitCreateBloc.add(HabitCreateSaveEvent());
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/l10n/intl_exp.dart';
import 'package:habit_current/ui/habit_create/bloc/habit_create_bloc.dart';
import 'package:habit_current/ui/widgets/text_form_title.dart';

class HabitNameEditWidget extends StatelessWidget {
  const HabitNameEditWidget({super.key,});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = context.l10n;

    return Container(
      padding: const EdgeInsets.all(Constants.paddingMedium),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(Constants.borderRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormTitle(strings.habitEnterName),
          SizedBox(height: Constants.paddingMedium),
          TextField(
            style: theme.textTheme.bodyLarge,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              filled: true,
              fillColor: theme.colorScheme.secondaryContainer,
              hintText: strings.habitEnterNameHint,
              hintStyle: theme.textTheme.headlineSmall,
              errorStyle: theme.textTheme.headlineSmall?.copyWith(
                color: theme.colorScheme.error,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: Constants.textFieldPaddingHorizontal,
                vertical: Constants.textFieldPaddingVertical,
              ),
            ),
            onChanged: (value) => context.read<HabitCreateBloc>().add(NameChangedEvent(name: value)),
          ),
        ],
      ),
    );
  }
}

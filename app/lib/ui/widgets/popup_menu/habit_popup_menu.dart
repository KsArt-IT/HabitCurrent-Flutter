import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/app/bloc/app_bloc.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/l10n/intl_exp.dart';
import 'package:habit_current/ui/widgets/popup_menu/habit_popup_menu_item.dart';
import 'package:habit_current/ui/widgets/popup_menu/habit_popup_menu_value.dart';

class HabitPopupMenu extends StatelessWidget {
  final int habitId;
  const HabitPopupMenu({super.key, required this.habitId});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<HabitPopupMenuValue>(
      padding: EdgeInsets.zero,
      color: Theme.of(context).colorScheme.onTertiaryFixedVariant,
      icon: Icon(
        Icons.more_horiz,
        color: Theme.of(context).colorScheme.secondaryFixed,
        size: Constants.iconSize,
      ),
      onSelected: (value) {
        switch (value) {
          case HabitPopupMenuValue.edit:
            context.read<AppBloc>().add(AppHabitEditEvent(habitId: habitId));
          case HabitPopupMenuValue.delete:
            context.read<AppBloc>().add(AppHabitDeleteEvent(habitId: habitId));
        }
      },
      itemBuilder:
          (context) => [
            HabitPopupMenuItem(
              label: context.l10n.edit,
              icon: Icons.edit,
              value: HabitPopupMenuValue.edit,
            ),
            HabitPopupMenuItem(
              label: context.l10n.delete,
              icon: Icons.delete,
              value: HabitPopupMenuValue.delete,
            ),
          ],
    );
  }
}

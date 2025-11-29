import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/app/bloc/app_bloc.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/core/extension/intl_exp.dart';
import 'package:habit_current/ui/widgets/popup_menu/habit_popup_menu_item.dart';
import 'package:habit_current/ui/widgets/popup_menu/habit_popup_menu_value.dart';

class HabitPopupMenu extends StatelessWidget {
  final int habitId;
  const HabitPopupMenu({super.key, required this.habitId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appBloc = context.read<AppBloc>();

    return PopupMenuButton<HabitPopupMenuValue>(
      padding: .zero,
      color: theme.colorScheme.onTertiaryFixedVariant,
      icon: Icon(
        Icons.more_horiz,
        color: theme.colorScheme.secondaryFixed,
        size: Constants.iconSize,
      ),
      onSelected: (value) => appBloc.add(switch (value) {
        .edit => AppHabitEditEvent(habitId: habitId),
        .delete => AppHabitDeleteEvent(habitId: habitId),
      }),
      itemBuilder: (context) => [
        HabitPopupMenuItem(
          label: context.l10n.edit,
          icon: Icons.edit,
          value: .edit,
        ),
        HabitPopupMenuItem(
          label: context.l10n.delete,
          icon: Icons.delete,
          value: .delete,
        ),
      ],
    );
  }
}

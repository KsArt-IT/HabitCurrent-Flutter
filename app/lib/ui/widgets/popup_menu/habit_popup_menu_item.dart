import 'package:flutter/material.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/ui/widgets/popup_menu/habit_popup_menu_value.dart';

class HabitPopupMenuItem extends PopupMenuItem<HabitPopupMenuValue> {
  final String label;
  final IconData icon;

  HabitPopupMenuItem({
    super.key,
    required this.label,
    required this.icon,
    required super.value,
  }) : super(
         child: Builder(
           builder: (context) => Row(
             children: [
               Icon(
                 icon,
                 size: Constants.iconSize,
                 color: Theme.of(context).colorScheme.onPrimary,
               ),
               const SizedBox(width: Constants.paddingSmall),
               Text(
                 label,
                 style: Theme.of(context).textTheme.titleMedium?.copyWith(
                   color: Theme.of(context).colorScheme.onPrimary,
                 ),
               ),
             ],
           ),
         ),
       );
}

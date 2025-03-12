import 'package:flutter/material.dart';
import 'package:habit_current/core/utils/constants.dart';
import 'package:habit_current/ui/home/home_tab.dart';

class TabItemButton extends StatelessWidget {
  final HomeTab tab;
  final int active;
  final Function(int) onTap;

  const TabItemButton({super.key, required this.tab, required this.active, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isActive = active == tab.index;
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: AppConstants.tabItemButtonSize,
      height: AppConstants.tabItemButtonSize,
      child: InkWell(
        onTap: () => onTap(tab.index),
        customBorder: const CircleBorder(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(tab.icon, color: isActive ? colorScheme.primary : colorScheme.inversePrimary),
            Text(
              tab.getLabel(context),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(color: isActive ? colorScheme.primary : colorScheme.inversePrimary, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

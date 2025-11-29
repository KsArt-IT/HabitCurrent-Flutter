import 'package:flutter/material.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/ui/home/home_tab.dart';

class TabItemButton extends StatelessWidget {
  final HomeTab tab;
  final int active;
  final ValueChanged<int> onTap;

  const TabItemButton({
    super.key,
    required this.tab,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = active == tab.index;
    final theme = Theme.of(context);

    return InkWell(
      onTap: () => onTap(tab.index),
      customBorder: const CircleBorder(),
      child: Ink(
        height: Constants.tabItemButtonSize,
        width: Constants.tabItemButtonSize,
        decoration: BoxDecoration(
          color: isActive ? theme.colorScheme.inversePrimary : theme.colorScheme.primary,
          borderRadius: .circular(Constants.tabItemRadius),
        ),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Icon(
              tab.icon,
              color: isActive ? theme.colorScheme.primary : theme.colorScheme.inversePrimary,
            ),
            Text(
              tab.getLabel(context),
              overflow: .ellipsis,
              style: isActive
                  ? theme.textTheme.headlineMedium!.copyWith(
                      color: theme.colorScheme.primary,
                    )
                  : theme.textTheme.headlineMedium,
            ),
          ],
        ),
      ),
    );
  }
}

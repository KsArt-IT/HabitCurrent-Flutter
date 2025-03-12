import 'package:flutter/material.dart';
import 'package:habit_current/ui/home/home_tab.dart';

class TabItemButton extends StatelessWidget {
  final HomeTab tab;
  final int active;
  final Function(int) onTap;
  final size = 70.0;

  const TabItemButton({
    super.key,
    required this.tab,
    required this.active,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(tab.index),
      borderRadius: BorderRadius.circular(size),
      child: SizedBox(
        width: size,
        height: size,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              tab.icon,
              color:
                  active == tab.index
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.surface,
            ),
            Text(
              tab.getLabel(context),
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color:
                    active == tab.index
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

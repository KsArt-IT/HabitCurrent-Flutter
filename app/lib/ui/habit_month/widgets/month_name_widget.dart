import 'package:flutter/material.dart';
import 'package:habit_current/core/extension/datetime_ext.dart';

class MonthNameWidget extends StatelessWidget {
  final DateTime month;
  final bool selected;
  final bool disabled;
  const MonthNameWidget({
    super.key,
    required this.month,
    this.selected = false,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return disabled
        ? const SizedBox(width: 50)
        : SizedBox(
            width: 50,
            child: Text(
              month.toShortMonth(),
              style: theme.textTheme.titleMedium?.copyWith(
                color: selected ? theme.colorScheme.onPrimary : theme.colorScheme.onTertiaryFixed,
                fontWeight: selected ? .w500 : .w300,
              ),
              textAlign: .center,
            ),
          );
  }
}

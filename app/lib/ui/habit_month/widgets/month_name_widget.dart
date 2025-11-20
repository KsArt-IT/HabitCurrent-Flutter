import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
              DateFormat('MMM').format(month),
              style: theme.textTheme.titleMedium?.copyWith(
                color: selected ? theme.colorScheme.onPrimary : theme.colorScheme.onTertiaryFixed,
                fontWeight: selected ? FontWeight.w500 : FontWeight.w300,
              ),
              textAlign: TextAlign.center,
            ),
          );
  }
}

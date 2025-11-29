import 'package:flutter/material.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/core/extension/int_ext.dart';

class TimeContainer extends StatelessWidget {
  const TimeContainer({super.key, required this.time, this.onTap});

  final int time;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: .circular(Constants.timeContainerRadius),
          child: Ink(
            height: Constants.timeContainerHeight,
            width: .infinity,
            decoration: BoxDecoration(
              color: theme.colorScheme.secondaryContainer,
              borderRadius: .circular(
                Constants.timeContainerRadius,
              ),
            ),
            child: Center(
              child: Text(time.toTime(), style: theme.textTheme.labelSmall),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/models/habit_day_status.dart';

class HabitStatusWidget extends StatelessWidget {
  final List<HabitDayStatus> weekStatus;
  const HabitStatusWidget({super.key, required this.weekStatus});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget _buildWeekStatus(HabitDayStatus status) => switch (status) {
      HabitDayStatus.completed => Container(
        width: Constants.statusSize,
        height: Constants.statusSize,
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryFixedDim,
          shape: BoxShape.circle,
        ),
      ),
      HabitDayStatus.partiallyCompleted => Container(
        width: Constants.statusSize,
        height: Constants.statusSize,
        decoration: BoxDecoration(
          color: theme.colorScheme.secondaryFixed.withAlpha(100),
          shape: BoxShape.circle,
        ),
      ),
      HabitDayStatus.notCompleted => Container(
        width: Constants.statusSize,
        height: Constants.statusSize,
        decoration: BoxDecoration(
          color: theme.colorScheme.secondaryFixed.withAlpha(100),
          // color: theme.colorScheme.error,
          shape: BoxShape.circle,
        ),
      ),
      HabitDayStatus.awaitsExecution => Container(
        width: Constants.statusSize,
        height: Constants.statusSize,
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
          border: Border.all(
            color: theme.colorScheme.primaryFixedDim.withAlpha(100),
            width: 2,
          ),
        ),
      ),
      HabitDayStatus.skipped => Container(
        width: Constants.statusSize,
        height: Constants.statusSize,
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
      ),
      HabitDayStatus.notStarted => Container(
        width: Constants.statusSize,
        height: Constants.statusSize,
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
      ),
      HabitDayStatus.closed => Container(
        width: Constants.statusSize,
        height: Constants.statusSize,
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
      ),
    };

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:
          weekStatus
              .map((d) => Expanded(child: Center(child: _buildWeekStatus(d))))
              .toList(),
    );
  }
}

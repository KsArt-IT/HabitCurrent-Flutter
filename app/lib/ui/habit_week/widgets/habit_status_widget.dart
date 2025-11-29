import 'package:flutter/material.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/models/habit_day_status.dart';

class HabitStatusWidget extends StatelessWidget {
  final List<HabitDayStatus> weekStatus;
  const HabitStatusWidget({super.key, required this.weekStatus});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .spaceEvenly,
      children: weekStatus
          .map((status) => Expanded(child: Center(child: _HabitStatus(status))))
          .toList(),
    );
  }
}

class _HabitStatus extends StatelessWidget {
  const _HabitStatus(this.status);
  final HabitDayStatus status;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return switch (status) {
      .completed => Container(
        width: Constants.statusSize,
        height: Constants.statusSize,
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryFixedDim,
          shape: .circle,
        ),
      ),
      .partiallyCompleted => Container(
        width: Constants.statusSize,
        height: Constants.statusSize,
        decoration: BoxDecoration(
          color: theme.colorScheme.secondaryFixed.withValues(alpha: 0.4),
          shape: .circle,
        ),
      ),
      .notCompleted => Container(
        width: Constants.statusSize,
        height: Constants.statusSize,
        decoration: BoxDecoration(
          color: theme.colorScheme.secondaryFixed.withValues(alpha: 0.4),
          // color: theme.colorScheme.error,
          shape: .circle,
        ),
      ),
      .awaitsExecution => Container(
        width: Constants.statusSize,
        height: Constants.statusSize,
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: .circle,
          border: .all(
            color: theme.colorScheme.primaryFixedDim.withValues(alpha: 0.4),
            width: 2,
          ),
        ),
      ),
      .skipped => Container(
        width: Constants.statusSize,
        height: Constants.statusSize,
        decoration: const BoxDecoration(
          color: Colors.transparent,
          shape: .circle,
        ),
      ),
      .notStarted => Container(
        width: Constants.statusSize,
        height: Constants.statusSize,
        decoration: const BoxDecoration(
          color: Colors.transparent,
          shape: .circle,
        ),
      ),
      .closed => Container(
        width: Constants.statusSize,
        height: Constants.statusSize,
        decoration: const BoxDecoration(
          color: Colors.transparent,
          shape: .circle,
        ),
      ),
    };
  }
}

import 'package:flutter/material.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/ui/habit_week/bloc/habit_week_bloc.dart';

class WeekStatusWidget extends StatelessWidget {
  final List<WeekStatus> weekStatus;
  const WeekStatusWidget({super.key, required this.weekStatus});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget _buildWeekStatus(WeekStatus status) => switch (status) {
      WeekStatus.completed => Container(
        width: Constants.statusSize,
        height: Constants.statusSize,
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryFixedDim,
          shape: BoxShape.circle,
        ),
      ),
      WeekStatus.partiallyCompleted => Container(
        width: Constants.statusSize,
        height: Constants.statusSize,
        decoration: BoxDecoration(
          color: theme.colorScheme.secondaryFixed.withAlpha(100),
          shape: BoxShape.circle,
        ),
      ),
      WeekStatus.notCompleted => Container(
        width: Constants.statusSize,
        height: Constants.statusSize,
        decoration: BoxDecoration(
          color: theme.colorScheme.error,
          shape: BoxShape.circle,
        ),
      ),
      WeekStatus.notStarted => Container(
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
      WeekStatus.closed => Container(
        width: Constants.statusSize,
        height: Constants.statusSize,
        decoration: BoxDecoration(
          color: Colors.transparent,
          shape: BoxShape.circle,
        ),
      ),
      WeekStatus.skipped => Container(
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

import 'package:flutter/material.dart';
import 'package:habit_current/generated/l10n.dart';

enum HomeTab { flow, week, month, settings }

extension HomeTabExt on HomeTab {
  String getLabel(BuildContext context) => switch (this) {
    HomeTab.flow => S.of(context).tabFlow,
    HomeTab.week => S.of(context).tabWeek,
    HomeTab.month => S.of(context).tabMonth,
    HomeTab.settings => S.of(context).tabSettings,
  };

  IconData get icon => switch (this) {
    HomeTab.flow => Icons.home,
    HomeTab.week => Icons.calendar_today,
    HomeTab.month => Icons.calendar_view_month,
    HomeTab.settings => Icons.settings,
  };
}

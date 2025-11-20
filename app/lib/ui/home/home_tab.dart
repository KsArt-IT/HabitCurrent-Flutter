import 'package:flutter/material.dart';
import 'package:habit_current/core/extension/intl_exp.dart';

enum HomeTab { flow, week, month, settings }

extension HomeTabExt on HomeTab {
  String getLabel(BuildContext context) => switch (this) {
    HomeTab.flow => context.l10n.tabFlow,
    HomeTab.week => context.l10n.tabWeek,
    HomeTab.month => context.l10n.tabMonth,
    HomeTab.settings => context.l10n.tabSettings,
  };

  IconData get icon => switch (this) {
    HomeTab.flow => Icons.home,
    HomeTab.week => Icons.calendar_today,
    HomeTab.month => Icons.calendar_view_month,
    HomeTab.settings => Icons.settings,
  };
}

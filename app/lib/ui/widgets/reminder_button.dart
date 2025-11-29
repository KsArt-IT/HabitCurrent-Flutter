import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/app/bloc/app_bloc.dart';
import 'package:habit_current/core/constants/constants.dart';
import 'package:habit_current/models/reminder.dart';
import 'package:habit_current/ui/settings/bloc/settings_bloc.dart';

class ReminderButton extends StatefulWidget {
  const ReminderButton({super.key});

  @override
  State<ReminderButton> createState() => _ReminderButtonState();
}

class _ReminderButtonState extends State<ReminderButton> with WidgetsBindingObserver {
  late AppBloc _appBloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _appBloc = context.read<AppBloc>()..add(AppReminderCheckEvent());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _appBloc.add(AppReminderCheckEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<AppBloc, AppState>(
      buildWhen: (previous, current) => previous.reminder != current.reminder,
      builder: (context, state) {
        final reminder = state.reminder.isGranted
            ? context.read<SettingsBloc>().state.reminder
                  ? Reminder.enabled
                  : Reminder.disabled
            : state.reminder;
        log('reminder: $reminder', name: 'ReminderButton');

        return Padding(
          padding: const .only(top: Constants.paddingXLarge),
          child: IconButton(
            onPressed: () {
              _appBloc.add(AppReminderChangeEvent(reminder));
              context.read<SettingsBloc>().add(
                // если уведомления включены, то выключить, иначе включить.
                SettingsUpdateReminderEvent(reminder != .enabled),
              );
            },
            icon: switch (reminder) {
              .enabled => const Icon(Icons.notifications_active),
              .disabled => const Icon(Icons.notifications_off),
              .request => const Icon(Icons.notification_important),
              .open => const Icon(Icons.edit_notifications),
            },
            padding: const .all(Constants.paddingSmall),
            iconSize: Constants.iconSize,
            color: theme.colorScheme.onPrimary,
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit_current/app/bloc/app_bloc.dart';
import 'package:habit_current/models/reminder.dart';

class ReminderButton extends StatefulWidget {
  const ReminderButton({super.key});

  @override
  State<ReminderButton> createState() => _ReminderButtonState();
}

class _ReminderButtonState extends State<ReminderButton> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    context.read<AppBloc>().add(AppReminderCheckEvent());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<AppBloc>().add(AppReminderCheckEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    final reminder = context.select((AppBloc bloc) => bloc.state.reminder);
    debugPrint("reminder: $reminder");
    
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: IconButton(
        onPressed: () {
          context.read<AppBloc>().add(
            switch (reminder) {
              // вкл/выкл
              Reminder.enabled => AppReminderDisabledEvent(),
              Reminder.disabled => AppReminderEnabledEvent(),
              // запрос разрешения или перейти в настройки
              Reminder.request => AppReminderRequestEvent(),
              Reminder.open => AppReminderOpenEvent(),
            },
          );
        },
        icon: switch (reminder) {
          Reminder.enabled => const Icon(Icons.notifications_active),
          Reminder.disabled => const Icon(Icons.notifications_off),
          Reminder.request => const Icon(Icons.notification_important),
          Reminder.open => const Icon(Icons.edit_notifications),
        },
        padding: const EdgeInsets.all(8),
        iconSize: 24,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
    );
  }
}
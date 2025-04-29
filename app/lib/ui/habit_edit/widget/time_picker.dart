import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habit_current/core/constants/constants.dart';

Future<TimeOfDay?> pickTime(
  BuildContext context, {
  TimeOfDay? initialTime,
}) async {
  final theme = Theme.of(context);
  TimeOfDay selectedTime = initialTime ?? TimeOfDay.now();

  if (Platform.isIOS) {
    // Cupertino picker
    return await showCupertinoModalPopup<TimeOfDay>(
      context: context,
      builder: (_) {
        return Container(
          height: 350,
          color: theme.colorScheme.surface,
          padding: const EdgeInsets.all(Constants.paddingMedium),
          child: Column(
            children: [
              CupertinoTimerPicker(
                mode: CupertinoTimerPickerMode.hm,
                backgroundColor: theme.colorScheme.surface,
                initialTimerDuration: Duration(
                  hours: selectedTime.hour,
                  minutes: selectedTime.minute,
                ),
                onTimerDurationChanged: (Duration duration) {
                  selectedTime = TimeOfDay(
                    hour: duration.inHours,
                    minute: duration.inMinutes % 60,
                  );
                },
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                height: Constants.buttonHeight,
                child: CupertinoButton(
                  color: theme.colorScheme.surfaceContainerLow,
                  padding: const EdgeInsets.all(0),
                  borderRadius: BorderRadius.circular(Constants.buttonRadius),
                  child: Text('Done', style: theme.textTheme.labelLarge),
                  onPressed: () {
                    Navigator.of(context).pop(selectedTime);
                  },
                ),
              ),
              const SizedBox(height: Constants.paddingMedium),
            ],
          ),
        );
      },
    );
  } else {
    // Material picker
    return await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
  }
}

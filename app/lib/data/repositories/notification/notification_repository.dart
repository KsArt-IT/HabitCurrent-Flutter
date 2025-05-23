import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:habit_current/models/reminder.dart';

abstract interface class NotificationRepository {
  Future<void> initialize();

  Future<Reminder> getNotificationPermissionStatus();
  Future<bool> checkNotificationPermission();
  Future<bool> requestNotificationPermission();
  void openNotificationSettings();

  Future<void> showNotification(
    int id,
    String title,
    String body,
    String? payload,
  );

  Future<void> scheduleNotificationByHabitId(int habitId);

  Future<void> cancelNotificationByHabitId(int habitId);
  Future<void> cancelAllNotifications();

  Future<List<PendingNotificationRequest>> getPendingNotifications();
  Future<List<ActiveNotification>> getActiveNotifications();

  Future<void> observeNotificationReceived(
    Function(int habitId)? open,
    Function(int habitId, int intervalId, int weekDay)? markDone,
  );

  Future<void> close();
}

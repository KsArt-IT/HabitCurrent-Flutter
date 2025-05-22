import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:habit_current/models/habit_notification.dart';
import 'package:habit_current/models/reminder.dart';

abstract interface class NotificationRepository {
  Future<void> initialize();

  Future<Reminder> getNotificationPermissionStatus();
  Future<bool> checkNotificationPermission();
  Future<bool> requestNotificationPermission();
  void openNotificationSettings();

  Future<void> scheduleNotifications(
    String title,
    List<HabitNotification> notifications,
  );

  Future<void> scheduleNotificationByHabitId(int habitId);

  Future<void> cancelNotificationByHabitId(int habitId);
  Future<void> cancelAllNotifications();

  Future<List<PendingNotificationRequest>> getPendingNotifications();
  Future<List<ActiveNotification>> getActiveNotifications();

  Future<void> close();
}

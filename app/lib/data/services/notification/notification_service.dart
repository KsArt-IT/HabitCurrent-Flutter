import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';

abstract interface class NotificationService {
  Future<void> initialize();
  Future<void> observeNotificationReceived(
    Function(String identifier, bool isOpen) onReceived,
  );

  Future<bool?> getNotificationPermissionStatus();
  Future<bool> checkNotificationPermission();
  Future<bool> requestNotificationPermission();
  void openNotificationSettings();

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    required TZDateTime scheduledDate,
    String? payload,
  });

  Future<void> showNotificationOnDate({
    required int id,
    required String identifier,
    required String title,
    String? body,
    required TZDateTime scheduledDate,
  });

  Future<void> scheduleNotificationOnWeekday({
    required int id,
    required String identifier,
    required String title,
    String? body,

    required TZDateTime date, // current date and time
    required int time, // minutes since midnight
    required int weekday, // 1 = Monday, ..., 7 = Sunday // 127 = every day
  });

  Future<void> cancelNotification(int id);
  Future<void> cancelAllNotifications();

  Future<List<PendingNotificationRequest>> getPendingNotifications();
  Future<List<ActiveNotification>> getActiveNotifications();

  Future<void> close();
}

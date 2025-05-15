import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';

abstract interface class NotificationService {
  Future<void> initialize();
  Future<bool> requestNotificationPermissions();
  Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
  });
  Future<void> showNotificationOnDate({
    required int id,
    required String title,
    required String body,
    required TZDateTime scheduledDate,
    String? payload,
  });
  Future<void> cancelNotification(int id);
  Future<void> cancelAllNotifications();

  Future<List<PendingNotificationRequest>> getPendingNotifications();
  Future<List<ActiveNotification>> getActiveNotifications();
}

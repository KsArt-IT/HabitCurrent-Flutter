import 'package:flutter_local_notifications/flutter_local_notifications.dart';

abstract interface class NotificationRepository {
  Future<void> initialize();

  Future<bool?> getNotificationPermissionStatus();
  Future<bool> checkNotificationPermission();
  Future<bool> requestNotificationPermission();
  void openNotificationSettings();

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  });

  Future<void> scheduleNotificationByHabitId(int habitId);

  Future<void> cancelNotificationByHabitId(int habitId);
  Future<void> cancelAllNotifications();

  Future<List<PendingNotificationRequest>> getPendingNotifications();
  Future<List<ActiveNotification>> getActiveNotifications();

  Future<void> observeNotificationReceived(
    Function(String identifier, bool isOpen) onReceived,
  );

  Future<void> close();
}

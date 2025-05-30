import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:habit_current/models/notification_response_details.dart';

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
  Future<void> showNotificationLater({
    required int id,
    required String identifier,
    required int laterMinutes,
  });

  Future<void> scheduleNotificationByHabitId(int habitId);
  Future<void> scheduleNotificationByUserId(int userId);

  Future<void> cancelNotificationByHabitId(int habitId);
  Future<void> cancelAllNotifications();

  Future<List<PendingNotificationRequest>> getPendingNotifications();
  Future<List<ActiveNotification>> getActiveNotifications();

  Future<void> observeNotificationReceived(
    Function(NotificationResponseDetails notification) onReceived,
  );
  Future<NotificationResponseDetails?> getNotificationAppLaunchDetails();

  Future<void> close();
}

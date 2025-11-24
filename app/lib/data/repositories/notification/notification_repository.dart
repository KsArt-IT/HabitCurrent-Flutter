import 'package:flutter/foundation.dart';
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
  Future<void> scheduleNotificationByIntervalId(int intervalId, bool tomorrow);

  Future<void> cancelNotificationByHabitId(int habitId);
  Future<void> cancelAllNotifications();

  Future<List<PendingNotificationRequest>> getPendingNotifications();
  Future<List<ActiveNotification>> getActiveNotifications();

  Future<void> observeNotificationReceived(ValueChanged<NotificationResponseDetails> onReceived);
  Future<NotificationResponseDetails?> getNotificationAppLaunchDetails();

  String createIdentifier({
    required int userId,
    required int habitId,
    required int intervalId,
    required int weekDay,
    bool reschedule = false,
  });

  (int userId, int habitId, int intervalId, int weekDay, bool reschedule) parseIdentifier(
    String identifier,
  );

  Future<void> close();
}

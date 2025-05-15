import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:habit_current/core/extension/int_ext.dart';
import 'package:habit_current/data/repositories/notification/notification_repository.dart';
import 'package:habit_current/data/services/data/data_service.dart';
import 'package:habit_current/data/services/notification/notification_service.dart';
import 'package:habit_current/models/habit_notification.dart';
import 'package:timezone/timezone.dart';

final class LocalNotificationRepository implements NotificationRepository {
  final DataService _service;
  final NotificationService _notificationService;

  LocalNotificationRepository({
    required DataService service,
    required NotificationService notification,
  }) : _service = service,
       _notificationService = notification;

  @override
  Future<void> close() {
    return _service.close();
  }

  @override
  Future<void> cancelAllNotifications() async {
    await _notificationService.cancelAllNotifications();
  }

  @override
  Future<void> cancelNotificationByHabitId(int habitId) async {
    final notifications = await _service.loadNotificationsByHabitId(habitId);
    for (final notification in notifications) {
      _notificationService.cancelNotification(notification.id);
    }
  }

  @override
  Future<List<ActiveNotification>> getActiveNotifications() {
    return _notificationService.getActiveNotifications();
  }

  @override
  Future<List<PendingNotificationRequest>> getPendingNotifications() {
    return _notificationService.getPendingNotifications();
  }

  @override
  Future<void> initialize() {
    return _notificationService.initialize();
  }

  @override
  Future<bool> requestNotificationPermissions() {
    return _notificationService.requestNotificationPermissions();
  }

  @override
  Future<void> scheduleNotifications(String title, List<HabitNotification> notifications) async {
    final date = DateTime.now();
    for (final notification in notifications) {
      final scheduledDate = notification.time.toDateTime(date);
      if (scheduledDate.isAfter(date)) {
        _notificationService.showNotificationOnDate(
          id: notification.identifier,
          title: title,
          body: "",
          scheduledDate: TZDateTime.from(scheduledDate, local),
          payload: null,
        );
      }
    }
  }
}

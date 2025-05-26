import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:habit_current/data/repositories/notification/notification_repository.dart';
import 'package:habit_current/data/services/data/data_service.dart';
import 'package:habit_current/data/services/notification/notification_service.dart';
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
  Future<void> close() async {
    await _notificationService.close();
    await _service.close();
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
  Future<bool> requestNotificationPermission() {
    return _notificationService.requestNotificationPermission();
  }

  @override
  Future<bool?> getNotificationPermissionStatus() {
    return _notificationService.getNotificationPermissionStatus();
  }

  @override
  Future<bool> checkNotificationPermission() {
    return _notificationService.checkNotificationPermission();
  }

  @override
  void openNotificationSettings() {
    _notificationService.openNotificationSettings();
  }

  @override
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    final scheduledDate = TZDateTime.now(local).add(Duration(seconds: 5));

    _notificationService.showNotification(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduledDate,
      payload: payload,
    );
  }

  @override
  Future<void> scheduleNotificationByHabitId(int habitId) async {
    final notifications = await _service.loadNotificationsByHabitId(habitId);
    print('--------------------------------');
    print(
      "LocalNotificationRepository: notifications: ${notifications.length}",
    );

    final date = TZDateTime.now(local);
    for (final notification in notifications) {
      // отправляем 2 типа уведомлений
      // 1. на время, каждый день
      // 2. на день недели, каждую неделю
      _notificationService.scheduleNotificationOnWeekday(
        id: notification.id,
        identifier:
            "user_${notification.userId}_habit_${notification.habitId //
            }_time_${notification.intervalId}_day_${notification.weekDay}",
        title: notification.title,
        date: date,
        time: notification.time,
        weekday: notification.weekDay,
      );
    }
    print('--------------------------------');
  }

  @override
  Future<void> observeNotificationReceived(
    Function(String identifier, bool isOpen) onReceived,
  ) async {
    _notificationService.observeNotificationReceived(onReceived);
  }
}

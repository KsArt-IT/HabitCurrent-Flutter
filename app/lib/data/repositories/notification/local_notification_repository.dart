import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:habit_current/data/repositories/notification/notification_repository.dart';
import 'package:habit_current/data/services/data/data_service.dart';
import 'package:habit_current/data/services/notification/notification_service.dart';
import 'package:habit_current/models/reminder.dart';
import 'package:timezone/timezone.dart';

final class LocalNotificationRepository implements NotificationRepository {
  final DataService _service;
  final NotificationService _notificationService;

  Function(int habitId, int intervalId, int weekDay)? _onNotificationReceived;
  Function(int habitId)? _onNotificationOpened;

  LocalNotificationRepository({
    required DataService service,
    required NotificationService notification,
  }) : _service = service,
       _notificationService = notification {
    _notificationService.onNotificationReceived = (
      habitId,
      intervalId,
      weekDay,
    ) {
      _onNotificationReceived?.call(habitId, intervalId, weekDay);
    };
    _notificationService.onNotificationOpened = (habitId) {
      _onNotificationOpened?.call(habitId);
    };
  }

  @override
  Future<void> close() async {
    _notificationService.onNotificationReceived = null;
    _notificationService.onNotificationOpened = null;
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
  Future<Reminder> getNotificationPermissionStatus() {
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
  Future<void> showNotification(
    int id,
    String title,
    String body,
    String? payload,
  ) async {
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
            "habit_${habitId}_time_${notification.intervalId}_day_${notification.weekDay}",
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
    Function(int habitId)? open,
    Function(int habitId, int intervalId, int weekDay)? markDone,
  ) async {
    _onNotificationReceived = markDone;
    _onNotificationOpened = open;
  }
}

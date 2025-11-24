import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:habit_current/data/models/habit_notification_model.dart';
import 'package:habit_current/data/repositories/notification/notification_repository.dart';
import 'package:habit_current/data/services/data/data_service.dart';
import 'package:habit_current/data/services/notification/notification_service.dart';
import 'package:habit_current/models/notification_response_details.dart';
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
    final scheduledDate = TZDateTime.now(local).add(const Duration(seconds: 5));

    _notificationService.showNotification(
      id: id,
      title: title,
      body: body,
      scheduledDate: scheduledDate,
      payload: payload,
    );
  }

  @override
  Future<void> showNotificationLater({
    required int id,
    required String identifier,
    required int laterMinutes,
  }) async {
    final notification = await _service.loadNotificationById(id);
    if (notification == null) return;

    _notificationService.showNotificationOnDate(
      id: 1000000 + id,
      title: notification.title,
      identifier: identifier,
      scheduledDate: TZDateTime.now(local).add(Duration(minutes: laterMinutes)),
    );
  }

  @override
  Future<void> scheduleNotificationByHabitId(int habitId) async {
    final notifications = await _service.loadNotificationsByHabitId(habitId);
    _scheduleAllNotifications(notifications);
  }

  @override
  Future<void> scheduleNotificationByUserId(int userId) async {
    final notifications = await _service.loadNotificationsByUserId(userId);
    _scheduleAllNotifications(notifications);
  }

  @override
  Future<void> scheduleNotificationByIntervalId(
    int intervalId,
    bool tomorrow,
  ) async {
    // получить уведомление по intervalId
    final notification = await _service.loadNotificationByIntervalId(
      intervalId,
    );
    // если не было уведомления, то ничего не делаем
    if (notification == null || !notification.repeats) return;
    // удалим уведомление из системы
    await _notificationService.cancelNotification(notification.id);
    // запланируем уведомление с учетом даты на завтра или сегодня
    final date = TZDateTime.now(local).add(Duration(days: tomorrow ? 1 : 0));
    await _notificationService.scheduleNotificationOnWeekday(
      id: notification.id,
      identifier: createIdentifier(
        userId: notification.userId,
        habitId: notification.habitId,
        intervalId: notification.intervalId,
        weekDay: notification.weekDay,
        reschedule: tomorrow,
      ),
      title: notification.title,
      date: date,
      time: notification.time,
      weekday: notification.weekDay,
      // для уведомлений на завтра не повторять, перезапланируем позже
      repeats: tomorrow ? false : notification.repeats,
    );
  }

  Future<void> _scheduleAllNotifications(
    List<HabitNotificationModel> notifications,
  ) async {
    log('--------------------------------', name: 'LocalNotificationRepository');
    log(
      'LocalNotificationRepository: notifications: ${notifications.length}', name: 'LocalNotificationRepository'
    );
    if (notifications.isEmpty) return;

    final date = TZDateTime.now(local);
    for (final notification in notifications) {
      // отправляем 2 типа уведомлений
      // 1. на время, каждый день
      // 2. на день недели, каждую неделю
      _notificationService.scheduleNotificationOnWeekday(
        id: notification.id,
        identifier: createIdentifier(
          userId: notification.userId,
          habitId: notification.habitId,
          intervalId: notification.intervalId,
          weekDay: notification.weekDay,
        ),
        title: notification.title,
        date: date,
        time: notification.time,
        weekday: notification.weekDay,
      );
    }
    log('--------------------------------', name: 'LocalNotificationRepository');
  }

  @override
  String createIdentifier({
    required int userId,
    required int habitId,
    required int intervalId,
    required int weekDay,
    bool reschedule = false,
  }) {
    return "user_${userId}_habit_${habitId}_time_${intervalId}_day_${weekDay}_reschedule_${reschedule ? '1' : '0'}";
  }

  @override
  (int userId, int habitId, int intervalId, int weekDay, bool reschedule) parseIdentifier(
    String identifier,
  ) {
    final parts = identifier.split('_');
    if (parts.length != 10) {
      throw Exception('Invalid identifier: $identifier');
    }
    return (
      int.parse(parts[1]), // userId
      int.parse(parts[3]), // habitId
      int.parse(parts[5]), // intervalId
      int.parse(parts[7]), // weekDay
      parts[9] == '1', // reschedule
    );
  }

  @override
  Future<void> observeNotificationReceived(
    Function(NotificationResponseDetails notification) onReceived,
  ) async {
    _notificationService.observeNotificationReceived(onReceived);
  }

  @override
  Future<NotificationResponseDetails?> getNotificationAppLaunchDetails() async {
    return await _notificationService.getNotificationAppLaunchDetails();
  }
}

import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:habit_current/data/services/notification/notification_service.dart';
import 'package:timezone/timezone.dart';

final class LocalNotificationService implements NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  int id = 0;
  // MARK: - Android Notification Channel
  static const String notificationChannelId = 'habit_notification_channel_id';
  static const String notificationChannelName = 'Notification main channel';
  static const String notificationChannelDescription =
      'For regular notifications';
  static const AndroidNotificationChannel notificationChannel =
      AndroidNotificationChannel(
        notificationChannelId,
        notificationChannelName,
        description: notificationChannelDescription,
        importance: Importance.high,
        playSound: true,
        enableVibration: true,
        showBadge: true,
      );
  static const AndroidNotificationDetails androidNotificationDetails =
      AndroidNotificationDetails(
        notificationChannelId,
        notificationChannelName,
        channelDescription: notificationChannelDescription,
        importance: Importance.high,
        priority: Priority.high,
        ticker: 'ticker',
      );

  static const darwinNotificationDetails = DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  static const NotificationDetails notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
    iOS: darwinNotificationDetails,
    macOS: darwinNotificationDetails,
  );

  // MARK: - iOS Notification Category
  static const String notificationCategoryId = 'habit_notification_category';

  static const String navigationActionId = 'navigation_action_id';
  static const String completedActionId = 'notification_action_id';
  static const String laterAction10Id = 'notification_action_10_id';
  static const String laterAction30Id = 'notification_action_30_id';
  static const String laterAction60Id = 'notification_action_60_id';

  final List<DarwinNotificationCategory> darwinNotificationCategories =
      <DarwinNotificationCategory>[
        DarwinNotificationCategory(
          notificationCategoryId,
          actions: <DarwinNotificationAction>[
            DarwinNotificationAction.plain(completedActionId, 'Mark as done'),
            DarwinNotificationAction.plain(
              navigationActionId,
              'Open (foreground)',
              options: <DarwinNotificationActionOption>{
                DarwinNotificationActionOption.foreground,
              },
            ),
            DarwinNotificationAction.plain(
              laterAction10Id,
              'Remind me later in 10 minutes',
            ),
            DarwinNotificationAction.plain(
              laterAction30Id,
              'Remind me later in 30 minutes',
            ),
            DarwinNotificationAction.plain(
              laterAction60Id,
              'Remind me later in 60 minutes',
            ),
          ],
          options: <DarwinNotificationCategoryOption>{
            DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
          },
        ),
      ];

  // MARK: - Initialize Notification
  @override
  Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    final DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
          notificationCategories: darwinNotificationCategories,
        );

    final LinuxInitializationSettings linuxSettings =
        LinuxInitializationSettings(
          defaultActionName: 'Open notification',
          defaultIcon: AssetsLinuxIcon('icons/app_icon.png'),
        );

    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: androidSettings,
          iOS: iosSettings,
          macOS: iosSettings,
          linux: linuxSettings,
          // windows: windows.initSettings,
        );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onDidReceiveNotification,
      // onDidReceiveBackgroundNotificationResponse: _onDidReceiveNotification
    );
    if (_isAndroidVersionGreaterThan8()) {
      // Android 8.0 (API level 26) and higher
      // Create the notification channel
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(notificationChannel);
    }
  }

  Future<void> _onDidReceiveNotification(NotificationResponse response) async {

  }

  bool _isAndroidVersionGreaterThan8() {
    if (!Platform.isAndroid) return false;

    // Platform.version возвращает что-то вроде:
    // "Android 9 (SDK 28)"
    final versionString = Platform.version;

    final match = RegExp(r'SDK (\d+)').firstMatch(versionString);
    if (match != null) {
      final sdkInt = int.tryParse(match.group(1)!);
      if (sdkInt != null) {
        return sdkInt > 26;
      }
    }

    return false;
  }

  @override
  Future<bool> requestNotificationPermissions() async {
    bool granted = true;
    if (Platform.isIOS || Platform.isMacOS) {
      if (Platform.isIOS) {
        granted =
            await _flutterLocalNotificationsPlugin
                .resolvePlatformSpecificImplementation<
                  IOSFlutterLocalNotificationsPlugin
                >()
                ?.requestPermissions(alert: true, badge: true, sound: true) ??
            false;
      } else if (Platform.isMacOS) {
        granted =
            await _flutterLocalNotificationsPlugin
                .resolvePlatformSpecificImplementation<
                  MacOSFlutterLocalNotificationsPlugin
                >()
                ?.requestPermissions(alert: true, badge: true, sound: true) ??
            false;
      }
    }
    return granted;
  }

  // MARK: - Get Pending and Active Notifications
  @override
  Future<List<PendingNotificationRequest>> getPendingNotifications() async {
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await _flutterLocalNotificationsPlugin.pendingNotificationRequests();
    return pendingNotificationRequests;
  }

  @override
  Future<List<ActiveNotification>> getActiveNotifications() async {
    final List<ActiveNotification> activeNotifications =
        await _flutterLocalNotificationsPlugin.getActiveNotifications();
    return activeNotifications;
  }

  // MARK: - Show Notification
  @override
  Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    await _flutterLocalNotificationsPlugin.show(
      0,
      'plain title',
      'plain body',
      notificationDetails,
      payload: 'item x',
    );
  }

  @override
  Future<void> showNotificationOnDate({
    required int id,
    required String title,
    required String body,
    required TZDateTime scheduledDate,
    String? payload,
  }) async {
    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      payload: payload,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  // MARK: - Cancel Notification
  @override
  Future<void> cancelAllNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  @override
  Future<void> cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }
}

import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:habit_current/data/services/notification/notification_service.dart';
import 'package:habit_current/models/reminder.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart';

final class LocalNotificationService implements NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

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
        playSound: true,
        enableVibration: true,
      );

  // MARK: - iOS Notification Category
  static const String notificationCategoryId = 'habit_notification_category';

  static const String navigationActionId = 'navigation_action_id';
  static const String laterAction10Id = 'notification_action_10_id';
  static const String laterAction30Id = 'notification_action_30_id';
  static const String laterAction60Id = 'notification_action_60_id';

  final List<DarwinNotificationCategory> darwinNotificationCategories =
      <DarwinNotificationCategory>[
        DarwinNotificationCategory(
          notificationCategoryId,
          actions: <DarwinNotificationAction>[
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

  static const darwinNotificationDetails = DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
    categoryIdentifier: notificationCategoryId,
    interruptionLevel: InterruptionLevel.active,
    sound: 'default',
  );

  static const notificationDetails = NotificationDetails(
    android: androidNotificationDetails,
    iOS: darwinNotificationDetails,
    macOS: darwinNotificationDetails,
  );

  // MARK: - Initialize Notification
  @override
  Future<void> initialize() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    final iosSettings = DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      notificationCategories: darwinNotificationCategories,
    );

    final linuxSettings = LinuxInitializationSettings(
      defaultActionName: 'Open notification',
      defaultIcon: AssetsLinuxIcon('icons/app_icon.png'),
    );

    final initializationSettings = InitializationSettings(
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
    if (await _isAndroidVersionGreaterThan8()) {
      // Android 8.0 (API level 26) and higher
      // Create the notification channel
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(notificationChannel);
    }
  }

  static Future<bool> _isAndroidVersionGreaterThan8() async {
    if (!Platform.isAndroid) return false;

    final androidInfo = await DeviceInfoPlugin().androidInfo;
    return androidInfo.version.sdkInt >= 26;
  }

  Future<void> _onDidReceiveNotification(NotificationResponse response) async {}

  @override
  Future<Reminder> getNotificationPermissionStatus() async {
    final permission = await Permission.notification.request();
    print('permission: $permission');
    if (permission.isGranted) {
      return Reminder.enabled;
    }
    if (permission.isPermanentlyDenied || permission.isLimited) {
      return Reminder.open;
    }
    return Reminder.request;
  }

  @override
  Future<bool> checkNotificationPermission() async {
    if (Platform.isAndroid) {
      final plugin =
          _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();
      final permission = await plugin?.areNotificationsEnabled();
      return permission ?? false;
    }
    if (Platform.isIOS) {
      final plugin =
          _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin
              >();

      final permission = await plugin?.checkPermissions();
      return permission?.isEnabled ?? false;
    }
    if (Platform.isMacOS) {
      final plugin =
          _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                MacOSFlutterLocalNotificationsPlugin
              >();

      final permission = await plugin?.checkPermissions();
      return permission?.isEnabled ?? false;
    }
    final permission = await Permission.notification.request();
    return permission.isGranted;
  }

  @override
  Future<bool> requestNotificationPermission() async {
    if (Platform.isIOS) {
      final permission = await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
      return permission ?? false;
    }
    if (Platform.isMacOS) {
      final permission = await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
      return permission ?? false;
    }
    if (Platform.isAndroid) {
      final plugin =
          _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();
      final permission = await plugin?.requestNotificationsPermission();
      return permission ?? false;
    }
    final permission = await Permission.notification.request();
    return permission.isGranted;
  }

  @override
  void openNotificationSettings() {
    if (Platform.isIOS) {
      AppSettings.openAppSettings(
        type: AppSettingsType.appLocale,
        asAnotherTask: true,
      );
    } else if (Platform.isAndroid) {
      AppSettings.openAppSettings(
        type: AppSettingsType.notification,
        asAnotherTask: true,
      );
    } else {
      openAppSettings();
    }
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
    print('--------------------------------');
    print('showNotificationOnDate: $id, $title, $body, $scheduledDate');
    print('--------------------------------');
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

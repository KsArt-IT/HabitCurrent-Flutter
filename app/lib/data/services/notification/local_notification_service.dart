import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:habit_current/data/services/notification/notification_service.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

final class LocalNotificationService implements NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  int id = 0;
  // MARK: - Android Notification Channel
  static const String notificationChannelId = 'habit_notification_channel_id';
  static const String notificationChannelName =
      'habit_notification_channel_name';
  static const String notificationChannelDescription =
      'habit_notification_channel_description';
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
    await _configureLocalTimeZone();

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
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        // Handle notification response
        if (response.payload != null) {
          // Handle the payload
        }
      },
    );
    if (Platform.isAndroid) {
      await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(notificationChannel);
    }
  }

  @override
  Future<void> showNotification({
    required String title,
    required String body,
    String? payload,
  }) {
    // TODO: implement showNotification
    throw UnimplementedError();
  }

  @override
  Future<void> cancelAllNotifications() {
    // TODO: implement cancelAllNotifications
    throw UnimplementedError();
  }

  @override
  Future<void> cancelNotification(int id) {
    // TODO: implement cancelNotification
    throw UnimplementedError();
  }

  // MARK: - Configure Local Time Zone
  Future<void> _configureLocalTimeZone() async {
    if (kIsWeb || Platform.isLinux) {
      return;
    }
    tz.initializeTimeZones();
    if (Platform.isWindows) {
      return;
    }
    final String? timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
    // Initialize timezone
    // if (Platform.isIOS || Platform.isMacOS) {
    //   await FlutterTimezone.initializeTimeZone();
    // }
    if (kDebugMode) {
      print('--------------------------------');
      print('Local timezone: $timeZoneName');
      print('--------------------------------');
    }
  }
}

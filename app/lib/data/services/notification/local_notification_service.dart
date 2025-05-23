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
  Function(int habitId, int intervalId, int weekDay)? onNotificationReceived;
  Function(int habitId)? onNotificationOpened;

  // MARK: - Actions
  static const String openActionId = 'open_action';
  static const String laterAction10Id = 'later_action_10';
  static const String laterAction30Id = 'later_action_30';
  static const String laterAction60Id = 'later_action_60';

  static const String openAction = 'Open';
  static const String laterAction10 = 'Remind me later in 10 min';
  static const String laterAction30 = 'Remind me later in 30 min';
  static const String laterAction60 = 'Remind me later in 60 min';

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
        actions: <AndroidNotificationAction>[
          AndroidNotificationAction(openActionId, openAction),
          AndroidNotificationAction(laterAction10Id, laterAction10),
          AndroidNotificationAction(laterAction30Id, laterAction30),
          AndroidNotificationAction(laterAction60Id, laterAction60),
        ],
      );

  // MARK: - iOS Notification Category
  static const String notificationCategoryId = 'habit_notification_category';

  final List<DarwinNotificationCategory> darwinNotificationCategories =
      <DarwinNotificationCategory>[
        DarwinNotificationCategory(
          notificationCategoryId,
          actions: <DarwinNotificationAction>[
            DarwinNotificationAction.plain(
              openActionId,
              openAction,
              options: <DarwinNotificationActionOption>{
                DarwinNotificationActionOption.foreground,
              },
            ),
            DarwinNotificationAction.plain(
              laterAction10Id,
              laterAction10,
            ),
            DarwinNotificationAction.plain(
              laterAction30Id,
              laterAction30,
            ),
            DarwinNotificationAction.plain(
              laterAction60Id,
              laterAction60,
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

  Future<void> _onDidReceiveNotification(NotificationResponse response) async {
    print('--------------------------------');
    print('onDidReceiveNotification: $response');
    print('--------------------------------');
    if (response.payload == null) return;

    final data = response.payload!.split('_');
    if (data.length < 5) return;

    final habitId = int.parse(data[1]);
    final intervalId = int.parse(data[3]);
    final weekDay = int.parse(data[5]);

    print('habitId: $habitId');
    print('intervalId: $intervalId');
    print('weekDay: $weekDay');

// 🟢 Обработка действий
    switch (response.actionId) {
      case openActionId:
        print('Пользователь тапнул по уведомлению');
        onNotificationOpened?.call(habitId);
      case laterAction10Id:
        print('Пользователь нажал "Отметить как выполнено" data: ${response.data.toString()}');
        showNotificationOnDate(
          id: 1000000 + habitId,
          identifier: response.payload!,
          title: response.payload!,
          body: response.payload!,
          scheduledDate: TZDateTime.now(local).add(Duration(minutes: 10)),
        );
      case laterAction30Id:
        print('Пользователь нажал "Отметить как выполнено"');
        showNotificationOnDate(
          id: 1000000 + habitId,
          identifier: response.payload!,
          title: response.payload!,
          body: response.payload!,
          scheduledDate: TZDateTime.now(local).add(Duration(minutes: 30)),
        );
      case laterAction60Id:
        print('Пользователь нажал "Отметить как выполнено"');
        showNotificationOnDate(
          id: 1000000 + habitId,
          identifier: response.payload!,
          title: response.payload!,
          body: response.payload!,
          scheduledDate: TZDateTime.now(local).add(Duration(minutes: 60)),
        );
        default:
          print('Пользователь нажал "Отметить как выполнено"');
        onNotificationReceived?.call(habitId, intervalId, weekDay);
    }

  }

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

  // MARK: - Schedule Notification
  // периодические напоминания, каждый день, каждую неделю в определенный день
  @override
  Future<void> scheduleNotificationOnWeekday({
    required int id,
    required String identifier,
    required String title,
    String? body,

    required TZDateTime date, // current date and time
    required int time, // minutes since midnight
    required int weekday, // 1 = Monday, ..., 7 = Sunday // 127 = every day
  }) async {
    var scheduledDate = TZDateTime(
      local,
      date.year,
      date.month,
      date.day,
      time ~/ 60,
      time % 60,
    );

    // Обеспечиваем установку на следующий нужный день
    if (weekday < 8) {
      while (scheduledDate.weekday != weekday || scheduledDate.isBefore(date)) {
        scheduledDate = scheduledDate.add(Duration(days: 1));
      }
    }

    print('scheduleNotificationOnWeekday: $id, $title, $body, $scheduledDate');

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      payload: identifier,
      matchDateTimeComponents:
          weekday < 8
              ? DateTimeComponents.dayOfWeekAndTime
              : DateTimeComponents.time,
    );
  }

  @override
  Future<void> showNotificationOnDate({
    required int id,
    required String identifier,
    required String title,
    String? body,
    required TZDateTime scheduledDate,
  }) async {
    print('--------------------------------');
    print('scheduleNotificationOnWeekday: $id, $title, $body, $scheduledDate');
    print('--------------------------------');

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      payload: identifier,
    );
  }

  @override
  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    required TZDateTime scheduledDate,
    String? payload,
  }) async {
    print('--------------------------------');
    print('scheduleNotificationOnWeekday: $id, $title, $body, $scheduledDate');
    print('--------------------------------');

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      payload: payload,
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

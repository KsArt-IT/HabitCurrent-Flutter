import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:habit_current/data/services/notification/notification_service.dart';
import 'package:habit_current/models/notification_response_details.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart';

final class LocalNotificationService implements NotificationService {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Function(NotificationResponseDetails notification)? _onNotificationReceived;

  // MARK: - Actions
  static const String openActionId = 'open_action';
  static const String skipActionId = 'skip_action';
  static const String laterAction10Id = 'later_action_10';
  static const String laterAction30Id = 'later_action_30';
  static const String laterAction60Id = 'later_action_60';

  static const String openAction = 'Open';
  static const String skipAction = 'Skip';
  static const String laterAction10 = 'Later in 10 min';
  static const String laterAction30 = 'Later in 30 min';
  static const String laterAction60 = 'Later in 60 min';

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
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        playSound: true,
        enableVibration: true,
        // max 3 actions
        actions: <AndroidNotificationAction>[
          AndroidNotificationAction(
            skipActionId,
            skipAction,
            showsUserInterface: false,
          ),
          AndroidNotificationAction(
            laterAction30Id,
            laterAction30,
            showsUserInterface: true,
          ),
          AndroidNotificationAction(
            openActionId,
            openAction,
            showsUserInterface: true,
          ),
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
              skipActionId,
              skipAction,
              options: <DarwinNotificationActionOption>{
                DarwinNotificationActionOption.destructive,
              },
            ),
            DarwinNotificationAction.plain(
              laterAction10Id,
              laterAction10,
              options: <DarwinNotificationActionOption>{
                DarwinNotificationActionOption.destructive,
              },
            ),
            DarwinNotificationAction.plain(laterAction30Id, laterAction30),
            DarwinNotificationAction.plain(laterAction60Id, laterAction60),
            DarwinNotificationAction.plain(
              openActionId,
              openAction,
              options: <DarwinNotificationActionOption>{
                DarwinNotificationActionOption.foreground,
              },
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

  Future<bool> _isAndroidVersionGreaterThan8() async {
    if (!_isAndroid) return false;
    final androidInfo = await DeviceInfoPlugin().androidInfo;
    return androidInfo.version.sdkInt >= 26;
  }

  @override
  Future<bool?> getNotificationPermissionStatus() async {
    if (_isIOS) {
      final plugin =
          _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin
              >();
      final permission = await plugin?.checkPermissions();
      print("permission: ${permission?.isEnabled}");
      if (permission == null) return null;
      return permission.isEnabled;
    }
    if (_isMacOS) {
      final plugin =
          _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                MacOSFlutterLocalNotificationsPlugin
              >();
      final permission = await plugin?.checkPermissions();
      if (permission == null) return null;
      return permission.isEnabled;
    }
    if (_isAndroid) {
      final plugin =
          _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();
      final permission = await plugin?.areNotificationsEnabled();
      if (permission == null) return null;
      return permission;
    }
    final permission = await Permission.notification.request();
    if (!permission.isGranted &&
        !permission.isDenied &&
        permission.isPermanentlyDenied) {
      return null;
    }
    return permission.isGranted;
  }

  @override
  Future<bool> checkNotificationPermission() async {
    if (_isAndroid) {
      final plugin =
          _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();
      final permission = await plugin?.areNotificationsEnabled();
      return permission ?? false;
    }
    if (_isIOS) {
      final plugin =
          _flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin
              >();

      final permission = await plugin?.checkPermissions();
      return permission?.isEnabled ?? false;
    }
    if (_isMacOS) {
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
    if (_isIOS) {
      final permission = await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
      return permission ?? false;
    }
    if (_isMacOS) {
      final permission = await _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
      return permission ?? false;
    }
    if (_isAndroid) {
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
    openAppSettings();
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
    bool repeats = true,
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

    print(
      'scheduleNotificationOnWeekday: $id, $title, $body, $weekday, $repeats, $scheduledDate',
    );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      payload: identifier,
      matchDateTimeComponents:
          repeats
              ? weekday < 8
                  ? DateTimeComponents.dayOfWeekAndTime
                  : DateTimeComponents.time
              : null, // не повторять, чтобы отложить на завтра
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
    print('showNotificationOnDate: $id, $title, $body, $scheduledDate');
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
    print('showNotification: $id, $title, $body, $scheduledDate');
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
    print('cancelNotification: $id');
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  // MARK: - Observe Notification Received
  @override
  Future<void> observeNotificationReceived(
    Function(NotificationResponseDetails notification) onReceived,
  ) async {
    _onNotificationReceived = onReceived;
  }

  void _onDidReceiveNotification(NotificationResponse response) {
    print('--------------------------------');
    print('onDidReceiveNotification: $response');
    print('--------------------------------');
    if (response.payload == null) return;
    final notification = _getNotificationDetails(response);
    _onNotificationReceived?.call(notification);
  }

  @override
  Future<NotificationResponseDetails?> getNotificationAppLaunchDetails() async {
    final launchDetails =
        await _flutterLocalNotificationsPlugin
            .getNotificationAppLaunchDetails();
    if (launchDetails == null) return null;
    if (!launchDetails.didNotificationLaunchApp) return null;

    final response = launchDetails.notificationResponse;
    if (response == null || response.payload == null) return null;
    return _getNotificationDetails(response);
  }

  NotificationResponseDetails _getNotificationDetails(response) {
    print('--------------------------------');
    print('getNotificationDetails: ${response.actionId}');
    switch (response.actionId) {
      case laterAction10Id:
        print('Пользователь нажал "отложить на 10 минут"');
        return NotificationResponseDetails(
          id: response.id ?? 0,
          identifier: response.payload!,
          laterMinutes: 10,
        );

      case laterAction30Id:
        print('Пользователь нажал "отложить на 30 минут"');
        return NotificationResponseDetails(
          id: response.id ?? 0,
          identifier: response.payload!,
          laterMinutes: 30,
        );

      case laterAction60Id:
        print('Пользователь нажал "отложить на 60 минут"');
        return NotificationResponseDetails(
          id: response.id ?? 0,
          identifier: response.payload!,
          laterMinutes: 60,
        );

      case openActionId:
        print('Пользователь нажал "открыть"');
        return NotificationResponseDetails(
          id: response.id ?? 0,
          identifier: response.payload!,
          isOpen: true,
        );

      case skipActionId:
        print('Пользователь нажал "пропустить"');
        return NotificationResponseDetails(id: 0, identifier: "");

      default:
        print(
          'Пользователь нажал "Отметить как выполнено" id: ${response.id} ${response.payload!}',
        );
        return NotificationResponseDetails(
          id: response.id ?? 0,
          identifier: response.payload!,
          isOpen: false,
        );
    }
  }

  // MARK: - Close
  @override
  Future<void> close() async {
    _onNotificationReceived = null;
  }

  // MARK: - Platform
  bool get _isAndroid => defaultTargetPlatform == TargetPlatform.android;

  bool get _isIOS => defaultTargetPlatform == TargetPlatform.iOS;

  bool get _isMacOS => defaultTargetPlatform == TargetPlatform.macOS;

  bool get _isLinux => defaultTargetPlatform == TargetPlatform.linux;

  bool get _isWindows => defaultTargetPlatform == TargetPlatform.windows;
}

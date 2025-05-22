import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

abstract class TimeZone {
  static Future<void> initialize() async {
    await _configureLocalTimeZone();
  }

  // MARK: - Configure Local Time Zone
  static Future<void> _configureLocalTimeZone() async {
    if (kIsWeb || Platform.isLinux) {
      return;
    }
    tz.initializeTimeZones();
    if (Platform.isWindows) {
      return;
    }
    final String? timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName!));
    if (kDebugMode) {
      print('--------------------------------');
      print('Local timezone: $timeZoneName');
      print('--------------------------------');
    }
  }
}
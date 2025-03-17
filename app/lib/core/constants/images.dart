import 'package:flutter/material.dart';

abstract class ThemeImage {
  static String getPath (String imageName, BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeFolder = isDark ? 'dark' : 'light';
    return 'assets/images/$themeFolder/$imageName';
  }
}
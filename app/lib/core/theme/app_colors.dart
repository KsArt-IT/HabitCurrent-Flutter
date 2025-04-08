import 'package:flutter/material.dart';

sealed class AppColors {
  static const Color brandColor = Color(0xFFFAFF00);
  static const Color gray50 = Color(0xFFF5F5F5);
  static const Color gray100 = Color(0xFFEBEBEB);
  static const Color gray300 = Color(0xFFC4C4C4);
  static const Color gray600 = Color(0xFF808080);
  static const Color gray700 = Color(0xFF5E5E5E);
  static const Color gray800 = Color(0xFF404040);
  static const Color gray900 = Color(0xFF1F1F1F);
  static const Color gray950 = Color(0xFF0F0F0F);

  static const Color error = Color(0xFFC93400);
  static const Color onError = Color(0xFFC93400);
  static const Color onboardColor = brandColor;
  static const Color onboardColorDark = gray950;
}

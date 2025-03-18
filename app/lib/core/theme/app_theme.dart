import 'package:flutter/material.dart';
import 'package:habit_current/core/theme/colors.dart';

sealed class AppTheme {
  static final lightTheme = ThemeData.light(useMaterial3: true).copyWith(
    appBarTheme: AppBarTheme(backgroundColor: AppColors.gray50),
    colorScheme: ColorScheme.light().copyWith(
      // Primary gray50 gray950
      primary: AppColors.gray50,
      onPrimary: AppColors.gray950,
      
      // Buttons
      secondary: AppColors.gray950,
      onSecondary: AppColors.gray50,
      secondaryFixed: AppColors.gray300,
      //
      secondaryContainer: AppColors.gray950,
      onSecondaryContainer: Color.fromARGB(0xFF, 0x0F, 0x0F, 0x0F),
      tertiary: Color.fromARGB(0xFF, 0xF5, 0xF5, 0xF5),
      onTertiary: Color.fromARGB(0xFF, 0x0F, 0x0F, 0x0F),
      // Onboard Text Field
      tertiaryContainer: AppColors.gray50,
      onTertiaryContainer: AppColors.gray800,
      tertiaryFixedDim: AppColors.gray300,
      // Onboard Background
      tertiaryFixed: AppColors.onboardColor,
      onTertiaryFixed: AppColors.gray50,
    ),
  );

  static final darkTheme = ThemeData.dark(useMaterial3: true).copyWith(
    appBarTheme: AppBarTheme(backgroundColor: AppColors.gray950),
    colorScheme: ColorScheme.dark().copyWith(
      // Primary gray50 gray950
      primary: AppColors.gray950,
      onPrimary: AppColors.gray50,
      // Buttons
      secondary: AppColors.gray50,
      onSecondary: AppColors.gray950,
      secondaryFixed: AppColors.gray700,
      //
      secondaryContainer: Color.fromARGB(0xFF, 0x0F, 0x0F, 0x0F),
      onSecondaryContainer: Color.fromARGB(0xFF, 0xF5, 0xF5, 0xF5),

      tertiary: Color.fromARGB(0xFF, 0x1F, 0x1F, 0x1F),
      onTertiary: Color.fromARGB(0xFF, 0xF5, 0xF5, 0xF5),
      // Onboard Text Field
      tertiaryContainer: AppColors.gray900,
      onTertiaryContainer: AppColors.gray800,
      tertiaryFixedDim: AppColors.gray900,
      // Onboard Background
      tertiaryFixed: AppColors.onboardColorDark,
      onTertiaryFixed: AppColors.gray950,
    ),
  );
}

extension ThemeX on ThemeData {
  String get _themeFolder => brightness == Brightness.dark ? 'dark' : 'light';

  String getImagePath(String imageName) => 'assets/images/$_themeFolder/$imageName';
}

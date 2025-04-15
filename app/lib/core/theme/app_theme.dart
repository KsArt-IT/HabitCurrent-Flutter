import 'package:flutter/material.dart';
import 'package:habit_current/core/theme/app_colors.dart';

sealed class AppTheme {
  static final _fontFamily = 'Inter';

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    fontFamily: _fontFamily,
    appBarTheme: AppBarTheme(backgroundColor: AppColors.gray50),
    scaffoldBackgroundColor: AppColors.gray50,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.brandColor,
      brightness: Brightness.light,
    ).copyWith(
      // Primary gray50 gray950
      // primary: AppColors.gray950,
      // onPrimary: AppColors.gray50,
      // inversePrimary: AppColors.gray50,
      
      primaryContainer: AppColors.error, //AppColors.gray950,
      onPrimaryContainer: AppColors.error,
      // Error
      error: AppColors.error,
      onError: AppColors.onError,
      // Buttons
      surfaceContainerLow: AppColors.gray950,
      // Buttons disabled
      tertiaryFixed: AppColors.gray300,
      onTertiaryFixed: AppColors.gray600,
      //
      surface: AppColors.gray100,
      onSurface: AppColors.gray950,
      // Onboard Background
      tertiaryFixedDim: AppColors.onboardColor,
      onTertiaryFixedVariant: AppColors.gray50,
      // fillColor decoration
      tertiaryContainer: AppColors.gray50,
      onTertiaryContainer: AppColors.gray950,
      // Outline
      outlineVariant: AppColors.gray300,
    ),
    // Text Theme
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 48,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
        color: AppColors.gray950,
      ),
      displayMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: AppColors.gray950,
      ),
      displaySmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: AppColors.gray800,
      ),
      titleLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w500,
        color: AppColors.gray600,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.gray600,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.gray600,
      ),
      // hint light
      headlineSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: AppColors.gray800,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.gray950,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.gray600,
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.gray600,
      ),
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.gray50,
      ),
      labelMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.gray50,
      ),
      labelSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: AppColors.gray600,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: AppColors.gray50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide.none,
      ),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    fontFamily: _fontFamily,
    appBarTheme: AppBarTheme(backgroundColor: AppColors.gray950),
    scaffoldBackgroundColor: AppColors.gray950,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.brandColor,
      brightness: Brightness.dark,
    ).copyWith(
      // Primary gray50 gray950
      primary: AppColors.gray950,
      onPrimary: AppColors.gray50,
      inversePrimary: AppColors.gray950,

      primaryContainer: AppColors.error,
      onPrimaryContainer: AppColors.error,
      // Error
      error: AppColors.error,
      onError: AppColors.onError,
      // Buttons
      surfaceContainerLow: AppColors.gray50,
      tertiaryFixed: AppColors.gray700,
      onTertiaryFixed: AppColors.gray600,
      //
      secondary: AppColors.gray50,
      onSecondary: AppColors.gray950,
      secondaryFixed: AppColors.gray700,
      //
      secondaryContainer: AppColors.gray950,
      onSecondaryContainer: AppColors.gray50,

      tertiary: AppColors.gray900,
      onTertiary: AppColors.gray50,
      // Onboard Background
      tertiaryFixedDim: AppColors.gray950,
      onTertiaryFixedVariant: AppColors.gray950,
      // fillColor decoration
      tertiaryContainer: AppColors.gray900,
      onTertiaryContainer: AppColors.gray50,
      // Outline
      outlineVariant: AppColors.gray900,
    ),
    // Text Theme
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 48,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.w600,
        color: AppColors.gray50,
      ),
      displayMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: AppColors.brandColor,
      ),
      displaySmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: AppColors.gray600,
      ),
      // AppBar
      titleLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w500,
        color: AppColors.gray50,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.gray50,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.gray50,
      ),
      // hint light
      headlineSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: AppColors.gray800,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.gray50,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.gray600,
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.gray600,
      ),
      // Buttons
      labelLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: AppColors.gray950,
      ),
      labelMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.gray950,
      ),
      labelSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: AppColors.gray950,
      ),
    ),
  );
}

extension ThemeX on ThemeData {
  String get _themeFolder => brightness == Brightness.dark ? 'dark' : 'light';

  String getImagePath(String imageName) =>
      'assets/images/$_themeFolder/$imageName';
}

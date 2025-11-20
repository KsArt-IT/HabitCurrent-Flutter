import 'package:flutter/material.dart';
import 'package:habit_current/core/theme/app_colors.dart';

sealed class AppTheme {
  static final _fontFamily = 'Inter';

  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    fontFamily: _fontFamily,
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.gray50),
    scaffoldBackgroundColor: AppColors.gray50,
    colorScheme: const ColorScheme.light().copyWith(
      primary: AppColors.gray100,
      onPrimary: AppColors.gray950,
      inversePrimary: AppColors.gray950,
      // primaryContainer: AppColors.error, //AppColors.gray950,
      // onPrimaryContainer: AppColors.error,
      //
      // secondary: AppColors.gray50,
      onSecondary: AppColors.gray950,
      //
      primaryFixed: AppColors.gray900,
      primaryFixedDim: AppColors.gray950,
      onPrimaryFixed: AppColors.brandColor,
      //
      secondaryFixed: AppColors.gray950,
      //
      secondaryContainer: AppColors.gray50,
      onSecondaryContainer: AppColors.gray950,
      // Error
      error: AppColors.error,
      onError: AppColors.onError,
      // Buttons
      surfaceContainerLow: AppColors.gray950,
      onSurfaceVariant: AppColors.gray50,
      // Buttons disabled
      tertiaryFixed: AppColors.gray300,
      onTertiaryFixed: AppColors.gray600,
      //
      tertiary: AppColors.gray900,
      onTertiary: AppColors.gray950,
      //
      surface: AppColors.gray100,
      onSurface: AppColors.gray50,
      // Onboard Background
      tertiaryFixedDim: AppColors.onboardColor,
      onTertiaryFixedVariant: AppColors.gray50,
      // fillColor decoration
      tertiaryContainer: AppColors.gray50,
      onTertiaryContainer: AppColors.gray950,
      // Outline
      outlineVariant: AppColors.gray300,
    ),
    unselectedWidgetColor: AppColors.gray600,
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.gray900; // выбран
        }
        return AppColors.gray600; // не выбран
      }),
      visualDensity: VisualDensity.compact,
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.all(Colors.transparent),
      checkColor: WidgetStateProperty.all(AppColors.gray900),
      side: const BorderSide(color: AppColors.gray600),
      visualDensity: VisualDensity.compact,
    ),
    // Time Picker
    timePickerTheme: TimePickerThemeData(
      backgroundColor: AppColors.gray100,

      hourMinuteColor: AppColors.gray950,
      hourMinuteTextColor: AppColors.gray50,
      
      dayPeriodColor: AppColors.gray950,
      dayPeriodTextColor: AppColors.gray50,
      
      dialHandColor: AppColors.gray600,
      dialBackgroundColor: AppColors.gray950,
      dialTextColor: AppColors.gray50,
      
      entryModeIconColor: AppColors.gray950,
      timeSelectorSeparatorColor: WidgetStateProperty.all(AppColors.gray950),

      cancelButtonStyle: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.gray950),
        foregroundColor: WidgetStateProperty.all(AppColors.gray50),
      ),
      confirmButtonStyle: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.gray950),
        foregroundColor: WidgetStateProperty.all(AppColors.gray50),
      ),
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
        fontWeight: FontWeight.w600,
        color: AppColors.gray950,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.gray950,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.gray600,
      ),
      // hint light
      headlineSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: AppColors.gray800,
      ),
      headlineMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w300,
        color: AppColors.gray950,
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
        color: AppColors.gray950,
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
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.gray950),
    scaffoldBackgroundColor: AppColors.gray950,
    colorScheme: const ColorScheme.dark().copyWith(
      // Primary gray50 gray950
      primary: AppColors.gray900,
      onPrimary: AppColors.gray50,
      inversePrimary: AppColors.gray50,

      // primaryContainer: AppColors.error,
      // onPrimaryContainer: AppColors.error,
      //
      primaryFixed: AppColors.brandColor,
      primaryFixedDim: AppColors.brandColor,
      onPrimaryFixed: AppColors.brandColor,
      // Error
      error: AppColors.error,
      onError: AppColors.onError,
      // Buttons
      surfaceContainerLow: AppColors.gray50,
      onSurfaceVariant: AppColors.gray950,
      // Buttons disabled
      tertiaryFixed: AppColors.gray700,
      onTertiaryFixed: AppColors.gray600,
      //
      // secondary: AppColors.gray50,
      onSecondary: AppColors.gray700,
      secondaryFixed: AppColors.gray950,
      //
      secondaryContainer: AppColors.gray950,
      onSecondaryContainer: AppColors.gray50,
      //
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
      //
      surface: AppColors.gray900,
      onSurface: AppColors.gray50,
    ),
    unselectedWidgetColor: AppColors.gray700,
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.brandColor; // выбран
        }
        return AppColors.gray700; // не выбран
      }),
      visualDensity: VisualDensity.compact,
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.all(Colors.transparent),
      checkColor: WidgetStateProperty.all(AppColors.brandColor),
      side: const BorderSide(color: AppColors.gray700),
      visualDensity: VisualDensity.compact,
    ),
    // Time Picker
    timePickerTheme: TimePickerThemeData(
      backgroundColor: AppColors.gray900,

      hourMinuteColor: AppColors.gray50,
      hourMinuteTextColor: AppColors.gray950,

      dayPeriodColor: AppColors.gray50,
      dayPeriodTextColor: AppColors.gray950,

      dialHandColor: AppColors.gray700,
      dialBackgroundColor: AppColors.gray950,
      dialTextColor: AppColors.gray50,

      entryModeIconColor: AppColors.gray50,
      timeSelectorSeparatorColor: WidgetStateProperty.all(AppColors.gray50),

      cancelButtonStyle: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.gray50),
        foregroundColor: WidgetStateProperty.all(AppColors.gray950),
      ),
      confirmButtonStyle: ButtonStyle(
        backgroundColor: WidgetStateProperty.all(AppColors.gray50),
        foregroundColor: WidgetStateProperty.all(AppColors.gray950),
      ),
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
        fontWeight: FontWeight.w600,
        color: AppColors.gray50,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.gray50,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.gray700,
      ),
      // hint light
      headlineSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: AppColors.gray800,
      ),
      headlineMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w300,
        color: AppColors.gray50,
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
        color: AppColors.gray50,
      ),
    ),
  );
}

extension ThemeX on ThemeData {
  String get _themeFolder => brightness == Brightness.dark ? 'dark' : 'light';

  String getImagePath(String imageName) =>
      'assets/images/$_themeFolder/$imageName';
}

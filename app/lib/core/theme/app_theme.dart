import 'package:flutter/material.dart';
import 'package:habit_current/core/theme/app_colors.dart';

sealed class AppTheme {
  static final _fontFamily = 'Inter';

  static final lightTheme = ThemeData(
    brightness: .light,
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
    radioTheme: .new(
      fillColor: .resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.gray900; // выбран
        }
        return AppColors.gray600; // не выбран
      }),
      visualDensity: .compact,
    ),
    checkboxTheme: .new(
      fillColor: .all(Colors.transparent),
      checkColor: .all(AppColors.gray900),
      side: const .new(color: AppColors.gray600),
      visualDensity: .compact,
    ),
    // Time Picker
    timePickerTheme: .new(
      backgroundColor: AppColors.gray100,

      hourMinuteColor: AppColors.gray950,
      hourMinuteTextColor: AppColors.gray50,

      dayPeriodColor: AppColors.gray950,
      dayPeriodTextColor: AppColors.gray50,

      dialHandColor: AppColors.gray600,
      dialBackgroundColor: AppColors.gray950,
      dialTextColor: AppColors.gray50,

      entryModeIconColor: AppColors.gray950,
      timeSelectorSeparatorColor: .all(AppColors.gray950),

      cancelButtonStyle: .new(
        backgroundColor: .all(AppColors.gray950),
        foregroundColor: .all(AppColors.gray50),
      ),
      confirmButtonStyle: .new(
        backgroundColor: .all(AppColors.gray950),
        foregroundColor: .all(AppColors.gray50),
      ),
    ),
    // Text Theme
    textTheme: const .new(
      displayLarge: .new(
        fontSize: 48,
        fontStyle: .normal,
        fontWeight: .w600,
        color: AppColors.gray950,
      ),
      displayMedium: .new(
        fontSize: 24,
        fontWeight: .w500,
        color: AppColors.gray950,
      ),
      displaySmall: .new(
        fontSize: 20,
        fontWeight: .w400,
        color: AppColors.gray800,
      ),
      titleLarge: .new(
        fontSize: 32,
        fontWeight: .w600,
        color: AppColors.gray950,
      ),
      titleMedium: .new(
        fontSize: 16,
        fontWeight: .w400,
        color: AppColors.gray950,
      ),
      titleSmall: .new(
        fontSize: 14,
        fontWeight: .w400,
        color: AppColors.gray600,
      ),
      // hint light
      headlineSmall: .new(
        fontSize: 14,
        fontWeight: .w300,
        color: AppColors.gray800,
      ),
      headlineMedium: .new(
        fontSize: 12,
        fontWeight: .w300,
        color: AppColors.gray950,
      ),
      bodyLarge: .new(
        fontSize: 16,
        fontWeight: .w400,
        color: AppColors.gray950,
      ),
      bodyMedium: .new(
        fontSize: 16,
        fontWeight: .w500,
        color: AppColors.gray600,
      ),
      bodySmall: .new(
        fontSize: 14,
        fontWeight: .w400,
        color: AppColors.gray600,
      ),
      labelLarge: .new(
        fontSize: 16,
        fontWeight: .w500,
        color: AppColors.gray50,
      ),
      labelMedium: .new(
        fontSize: 16,
        fontWeight: .w400,
        color: AppColors.gray50,
      ),
      labelSmall: .new(
        fontSize: 14,
        fontWeight: .w300,
        color: AppColors.gray950,
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: AppColors.gray50,
      border: OutlineInputBorder(
        borderRadius: .all(Radius.circular(8)),
        borderSide: .none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: .all(Radius.circular(8)),
        borderSide: .none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: .all(Radius.circular(8)),
        borderSide: .none,
      ),
    ),
  );

  static final darkTheme = ThemeData(
    brightness: .dark,
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
    radioTheme: .new(
      fillColor: .resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.brandColor; // выбран
        }
        return AppColors.gray700; // не выбран
      }),
      visualDensity: .compact,
    ),
    checkboxTheme: .new(
      fillColor: .all(Colors.transparent),
      checkColor: .all(AppColors.brandColor),
      side: const .new(color: AppColors.gray700),
      visualDensity: .compact,
    ),
    // Time Picker
    timePickerTheme: .new(
      backgroundColor: AppColors.gray900,

      hourMinuteColor: AppColors.gray50,
      hourMinuteTextColor: AppColors.gray950,

      dayPeriodColor: AppColors.gray50,
      dayPeriodTextColor: AppColors.gray950,

      dialHandColor: AppColors.gray700,
      dialBackgroundColor: AppColors.gray950,
      dialTextColor: AppColors.gray50,

      entryModeIconColor: AppColors.gray50,
      timeSelectorSeparatorColor: .all(AppColors.gray50),

      cancelButtonStyle: .new(
        backgroundColor: .all(AppColors.gray50),
        foregroundColor: .all(AppColors.gray950),
      ),
      confirmButtonStyle: .new(
        backgroundColor: .all(AppColors.gray50),
        foregroundColor: .all(AppColors.gray950),
      ),
    ),
    // Text Theme
    textTheme: const .new(
      displayLarge: .new(
        fontSize: 48,
        fontStyle: .normal,
        fontWeight: .w600,
        color: AppColors.gray50,
      ),
      displayMedium: .new(
        fontSize: 24,
        fontWeight: .w500,
        color: AppColors.brandColor,
      ),
      displaySmall: .new(
        fontSize: 20,
        fontWeight: .w400,
        color: AppColors.gray600,
      ),
      // AppBar
      titleLarge: .new(
        fontSize: 32,
        fontWeight: .w600,
        color: AppColors.gray50,
      ),
      titleMedium: .new(
        fontSize: 16,
        fontWeight: .w400,
        color: AppColors.gray50,
      ),
      titleSmall: .new(
        fontSize: 14,
        fontWeight: .w400,
        color: AppColors.gray700,
      ),
      // hint light
      headlineSmall: .new(
        fontSize: 14,
        fontWeight: .w300,
        color: AppColors.gray800,
      ),
      headlineMedium: .new(
        fontSize: 12,
        fontWeight: .w300,
        color: AppColors.gray50,
      ),
      bodyLarge: .new(
        fontSize: 16,
        fontWeight: .w400,
        color: AppColors.gray50,
      ),
      bodyMedium: .new(
        fontSize: 16,
        fontWeight: .w500,
        color: AppColors.gray600,
      ),
      bodySmall: .new(
        fontSize: 14,
        fontWeight: .w400,
        color: AppColors.gray600,
      ),
      // Buttons
      labelLarge: .new(
        fontSize: 16,
        fontWeight: .w500,
        color: AppColors.gray950,
      ),
      labelMedium: .new(
        fontSize: 16,
        fontWeight: .w400,
        color: AppColors.gray950,
      ),
      labelSmall: .new(
        fontSize: 14,
        fontWeight: .w300,
        color: AppColors.gray50,
      ),
    ),
  );
}

extension ThemeX on ThemeData {
  String get _themeFolder => brightness == .dark ? 'dark' : 'light';

  String getImagePath(String imageName) => 'assets/images/$_themeFolder/$imageName';
}

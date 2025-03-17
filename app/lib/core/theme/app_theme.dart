import 'package:flutter/material.dart';

sealed class AppTheme {
  static final lightTheme = ThemeData.light(
    useMaterial3: true,
  ).copyWith(
    appBarTheme: AppBarTheme(backgroundColor: Colors.indigo[300]),
    colorScheme: ColorScheme.light().copyWith(
      // Primary Button
      secondary: Color.fromARGB(0xFF, 0x0F, 0x0F, 0x0F),
      onSecondary: Color.fromARGB(0xFF, 0xF5, 0xF5, 0xF5),
      // Onboard Background Brand Color
      tertiary: Color.fromARGB(0xFF, 0xFA, 0xFC, 0x2C),//#FAFC2C
      tertiaryContainer: Color.fromARGB(0xFF, 0xF5, 0xF5, 0xF5),
    )
  );

  static final darkTheme = ThemeData.dark(
    useMaterial3: true,
  ).copyWith(
    appBarTheme: AppBarTheme(backgroundColor: Colors.indigo[900]),
    colorScheme: ColorScheme.dark().copyWith(
      secondary: Color.fromARGB(0xFF, 0xF5, 0xF5, 0xF5),
      onSecondary: Color.fromARGB(0xFF, 0x0F, 0x0F, 0x0F),
      tertiary: Color.fromARGB(0xFF, 0x0F, 0x0F, 0x0F),
      tertiaryContainer: Color.fromARGB(0xFF, 0x0F, 0x0F, 0x0F),
    )
  );
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF2A5C8A), // Professional blue
    brightness: Brightness.light,
    primary: const Color(0xFF2A5C8A),
    secondary: const Color(0xFF4CAF50), // Productivity green
    tertiary: const Color(0xFFFFC107), // Accent yellow
    error: const Color(0xFFD32F2F),
  ),
  fontFamily: 'Roboto',
  cupertinoOverrideTheme: const CupertinoThemeData(
    primaryColor: Color(0xFF2A5C8A),
    barBackgroundColor: Color(0xFFF5F5F5),
    scaffoldBackgroundColor: Color(0xFFF5F5F5),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    displayMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    bodyLarge: TextStyle(fontSize: 16, height: 1.5),
    bodyMedium: TextStyle(fontSize: 14),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
);

// Dark Theme Variant
final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF3B82F6),
    brightness: Brightness.dark,
    primary: const Color(0xFF3B82F6),
    secondary: const Color(0xFF10B981),
  ),
  cupertinoOverrideTheme: const CupertinoThemeData(
    primaryColor: Color(0xFF3B82F6),
    barBackgroundColor: Color(0xFF1F2933),
    scaffoldBackgroundColor: Color(0xFF1F2933),
  ),
  // Rest of dark theme configurations...
);

// App-specific Text Styles Extension
extension CustomTextStyles on TextTheme {
  TextStyle get projectTitle => const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: Color(0xFF1A2E35),
  );

  TextStyle get timeEntry =>
      const TextStyle(fontSize: 14, color: Color(0xFF4B5563));

  TextStyle get reportHeader => const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: Color(0xFF2A5C8A),
  );
}

// Spacing Extension
extension AppSpacing on ThemeData {
  EdgeInsets get sectionPadding => const EdgeInsets.all(24);
  EdgeInsets get itemPadding => const EdgeInsets.symmetric(vertical: 8);
  double get gridSpacing => 16;
}

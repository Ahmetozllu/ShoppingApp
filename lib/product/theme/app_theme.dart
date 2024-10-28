import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    cardColor: Colors.white,
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      bodyMedium: TextStyle(
        color: Colors.black,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
      ),
    ),
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
  );

  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontWeight: FontWeight.w500,
        color: Colors.white,  // Karanlık temada başlık rengi
      ),
      bodyMedium: TextStyle(
        color: Colors.white,  // Karanlık temada metin rengi
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,  // Karanlık temada düğme metin rengi
        backgroundColor: Colors.red,     // Karanlık temada düğme arka plan rengi
      ),
    ),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      brightness: Brightness.dark,  // Karanlık tema
    ),
    useMaterial3: true,
  );
}

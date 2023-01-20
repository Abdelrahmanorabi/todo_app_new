import 'package:flutter/material.dart';

class MyTheme {
  static const Color lightPrimary = Color(0xFF5D9CEC);
  static const Color lightScaffoldBackground = Color(0xFFDFECDB);
  static const Color greenColor = Color(0xFF61E757);
  static const Color redColor = Color(0xFFEC4B4B);
  static const Color darkScaffoldBackground = Color(0xFF060E1E);
  static const Color darkTaskBackground = Color(0xFF141922);

  static final ThemeData lightTheme = ThemeData(
      primaryColor: lightPrimary,
      scaffoldBackgroundColor: lightScaffoldBackground,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedIconTheme: IconThemeData(
            size: 36,
          ),
          unselectedIconTheme: IconThemeData(size: 36)),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        iconSize: 36,
      ),
      textTheme: const TextTheme(
        titleMedium: TextStyle(
          fontSize: 24,
          color: lightPrimary,
          fontWeight: FontWeight.bold,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          color: Colors.black,
        ),
        titleSmall: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),

      ));


  static final ThemeData darkTheme = ThemeData(
      primaryColor: lightPrimary,
      scaffoldBackgroundColor: darkScaffoldBackground,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedIconTheme: IconThemeData(
            size: 36,
          ),
          unselectedIconTheme: IconThemeData(size: 36,color: Colors.white)),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        iconSize: 36,
      ),
      textTheme: const TextTheme(
        titleMedium: TextStyle(
          fontSize: 24,
          color: lightPrimary,
          fontWeight: FontWeight.bold,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          color: Colors.white,
        ),
        titleSmall: TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),

      ));
}

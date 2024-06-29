import 'package:flutter/material.dart';
import 'package:sehatyaab/theme/AppColors.dart';

class AppTheme {
  static final OutlineInputBorder _lightInputBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: AppColors.blue5, width: 2.0),
    borderRadius: BorderRadius.circular(10),
  );

  static final OutlineInputBorder _darkInputBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: AppColors.blue2, width: 2.0),
    borderRadius: BorderRadius.circular(10),
  );

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.blue1,
    shadowColor: AppColors.gray,
    hoverColor: AppColors.pink,
    cardColor: AppColors.blue5,
    fontFamily: 'GoogleSans',
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: AppColors.black,
        fontFamily: 'GoogleSans',
        fontSize: 28,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: TextStyle(
        color: AppColors.black,
        fontFamily: 'GoogleSans',
        fontSize: 22,
      ),
      bodySmall: TextStyle(
        color: AppColors.black,
        fontFamily: 'GoogleSans',
        fontSize: 20,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.white,
        backgroundColor: AppColors.blue5,
        overlayColor: AppColors.blue3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        fixedSize: const Size(200, 50),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(color: AppColors.black),
      border: _lightInputBorder,
      enabledBorder: _lightInputBorder,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppColors.blue3,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.peach),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.blue4),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.blue4),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: AppColors.black,
    primaryColor: AppColors.blue5,
    shadowColor: AppColors.gray,
    hoverColor: AppColors.peach,
    cardColor: AppColors.blue2,
    fontFamily: 'GoogleSans',
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: AppColors.white,
        fontFamily: 'GoogleSans',
        fontSize: 28,
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: TextStyle(
        color: AppColors.white,
        fontFamily: 'GoogleSans',
        fontSize: 22,
      ),
      bodySmall: TextStyle(
        color: AppColors.white,
        fontFamily: 'GoogleSans',
        fontSize: 20,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.blue5,
        backgroundColor: AppColors.blue1,
        overlayColor: AppColors.blue2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        fixedSize: const Size(200, 50),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      hintStyle: const TextStyle(color: AppColors.black),
      border: _darkInputBorder,
      enabledBorder: _darkInputBorder,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: AppColors.blue3,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.peach),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.blue1),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.blue1),
  );

  static final ValueNotifier<ThemeData> currentTheme =
      ValueNotifier(lightTheme);

  static void toggleTheme() {
    if (currentTheme.value == lightTheme) {
      currentTheme.value = darkTheme;
    } else {
      currentTheme.value = lightTheme;
    }
  }
}

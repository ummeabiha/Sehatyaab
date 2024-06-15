import 'package:flutter/material.dart';
import 'package:sehatyaab/theme/AppColors.dart';

class AppTheme {
  static final OutlineInputBorder _defaultInputBorder = OutlineInputBorder(
    borderSide: const BorderSide(color: AppColors.blue5),
    borderRadius: BorderRadius.circular(10),
  );

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: AppColors.blue1,
    shadowColor: AppColors.gray,
    hoverColor: AppColors.peach,
    cardColor: AppColors.blue5,
    fontFamily: 'GoogleSans-Regular',
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        color: AppColors.black,
        fontFamily: 'GoogleSans-Bold',
        fontSize: 26,
      ),
      bodyMedium: TextStyle(
          color: AppColors.black,
          fontFamily: 'GoogleSans-Medium',
          fontSize: 22),
      bodySmall: TextStyle(
          color: AppColors.black,
          fontFamily: 'GoogleSans-Regular',
          fontSize: 20),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.white,
        backgroundColor: AppColors.blue5,
        overlayColor: AppColors.blue3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        fixedSize: const Size(200, 50), // Set the width and height here
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(color: AppColors.black),
      border: _defaultInputBorder,
      enabledBorder: _defaultInputBorder,
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.blue3),
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.red),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.blue5),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    iconTheme: const IconThemeData(color: AppColors.blue4),
  );

  static final ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: AppColors.blue5,
      shadowColor: AppColors.gray,
      hoverColor: AppColors.peach,
      cardColor: AppColors.blue2,
      fontFamily: 'GoogleSans-Medium',
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
            color: AppColors.white,
            fontFamily: 'GoogleSans-Bold',
            fontSize: 26),
        bodyMedium: TextStyle(
            color: AppColors.white,
            fontFamily: 'GoogleSans-Medium',
            fontSize: 22),
        bodySmall: TextStyle(
            color: AppColors.white,
            fontFamily: 'GoogleSans-Regular',
            fontSize: 20),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.blue5,
          backgroundColor: AppColors.blue1,
          overlayColor: AppColors.blue2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          fixedSize: const Size(200, 50), // Set the width and height here
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(color: AppColors.white),
        border: _defaultInputBorder,
        enabledBorder: _defaultInputBorder,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.blue2),
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.red),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppColors.blue3),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      iconTheme: const IconThemeData(color: AppColors.blue1));
}

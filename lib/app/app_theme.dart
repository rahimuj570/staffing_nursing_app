import 'package:flutter/material.dart';
import 'package:staffing/app/constants/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      colorSchemeSeed: AppColors.themeColor,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: AppColors.themeColor,
        elevation: 2,
        backgroundColor: Colors.white,
      ),
    );
  }
}

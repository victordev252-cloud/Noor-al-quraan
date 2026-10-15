import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryEmerald = Color(0xFF075E46);
  static const Color deepEmerald = Color(0xFF043D30);
  static const Color darkBackground = Color(0xFF071A16);
  static const Color darkSurface = Color(0xFF102720);
  static const Color premiumGold = Color(0xFFD6B56D);
  static const Color softGold = Color(0xFFE8D5A0);
  static const Color warmWhite = Color(0xFFFFFDF7);
  static const Color secondaryText = Color(0xFF84968D);
  static const Color border = Color(0xFFDCE7DF);
  static const Color lightBackground = Color(0xFFF7F8F2);
  static const Color whiteSurface = Color(0xFFFFFFFF);
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: AppColors.primaryEmerald,
    scaffoldBackgroundColor: AppColors.lightBackground,
    colorScheme: const ColorScheme.light(
      primary: AppColors.primaryEmerald,
      secondary: AppColors.premiumGold,
      surface: AppColors.whiteSurface,
      background: AppColors.lightBackground,
    ),
    fontFamily: 'Inter',
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primaryEmerald,
      foregroundColor: AppColors.warmWhite,
      elevation: 0,
      centerTitle: true,
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: AppColors.primaryEmerald,
    scaffoldBackgroundColor: AppColors.darkBackground,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.primaryEmerald,
      secondary: AppColors.premiumGold,
      surface: AppColors.darkSurface,
      background: AppColors.darkBackground,
    ),
    fontFamily: 'Inter',
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkSurface,
      foregroundColor: AppColors.warmWhite,
      elevation: 0,
      centerTitle: true,
    ),
  );
}

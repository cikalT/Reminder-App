import 'package:flutter/material.dart';
import 'package:its_reminder_app/utils/app_colors.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  tabBarTheme: TabBarTheme(
    indicator: const UnderlineTabIndicator(
      borderSide: BorderSide(color: AppColors.mainColor, width: 4.0),
    ),
    labelColor: Colors.black,
    unselectedLabelColor: Colors.grey.shade400,
    unselectedLabelStyle: TextStyle(color: Colors.grey.shade400, fontSize: 10),
    dividerColor: Colors.transparent,
    indicatorSize: TabBarIndicatorSize.label,
    labelStyle: const TextStyle(fontSize: 12, letterSpacing: 1.3, fontWeight: FontWeight.w500),
  ),
  primaryColor: const Color(0xFFfafafa),
  scaffoldBackgroundColor: AppColors.whiteColor,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF2b2119),
  ),
);

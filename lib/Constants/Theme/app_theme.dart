import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';

class AppTheme {
  ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primaryViolet,
      onPrimary: AppColors.primaryBlack,
      secondary: AppColors.primaryViolet,
      onSecondary: AppColors.black50,
      error: AppColors.primaryRed,
      onError: AppColors.primaryRed,
      surface: AppColors.primaryLight,
      onSurface: AppColors.black50,
    ),
    fontFamily: "Inter",
    primaryColor: AppColors.primaryViolet,
  );
}

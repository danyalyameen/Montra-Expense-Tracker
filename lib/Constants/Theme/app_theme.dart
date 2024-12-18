import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Theme/text_styles.dart';

class AppTheme {
  ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      titleTextStyle: CustomTextStyles.appBarTitle,
      centerTitle: true,
    ),
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
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryViolet,
          foregroundColor: AppColors.light80,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          textStyle: const TextStyle(fontWeight: FontWeight.w600)),
    ),
  );
}

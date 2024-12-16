import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';

class CustomTextStyles {
  static TextStyle appBarTitle =
      TextStyle(color: AppColors.primaryLight, fontWeight: FontWeight.bold);
  static TextStyle buttonText = TextStyle(
    color: AppColors.light80,
    fontWeight: FontWeight.w900,
  );
  static TextStyle textFieldTextStyle = const TextStyle(
      color: Colors.grey, fontSize: 20, fontWeight: FontWeight.w500);
}

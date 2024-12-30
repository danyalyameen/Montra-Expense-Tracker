import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';

class AppTextStyles {

  //Black Text Styles

  static TextStyle titleBlack({required BuildContext context}) {
    double width = MediaQuery.sizeOf(context).width;
    return TextStyle(
      color: AppColors.primaryBlack,
      fontSize: width * 0.05,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle subtitleBlack({required BuildContext context}) {
    double width = MediaQuery.sizeOf(context).width;
    return TextStyle(
      color: AppColors.primaryBlack,
      fontSize: width * 0.045,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle descriptionBlack({required BuildContext context}) {
    double width = MediaQuery.sizeOf(context).width;
    return TextStyle(
      color: AppColors.primaryBlack,
      fontSize: width * 0.04,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle onBoardingTitleBlack({required BuildContext context}) {
    double width = MediaQuery.sizeOf(context).width;
    return TextStyle(
      color: AppColors.black75,
      fontSize: width * 0.08,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle onBoardingDescriptionBlack({required BuildContext context}) {
    double width = MediaQuery.sizeOf(context).width;
    return TextStyle(
      color: AppColors.black25,
      fontSize: width * 0.04,
      fontWeight: FontWeight.w500,
    );
  }


  // White Text Styles

  static TextStyle titleWhite({required BuildContext context}) {
    double width = MediaQuery.sizeOf(context).width;
    return TextStyle(
      color: AppColors.primaryLight,
      fontSize: width * 0.05,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle subtitleWhite({required BuildContext context}) {
    double width = MediaQuery.sizeOf(context).width;
    return TextStyle(
      color: AppColors.primaryLight,
      fontSize: width * 0.045,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle description({required BuildContext context}) {
    double width = MediaQuery.sizeOf(context).width;
    return TextStyle(
      color: AppColors.primaryLight,
      fontSize: width * 0.04,
      fontWeight: FontWeight.w500,
    );
  }
}

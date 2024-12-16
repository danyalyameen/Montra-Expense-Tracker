import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Theme/text_styles.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final double width;
  final double height;
  final String text;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.width,
      required this.text,
      required this.height});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.9,
      child: TextField(
        controller: controller,
        cursorColor: AppColors.primaryBlack,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(
            left: width * 0.04,
            top: height * 0.018,
            bottom: height * 0.018,
          ),
          hintText: text,
          hintStyle: CustomTextStyles.textFieldTextStyle,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width * 0.04),
            borderSide: BorderSide(
              color: AppColors.light20,
              width: width * 0.005,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width * 0.04),
            borderSide: BorderSide(
              color: AppColors.light20,
              width: width * 0.005,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(width * 0.04),
            borderSide: BorderSide(
              color: AppColors.light20,
              width: width * 0.005,
            ),
          ),
        ),
      ),
    );
  }
}

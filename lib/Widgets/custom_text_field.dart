import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final double width;
  final double height;
  final String hintText;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final TapRegionCallback? onTapOutside;
  final VoidCallback? onCompleted;
  final double? borderRadius;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.width,
      required this.hintText,
      required this.height,
      this.suffixIcon,
      this.onTap,
      this.onTapOutside,
      this.onCompleted, this.borderRadius});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width * 0.9,
        child: TextField(
          controller: controller,
          onTap: onTap,
          onTapOutside: onTapOutside,
          onEditingComplete: onCompleted,
          cursorColor: AppColors.primaryBlack,
          style: TextStyle(
            color: AppColors.primaryBlack,
            fontSize: width * 0.04,
            fontWeight: FontWeight.w500,
          ),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(
              left: width * 0.04,
              top: height * 0.018,
              bottom: height * 0.018,
              right: width * 0.04,
            ),
            hintText: hintText,
            suffixIcon: suffixIcon,
            hintStyle: TextStyle(
              color: AppColors.grey,
              fontSize: width * 0.045,
              fontWeight: FontWeight.w500,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? width * 0.04),
              borderSide: BorderSide(
                color: AppColors.primaryViolet,
                width: width * 0.005,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? width * 0.04),
              borderSide: BorderSide(
                color: AppColors.light60,
                width: width * 0.004,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

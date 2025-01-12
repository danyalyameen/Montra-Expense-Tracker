import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final double width;
  final double height;
  final TextEditingController controller;
  final String hintText;
  final Widget? suffixIcon;
  final double? borderRadius;
  final bool? obscureText;
  final String? Function(String? value) validator;
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.width,
    required this.hintText,
    required this.height,
    this.suffixIcon,
    this.borderRadius,
    required this.validator,
    this.obscureText,
  });
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width * 0.9,
        child: TextFormField(
          controller: controller,
          cursorColor: AppColors.primaryBlack,
          obscureText: obscureText ?? false,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) => validator(value),
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
            errorStyle: TextStyle(fontSize: width * 0.035),
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
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? width * 0.04),
              borderSide: BorderSide(
                color: AppColors.primaryRed,
                width: width * 0.004,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius ?? width * 0.04),
              borderSide: BorderSide(
                color: AppColors.primaryRed,
                width: width * 0.004,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

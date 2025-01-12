import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double width, height;
  final String? text;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  final Widget? child;
  const CustomElevatedButton(
      {super.key,
      this.onPressed,
      required this.width,
      required this.height,
      this.text,
      this.textStyle,
      this.backgroundColor,
      this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.9,
      height: height * 0.068,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: backgroundColor == null
              ? WidgetStatePropertyAll(AppColors.primaryViolet)
              : WidgetStatePropertyAll(backgroundColor),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(width * 0.04),
            ),
          ),
        ),
        onPressed: onPressed,
        child: child ??
            Text(
              "$text",
              style: textStyle ??
                  TextStyle(
                    color: AppColors.primaryLight,
                    fontSize: width * 0.045,
                    fontWeight: FontWeight.w600,
                  ),
            ),
      ),
    );
  }
}

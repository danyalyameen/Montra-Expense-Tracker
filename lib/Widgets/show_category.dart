import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';

class ShowCategory extends StatelessWidget {
  final double width, height;
  final String category, icon;
  final Color iconColor, backgroundColor;
  const ShowCategory(
      {super.key,
      required this.width,
      required this.height,
      required this.category,
      required this.iconColor,
      required this.backgroundColor,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: height * 0.02),
          height: height * 0.08,
          decoration: BoxDecoration(
            border: Border.all(
              width: width * 0.001,
              color: AppColors.light20,
            ),
            borderRadius: BorderRadius.circular(width * 0.07),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: width * 0.001, horizontal: width * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: width * 0.01),
                  child: Container(
                    width: width * 0.11,
                    height: width * 0.11,
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(width * 0.04),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        icon,
                        colorFilter:
                            ColorFilter.mode(iconColor, BlendMode.srcIn),
                        width: width * 0.065,
                        height: width * 0.065,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: width * 0.02,
                ),
                Text(
                  category,
                  style: TextStyle(
                    color: AppColors.primaryBlack,
                    fontSize: width * 0.038,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

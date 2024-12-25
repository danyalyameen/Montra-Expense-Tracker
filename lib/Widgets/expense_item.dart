import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';

class ExpenseItem extends StatelessWidget {
  final double width, height;
  final int index;
  final String titleKey,
      descriptionKey,
      timeKey,
      priceKey,
      iconKey,
      iconColorKey,
      iconBackgroundColor;
  final Color? priceColor;
  final List<Map<String, dynamic>> data;
  const ExpenseItem(
      {super.key,
      required this.width,
      required this.height,
      required this.titleKey,
      required this.descriptionKey,
      required this.timeKey,
      required this.priceKey,
      required this.iconKey,
      required this.iconColorKey,
      required this.iconBackgroundColor,
      required this.index,
      required this.data,
      this.priceColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: height * 0.01),
      width: width * 0.9,
      height: height * 0.1,
      decoration: BoxDecoration(
        color: AppColors.light80,
        borderRadius: BorderRadius.circular(width * 0.04),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(left: width * 0.04),
            child: Container(
              width: width * 0.15,
              height: width * 0.15,
              decoration: BoxDecoration(
                color: data[index][iconBackgroundColor],
                borderRadius: BorderRadius.circular(width * 0.04),
              ),
              child: Center(
                child: SvgPicture.asset(
                  data[index][iconKey],
                  colorFilter: ColorFilter.mode(
                      data[index][iconColorKey], BlendMode.srcIn),
                  width: width * 0.09,
                  height: width * 0.09,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: height * 0.02, left: width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data[index][titleKey],
                  style: TextStyle(
                    color: AppColors.primaryBlack,
                    fontSize: width * 0.042,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: height * 0.002,
                ),
                Text(
                  data[index][descriptionKey].length > 20
                      ? data[index][descriptionKey].substring(0, 20) + "..."
                      : data[index][descriptionKey],
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: width * 0.035,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(right: width * 0.04, top: height * 0.02),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${data[index][priceKey]}",
                  style: TextStyle(
                    color: priceColor ?? AppColors.primaryRed,
                    fontSize: width * 0.045,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: height * 0.005,
                ),
                Text(
                  data[index][timeKey],
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: width * 0.032,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

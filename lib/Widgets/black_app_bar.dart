import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';

PreferredSizeWidget? blackAppBar(
    {required String title,
    required double width,
    required double height,
    List<Widget>? actions,
    Color backgroundColor = Colors.white,
    GestureTapCallback? onTap}) {
  return AppBar(
    backgroundColor: backgroundColor,
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(
        fontSize: width * 0.05,
        color: AppColors.primaryBlack,
        fontWeight: FontWeight.w700,
      ),
    ),
    leading: Center(
      child: InkWell(
        onTap: onTap,
        child: SvgPicture.asset(
          IconsPath.backArrow,
          colorFilter:
              ColorFilter.mode(AppColors.primaryBlack, BlendMode.srcIn),
          width: width * 0.04,
          height: height * 0.04,
        ),
      ),
    ),
    actions: actions,
  );
}
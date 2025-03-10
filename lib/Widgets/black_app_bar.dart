import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:stacked_services/stacked_services.dart';

PreferredSizeWidget? blackAppBar(
    {required String title,
    required double width,
    required double height,
    List<Widget>? actions,
    Color backgroundColor = Colors.white,
    Widget? leading,
    double? toolBarHeight,
    GestureTapCallback? onTap}) {
  return AppBar(
    backgroundColor: backgroundColor,
    toolbarHeight: toolBarHeight,
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(
        fontSize: width * 0.05,
        color: AppColors.primaryBlack,
        fontWeight: FontWeight.w700,
      ),
    ),
    scrolledUnderElevation: 0,
    leading: leading ??
        Center(
          child: InkWell(
            borderRadius: BorderRadius.circular(width),
            onTap: onTap ?? () => NavigationService().back(),
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

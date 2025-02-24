import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';

PreferredSizeWidget? whiteAppBar(
    {required String title,
    required double width,
    required double height,
    List<Widget> actions = const [],
    Color backgroundColor = Colors.white,
    Widget? leading,
    double? toolBarHight,
    GestureTapCallback? onTap}) {
  return AppBar(
    backgroundColor: backgroundColor,
    toolbarHeight: toolBarHight,
    centerTitle: true,
    title: Text(
      title,
      style: TextStyle(
        fontSize: width * 0.05,
        color: AppColors.primaryLight,
        fontWeight: FontWeight.w700,
      ),
    ),
    leading: leading ??
        Center(
          child: InkWell(
            borderRadius: BorderRadius.circular(width),
            onTap: onTap,
            child: SvgPicture.asset(
              IconsPath.backArrow,
              colorFilter:
                  ColorFilter.mode(AppColors.primaryLight, BlendMode.srcIn),
              width: width * 0.04,
              height: height * 0.04,
            ),
          ),
        ),
    actions: actions,
  );
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/App/app.locator.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:stacked_services/stacked_services.dart';

class SuccessfullyDone extends StatefulWidget {
  final String msg;
  // ignore: prefer_typing_uninitialized_variables
  final className;
  const SuccessfullyDone({super.key, required this.msg, this.className});

  @override
  State<SuccessfullyDone> createState() => _SuccessfullyDoneState();
}

class _SuccessfullyDoneState extends State<SuccessfullyDone> {
  NavigationService navigationService = locator<NavigationService>();

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        navigationService.navigateToView(widget.className);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon
            SvgPicture.asset(
              IconsPath.success,
              width: width * 0.3,
              height: width * 0.3,
              colorFilter:
                  ColorFilter.mode(AppColors.primaryGreen, BlendMode.srcIn),
            ),
            // For Spacing
            SizedBox(
              height: height * 0.015,
            ),
            // Message
            Text(
              widget.msg,
              style: TextStyle(
                color: AppColors.primaryBlack,
                fontSize: width * 0.06,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }
}

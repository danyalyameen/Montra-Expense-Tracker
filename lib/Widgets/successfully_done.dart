import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';

class SuccessfullyDone extends StatelessWidget {
  final String msg;
  // ignore: prefer_typing_uninitialized_variables
  final className;
  const SuccessfullyDone({super.key, required this.msg, this.className});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Future.delayed(
      const Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
              builder: (context) => className,
            ));
      },
    );
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              IconsPath.success,
              width: width * 0.3,
              height: width * 0.3,
              colorFilter:
                  ColorFilter.mode(AppColors.primaryGreen, BlendMode.srcIn),
            ),
            SizedBox(
              height: height * 0.015,
            ),
            Text(
              msg,
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

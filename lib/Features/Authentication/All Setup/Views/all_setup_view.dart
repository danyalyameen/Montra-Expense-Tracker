import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Authentication/All%20Setup/Views/all_setup_view_model.dart';
import 'package:stacked/stacked.dart';

// ignore: must_be_immutable
class AllSetupView extends StackedView<AllSetupViewModel> {
  AllSetupView({super.key});

  String successTitle = "You are set!";

  @override
  Widget builder(
      BuildContext context, AllSetupViewModel viewModel, Widget? child) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
              successTitle,
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

  @override
  AllSetupViewModel viewModelBuilder(BuildContext context) =>
      AllSetupViewModel();
}

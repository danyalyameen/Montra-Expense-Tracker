import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Features/Splash%20Screen/Views/splash_screen_view_model.dart';
import 'package:stacked/stacked.dart';

// ignore: must_be_immutable
class SplashScreenView extends StackedView<SplashScreenViewModel> {
  SplashScreenView({super.key});

  String appName = "montra";

  @override
  Widget builder(
      BuildContext context, SplashScreenViewModel viewModel, Widget? child) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.primaryViolet,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: height * 0.458,
              left: width * 0.32,
            ),
            child: Container(
              width: width * 0.2,
              height: width * 0.2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.pinkAccent.withOpacity(0.6),
                    spreadRadius: width * 0.014,
                    blurRadius: width * 0.08,
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Text(
              appName,
              style: TextStyle(
                color: AppColors.primaryLight,
                fontSize: width * 0.14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  SplashScreenViewModel viewModelBuilder(BuildContext context) =>
      SplashScreenViewModel();
}

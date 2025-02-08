import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Features/Splash%20Screen/Views/splash_screen_view_model.dart';
import 'package:stacked/stacked.dart';

class SplashScreenView extends StackedView<SplashScreenViewModel> {
  const SplashScreenView({super.key});

  // App Logo means Montra Text
  final String appLogo = "montra";

  // This Function is Called when the Screen is Ready to View
  @override
  void onViewModelReady(SplashScreenViewModel viewModel) {
    viewModel.navigation();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
      BuildContext context, SplashScreenViewModel viewModel, Widget? child) {
    // Get Screen Size of Device
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      // Prevent the UI Disturbance when Keyboard is Open
      resizeToAvoidBottomInset: false,
      // Background Color of Screen
      backgroundColor: AppColors.primaryViolet,
      // Main Logo of Splash Screen
      body: _Logo(width: width, height: height, appLogo: appLogo),
    );
  }

  @override
  SplashScreenViewModel viewModelBuilder(BuildContext context) =>
      SplashScreenViewModel();
}

// Main Logo
class _Logo extends StatelessWidget {
  final double width, height;
  final String appLogo;
  const _Logo(
      {required this.width, required this.height, required this.appLogo});

  @override
  Widget build(BuildContext context) {
    // Use Stack for Placing widgets on top of each other
    return Stack(
      children: [
        // Glowing Circle behind the Logo of App or Splash Screen
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
                // Glowing Effect means shadow of App
                BoxShadow(
                  color: Colors.pinkAccent.withValues(alpha: 0.6),
                  spreadRadius: width * 0.014,
                  blurRadius: width * 0.08,
                ),
              ],
            ),
          ),
        ),
        // App Logo or App Name Text
        Center(
          child: Text(
            appLogo,
            style: TextStyle(
              color: AppColors.primaryLight,
              fontSize: width * 0.14,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

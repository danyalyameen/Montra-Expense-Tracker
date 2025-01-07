import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Features/Splash%20Screen/Views/splash_screen_view_model.dart';
import 'package:stacked/stacked.dart';

class SplashScreenView extends StackedView<SplashScreenViewModel> {
  const SplashScreenView({super.key});

  final String appLogo = "montra";

  @override
  void onViewModelReady(SplashScreenViewModel viewModel) async {
    await Future.delayed(const Duration(seconds: 3));
    viewModel.navigationService.replaceWithOnBoardingView();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
      BuildContext context, SplashScreenViewModel viewModel, Widget? child) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.primaryViolet,
      body: _Logo(width: width, height: height, appLogo: appLogo),
    );
  }

  @override
  SplashScreenViewModel viewModelBuilder(BuildContext context) =>
      SplashScreenViewModel();
}

class _Logo extends StatelessWidget {
  final double width, height;
  final String appLogo;
  const _Logo(
      {required this.width, required this.height, required this.appLogo});

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                  color: Colors.pinkAccent.withValues(alpha: 0.6),
                  spreadRadius: width * 0.014,
                  blurRadius: width * 0.08,
                ),
              ],
            ),
          ),
        ),
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

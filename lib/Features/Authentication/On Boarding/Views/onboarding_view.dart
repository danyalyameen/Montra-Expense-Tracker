import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Features/Authentication/On%20Boarding/Views/onboarding_view_model.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:stacked/stacked.dart';

class OnBoardingView extends StackedView<OnBoardingViewModel> {
  const OnBoardingView({super.key});

  @override
  void onViewModelReady(OnBoardingViewModel viewModel) {
    super.onViewModelReady(viewModel);
    viewModel.notificationBarService.blackNotificationBar();
    // Call Function When Screen or View is Ready
    viewModel.automaticChangePage();
  }

  // Dispose Timer and Page Controller
  @override
  void onDispose(OnBoardingViewModel viewModel) {
    viewModel.timer.cancel();
    viewModel.pageController.dispose();
    super.onDispose(viewModel);
  }

  @override
  Widget builder(
      BuildContext context, OnBoardingViewModel viewModel, Widget? child) {
    // Get Screen Size of Device
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          // Main Onboarding Items
          _OnBardingItem(
            width: width,
            height: height,
            data: Database.onBoardingData,
          ),
          // Dot Indicators
          _ShowIndicators(
            width: width,
            height: height,
          ),
          // Buttons For Navigation
          _AuthenticationButtons(
            width: width,
            height: height,
            navigationSignUp: viewModel.navigationSignUp,
            navigationLogin: viewModel.navigationLogin,
          ),
        ],
      ),
    );
  }

  @override
  OnBoardingViewModel viewModelBuilder(BuildContext context) =>
      OnBoardingViewModel();

  @override
  bool get reactive => false;
}

class _OnBardingItem extends ViewModelWidget<OnBoardingViewModel> {
  final double width, height;
  final List<Map<String, dynamic>> data;
  const _OnBardingItem({
    required this.width,
    required this.height,
    required this.data,
  });

  // Declare Data Keys
  final String iconKey = "Icon";
  final String titleKey = "Title";
  final String descriptionKey = "Description";

  @override
  Widget build(BuildContext context, OnBoardingViewModel viewModel) {
    // Page View Builder for Making the On Boarding Items
    return SizedBox(
      width: width,
      height: height * 0.7,
      child: PageView.builder(
        controller: viewModel.pageController,
        itemCount: data.length,
        onPageChanged: (value) {
          // Update Current Index and Update the UI
          viewModel.updateCurrentIndex(value);
        },
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: height * 0.16),
            child: Column(
              children: [
                // Picture of On Boarding Item
                SvgPicture.asset(
                  data[index][iconKey],
                  width: width * 0.7,
                  height: width * 0.7,
                ),
                // For Spacing
                SizedBox(
                  height: height * 0.01,
                ),
                // Title and Description
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                  child: SizedBox(
                    width: width,
                    height: height * 0.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Title
                        Text(
                          data[index][titleKey],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.black75,
                            fontSize: width * 0.08,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        // For Spacing
                        SizedBox(
                          height: height * 0.01,
                        ),
                        // Description
                        Text(
                          data[index][descriptionKey],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.black25,
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ShowIndicators extends ViewModelWidget<OnBoardingViewModel> {
  final double width, height;
  const _ShowIndicators({required this.width, required this.height});

  @override
  Widget build(BuildContext context, OnBoardingViewModel viewModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        Database.onBoardingData.length,
        (index) {
          return Container(
            // Changing width and height of Dot Indicators
            width:
                viewModel.currentIndex == index ? width * 0.04 : width * 0.025,
            height:
                viewModel.currentIndex == index ? width * 0.04 : width * 0.025,
            margin: EdgeInsets.all(width * 0.01),
            // Indicators
            child: CircleAvatar(
              backgroundColor: index == viewModel.currentIndex
                  ? AppColors.primaryViolet
                  : AppColors.violet20,
            ),
          );
        },
      ),
    );
  }
}

class _AuthenticationButtons extends StatelessWidget {
  final double width, height;
  final Function navigationLogin, navigationSignUp;
  const _AuthenticationButtons({
    required this.width,
    required this.height,
    required this.navigationLogin,
    required this.navigationSignUp,
  });

  // Text of Authentication Buttons
  final String signUpText = "Sign Up";
  final String loginText = "Login";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: height * 0.02,
      ),
      child: Column(
        children: [
          // Sign Up Button
          CustomElevatedButton(
            width: width,
            height: height,
            text: signUpText,
            onPressed: () => navigationSignUp(),
          ),
          // For Spacing
          SizedBox(
            height: height * 0.015,
          ),
          // Login Button
          CustomElevatedButton(
            width: width,
            height: height,
            text: loginText,
            textStyle: TextStyle(
                color: AppColors.primaryViolet, fontSize: width * 0.045),
            backgroundColor: AppColors.violet20,
            onPressed: () => navigationLogin(),
          ),
        ],
      ),
    );
  }
}

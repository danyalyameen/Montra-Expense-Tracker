import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Features/Authentication/On%20Boarding/Views/onboarding_view_model.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:stacked/stacked.dart';

// ignore: must_be_immutable
class OnBoardingView extends StackedView<OnBoardingViewModel> {
  OnBoardingView({super.key});

  String iconKey = "Icon";
  String titleKey = "Title";
  String descriptionKey = "Description";
  String signUpText = "Sign Up";
  String loginText = "Login";

  @override
  Widget builder(
      BuildContext context, OnBoardingViewModel viewModel, Widget? child) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          OnBardingItem(
            width: width,
            height: height,
            iconKey: iconKey,
            titleKey: titleKey,
            descriptionKey: descriptionKey,
            data: Database.onBoardingData,
            updateCurrentIndex: (index) {
              viewModel.updateCurrentIndex(index);
            },
          ),
          ShowIndicators(
            width: width,
            height: height,
            data: Database.onBoardingData,
            currentIndex: viewModel.currentIndex,
          ),
          AuthenticationButtons(
            width: width,
            height: height,
            loginText: loginText,
            signUpText: signUpText,
          ),
        ],
      ),
    );
  }

  @override
  OnBoardingViewModel viewModelBuilder(BuildContext context) =>
      OnBoardingViewModel();
}

class OnBardingItem extends StatelessWidget {
  final double width, height;
  final List<Map<String, dynamic>> data;
  final String iconKey, titleKey, descriptionKey;
  final Function(int index) updateCurrentIndex;
  const OnBardingItem(
      {super.key,
      required this.width,
      required this.height,
      required this.data,
      required this.iconKey,
      required this.titleKey,
      required this.descriptionKey,
      required this.updateCurrentIndex});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height * 0.75,
      child: PageView.builder(
        itemCount: data.length,
        onPageChanged: (value) {
          updateCurrentIndex(value);
        },
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(top: height * 0.2),
            child: Column(
              children: [
                SvgPicture.asset(
                  data[index][iconKey],
                  width: width * 0.7,
                  height: width * 0.7,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                  child: SizedBox(
                    width: width,
                    height: height * 0.2,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          data[index][titleKey],
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.black75,
                            fontSize: width * 0.08,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
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

class ShowIndicators extends StatelessWidget {
  final double width, height;
  final List<Map<String, dynamic>> data;
  final int currentIndex;
  const ShowIndicators(
      {super.key,
      required this.width,
      required this.height,
      required this.data,
      required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        data.length,
        (index) {
          return Container(
            width: currentIndex == index ? width * 0.04 : width * 0.025,
            height: currentIndex == index ? width * 0.04 : width * 0.025,
            margin: EdgeInsets.all(width * 0.01),
            child: CircleAvatar(
              backgroundColor: index == currentIndex
                  ? AppColors.primaryViolet
                  : AppColors.violet20,
            ),
          );
        },
      ),
    );
  }
}

class AuthenticationButtons extends StatelessWidget {
  final double width, height;
  final String loginText, signUpText;
  const AuthenticationButtons(
      {super.key,
      required this.width,
      required this.height,
      required this.loginText,
      required this.signUpText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: height * 0.02,
      ),
      child: Column(
        children: [
          CustomElevatedButton(width: width, height: height, text: signUpText),
          SizedBox(
            height: height * 0.015,
          ),
          CustomElevatedButton(
            width: width,
            height: height,
            text: loginText,
            textStyle: TextStyle(
                color: AppColors.primaryViolet, fontSize: width * 0.045),
            backgroundColor: AppColors.violet20,
          ),
        ],
      ),
    );
  }
}

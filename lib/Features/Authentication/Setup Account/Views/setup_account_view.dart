import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Features/Authentication/Setup%20Account/Views/setup_account_view_model.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:stacked/stacked.dart';

// ignore: must_be_immutable
class SetupAccountView extends StackedView<SetupAccountViewModel> {
  SetupAccountView({super.key});

  String title = "Let's setup your account!";
  String description = "Account can be your bank, credit card or your wallet.";
  String buttonText = "Let's go";

  @override
  Widget builder(
      BuildContext context, SetupAccountViewModel viewModel, Widget? child) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: height * 0.1),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: width * 0.05,
                right: width * 0.12,
              ),
              child: Column(
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColors.primaryBlack,
                      fontSize: width * 0.1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Text(
                    description,
                    style: TextStyle(
                      color: AppColors.primaryBlack,
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.58),
              child: CustomElevatedButton(
                  width: width, height: height, text: buttonText),
            )
          ],
        ),
      ),
    );
  }

  @override
  SetupAccountViewModel viewModelBuilder(BuildContext context) =>
      SetupAccountViewModel();
}
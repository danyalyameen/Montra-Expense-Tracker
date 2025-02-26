import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Features/Authentication/Setup%20Account/Views/setup_account_view_model.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:stacked/stacked.dart';

class SetupAccountView extends StackedView<SetupAccountViewModel> {
  const SetupAccountView({super.key});

  // Variables
  final String title = "Let's setup your account!";
  final String description =
      "Account can be your bank, credit card or your wallet.";
  final String buttonText = "Let's go";

  @override
  void onViewModelReady(SetupAccountViewModel viewModel) {
    super.onViewModelReady(viewModel);
    // Change Notification Bar Color
    viewModel.notificationBarService.blackNotificationBar();
  }

  @override
  Widget builder(
      BuildContext context, SetupAccountViewModel viewModel, Widget? child) {
    // Get Screen Size of Device
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      body: Padding(
        padding: EdgeInsets.only(top: height * 0.1),
        child: Column(
          children: [
            // Title and Description
            Padding(
              padding: EdgeInsets.only(
                left: width * 0.05,
                right: width * 0.12,
              ),
              child: Column(
                children: [
                  // Title
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColors.primaryBlack,
                      fontSize: width * 0.1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  // For Spacing
                  SizedBox(
                    height: height * 0.02,
                  ),
                  // Description
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
            // Continue Button
            Padding(
              padding: EdgeInsets.only(top: height * 0.55),
              child: CustomElevatedButton(
                width: width,
                height: height,
                text: buttonText,
                onPressed: () => viewModel.setupWalletNavigation(),
              ),
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

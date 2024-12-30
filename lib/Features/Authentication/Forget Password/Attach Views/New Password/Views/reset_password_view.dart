import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Features/Authentication/Forget%20Password/Attach%20Views/New%20Password/Views/reset_password_view_model.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:montra_expense_tracker/Widgets/custom_text_field.dart';
import 'package:stacked/stacked.dart';

class ResetPasswordView extends StackedView<ResetPasswordViewModel> {
  const ResetPasswordView({super.key});

  final String appBarTitle = "Reset Password";
  final String newPasswordHintText = "New Password";
  final String reptypeNewPasswordHintText = "Retype New Password";
  final String buttonText = "Continue";

  @override
  Widget builder(
      BuildContext context, ResetPasswordViewModel viewModel, Widget? child) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: blackAppBar(
        title: appBarTitle,
        width: width,
        height: height,
        onTap: () => viewModel.back(),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: height * 0.04),
        child: Column(
          children: [
            CustomTextField(
              controller: viewModel.newPasswordEditingController,
              width: width,
              hintText: newPasswordHintText,
              height: height,
            ),
            SizedBox(
              height: height * 0.03,
            ),
            CustomTextField(
              controller: viewModel.retypeNewPasswordEditingController,
              width: width,
              hintText: reptypeNewPasswordHintText,
              height: height,
            ),
            SizedBox(
              height: height * 0.03,
            ),
            CustomElevatedButton(
              width: width,
              height: height,
              text: buttonText,
              onPressed: () => viewModel.setupPinNavigation(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  ResetPasswordViewModel viewModelBuilder(BuildContext context) =>
      ResetPasswordViewModel();
}

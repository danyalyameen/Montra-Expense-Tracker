import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Features/Authentication/Forget%20Password/Views/forget_password_view_model.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:montra_expense_tracker/Widgets/custom_text_field.dart';
import 'package:stacked/stacked.dart';

class ForgetPasswordView extends StackedView<ForgetPasswordViewModel> {
  const ForgetPasswordView({super.key});

  final String appBarTitle = "Forget Password";
  final String title =
      "Don't worry. \nEnter your email and we'll send you a link to reset your password.";
  final String textFieldHintText = "Email";
  final String buttonHintText = "Continue";

  @override
  Widget builder(
      BuildContext context, ForgetPasswordViewModel viewModel, Widget? child) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: blackAppBar(
        title: appBarTitle,
        width: width,
        height: height,
        onTap: () => viewModel.back(),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: height * 0.1,
              left: width * 0.05,
              right: width * 0.05,
            ),
            child: Text(
              title,
              style: TextStyle(
                color: AppColors.primaryBlack,
                fontWeight: FontWeight.w700,
                fontSize: width * 0.065,
              ),
            ),
          ),
          SizedBox(
            height: height * 0.04,
          ),
          CustomTextField(
            controller: viewModel.emailController,
            width: width,
            hintText: textFieldHintText,
            height: height,
          ),
          SizedBox(
            height: height * 0.04,
          ),
          CustomElevatedButton(
            width: width,
            height: height,
            text: buttonHintText,
            onPressed: () => viewModel.resetPasswordNavigation(),
          ),
        ],
      ),
    );
  }

  @override
  ForgetPasswordViewModel viewModelBuilder(BuildContext context) =>
      ForgetPasswordViewModel();
}

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Features/Authentication/Forget%20Password/Views/forget_password_view_model.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:montra_expense_tracker/Widgets/custom_text_form_field.dart';
import 'package:stacked/stacked.dart';

class ForgetPasswordView extends StackedView<ForgetPasswordViewModel> {
  const ForgetPasswordView({super.key});

  // Variables
  final String appBarTitle = "Forget Password";
  final String title =
      "Don't worry. \nEnter your email and we'll send you a link to reset your password.";
  final String textFieldHintText = "Email";
  final String buttonHintText = "Continue";

  @override
  Widget builder(
      BuildContext context, ForgetPasswordViewModel viewModel, Widget? child) {
    // Get Screen Size of Device
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      appBar: blackAppBar(
        title: appBarTitle,
        width: width,
        height: height,
      ),
      body: Column(
        children: [
          // Title Text
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
          // For Spacing
          SizedBox(
            height: height * 0.04,
          ),
          // Email Text Field
          Form(
            key: viewModel.formKey,
            child: CustomTextFormField(
              width: width,
              height: height,
              hintText: textFieldHintText,
              controller: viewModel.emailController,
              validator: (value) {
                return viewModel.validateEmail(value);
              },
            ),
          ),
          // For Spacing
          SizedBox(
            height: height * 0.04,
          ),
          // Continue Button
          CustomElevatedButton(
            width: width,
            height: height,
            backgroundColor: viewModel.showLoading
                ? AppColors.violet20
                : AppColors.primaryViolet,
            onPressed: () => viewModel.sendResetPasswordLink(),
            child: viewModel.showLoading
                ? SpinKitThreeBounce(
                    color: AppColors.primaryViolet,
                    size: width * 0.06,
                  )
                : Text(
                    buttonHintText,
                    style: TextStyle(
                      color: AppColors.primaryLight,
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          )
        ],
      ),
    );
  }

  @override
  ForgetPasswordViewModel viewModelBuilder(BuildContext context) =>
      ForgetPasswordViewModel();

  @override
  void onDispose(ForgetPasswordViewModel viewModel) {
    viewModel.emailController.dispose();
    super.onDispose(viewModel);
  }
}

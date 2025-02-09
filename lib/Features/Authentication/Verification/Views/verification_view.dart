import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Authentication/Verification/Views/verification_view_model.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:stacked/stacked.dart';

class VerificationView extends StackedView<VerificationViewModel> {
  const VerificationView({super.key});

  // Variables
  final String appBarTitle = "Verification";
  final String verifyButtonText = "Check";

  @override
  void onViewModelReady(VerificationViewModel viewModel) async {
    super.onViewModelReady(viewModel);
    // Send Email Verification Link When Screen Loaded Completely
    await viewModel.auth.sendEmailVerificationLink();
    // Start Resend Timer Function
    viewModel.startResendTimer();
  }

  @override
  Widget builder(
      BuildContext context, VerificationViewModel viewModel, Widget? child) {
    // Get Screen Size of Device
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: blackAppBar(
        title: appBarTitle,
        width: width,
        height: height,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icon For Verify Email
          Padding(
            padding: EdgeInsets.only(top: height * 0.08),
            child: Center(
              child: SizedBox(
                width: width * 0.5,
                height: width * 0.5,
                child: SvgPicture.asset(
                  IconsPath.verifyEmail,
                  colorFilter: ColorFilter.mode(
                    AppColors.primaryViolet,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          // Main Verificaiton UI
          _VerificationUI(
            width: width,
            height: height,
            email: viewModel.getEmail(),
          ),
          // Resend Verification Button and Timer
          Padding(
            padding: EdgeInsets.only(left: width * 0.06),
            child: _ResendVerification(
              width: width,
              height: height,
            ),
          ),
          // For Spacing
          SizedBox(
            height: height * 0.03,
          ),
          // Check Button
          Center(
            child: CustomElevatedButton(
              width: width,
              height: height,
              text: verifyButtonText,
              onPressed: () {
                viewModel.checkEmailVerifiedOrNot();
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  VerificationViewModel viewModelBuilder(BuildContext context) =>
      VerificationViewModel();

  @override
  bool get reactive => false;
}

class _VerificationUI extends StatelessWidget {
  final double width, height;
  final String email;
  const _VerificationUI(
      {required this.width, required this.height, required this.email});

  // Variables
  final String title = "Check Your Inbox For Verify Email";
  final String descriptionStart = "We send verification link to your email ";
  final String descriptionEnd = "You can check your inbox";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.25,
      width: width,
      child: Padding(
        padding: EdgeInsets.only(
          left: width * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            SizedBox(
              width: width * 0.9,
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: descriptionStart,
                      style: TextStyle(
                        color: AppColors.primaryBlack,
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: email,
                      style: TextStyle(
                        color: AppColors.primaryViolet,
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text: descriptionEnd,
                      style: TextStyle(
                        color: AppColors.primaryBlack,
                        fontSize: width * 0.045,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResendVerification extends ViewModelWidget<VerificationViewModel> {
  final double width, height;
  const _ResendVerification({required this.width, required this.height});
  // Variables
  final String noReceiveCodeText = "I didn't received the Link? Send again";

  @override
  Widget build(BuildContext context, VerificationViewModel viewModel) {
    return viewModel.startTimer == 0
        ? InkWell(
            onTap: () {
              viewModel.startResendTimer();
              viewModel.startTimer = 120;
              viewModel.auth.sendEmailVerificationLink();
              viewModel.notifyListeners();
            },
            child: Text(
              noReceiveCodeText,
              style: TextStyle(
                color: AppColors.primaryViolet,
                fontSize: width * 0.045,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.primaryViolet,
              ),
            ),
          )
        : Text(
            viewModel.resendTiming,
            style: TextStyle(
              color: AppColors.primaryViolet,
              fontSize: width * 0.05,
              fontWeight: FontWeight.w500,
            ),
          );
  }
}

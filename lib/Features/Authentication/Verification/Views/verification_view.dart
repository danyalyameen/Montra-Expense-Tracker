import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Features/Authentication/Verification/Views/verification_view_model.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:stacked/stacked.dart';

class VerificationView extends StackedView<VerificationViewModel> {
  const VerificationView({super.key});

  final String appBarTitle = "Verification";
  final String verifyButtonText = "Verify";

  @override
  Widget builder(
      BuildContext context, VerificationViewModel viewModel, Widget? child) {
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
        children: [
          _VerificationUI(
            width: width,
            height: height,
            formKey: viewModel.formKey,
          ),
          CustomElevatedButton(
            width: width,
            height: height,
            text: verifyButtonText,
            onPressed: () => viewModel.setupPinNavigation(),
          ),
        ],
      ),
    );
  }

  @override
  VerificationViewModel viewModelBuilder(BuildContext context) =>
      VerificationViewModel();
}

class _VerificationUI extends StatelessWidget {
  final double width, height;
  final GlobalKey formKey;
  const _VerificationUI(
      {required this.width,
      required this.height,
      required this.formKey});
  
  final String title = "Enter your Verification Code";
  final String time = "04:59";
  final String descriptionStart = "We send verification code to your email ";
  final String email = "brajaoma*****@gmail.com.";
  final String descriptionEnd = "You can check your inbox";
  final String noReceiveCodeText = "I didn't received the code? Send again";

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.72,
      width: width,
      child: Padding(
        padding: EdgeInsets.only(
          top: height * 0.2,
          left: width * 0.05,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
              height: height * 0.01,
            ),
            Form(
              child: Row(
                children: List.generate(
                  6,
                  (index) {
                    return Padding(
                      padding: EdgeInsets.all(width * 0.02),
                      child: SizedBox(
                        width: width * 0.08,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          showCursor: false,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: width * 0.055,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryBlack,
                          ),
                          onChanged: (value) {
                            if (value.length == 1 && index < 5) {
                              FocusScope.of(context).nextFocus();
                            } else if (value.isEmpty && index > 0) {
                              FocusScope.of(context).previousFocus();
                            }
                          },
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: AppColors.primaryBlack,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: height * 0.06,
            ),
            Text(
              time,
              style: TextStyle(
                color: AppColors.primaryViolet,
                fontSize: width * 0.05,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Expanded(
              child: SizedBox(
                width: width * 0.78,
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
            ),
            SizedBox(
              height: height * 0.02,
            ),
            Expanded(
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
          ],
        ),
      ),
    );
  }
}

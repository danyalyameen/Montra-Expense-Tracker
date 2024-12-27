import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Features/Authentication/Verification/Views/verification_view_model.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:stacked/stacked.dart';

// ignore: must_be_immutable
class VerificationView extends StackedView<VerificationViewModel> {
  VerificationView({super.key});

  String appBarTitle = "Verification";
  String title = "Enter your Verification Code";
  String time = "04:59";
  String descriptionStart = "We send verification code to your email ";
  String email = "brajaoma*****@gmail.com.";
  String descriptionEnd = "You can check your inbox";
  String noReceiveCodeText = "I didn't received the code? Send again";
  String verifyButtonText = "Verify";

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
          VerificationUI(
            width: width,
            height: height,
            title: title,
            time: time,
            descriptionStart: descriptionStart,
            email: email,
            descriptionEnd: descriptionEnd,
            notReceiveCode: noReceiveCodeText,
            formKey: viewModel.formKey,
          ),
          CustomElevatedButton(
            width: width,
            height: height,
            text: verifyButtonText,
          ),
        ],
      ),
    );
  }

  @override
  VerificationViewModel viewModelBuilder(BuildContext context) =>
      VerificationViewModel();
}

class VerificationUI extends StatelessWidget {
  final double width, height;
  final String title,
      time,
      descriptionStart,
      email,
      descriptionEnd,
      notReceiveCode;
  final GlobalKey formKey;
  const VerificationUI(
      {super.key,
      required this.width,
      required this.height,
      required this.title,
      required this.time,
      required this.notReceiveCode,
      required this.descriptionStart,
      required this.email,
      required this.descriptionEnd,
      required this.formKey});

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
                          keyboardType: const TextInputType.numberWithOptions(),
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
                notReceiveCode,
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

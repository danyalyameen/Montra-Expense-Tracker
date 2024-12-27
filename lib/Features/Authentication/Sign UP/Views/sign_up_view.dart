import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Authentication/Sign%20UP/Views/sign_up_view_model.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:montra_expense_tracker/Widgets/custom_text_field.dart';
import 'package:stacked/stacked.dart';

// ignore: must_be_immutable
class SignUpView extends StackedView<SignUpViewModel> {
  SignUpView({super.key});

  String appBarTitle = "Sign Up";
  String nameHintText = "Name";
  String emailHintText = "Email";
  String passwordHintText = "Password";
  String signUpHintText = "Sign Up";
  String otherSignUpItemsHintText = "Or with";
  String googleButtonText = "Sign Up with Google";

  @override
  Widget builder(
      BuildContext context, SignUpViewModel viewModel, Widget? child) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: blackAppBar(
        title: appBarTitle,
        width: width,
        height: height,
        leading: const SizedBox(),
      ),
      body: Column(
        children: [
          SignUPItems(
            width: width,
            height: height,
            nameHintText: nameHintText,
            emailHintText: emailHintText,
            passwordHintText: passwordHintText,
            nameEditingController: viewModel.nameController,
            emailEditingController: viewModel.emailController,
            passwordEditingController: viewModel.passwordController,
            onTap: () => viewModel.onTap(),
            onTapOutside: (event) => viewModel.onTapOutside(context),
            isFocus: viewModel.isFocus,
            onComplete: () => viewModel.onComplete(context),
            isCheck: viewModel.isCheck,
            onChanged: (value) => viewModel.toggleCheck(value),
            signUpHintText: signUpHintText,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.015),
            child: Text(
              otherSignUpItemsHintText,
              style: TextStyle(
                color: AppColors.grey,
                fontSize: width * 0.04,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          OtherSignUpItems(
            width: width,
            height: height,
            buttonText: googleButtonText,
          ),
          Login(width: width, height: height),
        ],
      ),
    );
  }

  @override
  SignUpViewModel viewModelBuilder(BuildContext context) => SignUpViewModel();
}

class SignUPItems extends StatelessWidget {
  final double width, height;
  final String nameHintText, emailHintText, passwordHintText, signUpHintText;
  final TextEditingController nameEditingController,
      emailEditingController,
      passwordEditingController;
  final VoidCallback onTap;
  final VoidCallback onComplete;
  final TapRegionCallback onTapOutside;
  final bool isFocus, isCheck;
  final Function(bool? value) onChanged;
  const SignUPItems(
      {super.key,
      required this.width,
      required this.height,
      required this.nameHintText,
      required this.emailHintText,
      required this.passwordHintText,
      required this.nameEditingController,
      required this.emailEditingController,
      required this.passwordEditingController,
      required this.onTap,
      required this.onTapOutside,
      required this.isFocus,
      required this.onComplete,
      required this.isCheck,
      required this.onChanged,
      required this.signUpHintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.06),
      child: Column(
        children: [
          CustomTextField(
            controller: nameEditingController,
            width: width,
            hintText: nameHintText,
            height: height,
          ),
          SizedBox(
            height: height * 0.02,
          ),
          CustomTextField(
            controller: emailEditingController,
            width: width,
            hintText: emailHintText,
            height: height,
          ),
          SizedBox(
            height: height * 0.02,
          ),
          CustomTextField(
            controller: passwordEditingController,
            width: width,
            hintText: passwordHintText,
            height: height,
            onTap: onTap,
            onTapOutside: onTapOutside,
            onCompleted: onComplete,
            suffixIcon: Container(
              width: width * 0.15,
              height: width * 0.15,
              padding: EdgeInsets.only(right: width * 0.05),
              child: SvgPicture.asset(
                IconsPath.show,
                colorFilter: ColorFilter.mode(
                  isFocus
                      ? AppColors.primaryViolet
                      : AppColors.grey.withOpacity(0.8),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Row(
              children: [
                Transform.scale(
                  scale: width * 0.004,
                  child: Checkbox(
                    value: isCheck,
                    onChanged: (value) => onChanged(value),
                    activeColor: AppColors.primaryViolet,
                    checkColor: AppColors.primaryLight,
                    side: BorderSide(
                      color: AppColors.primaryViolet,
                      width: width * 0.004,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(width * 0.013),
                    ),
                  ),
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "By signing up, you agree to the ",
                          style: TextStyle(
                            color: AppColors.primaryBlack,
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        TextSpan(
                          text: "Terms of Service and Privacy Policy",
                          style: TextStyle(
                            color: AppColors.primaryViolet,
                            fontSize: width * 0.04,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          CustomElevatedButton(
              width: width, height: height, text: signUpHintText)
        ],
      ),
    );
  }
}

class OtherSignUpItems extends StatelessWidget {
  final double width, height;
  final String buttonText;
  const OtherSignUpItems(
      {super.key,
      required this.width,
      required this.height,
      required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width * 0.9,
      height: height * 0.07,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width * 0.04),
        border: Border.all(
          color: AppColors.light60,
          width: width * 0.004,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            IconsPath.google,
            width: width * 0.07,
            height: width * 0.07,
          ),
          SizedBox(
            width: width * 0.04,
          ),
          Text(
            buttonText,
            style: TextStyle(
              color: AppColors.black75.withOpacity(0.95),
              fontSize: width * 0.05,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}

class Login extends StatelessWidget {
  final double width, height;
  const Login({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Already have an account? ",
            style: TextStyle(
              color: AppColors.grey,
              fontSize: width * 0.045,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "Login",
            style: TextStyle(
              color: AppColors.primaryViolet,
              fontSize: width * 0.042,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.primaryViolet,
            ),
          ),
        ],
      ),
    );
  }
}

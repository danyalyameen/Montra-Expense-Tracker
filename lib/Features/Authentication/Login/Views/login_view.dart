import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Authentication/Login/Views/login_view_model.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:montra_expense_tracker/Widgets/custom_text_field.dart';
import 'package:stacked/stacked.dart';

// ignore: must_be_immutable
class LoginView extends StackedView<LoginViewModel> {
  LoginView({super.key});

  String appBarTitle = "Login";
  String emailHintText = "Email";
  String passwordHintText = "Password";
  String loginHintText = "Login";
  String forgetPasswordHintText = "Forget Password?";
  String googleButtonText = "Login with Google";

  @override
  Widget builder(
      BuildContext context, LoginViewModel viewModel, Widget? child) {
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
          LoginItems(
            width: width,
            height: height,
            emailHintText: emailHintText,
            passwordHintText: passwordHintText,
            emailEditingController: viewModel.emailController,
            passwordEditingController: viewModel.passwordController,
            onTap: () => viewModel.onTap(),
            onTapOutside: (event) => viewModel.onTapOutside(context),
            isFocus: viewModel.isFocus,
            onComplete: () => viewModel.onComplete(context),
            loginHintText: loginHintText,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.04),
            child: Text(
              forgetPasswordHintText,
              style: TextStyle(
                color: AppColors.primaryViolet,
                fontSize: width * 0.05,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          OtherLoginItems(
            width: width,
            height: height,
            buttonText: googleButtonText,
          ),
          SignUp(width: width, height: height),
        ],
      ),
    );
  }

  @override
  LoginViewModel viewModelBuilder(BuildContext context) => LoginViewModel();
}

class LoginItems extends StatelessWidget {
  final double width, height;
  final String emailHintText, passwordHintText, loginHintText;
  final TextEditingController emailEditingController, passwordEditingController;
  final VoidCallback onTap;
  final VoidCallback onComplete;
  final TapRegionCallback onTapOutside;
  final bool isFocus;
  const LoginItems(
      {super.key,
      required this.width,
      required this.height,
      required this.emailHintText,
      required this.passwordHintText,
      required this.emailEditingController,
      required this.passwordEditingController,
      required this.onTap,
      required this.onTapOutside,
      required this.isFocus,
      required this.onComplete,
      required this.loginHintText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.06),
      child: Column(
        children: [
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
          CustomElevatedButton(
              width: width, height: height, text: loginHintText)
        ],
      ),
    );
  }
}

class OtherLoginItems extends StatelessWidget {
  final double width, height;
  final String buttonText;
  const OtherLoginItems(
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

class SignUp extends StatelessWidget {
  final double width, height;
  const SignUp({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account yet? ",
            style: TextStyle(
              color: AppColors.grey,
              fontSize: width * 0.045,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            "Sign Up",
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

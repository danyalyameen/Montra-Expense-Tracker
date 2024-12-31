import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Authentication/Login/Views/login_view_model.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:montra_expense_tracker/Widgets/custom_text_field.dart';
import 'package:stacked/stacked.dart';

class LoginView extends StackedView<LoginViewModel> {
  const LoginView({super.key});

  final String appBarTitle = "Login";
  final String forgetPasswordHintText = "Forget Password?";

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
          _LoginItems(
            width: width,
            height: height,
            verificationNavigation: viewModel.verificationNavigation,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.04),
            child: InkWell(
              onTap: () => viewModel.forgetPasswordNavigation(),
              child: Text(
                forgetPasswordHintText,
                style: TextStyle(
                  color: AppColors.primaryViolet,
                  fontSize: width * 0.05,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          _OtherLoginItems(
            width: width,
            height: height,
          ),
          _SignUp(
            width: width,
            height: height,
            signUpNavigation: viewModel.signUpNavigation,
          ),
        ],
      ),
    );
  }

  @override
  LoginViewModel viewModelBuilder(BuildContext context) => LoginViewModel();
}

class _LoginItems extends ViewModelWidget<LoginViewModel> {
  final double width, height;
  final Function verificationNavigation;
  const _LoginItems(
      {required this.verificationNavigation,
      required this.width,
      required this.height});

  final String emailHintText = "Email";
  final String passwordHintText = "Password";
  final String loginHintText = "Login";

  @override
  Widget build(BuildContext context, LoginViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.06),
      child: Column(
        children: [
          CustomTextField(
            controller: viewModel.emailController,
            width: width,
            hintText: emailHintText,
            height: height,
          ),
          SizedBox(
            height: height * 0.02,
          ),
          CustomTextField(
            controller: viewModel.passwordController,
            width: width,
            hintText: passwordHintText,
            height: height,
            onTap: () => viewModel.onTap(),
            onTapOutside: (event) => viewModel.onTapOutside(context),
            onCompleted: () => viewModel.onComplete(context),
            suffixIcon: Container(
              width: width * 0.15,
              height: width * 0.15,
              padding: EdgeInsets.only(right: width * 0.05),
              child: SvgPicture.asset(
                IconsPath.show,
                colorFilter: ColorFilter.mode(
                  viewModel.isFocus
                      ? AppColors.primaryViolet
                      : AppColors.grey.withValues(alpha: 0.8),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          CustomElevatedButton(
            width: width,
            height: height,
            text: loginHintText,
            onPressed: () => verificationNavigation(),
          )
        ],
      ),
    );
  }
}

class _OtherLoginItems extends StatelessWidget {
  final double width, height;
  const _OtherLoginItems({
    required this.width,
    required this.height,
  });
  final String googleButtonText = "Login with Google";

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
            googleButtonText,
            style: TextStyle(
              color: AppColors.black75.withValues(alpha: 0.95),
              fontSize: width * 0.05,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}

class _SignUp extends StatelessWidget {
  final double width, height;
  final Function signUpNavigation;
  const _SignUp(
      {required this.width,
      required this.height,
      required this.signUpNavigation});

  final signUpTitle = "Don't have an account yet? ";
  final signUp = "Sign Up";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            signUpTitle,
            style: TextStyle(
              color: AppColors.grey,
              fontSize: width * 0.045,
              fontWeight: FontWeight.w500,
            ),
          ),
          InkWell(
            onTap: () => signUpNavigation(),
            child: Text(
              signUp,
              style: TextStyle(
                color: AppColors.primaryViolet,
                fontSize: width * 0.042,
                fontWeight: FontWeight.w500,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.primaryViolet,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Authentication/Sign%20UP/Views/sign_up_view_model.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:montra_expense_tracker/Widgets/custom_text_field.dart';
import 'package:stacked/stacked.dart';

class SignUpView extends StackedView<SignUpViewModel> {
  const SignUpView({super.key});

  final String appBarTitle = "Sign Up";
  final String otherSignUpItemsHintText = "Or with";

  @override
  Widget builder(
      BuildContext context, SignUpViewModel viewModel, Widget? child) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: blackAppBar(
        title: appBarTitle,
        width: width,
        height: height,
        leading: const SizedBox(),
      ),
      body: Column(
        children: [
          _SignUpItems(
            width: width,
            height: height,
            nameEditingController: viewModel.nameController,
            emailEditingController: viewModel.emailController,
            verificationNavigation: viewModel.verificationNavigation,
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
          _OtherSignUpItems(
            width: width,
            height: height,
          ),
          _Login(
            width: width,
            height: height,
            loginNavigation: viewModel.loginNavigation,
          ),
        ],
      ),
    );
  }

  @override
  SignUpViewModel viewModelBuilder(BuildContext context) => SignUpViewModel();

  @override
  bool get reactive => false;
}

class _SignUpItems extends StatelessWidget {
  final double width, height;
  final TextEditingController nameEditingController, emailEditingController;
  final Function verificationNavigation;
  const _SignUpItems({
    required this.width,
    required this.height,
    required this.nameEditingController,
    required this.emailEditingController, required this.verificationNavigation,
  });

  final String nameHintText = "Name";
  final String emailHintText = "Email";
  final String signUpButtonHintText = "Sign Up";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.06),
      child: Column(
        children: [
          CustomTextField(
            width: width,
            height: height,
            hintText: nameHintText,
            controller: nameEditingController,
          ),
          SizedBox(
            height: height * 0.02,
          ),
          CustomTextField(
            width: width,
            height: height,
            hintText: emailHintText,
            controller: emailEditingController,
          ),
          SizedBox(
            height: height * 0.02,
          ),
          _PasswordTextField(width: width, height: height),
          SizedBox(
            height: height * 0.02,
          ),
          _PrivacePolicy(width: width, height: height),
          SizedBox(
            height: height * 0.02,
          ),
          CustomElevatedButton(
              width: width, height: height, text: signUpButtonHintText, onPressed: () => verificationNavigation(),)
        ],
      ),
    );
  }
}

class _PasswordTextField extends ViewModelWidget<SignUpViewModel> {
  final double width, height;
  const _PasswordTextField({required this.width, required this.height});

  final String passwordHintText = "Password";

  @override
  Widget build(BuildContext context, SignUpViewModel viewModel) {
    return CustomTextField(
      width: width,
      height: height,
      hintText: passwordHintText,
      controller: viewModel.passwordController,
      onTap: () => viewModel.onTap(),
      onTapOutside: (event) => viewModel.onTapOutside(context: context),
      onCompleted: () => viewModel.onComplete(context: context),
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
    );
  }
}

class _PrivacePolicy extends ViewModelWidget<SignUpViewModel> {
  final double width, height;
  const _PrivacePolicy({
    required this.width,
    required this.height,
  });

  final String privacyPolicyTitle = "By signing up, you agree to the ";
  final String privacyPolicy = "Terms of Service and Privacy Policy";

  @override
  Widget build(BuildContext context, SignUpViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      child: Row(
        children: [
          Transform.scale(
            scale: width * 0.004,
            child: Checkbox(
              value: viewModel.isCheck,
              onChanged: (value) => viewModel.toggleCheck(value),
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
                    text: privacyPolicyTitle,
                    style: TextStyle(
                      color: AppColors.primaryBlack,
                      fontSize: width * 0.04,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: privacyPolicy,
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
    );
  }
}

class _OtherSignUpItems extends StatelessWidget {
  final double width, height;
  const _OtherSignUpItems({required this.width, required this.height});

  final String buttonText = "Sign Up with Google";

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

class _Login extends StatelessWidget {
  final double width, height;
  final Function loginNavigation;
  const _Login(
      {required this.width,
      required this.height,
      required this.loginNavigation});

  final String loginTextTitle = "Already have an account? ";
  final String loginText = "Login ";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            loginTextTitle,
            style: TextStyle(
              color: AppColors.grey,
              fontSize: width * 0.045,
              fontWeight: FontWeight.w500,
            ),
          ),
          InkWell(
            onTap: () => loginNavigation(),
            child: Text(
              loginText,
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

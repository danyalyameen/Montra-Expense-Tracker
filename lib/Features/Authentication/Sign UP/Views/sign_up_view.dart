import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Authentication/Sign%20UP/Views/sign_up_view_model.dart';
import 'package:montra_expense_tracker/Service/Authentication/auth_service.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:montra_expense_tracker/Widgets/custom_text_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SignUpView extends StackedView<SignUpViewModel> {
  const SignUpView({super.key});

  final String appBarTitle = "Sign Up";
  final String otherSignUpItemsTitle = "Or with";

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
      body: ListView(
        children: [
          _SignUpItems(
            width: width,
            height: height,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.015),
            child: Center(
              child: Text(
                otherSignUpItemsTitle,
                style: TextStyle(
                  color: AppColors.grey,
                  fontSize: width * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          _OtherSignUpItems(
            width: width,
            height: height,
            navigationService: viewModel.navigationService,
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

class _SignUpItems extends ViewModelWidget<SignUpViewModel> {
  final double width, height;
  const _SignUpItems({
    required this.width,
    required this.height,
  });

  final String nameHintText = "Name";
  final String emailHintText = "Email";
  final String passwordHintText = "Password";
  final String signUpButtonHintText = "Sign Up";

  @override
  Widget build(BuildContext context, SignUpViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.06),
      child: Column(
        children: [
          Form(
            key: viewModel.formKey,
            child: Column(
              children: [
                CustomTextFormField(
                  width: width,
                  height: height,
                  hintText: nameHintText,
                  controller: viewModel.nameController,
                  validator: (value) {
                    return viewModel.validateName(value);
                  },
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomTextFormField(
                  width: width,
                  height: height,
                  hintText: emailHintText,
                  controller: viewModel.emailController,
                  validator: (value) {
                    return viewModel.validateEmail(value);
                  },
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                CustomTextFormField(
                  width: width,
                  height: height,
                  hintText: passwordHintText,
                  controller: viewModel.passwordController,
                  obscureText: viewModel.hidePassword,
                  validator: (value) {
                    return viewModel.validatePassword(value);
                  },
                  suffixIcon: Container(
                    width: width * 0.15,
                    height: width * 0.15,
                    padding: EdgeInsets.only(
                        right: width * 0.05,
                        top: height * 0.01,
                        bottom: height * 0.01),
                    child: Center(
                      child: InkWell(
                        borderRadius: BorderRadius.circular(width),
                        onTap: () => viewModel.showOrHidePassword(),
                        child: SvgPicture.asset(
                          IconsPath.show,
                          width: width * 0.15,
                          height: width * 0.15,
                          colorFilter: ColorFilter.mode(
                            viewModel.hidePassword
                                ? AppColors.grey
                                : AppColors.primaryViolet,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: height * 0.02,
          ),
          _PrivacePolicy(width: width, height: height),
          SizedBox(
            height: height * 0.02,
          ),
          CustomElevatedButton(
            width: width,
            height: height,
            backgroundColor: viewModel.showLoading
                ? AppColors.violet20
                : AppColors.primaryViolet,
            onPressed: () => viewModel.verificationNavigation(),
            child: viewModel.showLoading
                ? SpinKitThreeBounce(
                    color: AppColors.primaryViolet,
                    size: width * 0.06,
                  )
                : Text(
                    signUpButtonHintText,
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
                color: viewModel.isError
                    ? AppColors.primaryRed
                    : AppColors.primaryViolet,
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
  final NavigationService navigationService;
  const _OtherSignUpItems(
      {required this.width,
      required this.height,
      required this.navigationService});

  final String buttonText = "Sign Up with Google";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width * 0.9,
        height: height * 0.07,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width * 0.04),
          border: Border.all(
            color: AppColors.light60,
            width: width * 0.004,
          ),
        ),
        child: InkWell(
          onTap: () async {
            try {
              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              await AuthService().googleAuth();
              sharedPreferences.setBool("Logged-In", true);
              navigationService.replaceWithSetupPinView();
            } catch (e) {
              // ignore: avoid_print
              print(e.toString());
            }
          },
          borderRadius: BorderRadius.circular(width * 0.04),
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
        ),
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

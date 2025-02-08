import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Features/Authentication/Login/Views/login_view_model.dart';
import 'package:montra_expense_tracker/Service/Authentication/auth_service.dart';
import 'package:montra_expense_tracker/Widgets/black_app_bar.dart';
import 'package:montra_expense_tracker/Widgets/custom_elevated_button.dart';
import 'package:montra_expense_tracker/Widgets/custom_text_form_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginView extends StackedView<LoginViewModel> {
  const LoginView({super.key});

  // Variables
  final String appBarTitle = "Login";
  final String forgetPasswordHintText = "Forget Password?";

  @override
  Widget builder(
      BuildContext context, LoginViewModel viewModel, Widget? child) {
    // Get Screen Size of Device
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
          // Login UI
          _LoginUI(
            width: width,
            height: height,
          ),
          // Other Login Items Text
          Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.04),
            child: InkWell(
              onTap: () =>
                  viewModel.navigationService.navigateToForgetPasswordView(),
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
          // Other Login Items Means Google Sign In
          _OtherLoginItems(
            width: width,
            height: height,
            navigationService: viewModel.navigationService,
          ),
          // Sign Up Text Button
          _SignUp(
            width: width,
            height: height,
            navigationService: viewModel.navigationService,
          ),
        ],
      ),
    );
  }

  @override
  LoginViewModel viewModelBuilder(BuildContext context) => LoginViewModel();

  @override
  void onDispose(LoginViewModel viewModel) {
    viewModel.emailController.dispose();
    viewModel.passwordController.dispose();
    super.onDispose(viewModel);
  }
}

class _LoginUI extends ViewModelWidget<LoginViewModel> {
  final double width, height;
  const _LoginUI({required this.width, required this.height});

  // Variables
  final String emailHintText = "Email";
  final String passwordHintText = "Password";
  final String loginHintText = "Login";

  @override
  Widget build(BuildContext context, LoginViewModel viewModel) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.06),
      child: Column(
        children: [
          // Text Fields
          Form(
            key: viewModel.formKey,
            child: Column(
              children: [
                // Email Text Field
                CustomTextFormField(
                  width: width,
                  height: height,
                  hintText: emailHintText,
                  controller: viewModel.emailController,
                  validator: (value) {
                    return viewModel.validateEmail(value);
                  },
                ),
                // For Spacing
                SizedBox(
                  height: height * 0.02,
                ),
                // Password Text Field
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
          // For Spacing
          SizedBox(
            height: height * 0.02,
          ),
          // Login Button
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
                    loginHintText,
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

class _OtherLoginItems extends StatelessWidget {
  final double width, height;
  final NavigationService navigationService;
  const _OtherLoginItems({
    required this.width,
    required this.height,
    required this.navigationService,
  });

  // Variables
  final String googleButtonText = "Login with Google";

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
              // Initialize Shared Preference to Ensure Next Time User is Logged In
              SharedPreferences sharedPreferences =
                  await SharedPreferences.getInstance();
              // Open Google Sign In
              UserCredential? credentials = await AuthService().googleAuth();
              // Check User Choose the Account for Login or not if yes then go to Setup Pin
              if (credentials != null) {
                sharedPreferences.setBool("Logged-In", true);
                navigationService.replaceWithSetupPinView();
              }
            } catch (e) {
              // ignore: avoid_print
              print(e.toString());
            }
          },
          borderRadius: BorderRadius.circular(width * 0.04),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Google Icon
              SvgPicture.asset(
                IconsPath.google,
                width: width * 0.07,
                height: width * 0.07,
              ),
              // For Spacing
              SizedBox(
                width: width * 0.04,
              ),
              // Google Button Text
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
        ),
      ),
    );
  }
}

class _SignUp extends StatelessWidget {
  final double width, height;
  final NavigationService navigationService;
  const _SignUp(
      {required this.width,
      required this.height,
      required this.navigationService});

  // Variables
  final signUpTitle = "Don't have an account yet? ";
  final signUp = "Sign Up";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: height * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Title
          Text(
            signUpTitle,
            style: TextStyle(
              color: AppColors.grey,
              fontSize: width * 0.045,
              fontWeight: FontWeight.w500,
            ),
          ),
          // Sign Up Text Button
          InkWell(
            onTap: () => navigationService.replaceWithSignUpView(),
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

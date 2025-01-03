import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';

class LoginViewModel extends ViewModel {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();

  TextEditingController get emailController => _emailEditingController;
  TextEditingController get passwordController => _passwordEditingController;

  bool _isFocus = false;

  bool get isFocus => _isFocus;

  void onTap() {
    _isFocus = true;
    notifyListeners();
  }

  void onTapOutside(BuildContext context) {
    _isFocus = false;
    FocusScope.of(context).unfocus();
    notifyListeners();
  }

  void onComplete(BuildContext context) {
    _isFocus = false;
    FocusScope.of(context).unfocus();
    notifyListeners();
  }

  void verificationNavigation() {
    navigationService.replaceWithVerificationView();
  }

  void forgetPasswordNavigation() {
    navigationService.navigateToForgetPasswordView();
  }

  void signUpNavigation() {
    navigationService.replaceWithSignUpView();
  }
}

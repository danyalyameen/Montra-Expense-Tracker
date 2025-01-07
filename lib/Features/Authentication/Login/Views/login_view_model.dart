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

  onTap() {
    _isFocus = true;
    notifyListeners();
  }

  onTapOutside(BuildContext context) {
    _isFocus = false;
    FocusScope.of(context).unfocus();
    notifyListeners();
  }

  onComplete(BuildContext context) {
    _isFocus = false;
    FocusScope.of(context).unfocus();
    notifyListeners();
  }

  verificationNavigation() {
    navigationService.replaceWithVerificationView();
  }

  forgetPasswordNavigation() {
    navigationService.navigateToForgetPasswordView();
  }

  signUpNavigation() {
    navigationService.replaceWithSignUpView();
  }
}

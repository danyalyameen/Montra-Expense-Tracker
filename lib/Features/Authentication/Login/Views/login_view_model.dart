import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';

class LoginViewModel extends ViewModel {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  TextEditingController get emailController => _emailEditingController;
  TextEditingController get passwordController => _passwordEditingController;

  // * Non Final Fields
  String _error = "";
  bool _showLoading = false;
  bool _hidePassword = true;
  // * Get Non Final Fields
  bool get hidePassword => _hidePassword;
  String get firebaseError => _error;
  bool get showLoading => _showLoading;

  void showOrHidePassword() {
    _hidePassword = !_hidePassword;
    notifyListeners();
  }

  String? validateEmail(String? value) {
    if (value!.isNotEmpty) {
      if (!emailValid.hasMatch(value)) {
        return "Please Enter valid Email";
      } else if (firebaseError == "invalid-credential") {
        return "Invalid Email";
      }
      return null;
    } else {
      return "Please Enter Your Email";
    }
  }

  String? validatePassword(String? value) {
    if (value!.isNotEmpty) {
      if (value.length < 8) {
        return "Password must be at least 8 Characters";
      } else if (firebaseError == "invalid-credential") {
        _error = "";
        return "Invalid Password";
      }
      return null;
    } else {
      return "Please Enter Your Password";
    }
  }

  void verificationNavigation() async {
    if (formKey.currentState!.validate()) {
      try {
        _showLoading = true;
        notifyListeners();
        await auth.login(
            email: emailController.text, password: passwordController.text);
        _showLoading = false;
        notifyListeners();
        navigationService.navigateToVerificationView();
      } on FirebaseAuthException catch (e) {
        _error = e.code;
        _showLoading = false;
        notifyListeners();
      }
    }
  }

  void forgetPasswordNavigation() {
    navigationService.navigateToForgetPasswordView();
  }

  void signUpNavigation() {
    navigationService.replaceWithSignUpView();
  }
}

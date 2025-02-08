import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Variables/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends ViewModel {
  // Final Fields
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  //  Get Final Fields
  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get emailController => _emailEditingController;
  TextEditingController get passwordController => _passwordEditingController;

  // Non Final Fields
  String _error = "";
  bool _hidePassword = true;
  bool _showLoading = false;
  // Get Non Final Fields
  String get firebaseError => _error;
  bool get hidePassword => _hidePassword;
  bool get showLoading => _showLoading;

  // Show Or Hide Password Function
  void showOrHidePassword() {
    _hidePassword = !_hidePassword;
    notifyListeners();
  }

  // Validate Email
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

  // Validate Password
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
        // Show Loading Means Bouncing Balls
        _showLoading = true;
        notifyListeners();
        await auth.login(
            email: emailController.text, password: passwordController.text);
        // Hide Loading
        _showLoading = false;
        notifyListeners();
        // Navigate to Verification View
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setBool(Variables.loggedInKey, true);
        sharedPreferences.setBool(Variables.redirectFromLoginKey, true);
        navigationService.replaceWithSetupPinView();
      } on FirebaseAuthException catch (e) {
        _error = e.code;
        _showLoading = false;
        notifyListeners();
      }
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';

class SignUpViewModel extends ViewModel {
  // * Final Fields
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  // * Get Final Fields
  TextEditingController get nameController => _nameEditingController;
  TextEditingController get emailController => _emailEditingController;
  TextEditingController get passwordController => _passwordEditingController;

  // * Non Final Fields
  bool _isCheck = false;
  bool _isError = false;
  String _error = "";
  bool _showLoading = false;
  bool _hidePassword = true;
  // * Get Non Final Fields
  bool get isCheck => _isCheck;
  bool get isError => _isError;
  String get firebaseError => _error;
  bool get showLoading => _showLoading;
  bool get hidePassword => _hidePassword;

  void showOrHidePassword() {
    _hidePassword = !_hidePassword;
    notifyListeners();
  }

  String? validateName(String? value) {
    if (value!.isEmpty) {
      return "Please Enter Your Name";
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value!.isNotEmpty) {
      if (!emailValid.hasMatch(value)) {
        return "Please Enter valid Email";
      } else if (firebaseError == "email-already-in-use") {
        _error = "";
        return "Email Already used";
      }
      return null;
    } else {
      return "Please Enter Your Email";
    }
  }

  String? validatePassword(String? value) {
    if (value!.isNotEmpty) {
      if (value.length < 8) {
        return "Password Must be at least 8 Characters";
      }
      return null;
    } else {
      return "Please Enter Your Password";
    }
  }

  void toggleCheck(bool? value) {
    value == null ? _isCheck : _isCheck = value;
    notifyListeners();
  }

  void verificationNavigation() async {
    if (formKey.currentState!.validate() && isCheck) {
      try {
        _showLoading = true;
        notifyListeners();
        final userCredentials = await auth.signUp(
            email: emailController.text, password: passwordController.text);
        await auth.addUserDetails(
            id: userCredentials.user!.uid, name: nameController.text);
        _showLoading = false;
        notifyListeners();
        navigationService.navigateToVerificationView();
      } on FirebaseAuthException catch (e) {
        _error = e.code;
        _showLoading = false;
        notifyListeners();
      }
    } else if (isCheck) {
      _isError = false;
      notifyListeners();
    } else if (isCheck == false) {
      _isError = true;
      notifyListeners();
    }
  }

  void loginNavigation() {
    navigationService.replaceWithLoginView();
  }
}

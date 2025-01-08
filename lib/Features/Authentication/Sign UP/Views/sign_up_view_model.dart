import 'dart:math';

import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Variables/variables.dart';

class SignUpViewModel extends ViewModel {
  // * Final Fields
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final FocusNode _passwordFocusNode = FocusNode();
  final emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  // * Get Final Fields
  TextEditingController get nameController => _nameEditingController;
  TextEditingController get emailController => _emailEditingController;
  TextEditingController get passwordController => _passwordEditingController;
  FocusNode get passwordFocusNode => _passwordFocusNode;

  // * Non Final Fields
  bool _isCheck = false;
  bool _isError = false;
  bool _showLoading = false;
  // * Get Non Final Fields
  bool get isCheck => _isCheck;
  bool get isError => _isError;
  bool get showLoading => _showLoading;

  void changeFocus() {
    _passwordFocusNode.addListener(
      () {
        notifyListeners();
      },
    );
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

  void loginNavigation() {
    navigationService.replaceWithLoginView();
  }

  void verificationNavigation() async {
    if (formKey.currentState!.validate() && isCheck) {
      _showLoading = true;
      notifyListeners();
      final userCredential = await authService.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      Variables.uid = userCredential.user!.uid;
      await database.collection('users').doc(userCredential.user!.uid).set({
        'name': nameController.text,
      }).onError(
        (error, stackTrace) {
          print("error: $error");
        },
      );
      log(Variables.uid);
      _showLoading = false;
      navigationService.replaceWithVerificationView();
    } else if (isCheck) {
      _isError = false;
      notifyListeners();
    } else if (isCheck == false) {
      _isError = true;
      notifyListeners();
    }
  }
}

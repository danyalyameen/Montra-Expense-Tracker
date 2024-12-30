import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';

class ForgetPasswordViewModel extends ViewModel {
  final TextEditingController _emailController = TextEditingController();

  TextEditingController get emailController => _emailController;

  void resetPasswordNavigation() {
    navigationService.replaceWithResetPasswordView();
  }

  void back() {
    navigationService.back();
  }
}

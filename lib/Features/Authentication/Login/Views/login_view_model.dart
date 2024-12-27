import 'package:flutter/material.dart';
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
    rebuildUi();
  }

  void onTapOutside(BuildContext context) {
    _isFocus = false;
    FocusScope.of(context).unfocus();
    rebuildUi();
  }

  void onComplete(BuildContext context) {
    _isFocus = false;
    FocusScope.of(context).unfocus();
    rebuildUi();
  }
}

import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';

class SignUpViewModel extends ViewModel {
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();

  TextEditingController get nameController => _nameEditingController;
  TextEditingController get emailController => _emailEditingController;
  TextEditingController get passwordController => _passwordEditingController;

  bool _isFocus = false;
  bool _isCheck = false;

  bool get isFocus => _isFocus;
  bool get isCheck => _isCheck;

  void onTap() {
    _isFocus = true;
    notifyListeners();
  }

  void onTapOutside({required BuildContext context}) {
    _isFocus = false;
    FocusScope.of(context).unfocus();
    notifyListeners();
  }

  void onComplete({required BuildContext context}) {
    _isFocus = false;
    FocusScope.of(context).unfocus();
    notifyListeners();
  }

  void toggleCheck(bool? value) {
    value == null ? _isCheck : _isCheck = value;
    notifyListeners();
  }

  void loginNavigation() {
    navigationService.replaceWithLoginView();
  }

  void verificationNavigation() {
    navigationService.replaceWithVerificationView();
  }
}

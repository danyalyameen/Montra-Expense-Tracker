import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';

class ForgetPasswordViewModel extends ViewModel {
  // Final Fields
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final _emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  // Get Final Fields
  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get emailController => _emailController;

  // Non Final Fields
  bool _showLoading = false;
  // Get Non Final Fields
  bool get showLoading => _showLoading;

  // Validate Email
  String? validateEmail(String? value) {
    if (value!.isNotEmpty) {
      if (!_emailValid.hasMatch(value)) {
        return "Please Enter valid Email";
      }
      return null;
    } else {
      return "Please Enter Your Email";
    }
  }
  
  // Send a Link to Create Password Link
  void sendResetPasswordLink() async {
    if (formKey.currentState!.validate()) {
      try {
        // Show Loading Means Bouncing Balls
        _showLoading = true;
        notifyListeners();
        // Send Password Reset Link
        await auth.sendPasswordResetLink(emailController.text);
        // Show Success Toast
        Fluttertoast.showToast(
          msg: "Password Reset Link Has been successfully send to your email.",
          backgroundColor: AppColors.primaryGreen,
          gravity: ToastGravity.BOTTOM,
          textColor: AppColors.primaryLight,
          toastLength: Toast.LENGTH_LONG,
        );
        // Hide Loading
        _showLoading = false;
        notifyListeners();
        // Navigate Back
        navigationService.back();
      } catch (e) {
        // ignore: avoid_print
        print(e.toString());
      }
    }
  }
}

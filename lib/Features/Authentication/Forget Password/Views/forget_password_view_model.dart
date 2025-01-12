import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';

class ForgetPasswordViewModel extends ViewModel {
  final TextEditingController _emailController = TextEditingController();
  final emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _showLoading = false;

  TextEditingController get emailController => _emailController;
  bool get showLoading => _showLoading;

  void sendResetPasswordLink() async {
    if (formKey.currentState!.validate()) {
      try {
        _showLoading = true;
        notifyListeners();
        await auth.sendPasswordResetLink(emailController.text);
        Fluttertoast.showToast(
          msg: "Password Reset Link Has been successfully send to your email.",
          backgroundColor: AppColors.primaryGreen,
          gravity: ToastGravity.BOTTOM,
          textColor: AppColors.primaryLight,
          toastLength: Toast.LENGTH_LONG,
        );
        _showLoading = false;
        notifyListeners();
        navigationService.back();
      } catch (e) {
        // ignore: avoid_print
        print(e.toString());
      }
    }
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
}

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/variables.dart';
import 'package:montra_expense_tracker/Features/Authentication/User%20Picture/Views/user_picture_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerificationViewModel extends ViewModel {
  // Final Fields
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // Get Final Fields
  GlobalKey<FormState> get formKey => _formKey;
  // Non Final Fields
  int startTimer = 120;
  Timer? _resendTimer;
  // Get Non Final Fields
  Timer? get resendTimer => _resendTimer;

  // Start Timer
  void startResendTimer() {
    if (_resendTimer != null && _resendTimer!.isActive) {
      return;
    }
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (startTimer == 0) {
        timer.cancel();
        notifyListeners();
      } else {
        startTimer--;
        notifyListeners();
      }
    });
  }

  // Get Email to Display on Screen
  String getEmail() {
    String? userEmail = auth.getUser()!.email;
    String displayEmail =
        "${userEmail!.substring(0, 10)}*****${userEmail.substring(userEmail.length - 9, userEmail.length)} ";
    return displayEmail;
  }

  // Show Timer on Text Widget
  String get resendTiming {
    String minutes = (startTimer ~/ 60).toString().padLeft(2, "0");
    String seconds = (startTimer % 60).toString().padLeft(2, "0");
    return "$minutes:$seconds";
  }

  // Check Email is Verified or Not
  void checkEmailVerifiedOrNot() async {
    // Reload the User Information
    FirebaseAuth.instance.currentUser!.reload();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (FirebaseAuth.instance.currentUser!.emailVerified) {
      sharedPreferences.setBool(Variables.loggedInKey, true);
      navigationService.replaceWithSuccessfullyDone(
          msg: "Email Verified", className: const UserPictureView());
    } else {
      Fluttertoast.showToast(
        msg: "Email is Not Yet Verified. Please Check Inbox",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: AppColors.primaryRed,
        textColor: AppColors.primaryLight,
      );
    }
  }
}

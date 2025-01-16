import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VerificationViewModel extends ViewModel {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  GlobalKey<FormState> get formKey => _formKey;

  int startTimer = 120;
  Timer? _resendTimer;

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

  String getEmail() {
    String? userEmail = auth.getUser()!.email;
    String displayEmail =
        "${userEmail!.substring(0, 10)}*****${userEmail.substring(userEmail.length - 10, userEmail.length - 1)}";
    return displayEmail;
  }

  String get resendTiming {
    String minutes = (startTimer ~/ 60).toString().padLeft(2, "0");
    String seconds = (startTimer % 60).toString().padLeft(2, "0");
    return "$minutes:$seconds";
  }

  void checkEmailVerifiedOrNot() async {
    FirebaseAuth.instance.currentUser!.reload();
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (FirebaseAuth.instance.currentUser!.emailVerified) {
      sharedPreferences.setBool("Logged-In", true);
      navigationService.replaceWithEmailVerifiedView();
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

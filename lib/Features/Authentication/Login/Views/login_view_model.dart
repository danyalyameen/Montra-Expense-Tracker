import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Variables/variables.dart';
import 'package:montra_expense_tracker/Models/person_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginViewModel extends ViewModel {
  // Final Fields
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController =
      TextEditingController();
  final _emailValid = RegExp(
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
      if (!_emailValid.hasMatch(value)) {
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
        // Setting values in Shared Preferences
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        sharedPreferences.setBool(Variables.loggedInKey, true);
        // Get User Data
        final data = await firestore.doc(auth.getUser()!.uid).get();
        final personData =
            PersonData.store(data.data() as Map<String, dynamic>);
        // Hide Loading
        _showLoading = false;
        notifyListeners();
        // Navigate to Verification View
        if (personData.imageUploaded == true) {
          navigationService.replaceWithSetupPinView();
        } else {
          navigationService.replaceWithUserPictureView();
        }
      } on FirebaseAuthException catch (e) {
        _error = e.code;
        _showLoading = false;
        notifyListeners();
      }
    }
  }

  void googleAuthentication() async {
    try {
      // Initialize Shared Preference to Ensure Next Time User is Logged In
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      // Open Google Sign In
      UserCredential? credentials = await auth.googleAuth();
      // Check User Choose the Account for Login or not if yes then go to Setup Pin
      if (credentials != null) {
        // Make Variables True
        sharedPreferences.setBool(Variables.loggedInKey, true);
        // Get User Data
        final data = await firestore.doc(auth.getUser()!.uid).get();
        final personData =
            PersonData.store(data.data() as Map<String, dynamic>);
        // Navigate to Verification View
        if (personData.imageUploaded == true) {
          navigationService.replaceWithSetupPinView();
        } else {
          navigationService.replaceWithUserPictureView();
        }
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }
}

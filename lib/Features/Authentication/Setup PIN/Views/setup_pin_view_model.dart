import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';

class SetupPinViewModel extends ViewModel {
  bool isFocus = true;
  String enteredPin = "";

  void setNotificationItemsWhite() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  void resetNotificationItems() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  void addPin(String value) {
    if (enteredPin.length < 4) {
      enteredPin += value;
      print(enteredPin);
    }
    rebuildUi();
  }

  void removePin() {
    if (enteredPin.isNotEmpty) {
      enteredPin = enteredPin.substring(0, enteredPin.length - 1);
      print(enteredPin);
    }
    rebuildUi();
  }
}

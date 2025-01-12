import 'package:fluttertoast/fluttertoast.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetupPinViewModel extends ViewModel {
  String title = "Let's setup your PIN";
  String _enteredPin = "";
  bool retypePin = false;

  String get enteredPin => _enteredPin;

  void addPin(String value) {
    if (_enteredPin.length < 4) {
      _enteredPin += value;
    }
    notifyListeners();
  }

  void removePin() {
    if (_enteredPin.isNotEmpty) {
      _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1);
    }
    notifyListeners();
  }

  void storePin() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool("Setup-Pin") == true &&
        _enteredPin == sharedPreferences.getString("Entered-Pin") &&
        _enteredPin.length == 4) {
      navigationService.replaceWithSetupAccountView();
    } else if (sharedPreferences.getBool("Setup-Pin") == true &&
        _enteredPin != sharedPreferences.getString("Entered-Pin") &&
        _enteredPin.length == 4) {
      Fluttertoast.showToast(
        msg: "Please Enter the Correct Pin.",
        backgroundColor: AppColors.primaryRed,
        gravity: ToastGravity.BOTTOM,
        textColor: AppColors.primaryLight,
        toastLength: Toast.LENGTH_LONG,
      );
    } else if (_enteredPin.length == 4 && retypePin == false) {
      sharedPreferences.setString("Entered-Pin", _enteredPin);
      _enteredPin = "";
      title = "Retype-Pin";
      retypePin = true;
      notifyListeners();
    } else if (_enteredPin.length == 4 && retypePin) {
      if (_enteredPin == sharedPreferences.getString("Entered-Pin")) {
        sharedPreferences.setBool("Setup-Pin", true);
        navigationService.replaceWithSetupAccountView();
      } else {
        Fluttertoast.showToast(
          msg: "Please Enter the Same Pin.",
          backgroundColor: AppColors.primaryRed,
          gravity: ToastGravity.BOTTOM,
          textColor: AppColors.primaryLight,
          toastLength: Toast.LENGTH_LONG,
        );
      }
    } else {
      Fluttertoast.showToast(
        msg: "Please Enter Your Pin.",
        backgroundColor: AppColors.primaryRed,
        gravity: ToastGravity.BOTTOM,
        textColor: AppColors.primaryLight,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }
}

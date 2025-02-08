import 'package:fluttertoast/fluttertoast.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetupPinViewModel extends ViewModel {
  // Non File Variables
  String title = "Let's setup your PIN";
  String _enteredPin = "";
  bool retypePin = false;

  String get enteredPin => _enteredPin;

  // Add Pin Function
  void addPin(String value) {
    if (_enteredPin.length < 4) {
      _enteredPin += value;
    }
    notifyListeners();
  }

  // Remove Pin Function
  void removePin() {
    if (_enteredPin.isNotEmpty) {
      _enteredPin = _enteredPin.substring(0, _enteredPin.length - 1);
    }
    notifyListeners();
  }

  // Store Pin Function & it is the Main Function to Store Pin
  void storePin() async {
    // Initialize Shared Preferences
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // Check Pin is already setup or not
    if (sharedPreferences.getBool(Variables.setupPinKey) == true &&
        _enteredPin == sharedPreferences.getString(Variables.enteredPinKey) &&
        _enteredPin.length == 4) {
      // Account is Setup Or Not. If Account is Setup then go to Dashboard otherwise Setup Account View
      if (sharedPreferences.getBool(Variables.walletSetupKey) == true) {
        navigationService.replaceWithDashboardView();
      } else {
        navigationService.replaceWithSetupAccountView();
      }
      // If Pin is not Correct then Show Toast
    } else if (sharedPreferences.getBool(Variables.setupPinKey) == true &&
        _enteredPin != sharedPreferences.getString(Variables.enteredPinKey) &&
        _enteredPin.length == 4) {
      // Toast Message
      Fluttertoast.showToast(
        msg: "Please Enter the Correct Pin.",
        backgroundColor: AppColors.primaryRed,
        gravity: ToastGravity.BOTTOM,
        textColor: AppColors.primaryLight,
        toastLength: Toast.LENGTH_LONG,
      );
      _enteredPin = "";
      notifyListeners();
      // If Pin is not Setup then Store Pin
    } else if (_enteredPin.length == 4 && retypePin == false) {
      sharedPreferences.setString(Variables.enteredPinKey, _enteredPin);
      _enteredPin = "";
      title = "Retype-Pin";
      retypePin = true;
      notifyListeners();
    } else if (_enteredPin.length == 4 && retypePin) {
      // Check The Retype Pin is Same or Not
      if (_enteredPin == sharedPreferences.getString(Variables.enteredPinKey)) {
        sharedPreferences.setBool(Variables.setupPinKey, true);
        if (sharedPreferences.getBool(Variables.redirectFromLoginKey) == true) {
          navigationService.replaceWithDashboardView();
        } else {
          navigationService.replaceWithSetupAccountView();
        }
      } else {
        // Error Toast Message
        Fluttertoast.showToast(
          msg: "Please Enter the Same Pin.",
          backgroundColor: AppColors.primaryRed,
          gravity: ToastGravity.BOTTOM,
          textColor: AppColors.primaryLight,
          toastLength: Toast.LENGTH_LONG,
        );
        _enteredPin = "";
        notifyListeners();
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

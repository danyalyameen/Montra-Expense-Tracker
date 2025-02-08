import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Variables/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenViewModel extends ViewModel {
  void navigation() async {
    // Navigate to Onboarding View After the Delay of 3 seconds
    await Future.delayed(const Duration(seconds: 3));
    // Initialize Shared Preference So that we can check if the User is Logged In or Not
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getBool(Variables.loggedInKey) == true) {
      // Navigate to Setup Pin View
      navigationService.replaceWithSetupPinView();
    } else {
      // Navigate to On Boarding View
      navigationService.replaceWithOnBoardingView();
    }
  }
}

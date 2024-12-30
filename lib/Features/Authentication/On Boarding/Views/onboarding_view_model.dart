import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';

class OnBoardingViewModel extends ViewModel {
  int currentIndex = 0;

  void updateCurrentIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void navigationSignUp() {
    navigationService.replaceWithSignUpView();
  }

  void navigationLogin() {
    navigationService.replaceWithLoginView();
  }
}

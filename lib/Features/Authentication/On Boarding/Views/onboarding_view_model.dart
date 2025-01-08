import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';

class OnBoardingViewModel extends ViewModel {
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  // * Update Index to change dot indicator color & size
  void updateCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  // * Navigate to SignUp View
  void navigationSignUp() {
    navigationService.replaceWithSignUpView();
  }

  // * Navigate to Login View
  void navigationLogin() {
    navigationService.replaceWithLoginView();
  }
}

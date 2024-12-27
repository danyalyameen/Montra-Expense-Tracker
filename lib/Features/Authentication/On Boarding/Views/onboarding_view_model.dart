import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';

class OnBoardingViewModel extends ViewModel {
  int currentIndex = 0;

  void updateCurrentIndex(int index) {
    currentIndex = index;
    rebuildUi();
  }
}

import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';

class DashboardViewModel extends ViewModel {
  int currentIndex = 0;
  int currentIndexForBottomNavigation = 0;
  bool showItems = false;

  void updateIndex(int index) {
    currentIndex = index;
    rebuildUi();
  }

  void updateIndexForBottomNavigation(int index) {
    currentIndexForBottomNavigation = index;
    rebuildUi();
  }

  void showOrHideItems() {
    showItems = !showItems;
    rebuildUi();
  }
}

import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';

class DashboardViewModel extends ViewModel {
  int currentIndex = 0;
  int currentIndexForBottomNavigation = 0;
  bool showItems = false;

  void notificationNavigation() {
    navigationService.navigateToNotificationView();
  }

  void updateIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void updateIndexForBottomNavigation(int index) {
    currentIndexForBottomNavigation = index;
    notifyListeners();
  }

  void showOrHideItems() {
    showItems = !showItems;
    notifyListeners();
  }
}

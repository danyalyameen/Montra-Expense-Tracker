import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';

class NotificationSettingsViewModel extends ViewModel {
  bool _alertNotification = false;
  bool _budgetAlertNotification = false;

  bool get alertNotification => _alertNotification;
  bool get budgetAlertNotification => _budgetAlertNotification;

  void updateExpense(value) {
    _alertNotification = value;
    notifyListeners();
  }

  void updateBudget(value) {
    _budgetAlertNotification = value;
    notifyListeners();
  }
}

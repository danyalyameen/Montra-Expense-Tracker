import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';

class ReportViewModel extends ViewModel {
  int _currentIndex = 0;
  int _indexForButtons = 0;

  int get currentIndex => _currentIndex;
  int get indexForButtons => _indexForButtons;

  void switchBetweenGraphs({required int index}) {
    _currentIndex = index;
    notifyListeners();
  }

  void onTapExpense() {
    _indexForButtons = 0;
    notifyListeners();
  }

  void onTapIncome() {
    _indexForButtons = 1;
    notifyListeners();
  }
}

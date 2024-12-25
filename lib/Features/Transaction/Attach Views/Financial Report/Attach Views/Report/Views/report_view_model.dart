import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';

class ReportViewModel extends ViewModel {
  int currentIndex = 0;
  int indexForButtons = 0;
  void switchBetweenGraphs({required int index}) {
    currentIndex = index;
    rebuildUi();
  }

  void onTapExpense() {
    indexForButtons = 0;
    rebuildUi();
  }

  void onTapIncome() {
    indexForButtons = 1;
    rebuildUi();
  }
}

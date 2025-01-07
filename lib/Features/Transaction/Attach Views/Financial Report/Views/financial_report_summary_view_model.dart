import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';

class FinancialReportSummaryViewModel extends ViewModel {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void onChanged(int value) {
    currentIndex == value;
    notifyListeners();
  }

  void swithingViews(
      {required TapUpDetails details, required double deviceWidth}) {
    if (_currentIndex == Database.financialReport.length - 1 &&
        details.localPosition.dx > deviceWidth / 2) {
      navigationService.replaceWithReportView();
    } else if (details.localPosition.dx > deviceWidth / 2) {
      _currentIndex++;
      notifyListeners();
    } else if (details.localPosition.dx < deviceWidth / 2 &&
        _currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }
}

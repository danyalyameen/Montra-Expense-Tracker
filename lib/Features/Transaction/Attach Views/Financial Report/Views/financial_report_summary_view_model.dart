import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';

class FinancialReportSummaryViewModel extends ViewModel {
  int currentIndex = 0;
  void swithingViews(
      {required TapUpDetails details, required double deviceWidth}) {
    if (currentIndex == Database.financialReport.length - 1 &&
        details.localPosition.dx > deviceWidth / 2) {
      navigationService.replaceWithReportView();
    } else if (details.localPosition.dx > deviceWidth / 2) {
      currentIndex++;
      rebuildUi();
    } else if (details.localPosition.dx < deviceWidth / 2 && currentIndex > 0) {
      currentIndex--;
      rebuildUi();
    }
  }
}

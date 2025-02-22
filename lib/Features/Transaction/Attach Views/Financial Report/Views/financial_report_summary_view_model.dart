import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';

class FinancialReportSummaryViewModel extends ViewModel {
  // Non Final Fields
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  // On Change of Page on Page View Builder
  void onChanged(int value) {
    currentIndex == value;
    notifyListeners();
  }

  // Get Total Expense
  Future<int> getTotalSpend() async {
    // Get Transactions
    var transactions = await transactionsService.getTransactions();
    // Total Spend
    int totalSpend = 0;
    // Calculate Total Spend
    for (var i = 0; i < transactions.length; i++) {
      if (transactions[i].type != "Income" &&
          transactions[i].time!.toDate().month == DateTime.now().month) {
        // Adding spend
        totalSpend += transactions[i].transactionPrice!;
      }
    }
    return totalSpend;
  }

  // Get Biggest Transaction Details
  Future<Map<String, dynamic>> getBiggestSpend() async {
    // Store Biggest Transactions Details
    Map<String, dynamic> category = {};
    // Largest Expense
    int? largestNumber = 0;
    // Get Transactions
    var transactions = await transactionsService.getTransactions();
    // Find Biggest Spend Transaction
    for (var i = 0; i < transactions.length; i++) {
      if (transactions[i].type != "Income" &&
          transactions[i].time!.toDate().month == DateTime.now().month) {
        largestNumber = largestNumber! > transactions[i].transactionPrice!
            ? largestNumber
            : transactions[i].transactionPrice;
      }
    }
    // Get Biggest Transaction
    var transaction = transactions.firstWhere(
      (element) {
        return element.transactionPrice! == largestNumber!;
      },
    );

    // Store Transaction Details according to Its Type
    switch (transaction.type) {
      case "Transfer":
        category["category"] = transaction.category;
        category["icon"] = IconsPath.transaction;
        category["iconColor"] = AppColors.primaryBlue;
        category["iconBackgroundColor"] = AppColors.blue20;
        category["largestNumber"] = largestNumber;
        break;
      case "Expense":
        switch (transaction.category) {
          case "Shopping":
            category["category"] = transaction.category;
            category["icon"] = IconsPath.shopping;
            category["iconColor"] = AppColors.primaryYellow;
            category["iconBackgroundColor"] = AppColors.yellow20;
            category["largestNumber"] = largestNumber;
            break;
          case "Food":
            category["category"] = transaction.category;
            category["icon"] = IconsPath.food;
            category["iconColor"] = AppColors.primaryRed;
            category["iconBackgroundColor"] = AppColors.red20;
            category["largestNumber"] = largestNumber;
            break;
          case "Travel":
            category["category"] = transaction.category;
            category["icon"] = IconsPath.transportation;
            category["iconColor"] = AppColors.primaryViolet;
            category["iconBackgroundColor"] = AppColors.violet20;
            category["largestNumber"] = largestNumber;
            break;
          case "Gadgets":
            category["category"] = transaction.category;
            category["icon"] = IconsPath.camera;
            category["iconColor"] = AppColors.primaryBlue;
            category["iconBackgroundColor"] = AppColors.blue20;
            category["largestNumber"] = largestNumber;
            break;
          case "Subscription":
            category["category"] = transaction.category;
            category["icon"] = IconsPath.subscription;
            category["iconColor"] = AppColors.primaryRed;
            category["iconBackgroundColor"] = AppColors.red20;
            category["largestNumber"] = largestNumber;
            break;
          default:
            category["category"] = transaction.category;
            category["icon"] = IconsPath.other;
            category["iconColor"] = AppColors.primaryRed;
            category["iconBackgroundColor"] = AppColors.red20;
            category["largestNumber"] = largestNumber;
        }
        break;
    }
    return category;
  }

  // Get Total Income of User
  Future<int> getTotalIncome() async {
    // Get Transactions
    var transactions = await transactionsService.getTransactions();
    // Total Income
    int totalIncome = 0;
    // Calculate Total Income
    for (var i = 0; i < transactions.length; i++) {
      if (transactions[i].type == "Income" &&
          transactions[i].time!.toDate().month == DateTime.now().month) {
        totalIncome += transactions[i].transactionPrice!;
      }
    }
    return totalIncome;
  }

  // Get Biggest Income
  Future<Map<String, dynamic>> getBiggestIncome() async {
    // Store Biggest Transactions Details
    Map<String, dynamic> category = {};
    // Largest Income
    int? largestNumber = 0;
    // Get Transactions
    var transactions = await transactionsService.getTransactions();
    // Find Biggest Spend Transaction
    for (var i = 0; i < transactions.length; i++) {
      if (transactions[i].type == "Income" &&
          transactions[i].time!.toDate().month == DateTime.now().month) {
        largestNumber = largestNumber! > transactions[i].transactionPrice!
            ? largestNumber
            : transactions[i].transactionPrice;
      }
    }
    // Get Biggest Transaction
    var transaction = transactions.firstWhere(
      (element) {
        return element.transactionPrice! == largestNumber!;
      },
    );
    // Store Transaction Details according to Its Type
    switch (transaction.type) {
      case "Income":
        category["category"] = transaction.category;
        category["icon"] = IconsPath.money;
        category["iconColor"] = AppColors.primaryGreen;
        category["iconBackgroundColor"] = AppColors.green20;
        category["largestNumber"] = largestNumber;
        break;
    }
    return category;
  }

  // Navigate Between Pages By calculating the width of Device
  void swithingViews(
      {required TapUpDetails details, required double deviceWidth}) {
    // If index is last navigate to back
    if (_currentIndex == 2 && details.localPosition.dx > deviceWidth / 2) {
      navigationService.back();
      // If index is second switch to first page
    } else if (details.localPosition.dx > deviceWidth / 2) {
      _currentIndex++;
      notifyListeners();
      // If index is first switch to second page
    } else if (details.localPosition.dx < deviceWidth / 2 &&
        _currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }
}

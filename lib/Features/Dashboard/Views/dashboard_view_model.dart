import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Models/person_model.dart';

class DashboardViewModel extends ViewModel {
  final ValueNotifier<bool> showItems = ValueNotifier<bool>(false);

  // Non Final Felds
  int currentIndexForBottomNavigation = 0;
  bool imageError = false;

  // Navigate to Notification View
  void notificationNavigation() {
    navigationService.navigateToNotificationView();
  }

  // Update the Current Index of Bottom Navigation and Update the UI
  void updateIndexForBottomNavigation(int index) {
    currentIndexForBottomNavigation = index;
    notifyListeners();
  }

  // Show or Hide the Transaction Items
  void showOrHideItems() {
    showItems.value = !showItems.value;
  }

  // A Function to get First Letter of Name In case of No Profile Picture
  Future<String> getFirstLetterOfName() async {
    final data = await firestore.doc(auth.getUser()!.uid).get();
    final personData = PersonData.store(data.data() as Map<String, dynamic>);
    return personData.name!.substring(0, 1);
  }

  // Get the User Balance
  Future<int> getBalance() async {
    final wallets = await walletService.getWallets();
    int balance = 0;
    for (var wallet in wallets) {
      balance += wallet.balance!;
    }
    return balance;
  }

  // Get the Total Income of This Month
  Future<int> getTotalIncome() async {
    int income = 0;
    final transactions = await transactionsService.fetchTransactions();
    if (transactions.isNotEmpty) {
      for (var transaction in transactions) {
        if (transaction.type == "Income" &&
            transaction.time!.toDate().month == DateTime.now().month) {
          income += transaction.transactionPrice!;
        }
      }
    } else {
      income = 0;
    }
    return income;
  }

  // Get the Total Expense of This Month
  Future<int> getTotalExpense() async {
    int expense = 0;
    final transactions = await transactionsService.fetchTransactions();
    if (transactions.isNotEmpty) {
      for (var transaction in transactions) {
        if (transaction.type != "Income" &&
            transaction.time!.toDate().month == DateTime.now().month) {
          expense += transaction.transactionPrice!;
        }
      }
    } else {
      expense = 0;
    }
    return expense;
  }
}

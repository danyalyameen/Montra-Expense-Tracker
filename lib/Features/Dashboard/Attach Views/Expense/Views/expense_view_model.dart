import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Features/Dashboard/Views/dashboard_view.dart';
import 'package:montra_expense_tracker/Models/person_model.dart';

class ExpenseViewModel extends ViewModel {
  // Final Fields
  final TextEditingController _balanceController = TextEditingController();
  final GlobalKey<FormState> _descriptionFormKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();

  // Get Final Fields
  GlobalKey<FormState> get descriptionFormKey => _descriptionFormKey;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get balanceController => _balanceController;

  // Non Final Fields
  bool _showLoading = false;
  // Get Non Final Fields
  bool get showLoading => _showLoading;

  // Store Selected Category which is Selected by User
  Map<String, dynamic> storeSelectedCategory = {
    "option": "Category",
    "color": null,
  };

  // Store Selected Wallet which is Select by User
  Map<String, dynamic> storeSelectedWallet = {
    "option": "Wallet",
  };

  // Validate Balance
  validateBalance() {
    if (_balanceController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Balance",
        backgroundColor: AppColors.primaryRed,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  // Validate Category
  validateCategory() {
    if (storeSelectedCategory["option"] == "Category") {
      Fluttertoast.showToast(
        msg: "Please Select Category",
        backgroundColor: AppColors.primaryRed,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  // Validate Description
  String? validateDescription(String? value) {
    if (value!.isEmpty) {
      return "Please Enter Your Description";
    }
    return null;
  }

  // Validate Wallet
  validateWallet() {
    if (storeSelectedWallet["option"] == "Wallet") {
      Fluttertoast.showToast(
        msg: "Please Select Wallet",
        backgroundColor: AppColors.primaryRed,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  // Update Category
  void updateCategoryHintText({required int index}) async {
    var data = await optionService.getExpenseOptions();
    storeSelectedCategory["option"] = data[index].option;
    storeSelectedCategory["color"] = data[index].color;
    navigationService.back();
    notifyListeners();
  }

  // Update Wallet
  void updateWalletHintText({required int index}) async {
    List<Wallets> data = await walletService.getWallets();
    storeSelectedWallet["option"] = data[index].walletName;
    navigationService.back();
    notifyListeners();
  }

  // Add Transaction
  void addExpenseTransactionCompleted() async {
    validateBalance();
    validateCategory();
    validateWallet();
    if (descriptionFormKey.currentState!.validate() &&
        _balanceController.text.isNotEmpty &&
        storeSelectedCategory["option"] != "Category" &&
        storeSelectedWallet["option"] != "Wallet") {
      try {
        // Show Loading
        _showLoading = true;
        notifyListeners();
        // Add Transaction
        transactionsService.addTransaction(
          transactionPrice: int.parse(balanceController.text),
          walletName: storeSelectedWallet["option"],
          category: storeSelectedCategory["option"],
          description: descriptionController.text,
          transactionType: "Expense",
        );
        // Hide Loading
        _showLoading = false;
        notifyListeners();
        // Navigation
        navigationService.replaceWithSuccessfullyDone(
            msg: "Transaction Added", className: const DashboardView());
      } catch (e) {
        // ignore: avoid_print
        print("Firebase Error : $e");
      }
    }
  }
}

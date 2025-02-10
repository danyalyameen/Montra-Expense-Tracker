import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Features/Dashboard/Views/dashboard_view.dart';

class IncomeViewModel extends ViewModel {
  // Final Fields
  final GlobalKey<FormState> _descriptionFormKey = GlobalKey<FormState>();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _balanceEditingController =
      TextEditingController();

  // Get Final Fields
  GlobalKey<FormState> get descriptionFormKey => _descriptionFormKey;
  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get balanceController => _balanceEditingController;

  // Map to Store Selected Option or Income
  Map<String, dynamic> storeSelectedIncome = {
    "option": "Income",
    "color": null,
  };

  // Map to Store Selected Option or Wallet
  Map<String, dynamic> storeSelectedWallet = {
    "option": "Wallet",
  };

  // Non Final Fields
  bool _showLoading = false;
  File? image;
  // Get Non Final Fields
  bool get showLoading => _showLoading;

  // Validate Balance
  validateBalance() {
    if (_balanceEditingController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Balance",
        backgroundColor: AppColors.primaryRed,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  // Validate Income
  validateIncome() {
    if (storeSelectedIncome["option"] == "Income") {
      Fluttertoast.showToast(
        msg: "Please Select Income",
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

  void addIncomeCompleted() async {
    validateBalance();
    validateIncome();
    validateWallet();
    // Check All the Values are Valid or Not
    if (descriptionFormKey.currentState!.validate() &&
        _balanceEditingController.text.isNotEmpty &&
        storeSelectedIncome["option"] != "Income" &&
        storeSelectedWallet["option"] != "Wallet") {
      try {
        // Show Loading
        _showLoading = true;
        notifyListeners();
        // Add Transaction
        transactionsService.addTransaction(
          transactionPrice: int.parse(balanceController.text),
          walletName: storeSelectedWallet["option"],
          category: storeSelectedIncome["option"],
          description: descriptionController.text,
          transactionType: "Income",
        );
        // Hide Loading
        _showLoading = false;
        notifyListeners();
        // Navigate to Dashboard
        navigationService.replaceWithSuccessfullyDone(
            msg: "Transaction Added", className: const DashboardView());
      } catch (e) {
        // ignore: avoid_print
        print("Firebase Error : $e");
      }
    }
  }
}

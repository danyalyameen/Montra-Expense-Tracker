import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Features/Dashboard/Views/dashboard_view.dart';

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

  // Add Transaction
  void addExpenseTransactionCompleted({required BuildContext context}) async {
    validateBalance();
    validateCategory();
    validateWallet();
    final double width = MediaQuery.sizeOf(context).width;
    final double height = MediaQuery.sizeOf(context).height;
    if (descriptionFormKey.currentState!.validate() &&
        _balanceController.text.isNotEmpty &&
        storeSelectedCategory["option"] != "Category" &&
        storeSelectedWallet["option"] != "Wallet") {
      try {
        // Show Loading
        _showLoading = true;
        notifyListeners();
        // Get Budgets
        var budgets =
            await budgetService.fetchBudget(month: DateTime.now().month);
        // Get Spend
        var spend = await budgetService.spend(
            category: storeSelectedCategory["option"],
            month: DateTime.now().month);
        // Check if Spend is greater than or equal to Budget Limit
        if (budgets.isNotEmpty) {
          log("W");
          for (var budget in budgets) {
            log("H");

            if (budget.category == storeSelectedCategory["option"] &&
                spend >= budget.balance!) {
              log("A");

              showDialog(
                // ignore: use_build_context_synchronously
                context: context,
                builder: (context) {
                  log("T");
                  return AlertDialog(
                    backgroundColor: AppColors.primaryLight,
                    title: const Text("Budget Limit Exceeded"),
                    content: const Text(
                        "You have exceeded your budget limit. Please reduce your spend."),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                color: AppColors.primaryViolet,
                                fontWeight: FontWeight.w500,
                                fontSize: width * 0.04,
                              ),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              _showLoading = false;
                              notifyListeners();
                            },
                          ),
                          SizedBox(
                            width: width * 0.26,
                            height: height * 0.04,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                    AppColors.primaryViolet),
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(width * 0.04),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                Navigator.pop(context);
                                bool error =
                                    await transactionsService.addTransaction(
                                  transactionPrice:
                                      int.parse(balanceController.text),
                                  walletName: storeSelectedWallet["option"],
                                  category: storeSelectedCategory["option"],
                                  description: descriptionController.text,
                                  transactionType: "Expense",
                                );
                                // Hide Loading
                                _showLoading = false;
                                notifyListeners();
                                // Navigation
                                error
                                    ? null
                                    : navigationService
                                        .replaceWithSuccessfullyDone(
                                            msg: "Transaction Added",
                                            className: const DashboardView());
                              },
                              child: Text(
                                "OK",
                                style: TextStyle(
                                  color: AppColors.primaryLight,
                                  fontSize: width * 0.045,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  );
                },
              );
              break;
            } else {
              if (budget == budgets.last) {
                bool error = await transactionsService.addTransaction(
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
                error
                    ? null
                    : navigationService.replaceWithSuccessfullyDone(
                        msg: "Transaction Added",
                        className: const DashboardView());
              }
            }
          }
        }
        // Add Transaction
      } catch (e) {
        // ignore: avoid_print
        print("Firebase Error : $e");
      }
    }
  }
}

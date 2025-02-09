import 'package:cloud_firestore/cloud_firestore.dart';
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

  String? validateDescription(String? value) {
    if (value!.isEmpty) {
      return "Please Enter Your Description";
    }
    return null;
  }

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

  void updateCategoryHintText({required int index}) async {
    var data = await optionService.getExpenseOptions();
    storeSelectedCategory["option"] = data[index].option;
    storeSelectedCategory["color"] = data[index].color;
    navigationService.back();
    notifyListeners();
  }

  void updateWalletHintText({required int index}) async {
    List<Wallets> data = await walletService.getWallets();
    storeSelectedWallet["option"] = data[index].walletName;
    navigationService.back();
    notifyListeners();
  }

  void addExpenseTransactionCompleted() async {
    validateBalance();
    validateCategory();
    validateWallet();
    if (descriptionFormKey.currentState!.validate() &&
        _balanceController.text.isNotEmpty &&
        storeSelectedCategory["option"] != "Category" &&
        storeSelectedWallet["option"] != "Wallet") {
      try {
        _showLoading = true;
        notifyListeners();
        final data = await walletService.getWallets();
        for (var wallet in data) {
          if (wallet.walletName == storeSelectedWallet["option"]) {
            wallet.transactions ??= [];
            wallet.transactions!.insert(
              0,
              Transactions(
                type: "Expense",
                category: storeSelectedCategory["option"],
                description: descriptionController.text,
                transactionPrice: int.parse(balanceController.text),
                time: Timestamp.now(),
              ),
            );
            wallet.balance =
                wallet.balance! - int.parse(balanceController.text);
          }
        }
        await firestore
            .doc(auth.getUser()!.uid)
            .update(PersonData(wallets: data).receive());
        _showLoading = false;
        notifyListeners();
        navigationService.replaceWithSuccessfullyDone(
            msg: "Transaction Added", className: const DashboardView());
      } catch (e) {
        // ignore: avoid_print
        print("Firebase Error : $e");
      }
    }
  }
}

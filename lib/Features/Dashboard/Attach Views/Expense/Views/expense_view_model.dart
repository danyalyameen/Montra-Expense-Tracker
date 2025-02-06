import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Features/Dashboard/Views/dashboard_view.dart';
import 'package:montra_expense_tracker/Models/default_options_model.dart';
import 'package:montra_expense_tracker/Models/person_model.dart';

class ExpenseViewModel extends ViewModel {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _balanceController = TextEditingController();
  final GlobalKey<FormState> descriptionFormKey = GlobalKey<FormState>();

  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get balanceController => _balanceController;

  Map<String, dynamic> storeSelectedCategory = {
    "option": "Category",
    "color": null
  };

  Map<String, dynamic> storeSelectedWallet = {
    "option": "Wallet",
  };

  bool _showLoading = false;
  bool get showLoading => _showLoading;

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

  Future<List> fetchingCategoryOptions() async {
    var data = await expenseOptions.get();
    var defaultOptions =
        DefaultOptionsModel.store(data.data() as Map<String, dynamic>);
    return defaultOptions.defaultExpenseOptions!;
  }

  Future<PersonData> fetchingWalletOptions() async {
    var data = await firestore.doc(auth.getUser()!.uid).get();
    return PersonData.store(data.data() as Map<String, dynamic>);
  }

  void updateCategoryHintText({required int index}) async {
    var data = await fetchingCategoryOptions();
    storeSelectedCategory["option"] = data[index].option;
    storeSelectedCategory["color"] = data[index].color;
    navigationService.back();
    notifyListeners();
  }

  void updateWalletHintText({required int index}) async {
    var data = await fetchingWalletOptions();
    storeSelectedWallet["option"] = data.wallets![index].walletName;
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
        final data = await fetchingWalletOptions();
        if (data.wallets != null) {
          for (var wallet in data.wallets!) {
            if (wallet.walletName == storeSelectedWallet["option"]) {
              wallet.transactions ??= [];
              if (wallet.transactions != null) {
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
              }
              if (wallet.balance != null) {
                wallet.balance =
                    wallet.balance! - int.parse(balanceController.text);
              }
            }
          }
        }
        await firestore
            .doc(auth.getUser()!.uid)
            .update(PersonData(wallets: data.wallets).receive());
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

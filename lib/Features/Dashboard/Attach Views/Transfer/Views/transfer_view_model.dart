import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Features/Dashboard/Views/dashboard_view.dart';

class TransferViewModel extends ViewModel {
  // Final Text Fields
  final TextEditingController _balanceController = TextEditingController();
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier _itemIndex = ValueNotifier(0);

  // Get Final Fields
  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get balanceController => _balanceController;
  TextEditingController get fromController => _fromController;
  TextEditingController get toController => _toController;
  TextEditingController get descriptionController => _descriptionController;
  ValueNotifier get itemIndex => _itemIndex;

  // Non Final Fields
  bool _showLoading = false;
  final ValueNotifier errorValueNotifier = ValueNotifier("");

  // Get Non Final Fields
  bool get showLoading => _showLoading;

  // Store Wallet which is Selected by User
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

  // Validate From
  String? validateFrom(String? value) {
    if (value!.isNotEmpty) {
      return null;
    } else {
      return "Please Fill this";
    }
  }

  // Validate To
  String? validateTo(String? value) {
    if (value!.isNotEmpty) {
      return null;
    } else {
      return "Please Fill this";
    }
  }

  // Validate Description
  String? validateDescription(String? value) {
    if (value!.isNotEmpty) {
      return null;
    } else {
      return "Please Enter Description";
    }
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

  void addTransferTransactionCompleted() async {
    validateBalance();
    validateWallet();
    if (formKey.currentState!.validate() &&
        _balanceController.text.isNotEmpty &&
        storeSelectedWallet["option"] != "Wallet") {
      try {
        // Show Loading
        _showLoading = true;
        notifyListeners();
        // Add Transaction
        transactionsService.addTransaction(
            transactionPrice: int.parse(balanceController.text),
            walletName: storeSelectedWallet["option"],
            category: "${fromController.text},${toController.text}",
            description: descriptionController.text,
            transactionType: "Transfer",);
        // Hide Transaction
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

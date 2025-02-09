import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Features/Dashboard/Views/dashboard_view.dart';
import 'package:montra_expense_tracker/Models/person_model.dart';

class SetupWalletViewModel extends ViewModel {
  // Final Fields
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _balanceEditingController =
      TextEditingController();
  final TextEditingController _nameEditingController = TextEditingController();

  // Get Final Fields
  GlobalKey<FormState> get formKey => _formKey;
  TextEditingController get balanceController => _balanceEditingController;
  TextEditingController get nameController => _nameEditingController;

  // Non Final Fields
  bool _showLoading = false;
  bool _error = false;
  String _selectedAccountType = "";

  // Get Non Final Fields
  bool get showLoading => _showLoading;
  bool get walletError => _error;
  String get selectedAccountType => _selectedAccountType;

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

  // Validate Name
  String? validateName(String? value) {
    if (value!.isEmpty) {
      return "Please Enter Your Name";
    }
    if (_error) {
      _error = false;
      return "Name Already Used";
    }
    return null;
  }

  // Validate DropDown
  validateDropDown() {
    if (_selectedAccountType.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Select Account Type",
        backgroundColor: AppColors.primaryRed,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  // Drop Down Value Change Function
  void onChanged(String value) {
    _selectedAccountType = value;
    notifyListeners();
  }

  // Main Navigation on Wallet Setup
  void allSetupNavigation() async {
    validateBalance();
    validateDropDown();
    try {
      if (formKey.currentState!.validate() &&
          _balanceEditingController.text.isNotEmpty &&
          _selectedAccountType.isNotEmpty) {
        // Show Loading
        _showLoading = true;
        notifyListeners();
        // Add Wallet
        _error = await walletService.addWallet(
            wallet: Wallets(
          balance: int.parse(_balanceEditingController.text),
          walletName: _nameEditingController.text,
          accountType: _selectedAccountType,
        ));
        // Check Error
        if (_error) {
          _showLoading = false;
          notifyListeners();
          return;
        }
        // Make Account Setup Completed True
        await firestore
            .doc(auth.getUser()!.uid)
            .update(PersonData(accountSetupCompleted: true).receive());
        // Hide Loading
        _showLoading = false;
        notifyListeners();
        // Navigate to Dashboard
        navigationService.replaceWithSuccessfullyDone(
            msg: "Account Setup Successfully",
            className: const DashboardView());
      }
    } catch (e) {
      // ignore: avoid_print
      print("Firebase Error: $e");
    }
  }
}

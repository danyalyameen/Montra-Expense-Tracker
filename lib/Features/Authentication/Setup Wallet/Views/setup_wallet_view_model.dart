import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Models/person_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SetupWalletViewModel extends ViewModel {
  final TextEditingController _balanceEditingController =
      TextEditingController();
  final TextEditingController _nameEditingController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController get balanceController => _balanceEditingController;
  TextEditingController get nameController => _nameEditingController;

  bool _isFocus = false;
  bool _showLoading = false;
  bool _error = false;
  String _selectedAccountType = "";
  int _currentIndex = 0;

  bool get isFocus => _isFocus;
  bool get showLoading => _showLoading;
  bool get walletError => _error;
  String get selectedAccountType => _selectedAccountType;
  int get currentIndex => _currentIndex;

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

  void onTap() {
    _isFocus = true;
    notifyListeners();
  }

  void onTapOutside(BuildContext context) {
    _isFocus = false;
    FocusScope.of(context).unfocus();
    notifyListeners();
  }

  void onComplete(BuildContext context) {
    _isFocus = false;
    FocusScope.of(context).unfocus();
    notifyListeners();
  }

  void onChanged(String value) {
    _selectedAccountType = value;
    notifyListeners();
  }

  void updateCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void allSetupNavigation() async {
    validateBalance();
    validateDropDown();
    try {
      if (formKey.currentState!.validate() &&
          _balanceEditingController.text.isNotEmpty &&
          _selectedAccountType.isNotEmpty) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        _showLoading = true;
        notifyListeners();
        _error = await walletService.addWallet(
            wallet: Wallets(
          balance: int.parse(_balanceEditingController.text),
          walletName: _nameEditingController.text,
          accountType: _selectedAccountType,
        ));
        if (_error) {
          _showLoading = false;
          notifyListeners();
          return;
        }
        _showLoading = false;
        notifyListeners();
        sharedPreferences.setBool("Wallet-Setup", true);
        navigationService.navigateToAllSetupView();
      }
    } catch (e) {
      // ignore: avoid_print
      print("Firebase Error: $e");
    }
  }
}

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
  final GlobalKey<FormState> balanceFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> nameFormKey = GlobalKey<FormState>();

  TextEditingController get balanceController => _balanceEditingController;
  TextEditingController get nameController => _nameEditingController;

  bool _isFocus = false;
  bool _showLoading = false;
  String _selectedAccountType = "";
  int _currentIndex = 0;

  bool get isFocus => _isFocus;
  bool get showLoading => _showLoading;
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
      if (nameFormKey.currentState!.validate() &&
          balanceFormKey.currentState!.validate() &&
          _balanceEditingController.text.isNotEmpty &&
          _selectedAccountType.isNotEmpty) {
        SharedPreferences sharedPreferences =
            await SharedPreferences.getInstance();
        _showLoading = true;
        notifyListeners();
        var firebaseData = await firestore.doc(auth.getUser()!.uid).get();
        var data =
            PersonData.store(firebaseData.data() as Map<String, dynamic>);
        data.wallets ??= [];

        data.wallets!.insert(
            0,
            Wallets(
              walletName: nameController.text,
              balance: int.parse(balanceController.text),
              accountType: selectedAccountType,
            ));
        await firestore
            .doc(auth.getUser()!.uid)
            .update(PersonData(wallets: data.wallets!).receive());
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

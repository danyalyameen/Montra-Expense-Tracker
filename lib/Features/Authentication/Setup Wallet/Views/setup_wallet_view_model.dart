import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/variables.dart';

class SetupWalletViewModel extends ViewModel {
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _searchEditingController =
      TextEditingController();
  bool _isFocus = false;
  String selectedAccountType = "";
  int currentIndex = 0;

  TextEditingController get nameController => _nameEditingController;
  TextEditingController get searchController => _searchEditingController;
  bool get focus => _isFocus;

  Map<String, dynamic> storeSelectedWallet = {
    Variables.universalItemKey: "Wallet",
  };

  void updateWalletHintText({required int index}) {
    storeSelectedWallet[Variables.universalItemKey] =
        Database.walletOptions[index]["Wallet"];
    navigationService.back();
    notifyListeners();
  }

  void isFocus() {
    _isFocus = true;
    rebuildUi();
  }

  void onTapOutside(BuildContext context) {
    FocusScope.of(context).unfocus();
    _isFocus = false;
    rebuildUi();
  }

  void onComplete(BuildContext context) {
    FocusScope.of(context).unfocus();
    _isFocus = false;
    rebuildUi();
  }

  void dropDownOnChanged(String value) {
    selectedAccountType = value;
    rebuildUi();
  }

  void updateCurrentIndex(int index) {
    currentIndex = index;
    rebuildUi();
  }
}

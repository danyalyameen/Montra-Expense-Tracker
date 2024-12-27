import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/variables.dart';

class SetupWalletViewModel extends ViewModel {
  final TextEditingController _nameEditingController = TextEditingController();

  TextEditingController get nameController => _nameEditingController;

  Map<String, dynamic> storeSelectedWallet = {
    Variables.universalItemKey: "Wallet",
  };

  void updateWalletHintText({required int index}) {
    storeSelectedWallet[Variables.universalItemKey] =
        Database.walletOptions[index]["Wallet"];
    navigationService.back();
    notifyListeners();
  }
}

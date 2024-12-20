import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/variables.dart';

class IncomeViewModel extends ViewModel {
  final TextEditingController _descriptionController = TextEditingController();

  TextEditingController get descriptionController => _descriptionController;

  Map<String, dynamic> storeSelectedIncome = {
    Variables.universalItemKey: "Income",
    "Colors": null
  };

  Map<String, dynamic> storeSelectedWallet = {
    Variables.universalItemKey: "Wallet",
  };

  void updateIncomeHintText({required int index}) {
    storeSelectedIncome[Variables.universalItemKey] =
        Database.incomeOptions[index]["Income"];
    storeSelectedIncome["Colors"] = Database.incomeOptions[index]["Colors"];
    navigationService.back();
    notifyListeners();
  }

  void updateWalletHintText({required int index}) {
    storeSelectedWallet[Variables.universalItemKey] =
        Database.walletOptions[index]["Wallet"];
    navigationService.back();
    notifyListeners();
  }
}

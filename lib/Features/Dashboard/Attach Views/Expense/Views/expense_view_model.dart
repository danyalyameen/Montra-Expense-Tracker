import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/variables.dart';

class ExpenseViewModel extends ViewModel {
  final TextEditingController _descriptionController = TextEditingController();

  TextEditingController get descriptionController => _descriptionController;
  bool _isRepeat = false;

  bool get isRepeat => _isRepeat;
  String selectedItemForFrequency = "";
  String selectedItemForMonth = "";
  String selectedItemForDate = "";

  Map<String, dynamic> storeSelectedCategory = {
    Variables.universalItemKey: "Category",
    "Colors": null
  };

  Map<String, dynamic> storeSelectedWallet = {
    Variables.universalItemKey: "Wallet",
  };

  void updateCategoryHintText({required int index}) {
    storeSelectedCategory[Variables.universalItemKey] =
        Database.categoryOptions[index]["Category"];
    storeSelectedCategory["Colors"] = Database.categoryOptions[index]["Colors"];
    navigationService.back();
    notifyListeners();
  }

  void updateWalletHintText({required int index}) {
    storeSelectedWallet[Variables.universalItemKey] =
        Database.walletOptions[index]["Wallet"];
    navigationService.back();
    notifyListeners();
  }

  void toggleSwitch(bool? value) {
    _isRepeat = value!;
    rebuildUi();
  }

  void onChangedFrequency(String value) {
    selectedItemForFrequency = value;
    rebuildUi();
  }

  void onChangedMonth(String value) {
    selectedItemForMonth = value;
    rebuildUi();
  }

  void onChangedDate(String value) {
    selectedItemForDate = value;
    rebuildUi();
  }
}

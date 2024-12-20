import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/variables.dart';

class TransferViewModel extends ViewModel {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();

  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get fromController => _fromController;
  TextEditingController get toController => _toController;

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

import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Constants/Variables/variables.dart';

class IncomeViewModel extends ViewModel {
  final TextEditingController _descriptionController = TextEditingController();

  TextEditingController get descriptionController => _descriptionController;

  Map<String, dynamic> storeSelectedCategory = {
    Variables.universalItemKey: "Category",
    "Colors": null
  };

  Map<String, dynamic> storeSelectedWallet = {
    Variables.universalItemKey: "Wallet",
  };

  List<Map<String, dynamic>> categoryOptions = [
    {
      "Category": "Business",
      "Colors": Colors.red,
    },
    {
      "Category": "Rent",
      "Colors": Colors.blue,
    },
    {
      "Category": "Job",
      "Colors": Colors.green,
    },
    {
      "Category": "Investment",
      "Colors": Colors.yellow,
    },
  ];

  List<Map<String, dynamic>> walletOptions = [
    {
      "Wallet": "Jazz Cash",
      "Balance": 1000,
      "Account Type": "Wallet",
      "Picture": IconsPath.jazzcash
    },
    {
      "Wallet": "Easypaisa",
      "Balance": 100,
      "Account Type": "Wallet",
      "Picture": IconsPath.easypaisa
    },
    {
      "Wallet": "UBL",
      "Balance": 9899,
      "Account Type": "Bank",
      "Picture": IconsPath.ubl
    },
  ];

  void updateCategoryHintText({required int index}) {
    storeSelectedCategory[Variables.universalItemKey] =
        categoryOptions[index]["Category"];
    storeSelectedCategory["Colors"] = categoryOptions[index]["Colors"];
    navigationService.back();
    notifyListeners();
  }

  void updateWalletHintText({required int index}) {
    storeSelectedWallet[Variables.universalItemKey] =
        walletOptions[index]["Wallet"];
    navigationService.back();
    notifyListeners();
  }
}

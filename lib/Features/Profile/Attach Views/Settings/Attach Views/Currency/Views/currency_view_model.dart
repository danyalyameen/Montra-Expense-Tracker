import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Providers/Currency/currency_provider.dart';
import 'package:provider/provider.dart';

class CurrencyViewModel extends ViewModel {
  
  Future<void> markSelected(
    int index,
    BuildContext context,
  ) async {
    for (var element in Database.currencyData) {
      element["isSelect"] == true ? element["isSelect"] = false : null;
    }
    Database.currencyData[index]["isSelect"] = true;
    Database.settingsData[0]["Default-Selection"] =
        Database.currencyData[index]["Symbol"];
    await Provider.of<CurrencyProvider>(context, listen: false).setCurrency(
        Database.settingsData[0]["Default-Selection"] == "USD"
            ? "\$"
            : "${Database.settingsData[0]["Default-Selection"]} ");
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Constants/Variables/variables.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CurrencyProvider extends ChangeNotifier {
  String _currency = '\$';

  void setDefaultCurrency() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _currency = sharedPreferences.getString(Variables.currencyKey) ?? '\$';
  }

  String get currency => _currency;

  Future<void> setCurrency(String currency) async {
    _currency = currency;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(Variables.currencyKey, _currency);
    notifyListeners();
  }
}

import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Providers/Currency/currency_provider.dart';
import 'package:provider/provider.dart';

class CurrencyViewModel extends ViewModel {
  void markSelected(int index, context) {
    Map<String, dynamic> selectedCurrency =
        Database.currencyData.removeAt(index);
    Database.currencyData[0]["isSelect"] = false;
    Database.currencyData.insert(0, selectedCurrency);
    Database.currencyData[0]["isSelect"] = true;
    Database.settingsData[0]["Default-Selection"] =
        Database.currencyData[0]["Symbol"];
    Provider.of<CurrencyProvider>(context, listen: false).setCurrency(
        Database.settingsData[0]["Default-Selection"] == "USD"
            ? "\$"
            : "${Database.settingsData[0]["Default-Selection"]} ");
    notifyListeners();
  }
}

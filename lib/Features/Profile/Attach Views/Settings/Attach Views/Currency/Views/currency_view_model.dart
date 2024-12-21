import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';

class CurrencyViewModel extends ViewModel {
  void markSelected(int index) {
    Map<String, dynamic> selectedCurrency =
        Database.currencyData.removeAt(index);
    Database.currencyData[0]["isSelect"] = false;
    Database.currencyData.insert(0, selectedCurrency);
    Database.currencyData[0]["isSelect"] = true;
    Database.settingsData[0]["Default-Selection"] =
        Database.currencyData[0]["Symbol"];
    notifyListeners();
  }
}

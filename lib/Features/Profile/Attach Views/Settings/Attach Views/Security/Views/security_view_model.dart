import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';

class SecurityViewModel extends ViewModel {
  void markSelected(int index) {
    Map<String, dynamic> selectedSecurity =
        Database.securityData.removeAt(index);
    Database.securityData[0]["isSelect"] = false;
    Database.securityData.insert(0, selectedSecurity);
    Database.securityData[0]["isSelect"] = true;
    Database.settingsData[2]["Default-Selection"] =
        Database.securityData[0]["Security"];
    notifyListeners();
  }
}

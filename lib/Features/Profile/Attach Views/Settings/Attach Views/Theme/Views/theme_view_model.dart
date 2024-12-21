import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';

class ThemeViewModel extends ViewModel {
  void markSelected(int index) {
    Map<String, dynamic> selectedTheme = Database.themeData.removeAt(index);
    Database.themeData[0]["isSelect"] = false;
    Database.themeData.insert(0, selectedTheme);
    Database.themeData[0]["isSelect"] = true;
    Database.settingsData[1]["Default-Selection"] =
        Database.themeData[0]["Theme"];
    notifyListeners();
  }
}

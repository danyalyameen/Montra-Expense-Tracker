import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';

class CreateBudgetViewModel extends ViewModel {
  bool isOn = false;
  double sliderValue = 0;

  Map<String, dynamic> storeSelectedCategory = {
    "option" : "Category",
    "color": null
  };

  void updateCategoryHintText({required int index}) {
    storeSelectedCategory["option"] =
        Database.categoryOptions[index]["Category"];
    storeSelectedCategory["color"] = Database.categoryOptions[index]["Colors"];
    navigationService.back();
    notifyListeners();
  }

  void updateSwitch(value) {
    isOn = value;
    notifyListeners();
  }

  void updateSlider(value) {
    sliderValue = value;
    notifyListeners();
  }
}

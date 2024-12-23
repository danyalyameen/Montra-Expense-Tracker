import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';
import 'package:montra_expense_tracker/Constants/Variables/variables.dart';

class CreateBudgetViewModel extends ViewModel {
  Map<String, dynamic> storeSelectedCategory = {
    Variables.universalItemKey: "Category",
    "Colors": null
  };
    void updateCategoryHintText({required int index}) {
    storeSelectedCategory[Variables.universalItemKey] =
        Database.categoryOptions[index]["Category"];
    storeSelectedCategory["Colors"] = Database.categoryOptions[index]["Colors"];
    navigationService.back();
    notifyListeners();
  }
}
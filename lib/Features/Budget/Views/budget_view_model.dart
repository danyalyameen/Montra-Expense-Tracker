import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';

class BudgetViewModel extends ViewModel {
  double percentage({required int index}) {
    double percentage = Database.budgetData[index]["Spend"] /
        Database.budgetData[index]["Limit"];
    return percentage > 1 ? 1 : percentage;
  }

  int index = 0;

  void incrementIndex() {
    index == Database.months.length - 1 ? index : index++;
    rebuildUi();
  }

  void decrementIndex() {
    index == 0 ? index : index--;
    rebuildUi();
  }
}

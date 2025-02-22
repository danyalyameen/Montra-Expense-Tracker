import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';

class BudgetViewModel extends ViewModel {
  // Non Final Fields
  int index = 0;

  // Calculate Percentage of Progress Bar
  double percentage(
      {required int index, required int spend, required int limit}) {
    double percentage = spend / limit;
    return percentage > 1 ? 1 : percentage;
  }

  // Increment Index for Months
  void incrementIndex() {
    index == Database.months.length - 1 ? index : index++;
    rebuildUi();
  }

  // Decrement Index For Months
  void decrementIndex() {
    index == 0 ? index : index--;
    rebuildUi();
  }
}

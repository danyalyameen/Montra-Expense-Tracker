import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';

class SettingsViewModel extends ViewModel {
  void navigation({required int index}) async {
    await navigationService.navigateToView(Database.navigationViews[index]);
    rebuildUi();
  }
}
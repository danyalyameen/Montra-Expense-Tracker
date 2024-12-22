import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';

class ProfileViewModel extends ViewModel {
  void navigation({required int index}) {
    navigationService.navigateToView(Database.navigationViewsForProfile[index]);
  }
}

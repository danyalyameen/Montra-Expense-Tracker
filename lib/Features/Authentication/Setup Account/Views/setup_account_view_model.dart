import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';

class SetupAccountViewModel extends ViewModel {
  void setupWalletNavigation() {
    navigationService.replaceWithSetupWalletView();
  }
}

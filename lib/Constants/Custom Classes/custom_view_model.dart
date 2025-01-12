import 'package:montra_expense_tracker/App/app.locator.dart';
import 'package:montra_expense_tracker/Service/Authentication/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ViewModel extends BaseViewModel {
  NavigationService navigationService = locator<NavigationService>();
  Auth auth = locator<Auth>();
}

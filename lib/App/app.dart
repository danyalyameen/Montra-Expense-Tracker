import 'package:montra_expense_tracker/Features/Dashboard/Attach%20Views/Expense/Views/expense_view.dart';
import 'package:montra_expense_tracker/Features/Dashboard/Attach%20Views/Income/Views/income_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Account/Attach%20View/Account%20Details/Views/account_details.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Account/Views/account_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Views/profile_view.dart';
import 'package:montra_expense_tracker/Features/Dashboard/Attach%20Views/Transfer/Views/transfer_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: IncomeView),
    MaterialRoute(page: ExpenseView),
    MaterialRoute(page: TransferView),
    MaterialRoute(page: ProfileView),
    MaterialRoute(page: AccountView),
    MaterialRoute(page: AccountDetails),
  ],
  dependencies: [LazySingleton(classType: NavigationService)],
)
class App {}

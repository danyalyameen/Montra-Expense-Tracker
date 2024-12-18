import 'package:montra_expense_tracker/Features/Expense/Views/expense_view.dart';
import 'package:montra_expense_tracker/Features/Income/Views/income_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Views/profile_view.dart';
import 'package:montra_expense_tracker/Features/Transfer/Views/transfer_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: IncomeView),
    MaterialRoute(page: ExpenseView),
    MaterialRoute(page: TransferView),
    MaterialRoute(page: ProfileView),
  ],
  dependencies: [LazySingleton(classType: NavigationService)],
)
class App {}

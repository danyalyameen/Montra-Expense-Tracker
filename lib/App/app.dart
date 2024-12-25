import 'package:montra_expense_tracker/Features/Budget/Attach%20Views/Create%20Budget/create_budget_view.dart';
import 'package:montra_expense_tracker/Features/Budget/Attach%20Views/Edit%20Budget/edit_budget_view.dart';
import 'package:montra_expense_tracker/Features/Budget/Views/budget_view.dart';
import 'package:montra_expense_tracker/Features/Dashboard/Attach%20Views/Expense/Views/expense_view.dart';
import 'package:montra_expense_tracker/Features/Dashboard/Attach%20Views/Income/Views/income_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Account/Attach%20View/Account%20Details/Views/account_details.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Account/Views/account_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/About/Views/about_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Currency/Views/currency_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Help/Views/help_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Notification/Views/notification_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Security/Views/security_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Theme/Views/theme_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Views/settings_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Views/profile_view.dart';
import 'package:montra_expense_tracker/Features/Dashboard/Attach%20Views/Transfer/Views/transfer_view.dart';
import 'package:montra_expense_tracker/Features/Transaction/Attach%20Views/Financial%20Report/Attach%20Views/Report/Views/report_view.dart';
import 'package:montra_expense_tracker/Features/Transaction/Attach%20Views/Financial%20Report/Views/financial_report_summary_view.dart';
import 'package:montra_expense_tracker/Features/Transaction/Views/transaction_view.dart';
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
    MaterialRoute(page: SettingsView),
    MaterialRoute(page: AboutView),
    MaterialRoute(page: CurrencyView),
    MaterialRoute(page: HelpView),
    MaterialRoute(page: NotificationView),
    MaterialRoute(page: SecurityView),
    MaterialRoute(page: ThemeView),
    MaterialRoute(page: BudgetView),
    MaterialRoute(page: CreateBudgetView),
    MaterialRoute(page: EditBudgetView),
    MaterialRoute(page: TransactionView),
    MaterialRoute(page: FinancialReportSummaryView),
    MaterialRoute(page: ReportView),
  ],
  dependencies: [LazySingleton(classType: NavigationService)],
)
class App {}

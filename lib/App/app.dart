import 'package:montra_expense_tracker/Features/Authentication/Forget%20Password/Views/forget_password_view.dart';
import 'package:montra_expense_tracker/Features/Authentication/Login/Views/login_view.dart';
import 'package:montra_expense_tracker/Features/Authentication/On%20Boarding/Views/onboarding_view.dart';
import 'package:montra_expense_tracker/Features/Authentication/Setup%20Account/Views/setup_account_view.dart';
import 'package:montra_expense_tracker/Features/Authentication/Setup%20PIN/Views/setup_pin_view.dart';
import 'package:montra_expense_tracker/Features/Authentication/Setup%20Wallet/Views/setup_wallet_view.dart';
import 'package:montra_expense_tracker/Features/Authentication/Sign%20UP/Views/sign_up_view.dart';
import 'package:montra_expense_tracker/Features/Authentication/User%20Picture/Views/user_picture_view.dart';
import 'package:montra_expense_tracker/Features/Authentication/Verification/Views/verification_view.dart';
import 'package:montra_expense_tracker/Features/Budget/Attach%20Views/Create%20Budget/create_budget_view.dart';
import 'package:montra_expense_tracker/Features/Budget/Attach%20Views/Edit%20Budget/edit_budget_view.dart';
import 'package:montra_expense_tracker/Features/Budget/Views/budget_view.dart';
import 'package:montra_expense_tracker/Features/Dashboard/Attach%20Views/Expense/Views/expense_view.dart';
import 'package:montra_expense_tracker/Features/Dashboard/Attach%20Views/Income/Views/income_view.dart';
import 'package:montra_expense_tracker/Features/Dashboard/Attach%20Views/Notification/Views/notification_view.dart';
import 'package:montra_expense_tracker/Features/Dashboard/Views/dashboard_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Account/Attach%20View/Account%20Details/Views/account_details.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Account/Views/account_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/About/Views/about_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Currency/Views/currency_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Help/Views/help_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Notification/Views/notification_settings_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Views/settings_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Views/profile_view.dart';
import 'package:montra_expense_tracker/Features/Dashboard/Attach%20Views/Transfer/Views/transfer_view.dart';
import 'package:montra_expense_tracker/Features/Splash%20Screen/Views/splash_screen_view.dart';
import 'package:montra_expense_tracker/Features/Transaction/Attach%20Views/Details%20Transaction/Views/details_transaction_view.dart';
import 'package:montra_expense_tracker/Features/Transaction/Attach%20Views/Financial%20Report/Views/financial_report_summary_view.dart';
import 'package:montra_expense_tracker/Features/Transaction/Views/transaction_view.dart';
import 'package:montra_expense_tracker/Service/Authentication/auth_service.dart';
import 'package:montra_expense_tracker/Service/Budgets/budget_service.dart';
import 'package:montra_expense_tracker/Service/Image%20Picker/image_service.dart';
import 'package:montra_expense_tracker/Service/Notification%20Bar/notification_bar_service.dart';
import 'package:montra_expense_tracker/Service/Options/option_service.dart';
import 'package:montra_expense_tracker/Service/Transactions/transaction_service.dart';
import 'package:montra_expense_tracker/Service/Wallets/wallet_service.dart';
import 'package:montra_expense_tracker/Widgets/successfully_done.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: SplashScreenView, initial: true),
    MaterialRoute(page: OnBoardingView),
    MaterialRoute(page: SignUpView),
    MaterialRoute(page: LoginView),
    MaterialRoute(page: VerificationView),
    MaterialRoute(page: UserPictureView),
    MaterialRoute(page: SetupPinView),
    MaterialRoute(page: ForgetPasswordView),
    MaterialRoute(page: SetupAccountView),
    MaterialRoute(page: SetupWalletView),
    MaterialRoute(page: SuccessfullyDone),
    MaterialRoute(page: DashboardView),
    MaterialRoute(page: NotificationView),
    MaterialRoute(page: TransactionView),
    MaterialRoute(page: FinancialReportSummaryView),
    MaterialRoute(page: DetailsTransactionView),
    MaterialRoute(page: IncomeView),
    MaterialRoute(page: TransferView),
    MaterialRoute(page: ExpenseView),
    MaterialRoute(page: BudgetView),
    MaterialRoute(page: CreateBudgetView),
    MaterialRoute(page: EditBudgetView),
    MaterialRoute(page: ProfileView),
    MaterialRoute(page: AccountView),
    MaterialRoute(page: AccountDetails),
    MaterialRoute(page: SettingsView),
    MaterialRoute(page: CurrencyView),
    MaterialRoute(page: NotificationSettingsView),
    MaterialRoute(page: AboutView),
    MaterialRoute(page: HelpView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: AuthService),
    LazySingleton(classType: TransactionService),
    LazySingleton(classType: BudgetService),
    LazySingleton(classType: WalletService),
    LazySingleton(classType: OptionService),
    LazySingleton(classType: ImageService),
    LazySingleton(classType: NotificationBarService),
  ],
)
class App {}

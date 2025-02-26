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
import 'package:montra_expense_tracker/Features/Dashboard/Views/dashboard_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Account/Attach%20View/Account%20Details/Views/account_details.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Account/Views/account_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Edit%20Profile/Views/edit_profile_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/About/Views/about_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Currency/Views/currency_view.dart';
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Help/Views/help_view.dart';
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
import 'package:stacked/stacked.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    CustomRoute(
        page: SplashScreenView,
        initial: true,
        transitionsBuilder: TransitionsBuilders.slideLeft),
    CustomRoute(
        page: OnBoardingView,
        transitionsBuilder: TransitionsBuilders.slideLeft),
    CustomRoute(
        page: SignUpView, transitionsBuilder: TransitionsBuilders.slideLeft),
    CustomRoute(
        page: LoginView, transitionsBuilder: TransitionsBuilders.slideLeft),
    CustomRoute(
        page: VerificationView,
        transitionsBuilder: TransitionsBuilders.slideLeft),
    CustomRoute(
        page: UserPictureView,
        transitionsBuilder: TransitionsBuilders.slideLeft),
    CustomRoute(
        page: SetupPinView, transitionsBuilder: TransitionsBuilders.slideLeft),
    CustomRoute(
        page: ForgetPasswordView,
        transitionsBuilder: TransitionsBuilders.slideLeft),
    CustomRoute(
        page: SetupAccountView,
        transitionsBuilder: TransitionsBuilders.slideLeft),
    CustomRoute(
        page: SetupWalletView,
        transitionsBuilder: TransitionsBuilders.slideLeft),
    CustomRoute(
        page: SuccessfullyDone,
        transitionsBuilder: TransitionsBuilders.slideLeft),
    CustomRoute(
        page: DashboardView, transitionsBuilder: TransitionsBuilders.slideLeft),
    CustomRoute(
        page: TransactionView,
        transitionsBuilder: TransitionsBuilders.slideLeft),
    CustomRoute(
        page: FinancialReportSummaryView,
        transitionsBuilder: TransitionsBuilders.slideLeft),
    CustomRoute(
        page: DetailsTransactionView,
        transitionsBuilder: TransitionsBuilders.slideLeft),
    CustomRoute(
        page: IncomeView, transitionsBuilder: TransitionsBuilders.slideLeft),
    CustomRoute(
        page: TransferView, transitionsBuilder: TransitionsBuilders.slideLeft),
    CustomRoute(
        page: ExpenseView, transitionsBuilder: TransitionsBuilders.slideLeft),
    CustomRoute(
        page: BudgetView, transitionsBuilder: TransitionsBuilders.slideLeft),
    CustomRoute(
        page: CreateBudgetView,
        transitionsBuilder: TransitionsBuilders.slideLeft),
    CustomRoute(
        page: EditBudgetView,
        transitionsBuilder: TransitionsBuilders.slideLeft),
    CustomRoute(
        page: ProfileView, transitionsBuilder: TransitionsBuilders.slideLeft),
    CustomRoute(
        page: EditProfileView,
        transitionsBuilder: TransitionsBuilders.slideLeft),
    CustomRoute(
        page: AccountView, transitionsBuilder: TransitionsBuilders.slideLeft),
    CustomRoute(
        page: AccountDetails,
        transitionsBuilder: TransitionsBuilders.slideLeft),
    CustomRoute(
        page: SettingsView, transitionsBuilder: TransitionsBuilders.slideLeft),
    CustomRoute(
        page: CurrencyView, transitionsBuilder: TransitionsBuilders.slideLeft),
    CustomRoute(
        page: AboutView, transitionsBuilder: TransitionsBuilders.slideLeft),
    CustomRoute(
        page: HelpView, transitionsBuilder: TransitionsBuilders.slideLeft),
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

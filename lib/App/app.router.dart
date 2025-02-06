// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i34;

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as _i33;
import 'package:montra_expense_tracker/Features/Authentication/All%20Setup/Views/all_setup_view.dart'
    as _i12;
import 'package:montra_expense_tracker/Features/Authentication/Email%20Verified/Views/email_verified_view.dart'
    as _i7;
import 'package:montra_expense_tracker/Features/Authentication/Forget%20Password/Views/forget_password_view.dart'
    as _i9;
import 'package:montra_expense_tracker/Features/Authentication/Login/Views/login_view.dart'
    as _i5;
import 'package:montra_expense_tracker/Features/Authentication/On%20Boarding/Views/onboarding_view.dart'
    as _i3;
import 'package:montra_expense_tracker/Features/Authentication/Setup%20Account/Views/setup_account_view.dart'
    as _i10;
import 'package:montra_expense_tracker/Features/Authentication/Setup%20PIN/Views/setup_pin_view.dart'
    as _i8;
import 'package:montra_expense_tracker/Features/Authentication/Setup%20Wallet/Views/setup_wallet_view.dart'
    as _i11;
import 'package:montra_expense_tracker/Features/Authentication/Sign%20UP/Views/sign_up_view.dart'
    as _i4;
import 'package:montra_expense_tracker/Features/Authentication/Verification/Views/verification_view.dart'
    as _i6;
import 'package:montra_expense_tracker/Features/Budget/Attach%20Views/Create%20Budget/create_budget_view.dart'
    as _i23;
import 'package:montra_expense_tracker/Features/Budget/Attach%20Views/Edit%20Budget/edit_budget_view.dart'
    as _i24;
import 'package:montra_expense_tracker/Features/Budget/Views/budget_view.dart'
    as _i22;
import 'package:montra_expense_tracker/Features/Dashboard/Attach%20Views/Expense/Views/expense_view.dart'
    as _i21;
import 'package:montra_expense_tracker/Features/Dashboard/Attach%20Views/Income/Views/income_view.dart'
    as _i19;
import 'package:montra_expense_tracker/Features/Dashboard/Attach%20Views/Notification/Views/notification_view.dart'
    as _i15;
import 'package:montra_expense_tracker/Features/Dashboard/Attach%20Views/Transfer/Views/transfer_view.dart'
    as _i20;
import 'package:montra_expense_tracker/Features/Dashboard/Views/dashboard_view.dart'
    as _i14;
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Account/Attach%20View/Account%20Details/Views/account_details.dart'
    as _i27;
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Account/Views/account_view.dart'
    as _i26;
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/About/Views/about_view.dart'
    as _i31;
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Currency/Views/currency_view.dart'
    as _i29;
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Help/Views/help_view.dart'
    as _i32;
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Notification/Views/notification_settings_view.dart'
    as _i30;
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Views/settings_view.dart'
    as _i28;
import 'package:montra_expense_tracker/Features/Profile/Views/profile_view.dart'
    as _i25;
import 'package:montra_expense_tracker/Features/Splash%20Screen/Views/splash_screen_view.dart'
    as _i2;
import 'package:montra_expense_tracker/Features/Transaction/Attach%20Views/Details%20Transaction/Views/details_transaction_view.dart'
    as _i18;
import 'package:montra_expense_tracker/Features/Transaction/Attach%20Views/Financial%20Report/Views/financial_report_summary_view.dart'
    as _i17;
import 'package:montra_expense_tracker/Features/Transaction/Views/transaction_view.dart'
    as _i16;
import 'package:montra_expense_tracker/Widgets/successfully_done.dart' as _i13;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i35;

class Routes {
  static const splashScreenView = '/splash-screen-view';

  static const onBoardingView = '/on-boarding-view';

  static const signUpView = '/sign-up-view';

  static const loginView = '/login-view';

  static const verificationView = '/verification-view';

  static const emailVerifiedView = '/email-verified-view';

  static const setupPinView = '/setup-pin-view';

  static const forgetPasswordView = '/forget-password-view';

  static const setupAccountView = '/setup-account-view';

  static const setupWalletView = '/setup-wallet-view';

  static const allSetupView = '/all-setup-view';

  static const successfullyDone = '/successfully-done';

  static const dashboardView = '/dashboard-view';

  static const notificationView = '/notification-view';

  static const transactionView = '/transaction-view';

  static const financialReportSummaryView = '/financial-report-summary-view';

  static const detailsTransactionView = '/details-transaction-view';

  static const incomeView = '/income-view';

  static const transferView = '/transfer-view';

  static const expenseView = '/expense-view';

  static const budgetView = '/budget-view';

  static const createBudgetView = '/create-budget-view';

  static const editBudgetView = '/edit-budget-view';

  static const profileView = '/profile-view';

  static const accountView = '/account-view';

  static const accountDetails = '/account-details';

  static const settingsView = '/settings-view';

  static const currencyView = '/currency-view';

  static const notificationSettingsView = '/notification-settings-view';

  static const aboutView = '/about-view';

  static const helpView = '/help-view';

  static const all = <String>{
    splashScreenView,
    onBoardingView,
    signUpView,
    loginView,
    verificationView,
    emailVerifiedView,
    setupPinView,
    forgetPasswordView,
    setupAccountView,
    setupWalletView,
    allSetupView,
    successfullyDone,
    dashboardView,
    notificationView,
    transactionView,
    financialReportSummaryView,
    detailsTransactionView,
    incomeView,
    transferView,
    expenseView,
    budgetView,
    createBudgetView,
    editBudgetView,
    profileView,
    accountView,
    accountDetails,
    settingsView,
    currencyView,
    notificationSettingsView,
    aboutView,
    helpView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.splashScreenView,
      page: _i2.SplashScreenView,
    ),
    _i1.RouteDef(
      Routes.onBoardingView,
      page: _i3.OnBoardingView,
    ),
    _i1.RouteDef(
      Routes.signUpView,
      page: _i4.SignUpView,
    ),
    _i1.RouteDef(
      Routes.loginView,
      page: _i5.LoginView,
    ),
    _i1.RouteDef(
      Routes.verificationView,
      page: _i6.VerificationView,
    ),
    _i1.RouteDef(
      Routes.emailVerifiedView,
      page: _i7.EmailVerifiedView,
    ),
    _i1.RouteDef(
      Routes.setupPinView,
      page: _i8.SetupPinView,
    ),
    _i1.RouteDef(
      Routes.forgetPasswordView,
      page: _i9.ForgetPasswordView,
    ),
    _i1.RouteDef(
      Routes.setupAccountView,
      page: _i10.SetupAccountView,
    ),
    _i1.RouteDef(
      Routes.setupWalletView,
      page: _i11.SetupWalletView,
    ),
    _i1.RouteDef(
      Routes.allSetupView,
      page: _i12.AllSetupView,
    ),
    _i1.RouteDef(
      Routes.successfullyDone,
      page: _i13.SuccessfullyDone,
    ),
    _i1.RouteDef(
      Routes.dashboardView,
      page: _i14.DashboardView,
    ),
    _i1.RouteDef(
      Routes.notificationView,
      page: _i15.NotificationView,
    ),
    _i1.RouteDef(
      Routes.transactionView,
      page: _i16.TransactionView,
    ),
    _i1.RouteDef(
      Routes.financialReportSummaryView,
      page: _i17.FinancialReportSummaryView,
    ),
    _i1.RouteDef(
      Routes.detailsTransactionView,
      page: _i18.DetailsTransactionView,
    ),
    _i1.RouteDef(
      Routes.incomeView,
      page: _i19.IncomeView,
    ),
    _i1.RouteDef(
      Routes.transferView,
      page: _i20.TransferView,
    ),
    _i1.RouteDef(
      Routes.expenseView,
      page: _i21.ExpenseView,
    ),
    _i1.RouteDef(
      Routes.budgetView,
      page: _i22.BudgetView,
    ),
    _i1.RouteDef(
      Routes.createBudgetView,
      page: _i23.CreateBudgetView,
    ),
    _i1.RouteDef(
      Routes.editBudgetView,
      page: _i24.EditBudgetView,
    ),
    _i1.RouteDef(
      Routes.profileView,
      page: _i25.ProfileView,
    ),
    _i1.RouteDef(
      Routes.accountView,
      page: _i26.AccountView,
    ),
    _i1.RouteDef(
      Routes.accountDetails,
      page: _i27.AccountDetails,
    ),
    _i1.RouteDef(
      Routes.settingsView,
      page: _i28.SettingsView,
    ),
    _i1.RouteDef(
      Routes.currencyView,
      page: _i29.CurrencyView,
    ),
    _i1.RouteDef(
      Routes.notificationSettingsView,
      page: _i30.NotificationSettingsView,
    ),
    _i1.RouteDef(
      Routes.aboutView,
      page: _i31.AboutView,
    ),
    _i1.RouteDef(
      Routes.helpView,
      page: _i32.HelpView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplashScreenView: (data) {
      return _i33.MaterialPageRoute<dynamic>(
        builder: (context) => const _i2.SplashScreenView(),
        settings: data,
      );
    },
    _i3.OnBoardingView: (data) {
      return _i33.MaterialPageRoute<dynamic>(
        builder: (context) => const _i3.OnBoardingView(),
        settings: data,
      );
    },
    _i4.SignUpView: (data) {
      return _i33.MaterialPageRoute<dynamic>(
        builder: (context) => const _i4.SignUpView(),
        settings: data,
      );
    },
    _i5.LoginView: (data) {
      return _i33.MaterialPageRoute<dynamic>(
        builder: (context) => const _i5.LoginView(),
        settings: data,
      );
    },
    _i6.VerificationView: (data) {
      return _i33.MaterialPageRoute<dynamic>(
        builder: (context) => const _i6.VerificationView(),
        settings: data,
      );
    },
    _i7.EmailVerifiedView: (data) {
      return _i33.MaterialPageRoute<dynamic>(
        builder: (context) => const _i7.EmailVerifiedView(),
        settings: data,
      );
    },
    _i8.SetupPinView: (data) {
      return _i33.MaterialPageRoute<dynamic>(
        builder: (context) => const _i8.SetupPinView(),
        settings: data,
      );
    },
    _i9.ForgetPasswordView: (data) {
      return _i33.MaterialPageRoute<dynamic>(
        builder: (context) => const _i9.ForgetPasswordView(),
        settings: data,
      );
    },
    _i10.SetupAccountView: (data) {
      return _i33.MaterialPageRoute<dynamic>(
        builder: (context) => const _i10.SetupAccountView(),
        settings: data,
      );
    },
    _i11.SetupWalletView: (data) {
      return _i33.MaterialPageRoute<dynamic>(
        builder: (context) => const _i11.SetupWalletView(),
        settings: data,
      );
    },
    _i12.AllSetupView: (data) {
      return _i33.MaterialPageRoute<dynamic>(
        builder: (context) => const _i12.AllSetupView(),
        settings: data,
      );
    },
    _i13.SuccessfullyDone: (data) {
      final args = data.getArgs<SuccessfullyDoneArguments>(nullOk: false);
      return _i33.MaterialPageRoute<dynamic>(
        builder: (context) => _i13.SuccessfullyDone(
            key: args.key, msg: args.msg, className: args.className),
        settings: data,
      );
    },
    _i14.DashboardView: (data) {
      return _i33.MaterialPageRoute<dynamic>(
        builder: (context) => const _i14.DashboardView(),
        settings: data,
      );
    },
    _i15.NotificationView: (data) {
      return _i33.MaterialPageRoute<dynamic>(
        builder: (context) => const _i15.NotificationView(),
        settings: data,
      );
    },
    _i16.TransactionView: (data) {
      return _i33.MaterialPageRoute<dynamic>(
        builder: (context) => const _i16.TransactionView(),
        settings: data,
      );
    },
    _i17.FinancialReportSummaryView: (data) {
      return _i33.MaterialPageRoute<dynamic>(
        builder: (context) => const _i17.FinancialReportSummaryView(),
        settings: data,
      );
    },
    _i18.DetailsTransactionView: (data) {
      final args = data.getArgs<DetailsTransactionViewArguments>(nullOk: false);
      return _i33.MaterialPageRoute<dynamic>(
        builder: (context) => _i18.DetailsTransactionView(
            args.balance,
            args.description,
            args.time,
            args.category,
            args.type,
            args.accountType,
            args.color,
            key: args.key),
        settings: data,
      );
    },
    _i19.IncomeView: (data) {
      return _i33.MaterialPageRoute<dynamic>(
        builder: (context) => const _i19.IncomeView(),
        settings: data,
      );
    },
    _i20.TransferView: (data) {
      return _i33.MaterialPageRoute<dynamic>(
        builder: (context) => const _i20.TransferView(),
        settings: data,
      );
    },
    _i21.ExpenseView: (data) {
      return _i33.MaterialPageRoute<dynamic>(
        builder: (context) => const _i21.ExpenseView(),
        settings: data,
      );
    },
    _i22.BudgetView: (data) {
      return _i33.MaterialPageRoute<dynamic>(
        builder: (context) => const _i22.BudgetView(),
        settings: data,
      );
    },
    _i23.CreateBudgetView: (data) {
      return _i33.MaterialPageRoute<dynamic>(
        builder: (context) => const _i23.CreateBudgetView(),
        settings: data,
      );
    },
    _i24.EditBudgetView: (data) {
      final args = data.getArgs<EditBudgetViewArguments>(nullOk: false);
      return _i33.MaterialPageRoute<dynamic>(
        builder: (context) => _i24.EditBudgetView(
            args.color,
            args.category,
            args.spendBalance,
            args.limitBalance,
            args.backgroundColor,
            args.iconColor,
            args.icon,
            key: args.key),
        settings: data,
      );
    },
    _i25.ProfileView: (data) {
      return _i33.MaterialPageRoute<dynamic>(
        builder: (context) => const _i25.ProfileView(),
        settings: data,
      );
    },
    _i26.AccountView: (data) {
      return _i33.MaterialPageRoute<dynamic>(
        builder: (context) => const _i26.AccountView(),
        settings: data,
      );
    },
    _i27.AccountDetails: (data) {
      final args = data.getArgs<AccountDetailsArguments>(nullOk: false);
      return _i33.MaterialPageRoute<dynamic>(
        builder: (context) => _i27.AccountDetails(
            args.walletName, args.walletBalance, args.icon,
            key: args.key),
        settings: data,
      );
    },
    _i28.SettingsView: (data) {
      return _i33.MaterialPageRoute<dynamic>(
        builder: (context) => const _i28.SettingsView(),
        settings: data,
      );
    },
    _i29.CurrencyView: (data) {
      final args = data.getArgs<CurrencyViewArguments>(
        orElse: () => const CurrencyViewArguments(),
      );
      return _i33.MaterialPageRoute<dynamic>(
        builder: (context) => _i29.CurrencyView(key: args.key),
        settings: data,
      );
    },
    _i30.NotificationSettingsView: (data) {
      return _i33.MaterialPageRoute<dynamic>(
        builder: (context) => const _i30.NotificationSettingsView(),
        settings: data,
      );
    },
    _i31.AboutView: (data) {
      final args = data.getArgs<AboutViewArguments>(
        orElse: () => const AboutViewArguments(),
      );
      return _i33.MaterialPageRoute<dynamic>(
        builder: (context) => _i31.AboutView(key: args.key),
        settings: data,
      );
    },
    _i32.HelpView: (data) {
      final args = data.getArgs<HelpViewArguments>(
        orElse: () => const HelpViewArguments(),
      );
      return _i33.MaterialPageRoute<dynamic>(
        builder: (context) => _i32.HelpView(key: args.key),
        settings: data,
      );
    },
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class SuccessfullyDoneArguments {
  const SuccessfullyDoneArguments({
    this.key,
    required this.msg,
    this.className,
  });

  final _i33.Key? key;

  final String msg;

  final dynamic className;

  @override
  String toString() {
    return '{"key": "$key", "msg": "$msg", "className": "$className"}';
  }

  @override
  bool operator ==(covariant SuccessfullyDoneArguments other) {
    if (identical(this, other)) return true;
    return other.key == key && other.msg == msg && other.className == className;
  }

  @override
  int get hashCode {
    return key.hashCode ^ msg.hashCode ^ className.hashCode;
  }
}

class DetailsTransactionViewArguments {
  const DetailsTransactionViewArguments({
    required this.balance,
    required this.description,
    required this.time,
    required this.category,
    required this.type,
    required this.accountType,
    required this.color,
    this.key,
  });

  final String balance;

  final String description;

  final String time;

  final String category;

  final String type;

  final String accountType;

  final _i34.Color color;

  final _i33.Key? key;

  @override
  String toString() {
    return '{"balance": "$balance", "description": "$description", "time": "$time", "category": "$category", "type": "$type", "accountType": "$accountType", "color": "$color", "key": "$key"}';
  }

  @override
  bool operator ==(covariant DetailsTransactionViewArguments other) {
    if (identical(this, other)) return true;
    return other.balance == balance &&
        other.description == description &&
        other.time == time &&
        other.category == category &&
        other.type == type &&
        other.accountType == accountType &&
        other.color == color &&
        other.key == key;
  }

  @override
  int get hashCode {
    return balance.hashCode ^
        description.hashCode ^
        time.hashCode ^
        category.hashCode ^
        type.hashCode ^
        accountType.hashCode ^
        color.hashCode ^
        key.hashCode;
  }
}

class EditBudgetViewArguments {
  const EditBudgetViewArguments({
    required this.color,
    required this.category,
    required this.spendBalance,
    required this.limitBalance,
    required this.backgroundColor,
    required this.iconColor,
    required this.icon,
    this.key,
  });

  final _i34.Color color;

  final String category;

  final int spendBalance;

  final int limitBalance;

  final _i34.Color backgroundColor;

  final _i34.Color iconColor;

  final String icon;

  final _i33.Key? key;

  @override
  String toString() {
    return '{"color": "$color", "category": "$category", "spendBalance": "$spendBalance", "limitBalance": "$limitBalance", "backgroundColor": "$backgroundColor", "iconColor": "$iconColor", "icon": "$icon", "key": "$key"}';
  }

  @override
  bool operator ==(covariant EditBudgetViewArguments other) {
    if (identical(this, other)) return true;
    return other.color == color &&
        other.category == category &&
        other.spendBalance == spendBalance &&
        other.limitBalance == limitBalance &&
        other.backgroundColor == backgroundColor &&
        other.iconColor == iconColor &&
        other.icon == icon &&
        other.key == key;
  }

  @override
  int get hashCode {
    return color.hashCode ^
        category.hashCode ^
        spendBalance.hashCode ^
        limitBalance.hashCode ^
        backgroundColor.hashCode ^
        iconColor.hashCode ^
        icon.hashCode ^
        key.hashCode;
  }
}

class AccountDetailsArguments {
  const AccountDetailsArguments({
    required this.walletName,
    required this.walletBalance,
    required this.icon,
    this.key,
  });

  final String walletName;

  final int walletBalance;

  final String icon;

  final _i33.Key? key;

  @override
  String toString() {
    return '{"walletName": "$walletName", "walletBalance": "$walletBalance", "icon": "$icon", "key": "$key"}';
  }

  @override
  bool operator ==(covariant AccountDetailsArguments other) {
    if (identical(this, other)) return true;
    return other.walletName == walletName &&
        other.walletBalance == walletBalance &&
        other.icon == icon &&
        other.key == key;
  }

  @override
  int get hashCode {
    return walletName.hashCode ^
        walletBalance.hashCode ^
        icon.hashCode ^
        key.hashCode;
  }
}

class CurrencyViewArguments {
  const CurrencyViewArguments({this.key});

  final _i33.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant CurrencyViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class AboutViewArguments {
  const AboutViewArguments({this.key});

  final _i33.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant AboutViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class HelpViewArguments {
  const HelpViewArguments({this.key});

  final _i33.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant HelpViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

extension NavigatorStateExtension on _i35.NavigationService {
  Future<dynamic> navigateToSplashScreenView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.splashScreenView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToOnBoardingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.onBoardingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSignUpView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.signUpView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToVerificationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.verificationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEmailVerifiedView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.emailVerifiedView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSetupPinView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.setupPinView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToForgetPasswordView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.forgetPasswordView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSetupAccountView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.setupAccountView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSetupWalletView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.setupWalletView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAllSetupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.allSetupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSuccessfullyDone({
    _i33.Key? key,
    required String msg,
    dynamic className,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.successfullyDone,
        arguments:
            SuccessfullyDoneArguments(key: key, msg: msg, className: className),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDashboardView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.dashboardView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNotificationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.notificationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTransactionView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.transactionView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToFinancialReportSummaryView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.financialReportSummaryView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToDetailsTransactionView({
    required String balance,
    required String description,
    required String time,
    required String category,
    required String type,
    required String accountType,
    required _i34.Color color,
    _i33.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.detailsTransactionView,
        arguments: DetailsTransactionViewArguments(
            balance: balance,
            description: description,
            time: time,
            category: category,
            type: type,
            accountType: accountType,
            color: color,
            key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToIncomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.incomeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTransferView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.transferView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToExpenseView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.expenseView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToBudgetView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.budgetView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCreateBudgetView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.createBudgetView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEditBudgetView({
    required _i34.Color color,
    required String category,
    required int spendBalance,
    required int limitBalance,
    required _i34.Color backgroundColor,
    required _i34.Color iconColor,
    required String icon,
    _i33.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.editBudgetView,
        arguments: EditBudgetViewArguments(
            color: color,
            category: category,
            spendBalance: spendBalance,
            limitBalance: limitBalance,
            backgroundColor: backgroundColor,
            iconColor: iconColor,
            icon: icon,
            key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAccountView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.accountView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAccountDetails({
    required String walletName,
    required int walletBalance,
    required String icon,
    _i33.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.accountDetails,
        arguments: AccountDetailsArguments(
            walletName: walletName,
            walletBalance: walletBalance,
            icon: icon,
            key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSettingsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.settingsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCurrencyView({
    _i33.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.currencyView,
        arguments: CurrencyViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToNotificationSettingsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.notificationSettingsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAboutView({
    _i33.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.aboutView,
        arguments: AboutViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHelpView({
    _i33.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.helpView,
        arguments: HelpViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSplashScreenView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.splashScreenView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithOnBoardingView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.onBoardingView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSignUpView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.signUpView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithLoginView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.loginView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithVerificationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.verificationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEmailVerifiedView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.emailVerifiedView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSetupPinView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.setupPinView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithForgetPasswordView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.forgetPasswordView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSetupAccountView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.setupAccountView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSetupWalletView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.setupWalletView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAllSetupView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.allSetupView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSuccessfullyDone({
    _i33.Key? key,
    required String msg,
    dynamic className,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.successfullyDone,
        arguments:
            SuccessfullyDoneArguments(key: key, msg: msg, className: className),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDashboardView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.dashboardView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithNotificationView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.notificationView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTransactionView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.transactionView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithFinancialReportSummaryView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.financialReportSummaryView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithDetailsTransactionView({
    required String balance,
    required String description,
    required String time,
    required String category,
    required String type,
    required String accountType,
    required _i34.Color color,
    _i33.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.detailsTransactionView,
        arguments: DetailsTransactionViewArguments(
            balance: balance,
            description: description,
            time: time,
            category: category,
            type: type,
            accountType: accountType,
            color: color,
            key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithIncomeView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.incomeView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTransferView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.transferView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithExpenseView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.expenseView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithBudgetView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.budgetView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCreateBudgetView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.createBudgetView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEditBudgetView({
    required _i34.Color color,
    required String category,
    required int spendBalance,
    required int limitBalance,
    required _i34.Color backgroundColor,
    required _i34.Color iconColor,
    required String icon,
    _i33.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.editBudgetView,
        arguments: EditBudgetViewArguments(
            color: color,
            category: category,
            spendBalance: spendBalance,
            limitBalance: limitBalance,
            backgroundColor: backgroundColor,
            iconColor: iconColor,
            icon: icon,
            key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProfileView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.profileView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAccountView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.accountView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAccountDetails({
    required String walletName,
    required int walletBalance,
    required String icon,
    _i33.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.accountDetails,
        arguments: AccountDetailsArguments(
            walletName: walletName,
            walletBalance: walletBalance,
            icon: icon,
            key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSettingsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.settingsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCurrencyView({
    _i33.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.currencyView,
        arguments: CurrencyViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithNotificationSettingsView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.notificationSettingsView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAboutView({
    _i33.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.aboutView,
        arguments: AboutViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHelpView({
    _i33.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.helpView,
        arguments: HelpViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}

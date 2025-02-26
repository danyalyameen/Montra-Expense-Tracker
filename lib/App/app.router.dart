// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i33;

import 'package:cloud_firestore/cloud_firestore.dart' as _i32;
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as _i31;
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
import 'package:montra_expense_tracker/Features/Authentication/User%20Picture/Views/user_picture_view.dart'
    as _i7;
import 'package:montra_expense_tracker/Features/Authentication/Verification/Views/verification_view.dart'
    as _i6;
import 'package:montra_expense_tracker/Features/Budget/Attach%20Views/Create%20Budget/create_budget_view.dart'
    as _i21;
import 'package:montra_expense_tracker/Features/Budget/Attach%20Views/Edit%20Budget/edit_budget_view.dart'
    as _i22;
import 'package:montra_expense_tracker/Features/Budget/Views/budget_view.dart'
    as _i20;
import 'package:montra_expense_tracker/Features/Dashboard/Attach%20Views/Expense/Views/expense_view.dart'
    as _i19;
import 'package:montra_expense_tracker/Features/Dashboard/Attach%20Views/Income/Views/income_view.dart'
    as _i17;
import 'package:montra_expense_tracker/Features/Dashboard/Attach%20Views/Transfer/Views/transfer_view.dart'
    as _i18;
import 'package:montra_expense_tracker/Features/Dashboard/Views/dashboard_view.dart'
    as _i13;
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Account/Attach%20View/Account%20Details/Views/account_details.dart'
    as _i26;
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Account/Views/account_view.dart'
    as _i25;
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Edit%20Profile/Views/edit_profile_view.dart'
    as _i24;
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/About/Views/about_view.dart'
    as _i29;
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Currency/Views/currency_view.dart'
    as _i28;
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Help/Views/help_view.dart'
    as _i30;
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Views/settings_view.dart'
    as _i27;
import 'package:montra_expense_tracker/Features/Profile/Views/profile_view.dart'
    as _i23;
import 'package:montra_expense_tracker/Features/Splash%20Screen/Views/splash_screen_view.dart'
    as _i2;
import 'package:montra_expense_tracker/Features/Transaction/Attach%20Views/Details%20Transaction/Views/details_transaction_view.dart'
    as _i16;
import 'package:montra_expense_tracker/Features/Transaction/Attach%20Views/Financial%20Report/Views/financial_report_summary_view.dart'
    as _i15;
import 'package:montra_expense_tracker/Features/Transaction/Views/transaction_view.dart'
    as _i14;
import 'package:montra_expense_tracker/Widgets/successfully_done.dart' as _i12;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i34;

class Routes {
  static const splashScreenView = '/';

  static const onBoardingView = '/on-boarding-view';

  static const signUpView = '/sign-up-view';

  static const loginView = '/login-view';

  static const verificationView = '/verification-view';

  static const userPictureView = '/user-picture-view';

  static const setupPinView = '/setup-pin-view';

  static const forgetPasswordView = '/forget-password-view';

  static const setupAccountView = '/setup-account-view';

  static const setupWalletView = '/setup-wallet-view';

  static const successfullyDone = '/successfully-done';

  static const dashboardView = '/dashboard-view';

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

  static const editProfileView = '/edit-profile-view';

  static const accountView = '/account-view';

  static const accountDetails = '/account-details';

  static const settingsView = '/settings-view';

  static const currencyView = '/currency-view';

  static const aboutView = '/about-view';

  static const helpView = '/help-view';

  static const all = <String>{
    splashScreenView,
    onBoardingView,
    signUpView,
    loginView,
    verificationView,
    userPictureView,
    setupPinView,
    forgetPasswordView,
    setupAccountView,
    setupWalletView,
    successfullyDone,
    dashboardView,
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
    editProfileView,
    accountView,
    accountDetails,
    settingsView,
    currencyView,
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
      Routes.userPictureView,
      page: _i7.UserPictureView,
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
      Routes.successfullyDone,
      page: _i12.SuccessfullyDone,
    ),
    _i1.RouteDef(
      Routes.dashboardView,
      page: _i13.DashboardView,
    ),
    _i1.RouteDef(
      Routes.transactionView,
      page: _i14.TransactionView,
    ),
    _i1.RouteDef(
      Routes.financialReportSummaryView,
      page: _i15.FinancialReportSummaryView,
    ),
    _i1.RouteDef(
      Routes.detailsTransactionView,
      page: _i16.DetailsTransactionView,
    ),
    _i1.RouteDef(
      Routes.incomeView,
      page: _i17.IncomeView,
    ),
    _i1.RouteDef(
      Routes.transferView,
      page: _i18.TransferView,
    ),
    _i1.RouteDef(
      Routes.expenseView,
      page: _i19.ExpenseView,
    ),
    _i1.RouteDef(
      Routes.budgetView,
      page: _i20.BudgetView,
    ),
    _i1.RouteDef(
      Routes.createBudgetView,
      page: _i21.CreateBudgetView,
    ),
    _i1.RouteDef(
      Routes.editBudgetView,
      page: _i22.EditBudgetView,
    ),
    _i1.RouteDef(
      Routes.profileView,
      page: _i23.ProfileView,
    ),
    _i1.RouteDef(
      Routes.editProfileView,
      page: _i24.EditProfileView,
    ),
    _i1.RouteDef(
      Routes.accountView,
      page: _i25.AccountView,
    ),
    _i1.RouteDef(
      Routes.accountDetails,
      page: _i26.AccountDetails,
    ),
    _i1.RouteDef(
      Routes.settingsView,
      page: _i27.SettingsView,
    ),
    _i1.RouteDef(
      Routes.currencyView,
      page: _i28.CurrencyView,
    ),
    _i1.RouteDef(
      Routes.aboutView,
      page: _i29.AboutView,
    ),
    _i1.RouteDef(
      Routes.helpView,
      page: _i30.HelpView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.SplashScreenView: (data) {
      return _i31.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i2.SplashScreenView(),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i1.TransitionsBuilders.slideLeft,
      );
    },
    _i3.OnBoardingView: (data) {
      return _i31.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i3.OnBoardingView(),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i1.TransitionsBuilders.slideLeft,
      );
    },
    _i4.SignUpView: (data) {
      return _i31.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i4.SignUpView(),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i1.TransitionsBuilders.slideLeft,
      );
    },
    _i5.LoginView: (data) {
      return _i31.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i5.LoginView(),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i1.TransitionsBuilders.slideLeft,
      );
    },
    _i6.VerificationView: (data) {
      return _i31.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i6.VerificationView(),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i1.TransitionsBuilders.slideLeft,
      );
    },
    _i7.UserPictureView: (data) {
      return _i31.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i7.UserPictureView(),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i1.TransitionsBuilders.slideLeft,
      );
    },
    _i8.SetupPinView: (data) {
      return _i31.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i8.SetupPinView(),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i1.TransitionsBuilders.slideLeft,
      );
    },
    _i9.ForgetPasswordView: (data) {
      return _i31.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i9.ForgetPasswordView(),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i1.TransitionsBuilders.slideLeft,
      );
    },
    _i10.SetupAccountView: (data) {
      return _i31.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i10.SetupAccountView(),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i1.TransitionsBuilders.slideLeft,
      );
    },
    _i11.SetupWalletView: (data) {
      return _i31.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i11.SetupWalletView(),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i1.TransitionsBuilders.slideLeft,
      );
    },
    _i12.SuccessfullyDone: (data) {
      final args = data.getArgs<SuccessfullyDoneArguments>(nullOk: false);
      return _i31.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            _i12.SuccessfullyDone(
                key: args.key, msg: args.msg, className: args.className),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i1.TransitionsBuilders.slideLeft,
      );
    },
    _i13.DashboardView: (data) {
      return _i31.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i13.DashboardView(),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i1.TransitionsBuilders.slideLeft,
      );
    },
    _i14.TransactionView: (data) {
      return _i31.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i14.TransactionView(),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i1.TransitionsBuilders.slideLeft,
      );
    },
    _i15.FinancialReportSummaryView: (data) {
      return _i31.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i15.FinancialReportSummaryView(),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i1.TransitionsBuilders.slideLeft,
      );
    },
    _i16.DetailsTransactionView: (data) {
      final args = data.getArgs<DetailsTransactionViewArguments>(nullOk: false);
      return _i31.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            _i16.DetailsTransactionView(args.balance, args.description,
                args.time, args.category, args.type, args.color,
                key: args.key),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i1.TransitionsBuilders.slideLeft,
      );
    },
    _i17.IncomeView: (data) {
      return _i31.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i17.IncomeView(),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i1.TransitionsBuilders.slideLeft,
      );
    },
    _i18.TransferView: (data) {
      return _i31.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i18.TransferView(),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i1.TransitionsBuilders.slideLeft,
      );
    },
    _i19.ExpenseView: (data) {
      return _i31.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i19.ExpenseView(),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i1.TransitionsBuilders.slideLeft,
      );
    },
    _i20.BudgetView: (data) {
      return _i31.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i20.BudgetView(),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i1.TransitionsBuilders.slideLeft,
      );
    },
    _i21.CreateBudgetView: (data) {
      return _i31.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i21.CreateBudgetView(),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i1.TransitionsBuilders.slideLeft,
      );
    },
    _i22.EditBudgetView: (data) {
      final args = data.getArgs<EditBudgetViewArguments>(nullOk: false);
      return _i31.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            _i22.EditBudgetView(
                month: args.month,
                color: args.color,
                category: args.category,
                spendBalance: args.spendBalance,
                limitBalance: args.limitBalance,
                backgroundColor: args.backgroundColor,
                iconColor: args.iconColor,
                icon: args.icon,
                index: args.index,
                key: args.key),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i1.TransitionsBuilders.slideLeft,
      );
    },
    _i23.ProfileView: (data) {
      return _i31.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i23.ProfileView(),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i1.TransitionsBuilders.slideLeft,
      );
    },
    _i24.EditProfileView: (data) {
      final args = data.getArgs<EditProfileViewArguments>(nullOk: false);
      return _i31.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            _i24.EditProfileView(name: args.name, key: args.key),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i1.TransitionsBuilders.slideLeft,
      );
    },
    _i25.AccountView: (data) {
      return _i31.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i25.AccountView(),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i1.TransitionsBuilders.slideLeft,
      );
    },
    _i26.AccountDetails: (data) {
      final args = data.getArgs<AccountDetailsArguments>(nullOk: false);
      return _i31.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            _i26.AccountDetails(args.walletName, args.walletBalance, args.icon,
                key: args.key),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i1.TransitionsBuilders.slideLeft,
      );
    },
    _i27.SettingsView: (data) {
      return _i31.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i27.SettingsView(),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i1.TransitionsBuilders.slideLeft,
      );
    },
    _i28.CurrencyView: (data) {
      return _i31.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i28.CurrencyView(),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i1.TransitionsBuilders.slideLeft,
      );
    },
    _i29.AboutView: (data) {
      return _i31.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i29.AboutView(),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i1.TransitionsBuilders.slideLeft,
      );
    },
    _i30.HelpView: (data) {
      return _i31.PageRouteBuilder<dynamic>(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const _i30.HelpView(),
        settings: data,
        transitionsBuilder:
            data.transition ?? _i1.TransitionsBuilders.slideLeft,
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

  final _i31.Key? key;

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
    required this.color,
    this.key,
  });

  final String balance;

  final String description;

  final _i32.Timestamp time;

  final String category;

  final String type;

  final _i33.Color color;

  final _i31.Key? key;

  @override
  String toString() {
    return '{"balance": "$balance", "description": "$description", "time": "$time", "category": "$category", "type": "$type", "color": "$color", "key": "$key"}';
  }

  @override
  bool operator ==(covariant DetailsTransactionViewArguments other) {
    if (identical(this, other)) return true;
    return other.balance == balance &&
        other.description == description &&
        other.time == time &&
        other.category == category &&
        other.type == type &&
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
        color.hashCode ^
        key.hashCode;
  }
}

class EditBudgetViewArguments {
  const EditBudgetViewArguments({
    required this.month,
    required this.color,
    required this.category,
    required this.spendBalance,
    required this.limitBalance,
    required this.backgroundColor,
    required this.iconColor,
    required this.icon,
    required this.index,
    this.key,
  });

  final int month;

  final _i33.Color color;

  final String category;

  final int spendBalance;

  final int limitBalance;

  final _i33.Color backgroundColor;

  final _i33.Color iconColor;

  final String icon;

  final int index;

  final _i31.Key? key;

  @override
  String toString() {
    return '{"month": "$month", "color": "$color", "category": "$category", "spendBalance": "$spendBalance", "limitBalance": "$limitBalance", "backgroundColor": "$backgroundColor", "iconColor": "$iconColor", "icon": "$icon", "index": "$index", "key": "$key"}';
  }

  @override
  bool operator ==(covariant EditBudgetViewArguments other) {
    if (identical(this, other)) return true;
    return other.month == month &&
        other.color == color &&
        other.category == category &&
        other.spendBalance == spendBalance &&
        other.limitBalance == limitBalance &&
        other.backgroundColor == backgroundColor &&
        other.iconColor == iconColor &&
        other.icon == icon &&
        other.index == index &&
        other.key == key;
  }

  @override
  int get hashCode {
    return month.hashCode ^
        color.hashCode ^
        category.hashCode ^
        spendBalance.hashCode ^
        limitBalance.hashCode ^
        backgroundColor.hashCode ^
        iconColor.hashCode ^
        icon.hashCode ^
        index.hashCode ^
        key.hashCode;
  }
}

class EditProfileViewArguments {
  const EditProfileViewArguments({
    required this.name,
    this.key,
  });

  final String name;

  final _i31.Key? key;

  @override
  String toString() {
    return '{"name": "$name", "key": "$key"}';
  }

  @override
  bool operator ==(covariant EditProfileViewArguments other) {
    if (identical(this, other)) return true;
    return other.name == name && other.key == key;
  }

  @override
  int get hashCode {
    return name.hashCode ^ key.hashCode;
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

  final _i31.Key? key;

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

extension NavigatorStateExtension on _i34.NavigationService {
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

  Future<dynamic> navigateToUserPictureView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.userPictureView,
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

  Future<dynamic> navigateToSuccessfullyDone({
    _i31.Key? key,
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
    required _i32.Timestamp time,
    required String category,
    required String type,
    required _i33.Color color,
    _i31.Key? key,
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
    required int month,
    required _i33.Color color,
    required String category,
    required int spendBalance,
    required int limitBalance,
    required _i33.Color backgroundColor,
    required _i33.Color iconColor,
    required String icon,
    required int index,
    _i31.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.editBudgetView,
        arguments: EditBudgetViewArguments(
            month: month,
            color: color,
            category: category,
            spendBalance: spendBalance,
            limitBalance: limitBalance,
            backgroundColor: backgroundColor,
            iconColor: iconColor,
            icon: icon,
            index: index,
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

  Future<dynamic> navigateToEditProfileView({
    required String name,
    _i31.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.editProfileView,
        arguments: EditProfileViewArguments(name: name, key: key),
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
    _i31.Key? key,
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

  Future<dynamic> navigateToCurrencyView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.currencyView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAboutView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.aboutView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToHelpView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return navigateTo<dynamic>(Routes.helpView,
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

  Future<dynamic> replaceWithUserPictureView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.userPictureView,
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

  Future<dynamic> replaceWithSuccessfullyDone({
    _i31.Key? key,
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
    required _i32.Timestamp time,
    required String category,
    required String type,
    required _i33.Color color,
    _i31.Key? key,
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
    required int month,
    required _i33.Color color,
    required String category,
    required int spendBalance,
    required int limitBalance,
    required _i33.Color backgroundColor,
    required _i33.Color iconColor,
    required String icon,
    required int index,
    _i31.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.editBudgetView,
        arguments: EditBudgetViewArguments(
            month: month,
            color: color,
            category: category,
            spendBalance: spendBalance,
            limitBalance: limitBalance,
            backgroundColor: backgroundColor,
            iconColor: iconColor,
            icon: icon,
            index: index,
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

  Future<dynamic> replaceWithEditProfileView({
    required String name,
    _i31.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.editProfileView,
        arguments: EditProfileViewArguments(name: name, key: key),
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
    _i31.Key? key,
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

  Future<dynamic> replaceWithCurrencyView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.currencyView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAboutView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.aboutView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithHelpView([
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  ]) async {
    return replaceWith<dynamic>(Routes.helpView,
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }
}

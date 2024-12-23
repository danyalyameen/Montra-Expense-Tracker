// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:ui' as _i19;

import 'package:flutter/material.dart' as _i18;
import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Features/Budget/Attach%20Views/Create%20Budget/create_budget_view.dart'
    as _i16;
import 'package:montra_expense_tracker/Features/Budget/Attach%20Views/Edit%20Budget/edit_budget_view.dart'
    as _i17;
import 'package:montra_expense_tracker/Features/Budget/Views/budget_view.dart'
    as _i15;
import 'package:montra_expense_tracker/Features/Dashboard/Attach%20Views/Expense/Views/expense_view.dart'
    as _i3;
import 'package:montra_expense_tracker/Features/Dashboard/Attach%20Views/Income/Views/income_view.dart'
    as _i2;
import 'package:montra_expense_tracker/Features/Dashboard/Attach%20Views/Transfer/Views/transfer_view.dart'
    as _i4;
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Account/Attach%20View/Account%20Details/Views/account_details.dart'
    as _i7;
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Account/Views/account_view.dart'
    as _i6;
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/About/Views/about_view.dart'
    as _i9;
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Currency/Views/currency_view.dart'
    as _i10;
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Help/Views/help_view.dart'
    as _i11;
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Notification/Views/notification_view.dart'
    as _i12;
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Security/Views/security_view.dart'
    as _i13;
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Attach%20Views/Theme/Views/theme_view.dart'
    as _i14;
import 'package:montra_expense_tracker/Features/Profile/Attach%20Views/Settings/Views/settings_view.dart'
    as _i8;
import 'package:montra_expense_tracker/Features/Profile/Views/profile_view.dart'
    as _i5;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i20;

class Routes {
  static const incomeView = '/income-view';

  static const expenseView = '/expense-view';

  static const transferView = '/transfer-view';

  static const profileView = '/profile-view';

  static const accountView = '/account-view';

  static const accountDetails = '/account-details';

  static const settingsView = '/settings-view';

  static const aboutView = '/about-view';

  static const currencyView = '/currency-view';

  static const helpView = '/help-view';

  static const notificationView = '/notification-view';

  static const securityView = '/security-view';

  static const themeView = '/theme-view';

  static const budgetView = '/budget-view';

  static const createBudgetView = '/create-budget-view';

  static const editBudgetView = '/edit-budget-view';

  static const all = <String>{
    incomeView,
    expenseView,
    transferView,
    profileView,
    accountView,
    accountDetails,
    settingsView,
    aboutView,
    currencyView,
    helpView,
    notificationView,
    securityView,
    themeView,
    budgetView,
    createBudgetView,
    editBudgetView,
  };
}

class StackedRouter extends _i1.RouterBase {
  final _routes = <_i1.RouteDef>[
    _i1.RouteDef(
      Routes.incomeView,
      page: _i2.IncomeView,
    ),
    _i1.RouteDef(
      Routes.expenseView,
      page: _i3.ExpenseView,
    ),
    _i1.RouteDef(
      Routes.transferView,
      page: _i4.TransferView,
    ),
    _i1.RouteDef(
      Routes.profileView,
      page: _i5.ProfileView,
    ),
    _i1.RouteDef(
      Routes.accountView,
      page: _i6.AccountView,
    ),
    _i1.RouteDef(
      Routes.accountDetails,
      page: _i7.AccountDetails,
    ),
    _i1.RouteDef(
      Routes.settingsView,
      page: _i8.SettingsView,
    ),
    _i1.RouteDef(
      Routes.aboutView,
      page: _i9.AboutView,
    ),
    _i1.RouteDef(
      Routes.currencyView,
      page: _i10.CurrencyView,
    ),
    _i1.RouteDef(
      Routes.helpView,
      page: _i11.HelpView,
    ),
    _i1.RouteDef(
      Routes.notificationView,
      page: _i12.NotificationView,
    ),
    _i1.RouteDef(
      Routes.securityView,
      page: _i13.SecurityView,
    ),
    _i1.RouteDef(
      Routes.themeView,
      page: _i14.ThemeView,
    ),
    _i1.RouteDef(
      Routes.budgetView,
      page: _i15.BudgetView,
    ),
    _i1.RouteDef(
      Routes.createBudgetView,
      page: _i16.CreateBudgetView,
    ),
    _i1.RouteDef(
      Routes.editBudgetView,
      page: _i17.EditBudgetView,
    ),
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.IncomeView: (data) {
      final args = data.getArgs<IncomeViewArguments>(
        orElse: () => const IncomeViewArguments(),
      );
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i2.IncomeView(key: args.key),
        settings: data,
      );
    },
    _i3.ExpenseView: (data) {
      final args = data.getArgs<ExpenseViewArguments>(
        orElse: () => const ExpenseViewArguments(),
      );
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i3.ExpenseView(key: args.key),
        settings: data,
      );
    },
    _i4.TransferView: (data) {
      final args = data.getArgs<TransferViewArguments>(
        orElse: () => const TransferViewArguments(),
      );
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i4.TransferView(key: args.key),
        settings: data,
      );
    },
    _i5.ProfileView: (data) {
      final args = data.getArgs<ProfileViewArguments>(
        orElse: () => const ProfileViewArguments(),
      );
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.ProfileView(key: args.key),
        settings: data,
      );
    },
    _i6.AccountView: (data) {
      final args = data.getArgs<AccountViewArguments>(
        orElse: () => const AccountViewArguments(),
      );
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i6.AccountView(key: args.key),
        settings: data,
      );
    },
    _i7.AccountDetails: (data) {
      final args = data.getArgs<AccountDetailsArguments>(nullOk: false);
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i7.AccountDetails(
            args.walletName, args.walletBalance, args.icon,
            key: args.key),
        settings: data,
      );
    },
    _i8.SettingsView: (data) {
      final args = data.getArgs<SettingsViewArguments>(
        orElse: () => const SettingsViewArguments(),
      );
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i8.SettingsView(key: args.key),
        settings: data,
      );
    },
    _i9.AboutView: (data) {
      final args = data.getArgs<AboutViewArguments>(
        orElse: () => const AboutViewArguments(),
      );
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i9.AboutView(key: args.key),
        settings: data,
      );
    },
    _i10.CurrencyView: (data) {
      final args = data.getArgs<CurrencyViewArguments>(
        orElse: () => const CurrencyViewArguments(),
      );
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i10.CurrencyView(key: args.key),
        settings: data,
      );
    },
    _i11.HelpView: (data) {
      final args = data.getArgs<HelpViewArguments>(
        orElse: () => const HelpViewArguments(),
      );
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i11.HelpView(key: args.key),
        settings: data,
      );
    },
    _i12.NotificationView: (data) {
      final args = data.getArgs<NotificationViewArguments>(
        orElse: () => const NotificationViewArguments(),
      );
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i12.NotificationView(key: args.key),
        settings: data,
      );
    },
    _i13.SecurityView: (data) {
      final args = data.getArgs<SecurityViewArguments>(
        orElse: () => const SecurityViewArguments(),
      );
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i13.SecurityView(key: args.key),
        settings: data,
      );
    },
    _i14.ThemeView: (data) {
      final args = data.getArgs<ThemeViewArguments>(
        orElse: () => const ThemeViewArguments(),
      );
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i14.ThemeView(key: args.key),
        settings: data,
      );
    },
    _i15.BudgetView: (data) {
      final args = data.getArgs<BudgetViewArguments>(
        orElse: () => const BudgetViewArguments(),
      );
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i15.BudgetView(key: args.key),
        settings: data,
      );
    },
    _i16.CreateBudgetView: (data) {
      final args = data.getArgs<CreateBudgetViewArguments>(
        orElse: () => const CreateBudgetViewArguments(),
      );
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i16.CreateBudgetView(key: args.key),
        settings: data,
      );
    },
    _i17.EditBudgetView: (data) {
      final args = data.getArgs<EditBudgetViewArguments>(nullOk: false);
      return _i18.MaterialPageRoute<dynamic>(
        builder: (context) => _i17.EditBudgetView(
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
  };

  @override
  List<_i1.RouteDef> get routes => _routes;

  @override
  Map<Type, _i1.StackedRouteFactory> get pagesMap => _pagesMap;
}

class IncomeViewArguments {
  const IncomeViewArguments({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant IncomeViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class ExpenseViewArguments {
  const ExpenseViewArguments({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant ExpenseViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class TransferViewArguments {
  const TransferViewArguments({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant TransferViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class ProfileViewArguments {
  const ProfileViewArguments({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant ProfileViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class AccountViewArguments {
  const AccountViewArguments({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant AccountViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
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

  final _i18.Key? key;

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

class SettingsViewArguments {
  const SettingsViewArguments({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant SettingsViewArguments other) {
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

  final _i18.Key? key;

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

class CurrencyViewArguments {
  const CurrencyViewArguments({this.key});

  final _i18.Key? key;

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

class HelpViewArguments {
  const HelpViewArguments({this.key});

  final _i18.Key? key;

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

class NotificationViewArguments {
  const NotificationViewArguments({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant NotificationViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class SecurityViewArguments {
  const SecurityViewArguments({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant SecurityViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class ThemeViewArguments {
  const ThemeViewArguments({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant ThemeViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class BudgetViewArguments {
  const BudgetViewArguments({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant BudgetViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
  }
}

class CreateBudgetViewArguments {
  const CreateBudgetViewArguments({this.key});

  final _i18.Key? key;

  @override
  String toString() {
    return '{"key": "$key"}';
  }

  @override
  bool operator ==(covariant CreateBudgetViewArguments other) {
    if (identical(this, other)) return true;
    return other.key == key;
  }

  @override
  int get hashCode {
    return key.hashCode;
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

  final _i19.Color color;

  final String category;

  final int spendBalance;

  final int limitBalance;

  final _i19.Color backgroundColor;

  final _i19.Color iconColor;

  final String icon;

  final _i18.Key? key;

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

extension NavigatorStateExtension on _i20.NavigationService {
  Future<dynamic> navigateToIncomeView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.incomeView,
        arguments: IncomeViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToExpenseView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.expenseView,
        arguments: ExpenseViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToTransferView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.transferView,
        arguments: TransferViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToProfileView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.profileView,
        arguments: ProfileViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAccountView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.accountView,
        arguments: AccountViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAccountDetails({
    required String walletName,
    required int walletBalance,
    required String icon,
    _i18.Key? key,
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

  Future<dynamic> navigateToSettingsView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.settingsView,
        arguments: SettingsViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToAboutView({
    _i18.Key? key,
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

  Future<dynamic> navigateToCurrencyView({
    _i18.Key? key,
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

  Future<dynamic> navigateToHelpView({
    _i18.Key? key,
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

  Future<dynamic> navigateToNotificationView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.notificationView,
        arguments: NotificationViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToSecurityView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.securityView,
        arguments: SecurityViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToThemeView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.themeView,
        arguments: ThemeViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToBudgetView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.budgetView,
        arguments: BudgetViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToCreateBudgetView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return navigateTo<dynamic>(Routes.createBudgetView,
        arguments: CreateBudgetViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> navigateToEditBudgetView({
    required _i19.Color color,
    required String category,
    required int spendBalance,
    required int limitBalance,
    required _i19.Color backgroundColor,
    required _i19.Color iconColor,
    required String icon,
    _i18.Key? key,
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

  Future<dynamic> replaceWithIncomeView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.incomeView,
        arguments: IncomeViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithExpenseView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.expenseView,
        arguments: ExpenseViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithTransferView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.transferView,
        arguments: TransferViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithProfileView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.profileView,
        arguments: ProfileViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAccountView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.accountView,
        arguments: AccountViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAccountDetails({
    required String walletName,
    required int walletBalance,
    required String icon,
    _i18.Key? key,
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

  Future<dynamic> replaceWithSettingsView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.settingsView,
        arguments: SettingsViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithAboutView({
    _i18.Key? key,
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

  Future<dynamic> replaceWithCurrencyView({
    _i18.Key? key,
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

  Future<dynamic> replaceWithHelpView({
    _i18.Key? key,
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

  Future<dynamic> replaceWithNotificationView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.notificationView,
        arguments: NotificationViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithSecurityView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.securityView,
        arguments: SecurityViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithThemeView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.themeView,
        arguments: ThemeViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithBudgetView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.budgetView,
        arguments: BudgetViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithCreateBudgetView({
    _i18.Key? key,
    int? routerId,
    bool preventDuplicates = true,
    Map<String, String>? parameters,
    Widget Function(BuildContext, Animation<double>, Animation<double>, Widget)?
        transition,
  }) async {
    return replaceWith<dynamic>(Routes.createBudgetView,
        arguments: CreateBudgetViewArguments(key: key),
        id: routerId,
        preventDuplicates: preventDuplicates,
        parameters: parameters,
        transition: transition);
  }

  Future<dynamic> replaceWithEditBudgetView({
    required _i19.Color color,
    required String category,
    required int spendBalance,
    required int limitBalance,
    required _i19.Color backgroundColor,
    required _i19.Color iconColor,
    required String icon,
    _i18.Key? key,
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
}

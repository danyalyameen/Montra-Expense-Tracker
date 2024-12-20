// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedNavigatorGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i8;
import 'package:flutter/material.dart';
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
import 'package:montra_expense_tracker/Features/Profile/Views/profile_view.dart'
    as _i5;
import 'package:stacked/stacked.dart' as _i1;
import 'package:stacked_services/stacked_services.dart' as _i9;

class Routes {
  static const incomeView = '/income-view';

  static const expenseView = '/expense-view';

  static const transferView = '/transfer-view';

  static const profileView = '/profile-view';

  static const accountView = '/account-view';

  static const accountDetails = '/account-details';

  static const all = <String>{
    incomeView,
    expenseView,
    transferView,
    profileView,
    accountView,
    accountDetails,
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
  ];

  final _pagesMap = <Type, _i1.StackedRouteFactory>{
    _i2.IncomeView: (data) {
      final args = data.getArgs<IncomeViewArguments>(
        orElse: () => const IncomeViewArguments(),
      );
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => _i2.IncomeView(key: args.key),
        settings: data,
      );
    },
    _i3.ExpenseView: (data) {
      final args = data.getArgs<ExpenseViewArguments>(
        orElse: () => const ExpenseViewArguments(),
      );
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => _i3.ExpenseView(key: args.key),
        settings: data,
      );
    },
    _i4.TransferView: (data) {
      final args = data.getArgs<TransferViewArguments>(
        orElse: () => const TransferViewArguments(),
      );
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => _i4.TransferView(key: args.key),
        settings: data,
      );
    },
    _i5.ProfileView: (data) {
      final args = data.getArgs<ProfileViewArguments>(
        orElse: () => const ProfileViewArguments(),
      );
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => _i5.ProfileView(key: args.key),
        settings: data,
      );
    },
    _i6.AccountView: (data) {
      final args = data.getArgs<AccountViewArguments>(
        orElse: () => const AccountViewArguments(),
      );
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => _i6.AccountView(key: args.key),
        settings: data,
      );
    },
    _i7.AccountDetails: (data) {
      final args = data.getArgs<AccountDetailsArguments>(nullOk: false);
      return _i8.MaterialPageRoute<dynamic>(
        builder: (context) => _i7.AccountDetails(
            args.walletName, args.walletBalance, args.icon,
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

  final _i8.Key? key;

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

  final _i8.Key? key;

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

  final _i8.Key? key;

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

  final _i8.Key? key;

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

  final _i8.Key? key;

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

  final _i8.Key? key;

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

extension NavigatorStateExtension on _i9.NavigationService {
  Future<dynamic> navigateToIncomeView({
    _i8.Key? key,
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
    _i8.Key? key,
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
    _i8.Key? key,
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
    _i8.Key? key,
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
    _i8.Key? key,
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
    _i8.Key? key,
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

  Future<dynamic> replaceWithIncomeView({
    _i8.Key? key,
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
    _i8.Key? key,
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
    _i8.Key? key,
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
    _i8.Key? key,
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
    _i8.Key? key,
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
    _i8.Key? key,
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
}

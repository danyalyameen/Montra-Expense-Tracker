// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_services/src/navigation/navigation_service.dart';
import 'package:stacked_shared/stacked_shared.dart';

import '../Service/Authentication/auth_service.dart';
import '../Service/Budgets/budget_service.dart';
import '../Service/Image%20Picker/image_service.dart';
import '../Service/Notification%20Bar/notification_bar_service.dart';
import '../Service/Options/option_service.dart';
import '../Service/Transactions/transaction_service.dart';
import '../Service/Wallets/wallet_service.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => TransactionService());
  locator.registerLazySingleton(() => BudgetService());
  locator.registerLazySingleton(() => WalletService());
  locator.registerLazySingleton(() => OptionService());
  locator.registerLazySingleton(() => ImageService());
  locator.registerLazySingleton(() => NotificationBarService());
}

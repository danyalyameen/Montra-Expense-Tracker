import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:montra_expense_tracker/App/app.locator.dart';
import 'package:montra_expense_tracker/Service/Authentication/auth_service.dart';
import 'package:montra_expense_tracker/Service/Budgets/budget_service.dart';
import 'package:montra_expense_tracker/Service/Image%20Picker/image_service.dart';
import 'package:montra_expense_tracker/Service/Notification%20Bar/notification_bar_service.dart';
import 'package:montra_expense_tracker/Service/Options/option_service.dart';
import 'package:montra_expense_tracker/Service/Transactions/transaction_service.dart';
import 'package:montra_expense_tracker/Service/Wallets/wallet_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ViewModel extends BaseViewModel {
  NavigationService navigationService = locator<NavigationService>();
  AuthService auth = locator<AuthService>();
  WalletService walletService = locator<WalletService>();
  OptionService optionService = locator<OptionService>();
  TransactionService transactionsService = locator<TransactionService>();
  BudgetService budgetService = locator<BudgetService>();
  ImageService imageService = locator<ImageService>();
  NotificationBarService notificationBarService = locator<NotificationBarService>();
  CollectionReference firestore =
      FirebaseFirestore.instance.collection("users");
  DocumentReference incomeOptions = FirebaseFirestore.instance
      .collection("default options")
      .doc("income options");
  DocumentReference expenseOptions = FirebaseFirestore.instance
      .collection("default options")
      .doc("expense options");
  SupabaseClient supabase = Supabase.instance.client;
}

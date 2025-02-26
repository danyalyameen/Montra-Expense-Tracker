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
  // Services
  // Navigation Service
  NavigationService navigationService = locator<NavigationService>();
  // Authentication Service
  AuthService auth = locator<AuthService>();
  // Wallet Service
  WalletService walletService = locator<WalletService>();
  // Option Service
  OptionService optionService = locator<OptionService>();
  // Transaction Service
  TransactionService transactionsService = locator<TransactionService>();
  // Budget Service
  BudgetService budgetService = locator<BudgetService>();
  // Image Service
  ImageService imageService = locator<ImageService>();
  // Notification Bar Service
  NotificationBarService notificationBarService =
      locator<NotificationBarService>();
  // Instances
  // Firestore Instance
  CollectionReference firestore =
      FirebaseFirestore.instance.collection("users");
  // Supabase Instance
  SupabaseClient supabase = Supabase.instance.client;
  // Income Options Instance
  DocumentReference incomeOptions = FirebaseFirestore.instance
      .collection("default options")
      .doc("income options");
  // Expense Options Instance
  DocumentReference expenseOptions = FirebaseFirestore.instance
      .collection("default options")
      .doc("expense options");
}

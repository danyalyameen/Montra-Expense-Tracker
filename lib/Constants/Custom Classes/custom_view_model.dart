import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:montra_expense_tracker/App/app.locator.dart';
import 'package:montra_expense_tracker/Service/Authentication/auth_service.dart';
import 'package:montra_expense_tracker/Service/Budgets/budget_service.dart';
import 'package:montra_expense_tracker/Service/Transactions/transaction_service.dart';
import 'package:montra_expense_tracker/Service/Wallets/wallet_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class ViewModel extends BaseViewModel {
  NavigationService navigationService = locator<NavigationService>();
  AuthService auth = locator<AuthService>();
  CollectionReference firestore =
      FirebaseFirestore.instance.collection("users");
  DocumentReference incomeOptions = FirebaseFirestore.instance
      .collection("default options")
      .doc("income options");
  DocumentReference expenseOptions = FirebaseFirestore.instance
      .collection("default options")
      .doc("expense options");
  WalletService walletService = locator<WalletService>();
  TransactionService transactionsService = locator<TransactionService>();
  BudgetService budgetService = locator<BudgetService>();
}

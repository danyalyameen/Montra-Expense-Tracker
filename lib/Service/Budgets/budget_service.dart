import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:montra_expense_tracker/App/app.locator.dart';
import 'package:montra_expense_tracker/Models/person_model.dart';
import 'package:montra_expense_tracker/Service/Authentication/auth_service.dart';
import 'package:montra_expense_tracker/Service/Transactions/transaction_service.dart';

class BudgetService {
  final TransactionService transactionsService = locator<TransactionService>();

  Future<List<Budget>> fetchBudget() async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(AuthService().getUser()!.uid)
        .get();
    final personData = PersonData.store(data.data() as Map<String, dynamic>);
    if (personData.budget != null) {
      return personData.budget!;
    } else {
      return [];
    }
  }

  Future<int> spend({required String category, required int month}) async {
    final data = await transactionsService.fetchTransactions();
    var transactions = data.where(
      (e) {
        return e.category == category && e.time!.toDate().month == month;
      },
    ).toList();
    if (transactions.isEmpty) {
      return 0;
    }
    int total = transactions.fold(
      0,
      (previousValue, element) {
        return previousValue + element.transactionPrice!;
      },
    );
    return total;
  }
}

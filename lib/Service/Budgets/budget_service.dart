import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:montra_expense_tracker/App/app.locator.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Models/person_model.dart';
import 'package:montra_expense_tracker/Service/Authentication/auth_service.dart';
import 'package:montra_expense_tracker/Service/Transactions/transaction_service.dart';

class BudgetService {
  final TransactionService transactionsService = locator<TransactionService>();

  Future<List<Budget>> fetchBudget({required int month}) async {
    final data = await FirebaseFirestore.instance
        .collection('users')
        .doc(AuthService().getUser()!.uid)
        .get();
    final personData = PersonData.store(data.data() as Map<String, dynamic>);
    if (personData.budget != null) {
      return personData.budget!
          .where(
            (element) => element.month!.toDate().month == month,
          )
          .toList();
    } else {
      return [];
    }
  }

  Future<int> spend({required String category, required int month}) async {
    final data = await transactionsService.getTransactions();
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

  Future<List<Map<String, dynamic>>> getBudgetIcons(
      {required int month}) async {
    final budgets = await fetchBudget(month: month);
    if (budgets.isEmpty) {
      return [];
    }
    List<Map<String, dynamic>> iconData = [];
    for (var budget in budgets) {
      switch (budget.category) {
        case "Shopping":
          iconData.add({
            "icon": IconsPath.shopping,
            "iconColor": AppColors.primaryYellow,
            "iconBackgroundColor": AppColors.yellow20
          });
          break;
        case "Food":
          iconData.add({
            "icon": IconsPath.food,
            "iconColor": AppColors.primaryRed,
            "iconBackgroundColor": AppColors.red20
          });
          break;
        case "Travel":
          iconData.add({
            "icon": IconsPath.transportation,
            "iconColor": AppColors.primaryViolet,
            "iconBackgroundColor": AppColors.violet20
          });
          break;
        case "Gadgets":
          iconData.add({
            "icon": IconsPath.camera,
            "iconColor": AppColors.primaryRed,
            "iconBackgroundColor": AppColors.red20
          });
          break;
        case "Subscription":
          iconData.add({
            "icon": IconsPath.subscription,
            "iconColor": AppColors.primaryRed,
            "iconBackgroundColor": AppColors.red20
          });
          break;
        default:
          iconData.add({
            "icon": IconsPath.other,
            "iconColor": AppColors.primaryRed,
            "iconBackgroundColor": AppColors.red20
          });
      }
    }
    return iconData;
  }

  Future<void> deleteBudget({required int month, required int index}) async {
    var user = FirebaseFirestore.instance
        .collection('users')
        .doc(AuthService().getUser()!.uid);
    final data = await user.get();
    final personData = PersonData.store(data.data() as Map<String, dynamic>);
    personData.budget!.removeAt(index);
    await user.update(personData.receive());
  }
}

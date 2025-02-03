import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:montra_expense_tracker/App/app.locator.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Models/person_model.dart';
import 'package:montra_expense_tracker/Service/Authentication/auth_service.dart';

class FetchingTransactionsService {
  Future<List<Transactions>> fetchTransactions() async {
    List<Transactions> transactions = [];
    final firestore = FirebaseFirestore.instance;
    final auth = locator<Auth>();
    final data =
        await firestore.collection('users').doc(auth.getUser()!.uid).get();
    final personData = PersonData.store(data.data() as Map<String, dynamic>);
    for (var wallet in personData.wallets!) {
      if (wallet.transactions != null) {
        for (var e in wallet.transactions!) {
          transactions.add(e);
        }
      } else {
        return [];
      }
    }
    return transactions;
  }

  Future<List<Map<String, dynamic>>> transactionIcons() async {
    final transactions = await fetchTransactions();
    List<Map<String, dynamic>> iconData = [];
    for (var transaction in transactions) {
      switch (transaction.type) {
        case "Income":
          iconData.add({
            "icon": IconsPath.money,
            "iconColor": AppColors.primaryGreen,
            "iconBackgroundColor": AppColors.green20
          });
          break;
        case "Transfer":
          iconData.add({
            "icon": IconsPath.transaction,
            "iconColor": AppColors.primaryBlue,
            "iconBackgroundColor": AppColors.blue20
          });
          break;
        case "Expense":
          switch (transaction.category) {
            case "Grocery":
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
          }
          break;
      }
    }
    return iconData;
  }
}

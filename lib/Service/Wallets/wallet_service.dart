import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Models/person_model.dart';
import 'package:montra_expense_tracker/Service/Authentication/auth_service.dart';

class WalletService {
  Future<bool> addWallet({required Wallets wallet}) async {
    // Instance
    DocumentReference user = FirebaseFirestore.instance
        .collection('users')
        .doc(AuthService().getUser()!.uid);
    // Get User Data and Store it
    var data = await user.get();
    var personData = PersonData.store(data.data() as Map<String, dynamic>);
    var error = false;
    // Intialize if null
    personData.wallets ??= [];
    // Add Wallet if empty otherwise check the name is already present or not
    if (personData.wallets!.isEmpty) {
      personData.wallets!.insert(0, wallet);
      await user.update(PersonData(wallets: personData.wallets!).receive());
      error = false;
    } else {
      for (var element in personData.wallets!) {
        if (element.walletName == wallet.walletName) {
          error = true;
          break;
        } else {
          if (element == personData.wallets!.last) {
            personData.wallets!.insert(0, wallet);
            await user
                .update(PersonData(wallets: personData.wallets!).receive());
            error = false;
            break;
          }
        }
      }
    }
    return error;
  }
  
  // Get Wallets
  Future<List<Wallets>> getWallets() async {
    DocumentReference user = FirebaseFirestore.instance
        .collection('users')
        .doc(AuthService().getUser()!.uid);
    var data = await user.get();
    var personData = PersonData.store(data.data() as Map<String, dynamic>);
    return personData.wallets!;
  }
  
  // Get Transactions
  Future<List<Transactions>> getWalletTransactions(
      {required String walletName}) async {
    DocumentReference user = FirebaseFirestore.instance
        .collection('users')
        .doc(AuthService().getUser()!.uid);
    var data = await user.get();
    var personData = PersonData.store(data.data() as Map<String, dynamic>);
    for (var wallet in personData.wallets!) {
      if (wallet.walletName == walletName) {
        return wallet.transactions!;
      }
    }
    return [];
  }
  
  // Get Wallet Transaction Icons Same as Get Data and Calculate Icons
  Future<List<Map<String, dynamic>>> getWalletTransactionsIcons(
      {required String walletName}) async {
    DocumentReference user = FirebaseFirestore.instance
        .collection('users')
        .doc(AuthService().getUser()!.uid);
    var data = await user.get();
    var personData = PersonData.store(data.data() as Map<String, dynamic>);
    for (var wallet in personData.wallets!) {
      if (wallet.walletName == walletName) {
        List<Map<String, dynamic>> iconData = [];
        if (wallet.transactions != null) {
          for (var transaction in wallet.transactions!) {
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
                break;
              default:
                iconData.add({
                  "icon": IconsPath.other,
                  "iconColor": AppColors.primaryRed,
                  "iconBackgroundColor": AppColors.red20
                });
            }
          }
        } else {
          iconData = [];
        }
        return iconData;
      }
    }
    return [];
  }
  
  // Delete Wallet. First Find Wallet by name and delete it
  Future<void> deleteWallet({required String name}) async {
    DocumentReference user = FirebaseFirestore.instance
        .collection('users')
        .doc(AuthService().getUser()!.uid);
    var data = await user.get();
    var personData = PersonData.store(data.data() as Map<String, dynamic>);
    if (personData.wallets!.length == 1) {
      Fluttertoast.showToast(
        msg: "One Wallet is Required",
        textColor: AppColors.primaryLight,
        backgroundColor: AppColors.primaryRed,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
      return;
    }
    personData.wallets!.removeWhere((element) => element.walletName == name);
    await user.update(PersonData(wallets: personData.wallets!).receive());
  }
}

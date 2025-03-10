import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:montra_expense_tracker/App/app.locator.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Models/person_model.dart';
import 'package:montra_expense_tracker/Service/Authentication/auth_service.dart';
import 'package:montra_expense_tracker/Service/Image%20Picker/image_service.dart';
import 'package:montra_expense_tracker/Service/Wallets/wallet_service.dart';

class TransactionService {
  // Instances
  final user = FirebaseFirestore.instance.collection('users');
  final walletService = locator<WalletService>();
  final imageService = locator<ImageService>();

  // Add Transactions
  Future<bool> addTransaction(
      {required int transactionPrice,
      required String walletName,
      required String category,
      required String description,
      required String transactionType}) async {
    // Get User Wallets
    List<Wallets> wallets = await walletService.getWallets();
    var time = Timestamp.now();
    // Get the Selected Wallet
    for (var wallet in wallets) {
      if (wallet.walletName == walletName) {
        // Initialize Transactions if it is null
        wallet.transactions ??= [];
        // Add the Transaction
        wallet.transactions!.insert(
          0,
          Transactions(
            type: transactionType,
            category: category,
            description: description,
            transactionPrice: transactionPrice,
            time: time,
          ),
        );
        // Update Wallet Balance
        switch (transactionType) {
          case "Income":
            wallet.balance = wallet.balance! + transactionPrice;
            break;
          case "Transfer":
            wallet.balance = wallet.balance! - transactionPrice;
            if (wallet.balance! < 0) {
              Fluttertoast.showToast(
                  msg: "Insufficient Balance",
                  backgroundColor: AppColors.primaryRed,
                  textColor: AppColors.primaryLight,
                  gravity: ToastGravity.BOTTOM,
                  toastLength: Toast.LENGTH_LONG);
              wallet.balance = wallet.balance! + transactionPrice;
              return true;
            }
            break;
          case "Expense":
            wallet.balance = wallet.balance! - transactionPrice;
            if (wallet.balance! < 0) {
              Fluttertoast.showToast(
                  msg: "Insufficient Balance",
                  backgroundColor: AppColors.primaryRed,
                  textColor: AppColors.primaryLight,
                  gravity: ToastGravity.BOTTOM,
                  toastLength: Toast.LENGTH_LONG);
              wallet.balance = wallet.balance! + transactionPrice;
              return true;
            }
            break;
        }
        // Terminate Loop
        break;
      }
    }
    // Update User Wallet
    await user
        .doc(AuthService().getUser()!.uid)
        .update(PersonData(wallets: wallets).receive());
    imageService.image != null
        ? imageService.uploadImage(
            userPicture: false,
            imageUploadName: time.toString(),
            imageFile: imageService.image,
          )
        : null;
    await Future.delayed(const Duration(seconds: 3));
    return false;
  }

  // Get Transactions
  Future<List<Transactions>> getTransactions() async {
    List<Transactions> transactions = [];
    // Get Data and store it
    final data = await user.doc(AuthService().getUser()!.uid).get();
    final personData = PersonData.store(data.data() as Map<String, dynamic>);
    for (var wallet in personData.wallets!) {
      wallet.transactions ??= [];
      for (var e in wallet.transactions!) {
        transactions.add(e);
      }
    }
    transactions.sort((a, b) => b.time!.compareTo(a.time!));
    return transactions;
  }

  // Get Transaction Icons
  Future<List<Map<String, dynamic>>> getTransactionIcons(
      {List<Transactions>? userTransactions}) async {
    // Get
    final transactions = await getTransactions();
    if (transactions.isEmpty) {
      return [];
    }
    // Calculating Icons
    List<Map<String, dynamic>> iconData = [];
    for (var transaction in userTransactions ?? transactions) {
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
    return iconData;
  }

  // Delete Transactions
  void deleteTransaction({required Timestamp time}) async {
    final walletService = locator<WalletService>();
    final wallets = await walletService.getWallets();
    for (var wallet in wallets) {
      wallet.transactions ??= [];
      // Finding transaction is in which wallet
      if (wallet.transactions!.isNotEmpty) {
        int index =
            wallet.transactions!.indexWhere((element) => element.time == time);
        if (index >= 0) {
          switch (wallet.transactions![index].type) {
            case "Income":
              // Correcting Balance
              wallet.balance = wallet.balance! -
                  wallet.transactions![index].transactionPrice!;
              // Delete Image
              await imageService.deleteImage(
                userPicture: false,
                imageName: wallet.transactions![index].time.toString(),
              );
              // Remove Transaction
              wallet.transactions!.removeAt(index);
              break;
            case "Transfer":
              wallet.balance = wallet.balance! +
                  wallet.transactions![index].transactionPrice!;
              await imageService.deleteImage(
                userPicture: false,
                imageName: wallet.transactions![index].time.toString(),
              );
              wallet.transactions!.removeAt(index);
              break;
            case "Expense":
              wallet.balance = wallet.balance! +
                  wallet.transactions![index].transactionPrice!;
              await imageService.deleteImage(
                userPicture: false,
                imageName: wallet.transactions![index].time.toString(),
              );
              wallet.transactions!.removeAt(index);
              break;
          }
        }
      }
    }
    // Update Wallet
    await user
        .doc(AuthService().getUser()!.uid)
        .update(PersonData(wallets: wallets).receive());
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Constants/Variables/icons_path.dart';
import 'package:montra_expense_tracker/Models/person_model.dart';
import 'package:montra_expense_tracker/Service/Authentication/auth_service.dart';

class WalletService {
  DocumentReference user = FirebaseFirestore.instance
      .collection('users')
      .doc(AuthService().getUser()!.uid);

  Future<bool> addWallet({required Wallets wallet}) async {
    var data = await user.get();
    var personData = PersonData.store(data.data() as Map<String, dynamic>);
    var error = false;
    personData.wallets ??= [];
    if (personData.wallets!.isEmpty) {
      personData.wallets!.insert(0, wallet);
      await user.update(PersonData(wallets: personData.wallets!).receive());
      error = false;
    } else {
      for (var element in personData.wallets!) {
        if (element.walletName != wallet.walletName) {
          personData.wallets!.insert(0, wallet);
          await user.update(PersonData(wallets: personData.wallets!).receive());
          error = false;
          break;
        } else {
          error = true;
          break;
        }
      }
    }
    return error;
  }

  Future<List<Wallets>> getWallets() async {
    var data = await user.get();
    var personData = PersonData.store(data.data() as Map<String, dynamic>);
    if (personData.wallets != null) {
      return personData.wallets!;
    } else {
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> icon() async {
    List<Wallets> wallets = await getWallets();
    List<Map<String, dynamic>> icon = [];
    for (var wallet in wallets) {
      switch (wallet.accountType) {
        case "Bank":
          icon.insert(0,
              {"icon": IconsPath.bank, "iconColor": AppColors.primaryViolet});
          break;
        case "Wallet":
          icon.insert(0,
              {"icon": IconsPath.wallet, "iconColor": AppColors.primaryViolet});
          break;
      }
    }
    return icon;
  }
}

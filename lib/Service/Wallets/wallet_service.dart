import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:montra_expense_tracker/Models/person_model.dart';
import 'package:montra_expense_tracker/Service/Authentication/auth_service.dart';

class WalletService {
  Future<bool> addWallet({required Wallets wallet}) async {
    DocumentReference user = FirebaseFirestore.instance
        .collection('users')
        .doc(AuthService().getUser()!.uid);
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

  Future<List<Wallets>> getWallets() async {
    DocumentReference user = FirebaseFirestore.instance
        .collection('users')
        .doc(AuthService().getUser()!.uid);
    var data = await user.get();
    var personData = PersonData.store(data.data() as Map<String, dynamic>);
    return personData.wallets!;
  }
}

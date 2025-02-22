import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';

class AccountViewModel extends ViewModel {
  // Get the User Balance
  Future<int> getBalance() async {
    final wallets = await walletService.getWallets();
    int balance = 0;
    for (var wallet in wallets) {
      balance += wallet.balance!;
    }
    return balance;
  }
}

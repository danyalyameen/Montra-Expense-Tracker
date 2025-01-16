import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Features/Dashboard/Views/dashboard_view.dart';
import 'package:montra_expense_tracker/Models/person_model.dart';

class TransferViewModel extends ViewModel {
  final TextEditingController _balanceController = TextEditingController();
  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> transferFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> descriptionFormKey = GlobalKey<FormState>();

  TextEditingController get balanceController => _balanceController;
  TextEditingController get fromController => _fromController;
  TextEditingController get toController => _toController;
  TextEditingController get descriptionController => _descriptionController;

  final ValueNotifier _itemIndex = ValueNotifier(0);
  ValueNotifier get itemIndex => _itemIndex;
  bool _showLoading = false;
  bool get showLoading => _showLoading;

  Map<String, dynamic> storeSelectedWallet = {
    "option": "Wallet",
  };

  validateBalance() {
    if (_balanceController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Balance",
        backgroundColor: AppColors.primaryRed,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  String? validateFrom(String? value) {
    if (value!.isEmpty) {
      return "Please Fill this";
    }
    return null;
  }

  String? validateTo(String? value) {
    if (value!.isEmpty) {
      return "Please Fill this";
    }
    return null;
  }

  String? validateDescription(String? value) {
    if (value!.isEmpty) {
      return "Please Enter Your Description";
    }
    return null;
  }

  validateWallet() {
    if (storeSelectedWallet["option"] == "Wallet") {
      Fluttertoast.showToast(
        msg: "Please Select Wallet",
        backgroundColor: AppColors.primaryRed,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  Future<PersonData> fetchingWalletOptions() async {
    var data = await firestore.doc(auth.getUser()!.uid).get();
    return PersonData.store(data.data() as Map<String, dynamic>);
  }

  void updateWalletHintText({required int index}) async {
    var data = await fetchingWalletOptions();
    storeSelectedWallet["option"] = data.wallets![index].walletName;
    navigationService.back();
    notifyListeners();
  }

  void onPageChanged(int value) {
    _itemIndex.value = value;
  }

  void addTransferTransactionCompleted() async {
    validateBalance();
    validateWallet();
    if (_balanceController.text.isNotEmpty &&
        transferFormKey.currentState!.validate() &&
        descriptionFormKey.currentState!.validate() &&
        storeSelectedWallet["option"] != "Wallet") {
      try {
        _showLoading = true;
        notifyListeners();
        final data = await fetchingWalletOptions();
        if (data.wallets != null) {
          for (var wallet in data.wallets!) {
            if (wallet.walletName == storeSelectedWallet["option"]) {
              wallet.transactions ??= [];
              if (wallet.transactions != null) {
                wallet.transactions!.insert(
                  0,
                  Transactions(
                    type: "Transfer",
                    category: "${fromController.text},${toController.text}",
                    description: descriptionController.text,
                    transactionPrice: int.parse(balanceController.text),
                  ),
                );
              }
              if (wallet.balance != null) {
                wallet.balance =
                    wallet.balance! - int.parse(balanceController.text);
              }
            }
          }
        }
        await firestore
            .doc(auth.getUser()!.uid)
            .update(PersonData(wallets: data.wallets).receive());
        _showLoading = false;
        notifyListeners();
        navigationService.replaceWithSuccessfullyDone(
            msg: "Transaction Added", className: const DashboardView());
      } catch (e) {
        // ignore: avoid_print
        print("Firebase Error : $e");
      }
    }
  }
}

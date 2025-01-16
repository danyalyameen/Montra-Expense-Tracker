import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Features/Dashboard/Views/dashboard_view.dart';
import 'package:montra_expense_tracker/Models/person_model.dart';

class IncomeViewModel extends ViewModel {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _balanceEditingController =
      TextEditingController();
  final GlobalKey<FormState> descriptionFormKey = GlobalKey<FormState>();
  Map<String, dynamic> storeSelectedIncome = {
    "option": "Income",
    "color": null
  };

  Map<String, dynamic> storeSelectedWallet = {
    "option": "Wallet",
  };

  TextEditingController get descriptionController => _descriptionController;
  TextEditingController get balanceController => _balanceEditingController;

  final ValueNotifier _itemIndex = ValueNotifier(0);
  ValueNotifier get itemIndex => _itemIndex;
  bool _showLoading = false;
  bool get showLoading => _showLoading;

  validateBalance() {
    if (_balanceEditingController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Balance",
        backgroundColor: AppColors.primaryRed,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  validateIncome() {
    if (storeSelectedIncome["option"] == "Income") {
      Fluttertoast.showToast(
        msg: "Please Select Income",
        backgroundColor: AppColors.primaryRed,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
    }
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

  Future<PersonData> fetchingIncomeOptions() async {
    var data = await incomeOptions.get();
    return PersonData.store(data.data() as Map<String, dynamic>);
  }

  Future<PersonData> fetchingWalletOptions() async {
    var data = await firestore.doc(auth.getUser()!.uid).get();
    return PersonData.store(data.data() as Map<String, dynamic>);
  }

  void updateIncomeHintText({required int index}) async {
    PersonData personData = await fetchingIncomeOptions();
    storeSelectedIncome["option"] = personData.incomeOptions![index].option;
    storeSelectedIncome["color"] = personData.incomeOptions![index].color;
    navigationService.back();
    notifyListeners();
  }

  void updateWalletHintText({required int index}) async {
    PersonData personData = await fetchingWalletOptions();
    storeSelectedWallet["option"] = personData.wallets![index].walletName;
    navigationService.back();
    notifyListeners();
  }

  void onPageChanged(int value) {
    _itemIndex.value = value;
    notifyListeners();
  }

  void addIncomeCompleted() async {
    validateBalance();
    validateIncome();
    validateWallet();
    if (descriptionFormKey.currentState!.validate() &&
        _balanceEditingController.text.isNotEmpty &&
        storeSelectedIncome["option"] != "Income" &&
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
                    category: storeSelectedIncome["option"],
                    description: descriptionController.text,
                    transactionPrice: int.parse(balanceController.text),
                    type: "Income",
                  ),
                );
              }
              if (wallet.balance != null) {
                wallet.balance = wallet.balance! + int.parse(balanceController.text);
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Features/Dashboard/Views/dashboard_view.dart';
import 'package:montra_expense_tracker/Models/default_options_model.dart';
import 'package:montra_expense_tracker/Models/person_model.dart';

class CreateBudgetViewModel extends ViewModel {
  bool isOn = false;
  double sliderValue = 0;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController balanceController = TextEditingController();
  bool _showLoading = false;
  bool get showLoading => _showLoading;

  Map<String, dynamic> storeSelectedCategory = {
    "option": "Category",
    "color": null
  };

  validateBalance() {
    if (balanceController.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Please Enter Balance",
        backgroundColor: AppColors.primaryRed,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  validateCategory() {
    if (storeSelectedCategory["option"] == "Category") {
      Fluttertoast.showToast(
        msg: "Please Select Category",
        backgroundColor: AppColors.primaryRed,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  validateSlider() {
    if (isOn && sliderValue == 0) {
      Fluttertoast.showToast(
        msg: "Please Set Alert Limit or Turn Off",
        backgroundColor: AppColors.primaryRed,
        gravity: ToastGravity.BOTTOM,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }

  Future<DefaultOptionsModel> fetchingCategoryOptions() async {
    var data = await expenseOptions.get();
    return DefaultOptionsModel.store(data.data() as Map<String, dynamic>);
  }

  void updateCategoryHintText({required int index}) async {
    var data = await fetchingCategoryOptions();
    storeSelectedCategory["option"] = data.defaultExpenseOptions![index].option;
    storeSelectedCategory["color"] = data.defaultExpenseOptions![index].color;
    navigationService.back();
    notifyListeners();
  }

  void updateSwitch(value) {
    isOn = value;
    notifyListeners();
  }

  void updateSlider(value) {
    sliderValue = value;
    notifyListeners();
  }

  void addBudgetCompleted() async {
    validateBalance();
    validateCategory();
    validateSlider();
    if (formKey.currentState!.validate() &&
        storeSelectedCategory["option"] != "Category") {
      if (!isOn || isOn && sliderValue > 0) {
        try {
          _showLoading = true;
          notifyListeners();
          await firestore.doc(auth.getUser()!.uid).update(PersonData(budget: [
                Budget(
                  balance: int.parse(balanceController.text),
                  category: storeSelectedCategory["option"],
                  alertLimit: sliderValue.toInt(),
                  color: storeSelectedCategory['color'].toString(),
                  month: Timestamp.now(),
                )
              ]).receive());
          _showLoading = false;
          notifyListeners();
          navigationService.replaceWithSuccessfullyDone(
              msg: "Budget Added", className: const DashboardView());
        } catch (e) {
          // ignore: avoid_print
          print("Firebase Error : $e");
        }
      }
    }
  }
}

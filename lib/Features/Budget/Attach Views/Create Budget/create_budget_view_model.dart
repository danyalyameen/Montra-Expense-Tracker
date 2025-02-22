import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Theme/app_colors.dart';
import 'package:montra_expense_tracker/Features/Dashboard/Views/dashboard_view.dart';
import 'package:montra_expense_tracker/Models/person_model.dart';

class CreateBudgetViewModel extends ViewModel {
  // Final Variables
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController balanceController = TextEditingController();
  // Non Final Variables
  bool isOn = false;
  double sliderValue = 0;
  bool _showLoading = false;
  // Get Non Final Variables
  bool get showLoading => _showLoading;

  // Store Selected Category
  Map<String, dynamic> storeSelectedCategory = {
    "option": "Category",
    "color": null
  };

  // Validate Balance
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

  // Validate Category
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

  // Validate Slider
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

  // Update Switch Value
  void updateSwitch(value) {
    isOn = value;
    notifyListeners();
  }

  // Update Slider Value
  void updateSlider(value) {
    sliderValue = value;
    notifyListeners();
  }

  // Continue Button Logic
  void addBudgetCompleted() async {
    // Validate Inputs
    validateBalance();
    validateCategory();
    validateSlider();
    if (formKey.currentState!.validate() &&
        storeSelectedCategory["option"] != "Category" &&
        balanceController.text.isNotEmpty) {
      if (!isOn || isOn && sliderValue > 0) {
        try {
          // Show Loading
          _showLoading = true;
          notifyListeners();
          // Fetch User Data
          var userData = await firestore.doc(auth.getUser()!.uid).get();
          // Store into the Person Model
          var personModel =
              PersonData.store(userData.data() as Map<String, dynamic>);
          // Intialize Person Model if it is null
          personModel.budget ??= [];
          if (personModel.budget!.isEmpty) {
            // Insert the Budget in the List
            personModel.budget!.insert(
              0,
              Budget(
                balance: int.parse(balanceController.text),
                category: storeSelectedCategory["option"],
                alertLimit: sliderValue.toInt(),
                color: storeSelectedCategory['color'].toString(),
                month: Timestamp.now(),
              ),
            );
          } else {
            // Check if the Budget already exist
            for (var element in personModel.budget!) {
              // if true then show error message otherwise insert budget
              if (element.category == storeSelectedCategory["option"]) {
                log("Done");
                Fluttertoast.showToast(
                  msg: "Budget Already Defined. Try Deleting the Previous one",
                  backgroundColor: AppColors.primaryRed,
                  gravity: ToastGravity.BOTTOM,
                  toastLength: Toast.LENGTH_LONG,
                  textColor: AppColors.primaryLight,
                );
                // Hide Loading
                _showLoading = false;
                notifyListeners();
                return;
              } else {
                if (element == personModel.budget!.last) {
                  log("Last");
                  // insert budget
                  personModel.budget!.insert(
                    0,
                    Budget(
                      balance: int.parse(balanceController.text),
                      category: storeSelectedCategory["option"],
                      alertLimit: sliderValue.toInt(),
                      color: storeSelectedCategory['color'].toString(),
                      month: Timestamp.now(),
                    ),
                  );
                  break;
                }
              }
            }
          }
          await firestore
              .doc(auth.getUser()!.uid)
              .update(personModel.receive());
          // Hide Loading
          _showLoading = false;
          notifyListeners();
          // Loading
          navigationService.replaceWithSuccessfullyDone(
              msg: "Budget Added", className: const DashboardView());
        } catch (e) {
          log(e.toString());
        }
      }
    }
  }
}

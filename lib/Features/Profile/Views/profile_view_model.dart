import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';
import 'package:montra_expense_tracker/Constants/Variables/database.dart';

class ProfileViewModel extends ViewModel {
  // Non Final Variables
  ValueNotifier<bool> imageError = ValueNotifier(false);

  // Profile Navigations
  void navigation({required int index}) {
    navigationService.navigateToView(Database.navigationViewsForProfile[index]);
  }
}

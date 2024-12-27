import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';

class ResetPasswordViewModel extends ViewModel {
  final TextEditingController _newPasswordEditingController =
      TextEditingController();
  final TextEditingController _retypeNewPasswordingEditingController =
      TextEditingController();

  TextEditingController get newPasswordEditingController =>
      _newPasswordEditingController;
  TextEditingController get retypeNewPasswordEditingController =>
      _retypeNewPasswordingEditingController;
}

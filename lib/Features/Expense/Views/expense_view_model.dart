import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';

class ExpenseViewModel extends ViewModel {
  final TextEditingController _descriptionController = TextEditingController();

  TextEditingController get descriptionController => _descriptionController;
}

import 'package:flutter/material.dart';
import 'package:montra_expense_tracker/App/app.router.dart';
import 'package:montra_expense_tracker/Constants/Custom%20Classes/custom_view_model.dart';

class SetupWalletViewModel extends ViewModel {
  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _searchEditingController =
      TextEditingController();
  bool _isFocus = false;
  String _selectedAccountType = "";
  int _currentIndex = 0;

  TextEditingController get nameController => _nameEditingController;
  TextEditingController get searchController => _searchEditingController;
  bool get isFocus => _isFocus;
  String get selectedAccountType => _selectedAccountType;
  int get currentIndex => _currentIndex;

  void onTap() {
    _isFocus = true;
    notifyListeners();
  }

  void onTapOutside(BuildContext context) {
    _isFocus = false;
    FocusScope.of(context).unfocus();
    notifyListeners();
  }

  void onComplete(BuildContext context) {
    _isFocus = false;
    FocusScope.of(context).unfocus();
    notifyListeners();
  }

  void onChanged(String value) {
    _selectedAccountType = value;
    notifyListeners();
  }

  void updateCurrentIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  void allSetupNavigation() {
    navigationService.replaceWithAllSetupView();
  }
}
